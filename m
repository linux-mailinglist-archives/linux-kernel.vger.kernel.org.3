Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD97F4B558F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356118AbiBNQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:05:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356105AbiBNQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:05:50 -0500
X-Greylist: delayed 1436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 08:05:42 PST
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4436249277
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:05:42 -0800 (PST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 010FD2B35A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:41:46 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id JdS5nr9SaXvvJJdS5npJFb; Mon, 14 Feb 2022 09:39:45 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:59426 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nJdS3-002kde-Pt; Mon, 14 Feb 2022 09:39:43 -0600
Message-ID: <49ce9a81-8cd0-08d6-c6ae-011214c676ba@kernel.org>
Date:   Mon, 14 Feb 2022 16:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V2 17/21] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <e67874c8b676ea8dfe38679efa25363889bb1e76.1644830251.git.bristot@kernel.org>
 <6ead3577-75ec-1b9a-0c27-213a3a186c57@roeck-us.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <6ead3577-75ec-1b9a-0c27-213a3a186c57@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nJdS3-002kde-Pt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:59426
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 15:57, Guenter Roeck wrote:
> On 2/14/22 02:45, Daniel Bristot de Oliveira wrote:
>> Add a set of tracepoints, enabling the observability of the watchdog
>> device interactions with user-space.
>>
>> The events are:
>>     watchdog:watchdog_open
>>     watchdog:watchdog_close
>>     watchdog:watchdog_start
>>     watchdog:watchdog_stop
>>     watchdog:watchdog_set_timeout
>>     watchdog:watchdog_ping
>>     watchdog:watchdog_nowayout
>>     watchdog:watchdog_set_keep_alive
>>     watchdog:watchdog_keep_alive
>>
>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Marco Elver <elver@google.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-trace-devel@vger.kernel.org
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
>>   drivers/watchdog/watchdog_dev.c |  41 ++++++++++++-
>>   include/linux/watchdog.h        |   7 +--
>>   include/trace/events/watchdog.h | 103 ++++++++++++++++++++++++++++++++
>>   3 files changed, 142 insertions(+), 9 deletions(-)
>>   create mode 100644 include/trace/events/watchdog.h
>>
>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>> index 3a3d8b5c7ad5..0beeac5d4541 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -44,6 +44,9 @@
>>   #include <linux/watchdog.h>    /* For watchdog specific items */
>>   #include <linux/uaccess.h>    /* For copy_to_user/put_user/... */
>>   +#define CREATE_TRACE_POINTS
>> +#include <trace/events/watchdog.h>
>> +
>>   #include "watchdog_core.h"
>>   #include "watchdog_pretimeout.h"
>>   @@ -130,9 +133,11 @@ static inline void watchdog_update_worker(struct
>> watchdog_device *wdd)
>>       if (watchdog_need_worker(wdd)) {
>>           ktime_t t = watchdog_next_keepalive(wdd);
>>   -        if (t > 0)
>> +        if (t > 0) {
>>               hrtimer_start(&wd_data->timer, t,
>>                         HRTIMER_MODE_REL_HARD);
>> +            trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
>> +        }
>>       } else {
>>           hrtimer_cancel(&wd_data->timer);
>>       }
>> @@ -149,14 +154,16 @@ static int __watchdog_ping(struct watchdog_device *wdd)
>>       now = ktime_get();
>>         if (ktime_after(earliest_keepalive, now)) {
>> -        hrtimer_start(&wd_data->timer,
>> -                  ktime_sub(earliest_keepalive, now),
>> +        ktime_t t = ktime_sub(earliest_keepalive, now);
> 
> I am quite sure this line creates a checkpatch warning.

right, I will fix it.
> 
>> +        hrtimer_start(&wd_data->timer, t,
>>                     HRTIMER_MODE_REL_HARD);
>> +        trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
>>           return 0;
>>       }
>>         wd_data->last_hw_keepalive = now;
>>   +    trace_watchdog_ping(wdd);
>>       if (wdd->ops->ping)
>>           err = wdd->ops->ping(wdd);  /* ping the watchdog */
>>       else
>> @@ -215,6 +222,7 @@ static void watchdog_ping_work(struct kthread_work *work)
>>       wd_data = container_of(work, struct watchdog_core_data, work);
>>         mutex_lock(&wd_data->lock);
>> +    trace_watchdog_keep_alive(wd_data->wdd);
>>       if (watchdog_worker_should_ping(wd_data))
>>           __watchdog_ping(wd_data->wdd);
>>       mutex_unlock(&wd_data->lock);
>> @@ -252,6 +260,8 @@ static int watchdog_start(struct watchdog_device *wdd)
>>         set_bit(_WDOG_KEEPALIVE, &wd_data->status);
>>   +    trace_watchdog_start(wdd);
>> +
>>       started_at = ktime_get();
>>       if (watchdog_hw_running(wdd) && wdd->ops->ping) {
>>           err = __watchdog_ping(wdd);
>> @@ -298,6 +308,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
>>           return -EBUSY;
>>       }
>>   +    trace_watchdog_stop(wdd);
>>       if (wdd->ops->stop) {
>>           clear_bit(WDOG_HW_RUNNING, &wdd->status);
>>           err = wdd->ops->stop(wdd);
>> @@ -370,6 +381,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>>       if (watchdog_timeout_invalid(wdd, timeout))
>>           return -EINVAL;
>>   +    trace_watchdog_set_timeout(wdd, timeout);
>>       if (wdd->ops->set_timeout) {
>>           err = wdd->ops->set_timeout(wdd, timeout);
>>       } else {
>> @@ -432,6 +444,23 @@ static int watchdog_get_timeleft(struct watchdog_device
>> *wdd,
>>       return 0;
>>   }
>>   +/*
> 
> /** ?

yep, I will fix this too.

>> + * watchdog_set_nowayout - set nowaout bit
>> + * @wdd:    The watchdog device to set nowayoutbit
>> + * @nowayout    A boolean on/off switcher
>> + *
>> + * If nowayout boolean is true, the nowayout option is set. No action is
>> + * taken if nowayout is false.
>> + */
>> +void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
>> +{
>> +    if (nowayout) {
>> +        set_bit(WDOG_NO_WAY_OUT, &wdd->status);
>> +        trace_watchdog_nowayout(wdd);
>> +    }
>> +}
>> +EXPORT_SYMBOL(watchdog_set_nowayout);
>> +
>>   #ifdef CONFIG_WATCHDOG_SYSFS
>>   static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
>>                   char *buf)
>> @@ -457,6 +486,7 @@ static ssize_t nowayout_store(struct device *dev, struct
>> device_attribute *attr,
>>       /* nowayout cannot be disabled once set */
>>       if (test_bit(WDOG_NO_WAY_OUT, &wdd->status) && !value)
>>           return -EPERM;
>> +
>>       watchdog_set_nowayout(wdd, value);
>>       return len;
>>   }
>> @@ -858,6 +888,8 @@ static int watchdog_open(struct inode *inode, struct file
>> *file)
>>           goto out_clear;
>>       }
>>   +    trace_watchdog_open(wdd);
>> +
>>       err = watchdog_start(wdd);
>>       if (err < 0)
>>           goto out_mod;
>> @@ -880,6 +912,7 @@ static int watchdog_open(struct inode *inode, struct file
>> *file)
>>       return stream_open(inode, file);
>>     out_mod:
>> +    trace_watchdog_close(wdd);
>>       module_put(wd_data->wdd->ops->owner);
>>   out_clear:
>>       clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
>> @@ -940,6 +973,7 @@ static int watchdog_release(struct inode *inode, struct
>> file *file)
>>       /* make sure that /dev/watchdog can be re-opened */
>>       clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
>>   +    trace_watchdog_close(wdd);
>>   done:
>>       running = wdd && watchdog_hw_running(wdd);
>>       mutex_unlock(&wd_data->lock);
>> @@ -952,6 +986,7 @@ static int watchdog_release(struct inode *inode, struct
>> file *file)
>>           module_put(wd_data->cdev.owner);
>>           put_device(&wd_data->dev);
>>       }
>> +
> 
> You may disagree with current empty lines or other cosmetics, but that is not an
> acceptable reason for such changes. Please drop this change and the similar change
> further up.

It was miss attention from my side. I probably did some changes around these
lines in an early patch version but forgot to remove those "+<empty>" changes.
My bad. I will remove them.

Thanks, Guenter!
-- Daniel

> Guenter
