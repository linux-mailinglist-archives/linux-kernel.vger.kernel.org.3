Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5075776FF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiGQPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiGQPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:19:37 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1ACE12;
        Sun, 17 Jul 2022 08:19:36 -0700 (PDT)
Date:   Sun, 17 Jul 2022 23:19:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658071174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz1AwDi0TADJJc/MT4EIs1y66eRS6Ot3v2L/c0ATXYI=;
        b=IM8u/HtG4g5eg9lWxdyAKv0n1q8t1zvT4Ief6w4+8mh1FmVTZDEdwMFoZTqNpmki07dLVb
        H+TqCzyZx/1cjjUVZwqmajPP3DxLnFDZL9YgV5nYEFtTJNM5sChLDU0c0akDPGogWi6LWx
        1SQq4XaJX3Pr7GDSal9moQX4fxqVV2U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V5 06/16] Documentation/rv: Add a basic documentation
Message-ID: <YtQodznMVSmwvhBr@geo.homenetwork>
References: <cover.1657745645.git.bristot@kernel.org>
 <72d6b6619c9c336b254f5e560ac4ee5f44cb3956.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72d6b6619c9c336b254f5e560ac4ee5f44cb3956.1657745645.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:17:22PM +0200, Daniel Bristot de Oliveira wrote:
> Add the runtime-verification.rst document, explaining the basics of RV
> and how to use the interface.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Tao Zhou <tao.zhou@linux.dev>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  Documentation/trace/index.rst                 |   1 +
>  Documentation/trace/rv/index.rst              |   9 +
>  .../trace/rv/runtime-verification.rst         | 233 ++++++++++++++++++
>  kernel/trace/rv/Kconfig                       |   3 +
>  kernel/trace/rv/rv.c                          |   3 +
>  5 files changed, 249 insertions(+)
>  create mode 100644 Documentation/trace/rv/index.rst
>  create mode 100644 Documentation/trace/rv/runtime-verification.rst
> +   runtime-verification.rst

[snip]

> +The user interface
> +==================
> +
> +The user interface resembles the tracing interface (on purpose). It is
> +currently at "/sys/kernel/tracing/rv/".
> +
> +The following files/folders are currently available:
> +
> +**available_monitors**
> +
> +- Reading list the available monitors, one per line
> +
> +For example::
> +
> +   # cat available_monitors
> +   wip
> +   wwnr
> +
> +**available_reactors**
> +
> +- Reading shows the available reactors, one per line.
> +
> +For example::
> +
> +   # cat available_reactors
> +   nop
> +   panic
> +   printk
> +
> +**enabled_monitors**:
> +
> +- Reading lists the enabled monitors, one per line
> +- Writing to it enables a given monitor
> +- Writing a monitor name with a '-' prefix disables it

s/-/!/

> +- Truncating the file disables all enabled monitors
> +
> +For example::
> +
> +   # cat enabled_monitors
> +   # echo wip > enabled_monitors
> +   # echo wwnr >> enabled_monitors
> +   # cat enabled_monitors
> +   wip
> +   wwnr
> +   # echo '!wip' >> enabled_monitors
> +   # cat enabled_monitors
> +   wwnr
> +   # echo > enabled_monitors
> +   # cat enabled_monitors
> +   #
> +
> +Note that it is possible to enable more than one monitor concurrently.
> +
> +
> +**monitoring_on**
> +
> +This is an on/off general switcher for monitoring. It resembles the
> +"tracing_on" switcher in the trace interface.
> +
> +- Writing "0" stops the monitoring
> +- Writing "1" continues the monitoring
> +- Reading returns the current status of the monitoring
> +
> +Note that it does not disable enabled monitors but stop the per-entity
> +monitors monitoring the events received from the system.
> +
> +**reacting_on**
> +
> +- Writing "0" prevents reactions for happening
> +- Writing "1" enable reactions
> +- Reading returns the current status of the monitoring

s/monitoring/reaction/
