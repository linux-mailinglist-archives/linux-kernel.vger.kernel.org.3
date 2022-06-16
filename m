Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B754EE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379093AbiFPXzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379198AbiFPXzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:55:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB262CF7;
        Thu, 16 Jun 2022 16:55:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso3143696pjl.3;
        Thu, 16 Jun 2022 16:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ku/N1D4TewWQGYkEyPdHcptcQrrBWamkJuGCacVJaFw=;
        b=DRM7h9b7QnemRh2d8WudLMXQ3qckTbANbRLN1YliZRS5hRjfUDpGUOa19BsW8qC65o
         lKdDOBQsXCow3OiFTww1jTnFmHgfcSXpAwSiHaZSq8XFhhC1sHwpwCA6iwZmy3/dsDPZ
         1mJ8xlJn/cJxt1Hb4tCVQpqS038INLfysmm/xddJxCJvLVioBzfheurh2X0fTjZV4Fwt
         zdsobGm/gKQCjVuTKtY0c0i/+NisPOZ3scnFSrDM3p6dLHgX2AMue+NFWa9PIzdhpjJX
         lujwPkizkMinkFpIVODU922baUbb+pjWMKgFwEAkZaq6nOuCDHFNe14Dbe9Me1hFTxKp
         8Xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ku/N1D4TewWQGYkEyPdHcptcQrrBWamkJuGCacVJaFw=;
        b=UJ8PD7Z/NRD4jbClmsulRTrmiXu7cYD8ji99h811t1pkY9tzvShVNF/8eyyelIauB7
         NeG2S1r/WOql9GoAQlfAFQwQwM68qDdrKHNUXAZKk4BlFa7oFN96bVVey5OVbSSawidk
         l9yPWZ6adoLvP8Oe/Io1FLXrv9TK56GZJ64TiwbS5tPsj92UwQ6WmHocRHzmzKQtPgZk
         LU9U6bNqns58CAViHoOEVglscmT8rUI5XORMjncghIbUHaW2w1haNlx0zoewZgsq/jjQ
         XpUnT4xsSopiC2AxbfV6RfGn6juNqOwx+8TH3lkSikhJswfz4P3Zw4GkxsYG9e28B0tx
         23bQ==
X-Gm-Message-State: AJIora+zgyN2dLKfjVph2Qgr67vxaDO9lnGs2udKlOui8wA7Yi6hcQor
        q4IXRBLAoryTl3v5h/9ennA=
X-Google-Smtp-Source: AGRyM1t097LHAGhJhnJ9a6x/bocPOpMkbdZQtc0iIFRkvRSkonz94QnD5uy2kY42YW/yG36HR08X9g==
X-Received: by 2002:a17:902:c2d3:b0:168:e13c:4e23 with SMTP id c19-20020a170902c2d300b00168e13c4e23mr6889718pla.99.1655423722150;
        Thu, 16 Jun 2022 16:55:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001636d95fe59sm2161711pll.172.2022.06.16.16.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 16:55:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dc48373d-6568-4fab-cbe6-39f2c84ee1b5@roeck-us.net>
Date:   Thu, 16 Jun 2022 16:55:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 17/20] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <e153b772306577bcb3915474ed10eb3dcb228eda.1655368610.git.bristot@kernel.org>
 <a141e63a-c62c-8094-fedf-7f22f9090b0f@roeck-us.net>
 <4d8c53a1-7b94-fb0e-29e5-ed13b72093f1@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <4d8c53a1-7b94-fb0e-29e5-ed13b72093f1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 08:47, Daniel Bristot de Oliveira wrote:
> On 6/16/22 15:44, Guenter Roeck wrote:
>> On 6/16/22 01:44, Daniel Bristot de Oliveira wrote:
>>> Add a set of tracepoints, enabling the observability of the watchdog
>>> device interactions with user-space.
>>>
>>> The events are:
>>>      watchdog:watchdog_open
>>>      watchdog:watchdog_close
>>>      watchdog:watchdog_start
>>>      watchdog:watchdog_stop
>>>      watchdog:watchdog_set_timeout
>>>      watchdog:watchdog_ping
>>>      watchdog:watchdog_nowayout
>>>      watchdog:watchdog_set_keep_alive
>>>      watchdog:watchdog_keep_alive
>>>      watchdog:watchdog_set_pretimeout
>>>      watchdog:watchdog_pretimeout
>>>
>>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Marco Elver <elver@google.com>
>>> Cc: Dmitry Vyukov <dvyukov@google.com>
>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Clark Williams <williams@redhat.com>
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-trace-devel@vger.kernel.org
>>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>>> ---
>>>    drivers/watchdog/watchdog_dev.c        |  43 ++++++++++-
>>>    drivers/watchdog/watchdog_pretimeout.c |   2 +
>>>    include/linux/watchdog.h               |   7 +-
>>>    include/trace/events/watchdog.h        | 101 +++++++++++++++++++++++++
>>>    4 files changed, 143 insertions(+), 10 deletions(-)
>>>    create mode 100644 include/trace/events/watchdog.h
>>>
>>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>>> index 54903f3c851e..2f28dc5ab763 100644
>>> --- a/drivers/watchdog/watchdog_dev.c
>>> +++ b/drivers/watchdog/watchdog_dev.c
>>> @@ -44,6 +44,9 @@
>>>    #include <linux/watchdog.h>    /* For watchdog specific items */
>>>    #include <linux/uaccess.h>    /* For copy_to_user/put_user/... */
>>>    +#define CREATE_TRACE_POINTS
>>> +#include <trace/events/watchdog.h>
>>> +
>>>    #include "watchdog_core.h"
>>>    #include "watchdog_pretimeout.h"
>>>    @@ -130,9 +133,11 @@ static inline void watchdog_update_worker(struct
>>> watchdog_device *wdd)
>>>        if (watchdog_need_worker(wdd)) {
>>>            ktime_t t = watchdog_next_keepalive(wdd);
>>>    -        if (t > 0)
>>> +        if (t > 0) {
>>>                hrtimer_start(&wd_data->timer, t,
>>>                          HRTIMER_MODE_REL_HARD);
>>> +            trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
>>> +        }
>>>        } else {
>>>            hrtimer_cancel(&wd_data->timer);
>>>        }
>>> @@ -141,7 +146,7 @@ static inline void watchdog_update_worker(struct
>>> watchdog_device *wdd)
>>>    static int __watchdog_ping(struct watchdog_device *wdd)
>>>    {
>>>        struct watchdog_core_data *wd_data = wdd->wd_data;
>>> -    ktime_t earliest_keepalive, now;
>>> +    ktime_t earliest_keepalive, now, next_keepalive;
>>>        int err;
>>>          earliest_keepalive = ktime_add(wd_data->last_hw_keepalive,
>>> @@ -149,14 +154,16 @@ static int __watchdog_ping(struct watchdog_device *wdd)
>>>        now = ktime_get();
>>>          if (ktime_after(earliest_keepalive, now)) {
>>> -        hrtimer_start(&wd_data->timer,
>>> -                  ktime_sub(earliest_keepalive, now),
>>> +        next_keepalive = ktime_sub(earliest_keepalive, now);
>>> +        hrtimer_start(&wd_data->timer, next_keepalive,
>>>                      HRTIMER_MODE_REL_HARD);
>>> +        trace_watchdog_set_keep_alive(wdd, ktime_to_ms(next_keepalive));
>>>            return 0;
>>>        }
>>>          wd_data->last_hw_keepalive = now;
>>>    +    trace_watchdog_ping(wdd);
>>>        if (wdd->ops->ping)
>>>            err = wdd->ops->ping(wdd);  /* ping the watchdog */
>>>        else
>>> @@ -215,6 +222,7 @@ static void watchdog_ping_work(struct kthread_work *work)
>>>        wd_data = container_of(work, struct watchdog_core_data, work);
>>>          mutex_lock(&wd_data->lock);
>>> +    trace_watchdog_keep_alive(wd_data->wdd);
>>>        if (watchdog_worker_should_ping(wd_data))
>>>            __watchdog_ping(wd_data->wdd);
>>>        mutex_unlock(&wd_data->lock);
>>> @@ -250,6 +258,8 @@ static int watchdog_start(struct watchdog_device *wdd)
>>>          set_bit(_WDOG_KEEPALIVE, &wd_data->status);
>>>    +    trace_watchdog_start(wdd);
>>> +
>>>        started_at = ktime_get();
>>>        if (watchdog_hw_running(wdd) && wdd->ops->ping) {
>>>            err = __watchdog_ping(wdd);
>>> @@ -294,6 +304,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
>>>            return -EBUSY;
>>>        }
>>>    +    trace_watchdog_stop(wdd);
>>>        if (wdd->ops->stop) {
>>>            clear_bit(WDOG_HW_RUNNING, &wdd->status);
>>>            err = wdd->ops->stop(wdd);
>>> @@ -367,6 +378,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>>>        if (watchdog_timeout_invalid(wdd, timeout))
>>>            return -EINVAL;
>>>    +    trace_watchdog_set_timeout(wdd, timeout);
>>
>> The driver has no obligation to set the timeout to the
>> requested value. It might be more valuable to report both
>> the requested and the actual values.
>>
>>
> 
> Ack! how do I get the actual value?
> 
Read it from the data structure after the driver function returned.

>>>        if (wdd->ops->set_timeout) {
>>>            err = wdd->ops->set_timeout(wdd, timeout);
>>>        } else {
>>> @@ -399,6 +411,8 @@ static int watchdog_set_pretimeout(struct watchdog_device
>>> *wdd,
>>>        if (watchdog_pretimeout_invalid(wdd, timeout))
>>>            return -EINVAL;
>>>    +    trace_watchdog_set_pretimeout(wdd, timeout);
>>> +
>>
>> Again, the driver has no obligation to set the timeout to the
>> requested value.
> 
> /me takes note.
> 
>>
>>>        if (wdd->ops->set_pretimeout && (wdd->info->options & WDIOF_PRETIMEOUT))
>>>            err = wdd->ops->set_pretimeout(wdd, timeout);
>>>        else
>>> @@ -430,6 +444,23 @@ static int watchdog_get_timeleft(struct watchdog_device
>>> *wdd,
>>>        return 0;
>>>    }
>>>    +/**
>>> + * watchdog_set_nowayout - set nowaout bit
>>> + * @wdd:    The watchdog device to set nowayoutbit
>>> + * @nowayout    A boolean on/off switcher
>>> + *
>>> + * If nowayout boolean is true, the nowayout option is set. No action is
>>> + * taken if nowayout is false.
>>> + */
>>> +void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
>>> +{
>>> +    if (nowayout) {
>>> +        set_bit(WDOG_NO_WAY_OUT, &wdd->status);
>>> +        trace_watchdog_nowayout(wdd);
>>> +    }
>>> +}
>>> +EXPORT_SYMBOL(watchdog_set_nowayout);
>>> +
>>>    #ifdef CONFIG_WATCHDOG_SYSFS
>>>    static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
>>>                    char *buf)
>>> @@ -861,6 +892,8 @@ static int watchdog_open(struct inode *inode, struct file
>>> *file)
>>>            goto out_clear;
>>>        }
>>>    +    trace_watchdog_open(wdd);
>>> +
>>>        err = watchdog_start(wdd);
>>>        if (err < 0)
>>>            goto out_mod;
>>> @@ -883,6 +916,7 @@ static int watchdog_open(struct inode *inode, struct file
>>> *file)
>>>        return stream_open(inode, file);
>>>      out_mod:
>>> +    trace_watchdog_close(wdd);
>>>        module_put(wd_data->wdd->ops->owner);
>>>    out_clear:
>>>        clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
>>> @@ -944,6 +978,7 @@ static int watchdog_release(struct inode *inode, struct
>>> file *file)
>>>        /* make sure that /dev/watchdog can be re-opened */
>>>        clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
>>>    +    trace_watchdog_close(wdd);
>>>    done:
>>>        running = wdd && watchdog_hw_running(wdd);
>>>        mutex_unlock(&wd_data->lock);
>>> diff --git a/drivers/watchdog/watchdog_pretimeout.c
>>> b/drivers/watchdog/watchdog_pretimeout.c
>>> index 376a495ab80c..58c391ed2205 100644
>>> --- a/drivers/watchdog/watchdog_pretimeout.c
>>> +++ b/drivers/watchdog/watchdog_pretimeout.c
>>> @@ -8,6 +8,7 @@
>>>    #include <linux/spinlock.h>
>>>    #include <linux/string.h>
>>>    #include <linux/watchdog.h>
>>> +#include <trace/events/watchdog.h>
>>>      #include "watchdog_core.h"
>>>    #include "watchdog_pretimeout.h"
>>> @@ -107,6 +108,7 @@ void watchdog_notify_pretimeout(struct watchdog_device *wdd)
>>>            return;
>>>        }
>>>    +    trace_watchdog_pretimeout(wdd);
>>>        wdd->gov->pretimeout(wdd);
>>>        spin_unlock_irqrestore(&pretimeout_lock, flags);
>>>    }
>>> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
>>> index 99660197a36c..11d93407e492 100644
>>> --- a/include/linux/watchdog.h
>>> +++ b/include/linux/watchdog.h
>>> @@ -139,12 +139,7 @@ static inline bool watchdog_hw_running(struct
>>> watchdog_device *wdd)
>>>        return test_bit(WDOG_HW_RUNNING, &wdd->status);
>>>    }
>>>    -/* Use the following function to set the nowayout feature */
>>> -static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool
>>> nowayout)
>>> -{
>>> -    if (nowayout)
>>> -        set_bit(WDOG_NO_WAY_OUT, &wdd->status);
>>> -}
>>> +void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout);
>>>      /* Use the following function to stop the watchdog on reboot */
>>>    static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
>>> diff --git a/include/trace/events/watchdog.h b/include/trace/events/watchdog.h
>>> new file mode 100644
>>> index 000000000000..145cd6cfaa02
>>> --- /dev/null
>>> +++ b/include/trace/events/watchdog.h
>>> @@ -0,0 +1,101 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#undef TRACE_SYSTEM
>>> +#define TRACE_SYSTEM watchdog
>>> +
>>> +#if !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ)
>>> +#define _TRACE_WATCHDOG_H
>>> +
>>> +#include <linux/tracepoint.h>
>>> +
>>> +/*
>>> + * These are all events whose sole argument is the watchdog id.
>>> + */
>>> +DECLARE_EVENT_CLASS(dev_operations_template,
>>> +
>>> +    TP_PROTO(struct watchdog_device *wdd),
>>> +
>>> +    TP_ARGS(wdd),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(__u32, id)
>>> +    ),
>>> +
>>> +    TP_fast_assign(
>>> +        __entry->id = wdd->id;
>>> +    ),
>>> +
>>> +    TP_printk("id=%d",
>>> +          __entry->id)
>>> +);
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_open,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_close,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_start,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_stop,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_ping,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_nowayout,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_keep_alive,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +DEFINE_EVENT(dev_operations_template, watchdog_pretimeout,
>>> +         TP_PROTO(struct watchdog_device *wdd),
>>> +         TP_ARGS(wdd));
>>> +
>>> +/*
>>> + * These are all events with a device ID and a given timeout.
>>> + */
>>> +DECLARE_EVENT_CLASS(watchdog_timeout_template,
>>> +
>>> +    TP_PROTO(struct watchdog_device *wdd, u64 timeout),
>>> +
>>> +    TP_ARGS(wdd, timeout),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(__u32, id)
>>> +        __field(__u64, timeout)
>>
>>
>> Why u64 ? timeout is unsigned long.
> 
> ack! I will change it. (I am seeing unsigned int, am I missing something?).

Yes, you are correct.

Guenter
