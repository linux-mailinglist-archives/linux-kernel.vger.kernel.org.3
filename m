Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3710854EE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379590AbiFPXyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379601AbiFPXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:54:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ACA62BE0;
        Thu, 16 Jun 2022 16:53:58 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q140so2612111pgq.6;
        Thu, 16 Jun 2022 16:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=vOVvDVIkMtFSvKE+WBrOy5Mi7h7bWjJhd3uPliq1B+U=;
        b=G19pA1oY7hoG9D6Bbb1OJ1U0JTxfrvfKgV/meyPwMfZvTOxLlIu8hbDKRADHtMTfQH
         kFSi7EV8ex9e6OEdhDSuVKr3JE4B7DYnWcnW0PVrEkyciaVIVcc5GChomyDAMquxiLbA
         TffhxvN6cuPDWKO9R8FAwJn1SPdXF7GWyymgkTgbzlV05aY+GMwTWD0vtdYzJN6J4th3
         ZePA0ib4VfyOnSSbN5u0OU6b5I9DJQuwcNWCFEypTYt2iF8ep//Js/6bhMvLSPHbpwfe
         LRlmn5nfP8WF5WgLAkMTYDzl+gUodSGxV4kfGLgeOO+cgqDj4vZi9eu2Oyqlb5W7omMy
         sKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=vOVvDVIkMtFSvKE+WBrOy5Mi7h7bWjJhd3uPliq1B+U=;
        b=Xebe+4L3EVnJ5UEU3kyCd887G/6ZhCmdHIyxKpBVxUbJnyn7xOV5pDcTLPluVTw19B
         cCURHHF/cck5sfB1GmGx0mhMHqeqjgiws8kSZcDR3N6e0WEAwozjEKzG0oKh54YFTP28
         t8fsIs/lPTQmByLDKdeHZEj0f0BsFjXXuB5XS5H+h0jbdjr0PAIYGnTaUSqiGyscHf6a
         OKcCV5bd68rGWfQjzmeMjpDRYRtiTH4b+yZCWxc7y94alUq+FHbV0OsjbIC8AQLCfOqX
         CZO45ODeUxKoczK9+EhdCtKeZRpfGH+1ukuJzI1Kw/Ng6NcveWsW7pLFcUYFxT0rGN1Z
         GsUg==
X-Gm-Message-State: AJIora9qcxyX4C7fEGMDolH5H/BYKsmv6Opdyq+Sv4RYLlHWRNZDTMJJ
        4TOi8VmY+Z8tJoSjUnvYg1E=
X-Google-Smtp-Source: AGRyM1vHImOnh4obSVuu+LNUOWx+uxGdptT6jyOmvmKTeLxCn5y3y+2ItGSxYvryrv/YX8NeU3rDbg==
X-Received: by 2002:a62:1687:0:b0:50d:3364:46d4 with SMTP id 129-20020a621687000000b0050d336446d4mr7284036pfw.74.1655423638166;
        Thu, 16 Jun 2022 16:53:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902e8c200b001675d843332sm2173370plg.63.2022.06.16.16.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 16:53:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <17ade9e2-8fbe-ea80-93c1-9f1e291805b6@roeck-us.net>
Date:   Thu, 16 Jun 2022 16:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Gabriele Paoloni <gpaoloni@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
 <168af019-70d1-3237-dc9c-56a82beb5990@roeck-us.net>
 <04ca385b-47dc-5535-419e-1b814a383d1a@kernel.org>
 <CA+wEVJbvcMZbCroO2_rdVxLvYkUo-ePxCwsp5vbDpoqys4HGWQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V4 18/20] rv/monitor: Add safe watchdog monitor
In-Reply-To: <CA+wEVJbvcMZbCroO2_rdVxLvYkUo-ePxCwsp5vbDpoqys4HGWQ@mail.gmail.com>
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

On 6/16/22 08:43, Gabriele Paoloni wrote:
> 
> 
> On Thu, Jun 16, 2022 at 5:29 PM Daniel Bristot de Oliveira <bristot@kernel.org <mailto:bristot@kernel.org>> wrote:
> 
>     Hi Guenter,
> 
>     On 6/16/22 15:36, Guenter Roeck wrote:
>      > On 6/16/22 01:45, Daniel Bristot de Oliveira wrote:
>      >> The watchdog is an essential building block for the usage of Linux in
>      >> safety-critical systems because it allows the system to be monitored from
>      >> an external element - the watchdog hardware, acting as a safety-monitor.
>      >>
>      >> A user-space application controls the watchdog device via the watchdog
>      >> interface. This application, hereafter safety_app, enables the watchdog
>      >> and periodically pets the watchdog upon correct completion of the safety
>      >> related processing.
>      >>
>      >> If the safety_app, for any reason, stops pinging the watchdog,
>      >> the watchdog hardware can set the system in a fail-safe state. For
>      >> example, shutting the system down.
>      >>
>      >> Given the importance of the safety_app / watchdog hardware couple,
>      >> the interaction between these software pieces also needs some
>      >> sort of monitoring. In other words, "who monitors the monitor?"
>      >>
>      >> The safe watchdog (safe_wtd) RV monitor monitors the interaction between
>      >> the safety_app and the watchdog device, enforcing the correct sequence of
>      >> events that leads the system to a safe state.
>      >>
>      >> Furthermore, the safety_app can monitor the RV monitor by collecting the
>      >> events generated by the RV monitor itself via tracing interface. In this way,
>      >> closing the monitoring loop with the safety_app.
>      >>
>      >> To reach a safe state, the safe_wtd RV monitor requires the
>      >> safety_app to:
>      >>
>      >>     - Open the watchdog device
>      >>     - Start the watchdog
>      >>     - Set a timeout
>      >>     - ping at least once
>      >>
>      >> The RV monitor also avoids some undesired actions. For example, to have
>      >> other threads to touch the watchdog.
>      >>
>      >> The monitor also has a set of options, enabled via kernel command
>      >> line/module options. They are:
>      >>
>      >>     - watchdog_id: the device id to monitor (default 0).
>      >>     - dont_stop: once enabled, do not allow the RV monitor to be stopped
>      >>         (default off);
>      >>     - safe_timeout: define a maximum safe value that an user-space
>      >>         application can set as the watchdog timeout
>      >>         (default unlimited).
>      >>     - check_timeout: After every ping, check if the time left in the
>      >>         watchdog is less than or equal to the last timeout set
>      >>         for the watchdog. It only works for watchdog devices that
>      >>         provide the get_timeleft() function (default off).
>      >>
>      >> For further information, please refer to:
>      >>     Documentation/trace/rv/watchdog-monitor.rst
>      >>
>      >> The monitor specification was developed together with Gabriele Paoloni,
>      >> in the context of the Linux Foundation Elisa Project.
>      >>
>      >> Cc: Wim Van Sebroeck <wim@linux-watchdog.org <mailto:wim@linux-watchdog.org>>
>      >> Cc: Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
>      >> Cc: Jonathan Corbet <corbet@lwn.net <mailto:corbet@lwn.net>>
>      >> Cc: Steven Rostedt <rostedt@goodmis.org <mailto:rostedt@goodmis.org>>
>      >> Cc: Ingo Molnar <mingo@redhat.com <mailto:mingo@redhat.com>>
>      >> Cc: Thomas Gleixner <tglx@linutronix.de <mailto:tglx@linutronix.de>>
>      >> Cc: Peter Zijlstra <peterz@infradead.org <mailto:peterz@infradead.org>>
>      >> Cc: Will Deacon <will@kernel.org <mailto:will@kernel.org>>
>      >> Cc: Catalin Marinas <catalin.marinas@arm.com <mailto:catalin.marinas@arm.com>>
>      >> Cc: Marco Elver <elver@google.com <mailto:elver@google.com>>
>      >> Cc: Dmitry Vyukov <dvyukov@google.com <mailto:dvyukov@google.com>>
>      >> Cc: "Paul E. McKenney" <paulmck@kernel.org <mailto:paulmck@kernel.org>>
>      >> Cc: Shuah Khan <skhan@linuxfoundation.org <mailto:skhan@linuxfoundation.org>>
>      >> Cc: Gabriele Paoloni <gpaoloni@redhat.com <mailto:gpaoloni@redhat.com>>
>      >> Cc: Juri Lelli <juri.lelli@redhat.com <mailto:juri.lelli@redhat.com>>
>      >> Cc: Clark Williams <williams@redhat.com <mailto:williams@redhat.com>>
>      >> Cc: linux-doc@vger.kernel.org <mailto:linux-doc@vger.kernel.org>
>      >> Cc: linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>
>      >> Cc: linux-trace-devel@vger.kernel.org <mailto:linux-trace-devel@vger.kernel.org>
>      >> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org <mailto:bristot@kernel.org>>
>      >> ---
>      >>   include/trace/events/rv.h                    |  11 +
>      >>   kernel/trace/rv/Kconfig                      |  10 +
>      >>   kernel/trace/rv/Makefile                     |   1 +
>      >>   kernel/trace/rv/monitors/safe_wtd/safe_wtd.c | 300 +++++++++++++++++++
>      >>   kernel/trace/rv/monitors/safe_wtd/safe_wtd.h |  84 ++++++
>      >>   5 files changed, 406 insertions(+)
>      >>   create mode 100644 kernel/trace/rv/monitors/safe_wtd/safe_wtd.c
>      >>   create mode 100644 kernel/trace/rv/monitors/safe_wtd/safe_wtd.h
>      >>
>      >> diff --git a/include/trace/events/rv.h b/include/trace/events/rv.h
>      >> index 00f11a8dac3b..895eb3435ed7 100644
>      >> --- a/include/trace/events/rv.h
>      >> +++ b/include/trace/events/rv.h
>      >> @@ -66,6 +66,17 @@ DEFINE_EVENT(error_da_monitor, error_wip,
>      >>            TP_PROTO(char *state, char *event),
>      >>            TP_ARGS(state, event));
>      >>   #endif /* CONFIG_RV_MON_WIP */
>      >> +
>      >> +#ifdef CONFIG_RV_MON_SAFE_WTD
>      >> +DEFINE_EVENT(event_da_monitor, event_safe_wtd,
>      >> +         TP_PROTO(char *state, char *event, char *next_state, bool safe),
>      >> +         TP_ARGS(state, event, next_state, safe));
>      >> +
>      >> +DEFINE_EVENT(error_da_monitor, error_safe_wtd,
>      >> +         TP_PROTO(char *state, char *event),
>      >> +         TP_ARGS(state, event));
>      >> +#endif /* CONFIG_RV_MON_SAFE_WTD */
>      >> +
>      >>   #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
>      >>     #ifdef CONFIG_DA_MON_EVENTS_ID
>      >> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>      >> index 21f03fb3101a..b14ae63e792b 100644
>      >> --- a/kernel/trace/rv/Kconfig
>      >> +++ b/kernel/trace/rv/Kconfig
>      >> @@ -45,6 +45,16 @@ config RV_MON_WWNR
>      >>         illustrates the usage of per-task monitor. The model is
>      >>         broken on purpose: it serves to test reactors.
>      >>   +config RV_MON_SAFE_WTD
>      >> +    select DA_MON_EVENTS_IMPLICIT
>      >> +    bool "Safety watchdog"
>      >> +    help
>      >> +      Enable safe_wtd, this monitor observes the interaction
>      >> +      between a user-space safety monitor and a watchdog device.
>      >> +
>      >> +      For futher information see:
>      >> +        Documentation/trace/rv/safety-monitor.rst
>      >> +
>      >>   config RV_REACTORS
>      >>       bool "Runtime verification reactors"
>      >>       default y if RV
>      >> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
>      >> index 963d14875b45..904db96c7eae 100644
>      >> --- a/kernel/trace/rv/Makefile
>      >> +++ b/kernel/trace/rv/Makefile
>      >> @@ -3,6 +3,7 @@
>      >>   obj-$(CONFIG_RV) += rv.o
>      >>   obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
>      >>   obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
>      >> +obj-$(CONFIG_RV_MON_SAFE_WTD) += monitors/safe_wtd/safe_wtd.o
>      >>   obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>      >>   obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
>      >>   obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
>      >> diff --git a/kernel/trace/rv/monitors/safe_wtd/safe_wtd.c
>      >> b/kernel/trace/rv/monitors/safe_wtd/safe_wtd.c
>      >> new file mode 100644
>      >> index 000000000000..9856e0770d0d
>      >> --- /dev/null
>      >> +++ b/kernel/trace/rv/monitors/safe_wtd/safe_wtd.c
>      >> @@ -0,0 +1,300 @@
>      >> +// SPDX-License-Identifier: GPL-2.0
>      >> +#include <linux/ftrace.h>
>      >> +#include <linux/tracepoint.h>
>      >> +#include <linux/kernel.h>
>      >> +#include <linux/module.h>
>      >> +#include <linux/init.h>
>      >> +#include <linux/rv.h>
>      >> +#include <rv/instrumentation.h>
>      >> +#include <rv/da_monitor.h>
>      >> +
>      >> +#include <linux/watchdog.h>
>      >> +#include <linux/moduleparam.h>
>      >> +
>      >> +#include <trace/events/rv.h>
>      >> +#include <trace/events/watchdog.h>
>      >> +
>      >> +#define MODULE_NAME "safe_wtd"
>      >> +
>      >> +/*
>      >> + * This is the self-generated part of the monitor. Generally, there is no need
>      >> + * to touch this section.
>      >> + */
>      >> +#include "safe_wtd.h"
>      >> +
>      >> +/*
>      >> + * Declare the deterministic automata monitor.
>      >> + *
>      >> + * The rv monitor reference is needed for the monitor declaration.
>      >> + */
>      >> +struct rv_monitor rv_safe_wtd;
>      >> +DECLARE_DA_MON_GLOBAL(safe_wtd, char);
>      >> +
>      >> +/*
>      >> + * custom: safe_timeout is the maximum value a watchdog monitor
>      >> + * can set. This value is registered here to duplicate the information.
>      >> + * In this way, a miss-behaving monitor can be detected.
>      >> + */
>      >> +static int safe_timeout = ~0;
>      >> +module_param(safe_timeout, int, 0444);
>      >> +
>      >> +/*
>      >> + * custom: if check_timeout is set, the monitor will check if the time left
>      >> + * in the watchdog is less than or equals to the last safe timeout set by
>      >> + * user-space. This check is done after each ping. In this way, if any
>      >> + * code by-passed the watchdog dev interface setting a higher (so unsafe)
>      >> + * timeout, this monitor will catch the side effect and react.
>      >> + */
>      >> +static int last_timeout_set = 0;
>      >> +static int check_timeout = 0;
>      >> +module_param(check_timeout, int, 0444);
>      >> +
>      >> +/*
>      >> + * custom: if dont_stop is set the monitor will react if stopped.
>      >> + */
>      >> +static int dont_stop = 0;
>      >> +module_param(dont_stop, int, 0444);
>      >> +
>      >> +/*
>      >> + * custom: there are some states that are kept after the watchdog is closed.
>      >> + * For example, the nowayout state.
>      >> + *
>      >> + * Thus, the RV monitor needs to keep track of these states after a start/stop
>      >> + * of the RV monitor itself, and should not reset after each restart -
>      >> keeping the
>      >> + * know state until the system shutdown.
>      >> + *
>      >> + * If for an unknown reason an RV monitor would like to reset the RV monitor
>      >> at each
>      >> + * RV monitor start, set it to one.
>      >> + */
>      >> +static int reset_on_restart = 0;
>      >> +module_param(reset_on_restart, int, 0444);
>      >> +
>      >> +/*
>      >> + * open_pid takes note of the first thread that opened the watchdog.
>      >> + *
>      >> + * Any other thread that generates an event will cause an "other_threads"
>      >> + * event in the monitor.
>      >> + */
>      >> +static int open_pid = 0;
>      >
>      > Userspace could open a watchdog, create a child process, and handle it
>      > from the child. That is perfectly valid.
> 
>     Right! It is a correct usage of the watchdog subsystem.
> 
>     However, the idea here is to allow a "restricted" set of operations based on the
>     safety analysis made by people in the LF Elisa Workgroup (Gabriele Paoloni in Cc:).
> 
> 
> Yes this is correct. This model represents the instance of a specific monitor
> resulting from a specific use case that was analysed in ELISA. From my
> understanding nothing prevents extending the monitor to a more complex
> model in the future that may eventually result in a group of allowed
> processes for the WTD manipulation...
> 
> Kind Regards
> Gab
> 
> 
>     One of the specifications says that: only one process should touch the watchdog.
> 
>     There are details about it in the "watchdog-monitor.rst," section "RV monitor
>     specification."
> 
>     There could be another monitor, a less resticted one, in which the operation you
>     mention would be allowed.
> 
>     I will complement this commit log in the next version of the patch set,
>     clarifying that it is not a "full representation of the watchdog operations" but
>     a restricted set of operations specified by...
> 
>      >> +
>      >> +/*
>      >> + * watchdog_id: the watchdog to monitor
>      >> + */
>      >> +static int watchdog_id = 0;
>      >> +module_param(watchdog_id, int, 0444);
>      >
>      > Limiting the watcher to a single watchdog sounds less than perfect.
>      > What if the system supports more than one, more than one is enabled,
>      > and the non-monitored watchdog misbehaves ?
> 
>     I can add one monitor per watchdog dev. The easiest way would be adding a
>     "struct da_monitor" variable in the watchdog_device structure, e.g.,
> 
>     struct watchdog_device {
>     ...
>              #ifdef CONFIG_RV_MON_SAFE_WTD
>              struct da_monitor da_mon;
>              #endif
>     ...
>     }
> 

In my opinion shis should be dynamically allocated and not waste space in driver
code if unused.

>     A simplified version of the the "per task" monitor, in the patch 01, changes in
>     include/linux/sched.h.
> 
>      >> +
>      >> +static void handle_nowayout(void *data, struct watchdog_device *wdd)
>      >> +{
>      >> +    if (wdd->id != watchdog_id)
>      >> +        return;
>      >> +
>      >> +    da_handle_init_run_event_safe_wtd(nowayout_safe_wtd);
>      >> +}
>      >> +
>      >> +static void handle_close(void *data, struct watchdog_device *wdd)
>      >> +{
>      >> +    if (wdd->id != watchdog_id)
>      >> +        return;
>      >> +
>      >> +    if (open_pid && current->pid != open_pid) {
>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>      >> +    } else {
>      >> +        da_handle_event_safe_wtd(close_safe_wtd);
>      >> +        open_pid = 0;
>      >> +    }
>      >> +}
>      >> +
>      >> +static void handle_open(void *data, struct watchdog_device *wdd)
>      >> +{
>      >> +    if (wdd->id != watchdog_id)
>      >> +        return;
>      >> +
>      >> +    if (open_pid && current->pid != open_pid) {
>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>      >> +    } else {
>      >> +        da_handle_init_run_event_safe_wtd(open_safe_wtd);
>      >> +        open_pid = current->pid;
>      >> +    }
>      >> +}
>      >> +
>      >> +static void blocked_events(void *data, struct watchdog_device *wdd)
>      >> +{
>      >> +    if (wdd->id != watchdog_id)
>      >> +        return;
>      >> +
>      >> +    if (open_pid && current->pid != open_pid) {
>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>      >> +        return;
>      >> +    }
>      >> +    da_handle_event_safe_wtd(other_threads_safe_wtd);
>      >> +}
>      >> +
>      >> +static void blocked_events_timeout(void *data, struct watchdog_device *wdd,
>      >> u64 timeout)
>      >> +{
>      >> +    blocked_events(data, wdd);
>      >> +}
>      >> +
>      >> +static void handle_ping(void *data, struct watchdog_device *wdd)
>      >> +{
>      >> +    char msg[128];
>      >> +    unsigned int timeout;
>      >> +
>      >> +    if (wdd->id != watchdog_id)
>      >> +        return;
>      >> +
>      >> +    if (open_pid && current->pid != open_pid) {
>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>      >> +        return;
>      >> +    }
>      >> +
>      >> +    da_handle_event_safe_wtd(ping_safe_wtd);
>      >> +
>      >> +    if (!check_timeout)
>      >> +        return;
>      >> +
>      >> +    if (wdd->ops->get_timeleft) {
>      >> +        timeout = wdd->ops->get_timeleft(wdd);
>      >> +        if (timeout > last_timeout_set) {
>      >> +            snprintf(msg, 128,
>      >> +                 "watchdog timeout is %u > than previously set (%d)\n",
>      >> +                 timeout, last_timeout_set);
>      >> +            cond_react(msg);
>      >> +        }
>      >> +    } else {
>      >> +        snprintf(msg, 128, "error getting timeout: option not supported\n");
>      >
>      > This is not an error. The get_timeleft callback is optional.
> 
>     Right... but this part of the code is only reachable if the user explicitly
>     asked to check the timeout (if (!check_timeout)...return before this code).
> 
>     So, if the user only considers the system safe if the monitor also checks the
>     written timeout, but the watchdog is one of those that do not have the callback
>     implemented (which is ok for a Linux watchdog), the monitor captures this
>     "undesired" behavior.
> 
>     This monitor is not checking if the watchdog subsystem is correct at its
>     plenitude, it is checking if the watchdog usage is following a set of
>     specifications (raised by people in the LF Elisa workgroup).
> 

The kernel is not intended for special use cases. The callback is optional,
period. The test for check_timeout is way too late. A check like this should
be made when the check is requested, not when it is executed - in other words,
when the user requests it. That request should fail.

>      >> +        cond_react(msg);
>      >> +    }
>      >> +}
>      >> +
> 
>     [...]
> 
>      >> +
>      >> +struct automaton_safe_wtd automaton_safe_wtd = {
>      >> +    .state_names = {
>      >> +        "init",
>      >> +        "closed_running",
>      >> +        "closed_running_nwo",
>      >> +        "nwo",
>      >> +        "opened",
>      >> +        "opened_nwo",
>      >> +        "reopened",
>      >> +        "safe",
>      >> +        "safe_nwo",
>      >> +        "set",
>      >> +        "set_nwo",
>      >> +        "started",
>      >> +        "started_nwo",
>      >> +        "stoped"
>      >> +    },
>      >> +    .event_names = {
>      >> +        "close",
>      >> +        "nowayout",
>      >> +        "open",
>      >> +        "other_threads",
>      >> +        "ping",
>      >> +        "set_safe_timeout",
>      >> +        "start",
>      >> +        "stop"
>      >> +    },
>      >> +    .function = {
>      >> +        {                          -1,                nwo_safe_wtd,             opened_safe_wtd,               init_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
>      >> +        {                          -1, closed_running_nwo_safe_wtd,           reopened_safe_wtd,     closed_running_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
>      >> +        {                          -1, closed_running_nwo_safe_wtd,        started_nwo_safe_wtd, closed_running_nwo_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
>      >> +        {                          -1,                nwo_safe_wtd,         opened_nwo_safe_wtd,                nwo_safe_wtd,                          -1,                          -1,                         -1,                          -1 },
>      >> +        {               init_safe_wtd,                          -1,                          -1,                          -1,                          -1,                          -1,           started_safe_wtd,                          -1 },
>      >> +        {                nwo_safe_wtd,                          -1,                          -1,                          -1,                          -1,                          -1,       started_nwo_safe_wtd,                          -1 },
>      >> +        {     closed_running_safe_wtd,                          -1,                          -1,                          -1,                          -1,                set_safe_wtd,                          1,             opened_safe_wtd },
>      >> +        {     closed_running_safe_wtd,                          -1,                          -1,                          -1,               safe_safe_wtd,                          -1,                          1,             stoped_safe_wtd },
>      >> +        { closed_running_nwo_safe_wtd,                          -1,                          -1,                          -1,           safe_nwo_safe_wtd,                          -1,                         -1,                          -1 },
>      >> +        {                          -1,                          -1,                          -1,                          -1,               safe_safe_wtd,                          -1,                         -1,                          -1 },
>      >> +        {                          -1,                          -1,                          -1,                          -1,           safe_nwo_safe_wtd,                          -1,                         -1,                          -1 },
>      >> +        {     closed_running_safe_wtd,                          -1,                          -1,                          -1,                          -1,                set_safe_wtd,                         -1,             stoped_safe_wtd },
>      >> +        { closed_running_nwo_safe_wtd,                          -1,                          -1,                          -1,                          -1,            set_nwo_safe_wtd,                         -1,                          -1 },
>      >> +        {               init_safe_wtd,                          -1,                          -1,                          -1,                          -1,                          -1,                         -1,                          -1 },
>      >> +    },
>      >> +    .initial_state = init_safe_wtd,
>      >> +    .final_states = { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
>      >
>      > I find this event table all but impossible to verify.
> 
>     It is a matrix. Lines are states, and columns are events.
> 
>     On a given state/line, receiving a given event/column, the data is the next
>     state/row.
> 

I am aware of that, and I did program state machines before.

>     For instance, let's say "init" (row 0), event "nwo" (column 1), and the next
>     state is the "nwo" (row 3).
> 
>     -1 means invalid/blocked state (yeah, maybe it is better to have an #define
>     INVALID_STATE -1).
> 
>     This is the C representation of an automaton, following the formal definition of
>     a deterministic automaton. I've added an explanation of this representation in
>     the documentation (patch 15, file da_monitor_synthesis.rst).
> 
>     A deeper look into this subject is here (peer-reviewed conference paper at
>     Software Engineer and Formal Methods 2019):
>     https://bristot.me/wp-content/uploads/2019/09/paper.pdf <https://bristot.me/wp-content/uploads/2019/09/paper.pdf>
> 
>     One could translate it back to the automaton's graphical format... to a format
>     of by a tool used to analyze automaton properties... that is the good point of
>     using a well-established formalism. (The bad part is that they are often
>     boring... c'est la vie :-)).
> 

If the above state machine fails, no one but the authors will be able to even
remotely figure out what happened, and if the watchdog driver is at fault or
its monitor. It is a state machine making assumptions about state transitions,
sure, but who knows if those asssumptions are even remotely correct or match
reality. For example, I have no idea if the lack of a 'ping' function is handled
correctly,  if the lack of a 'stop' function is handled correctly, or what
happens if any of the driver functions returns an error.

I already found three assumptions which do not or not necessarily match
reality:

- The function to read the remaining timeout is optional and must not be
   used unconditionally, and its lack is not an error.
- The requested timeout (and pretimeout) do not have to match the actually
   configured timeout, and userspace must not rely on the assumption that
   the values match.
- The code assumes that the process opening the watchdog and the process
   accessing it are the same. While that is in general the case, it might
   well be that some application opens the watchdog and then handles it
   from a child process.

And that is just after briefly browsing through the code.

I am open to suggestions from others, but at this point I have serious doubts
that this code is maintainable in the kernel.

Guenter
