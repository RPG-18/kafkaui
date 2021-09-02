#pragma once

#include <boost/circular_buffer.hpp>
#include <cstdint>
#include <kafka/KafkaConsumer.h>

#include <QtCore/QByteArray>
#include <QtCore/QDateTime>
#include <QtCore/QMap>
#include <QtCore/QObject>

#include "ClusterConfig.h"
#include "ConsumerRecordBuffer.h"
#include "Filter.h"
#include "Limiter.h"

namespace core {

/**!
 * KafkaConsumer wrapper
 */
class KafkaConsumer : public QObject
{
    Q_OBJECT
public:
    static constexpr auto PoolInterval = std::chrono::milliseconds(0);
    static constexpr auto PoolTimeout = std::chrono::milliseconds(1000);
    static constexpr int MaxMessages = 500;

    KafkaConsumer(ClusterConfig cfg, const QStringList &topics, QObject *parent = nullptr);

    /*!
     * get records
     * @param out records
     */
    void records(ConsumerRecords &out);

    void seekOnTimestamp(const QDateTime &tm);

    void seekToBeginning();

    void setLimiter(std::unique_ptr<core::AbstractLimiter> limiter);
    void setFilter(std::unique_ptr<core::AbstractFilter> filter);

signals:

    /*!
     * notification about stopping consuming
     */
    void stopped();

public slots:

    /*!
     * start consuming
     */
    void start();

    /*!
     * stop consuming
     */
    void stop();

protected:
    void timerEvent(QTimerEvent *event) override;

private:
    void pool();
    void createConsumer();

    void append(ConsumerRecords &records);
    void setOnTimeOffset();
    void manualStop();

private:
    int m_timerId;
    ClusterConfig m_cfg;
    std::unique_ptr<kafka::KafkaManualCommitConsumer> m_consumer;
    QStringList m_topics;
    QMap<std::string, QString> m_topicMapper;
    QDateTime m_seekOnTime;
    bool m_toBeginning;
    std::unique_ptr<core::AbstractLimiter> m_limiter;
    std::unique_ptr<core::AbstractFilter> m_filter;
    ConsumerRecordBuffer m_buff;
};

} // namespace core
