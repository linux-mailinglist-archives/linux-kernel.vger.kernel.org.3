Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043624E455D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiCVRnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbiCVRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:43:07 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DFC888E1;
        Tue, 22 Mar 2022 10:41:32 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id l2so34975549ybe.8;
        Tue, 22 Mar 2022 10:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBwvYMbRVWzNNTUELOPjunMscPYO6cMzGqNzPKWdzP4=;
        b=pqSkVKr9o5xxU9E3uC1DqaDY4d7CFIftzyPbBG9upaShWKRLQoQrNJ+dKnhHwaWOhf
         gS9dPn0tEt0rN4N6GmQ0IdeuRavH+Tjhx965wW1I/Q74CdmACK4A1BkbcKmkd7KUx67/
         rPuGZPAaFS8nrgmTloz1H6wMLH2AMF92+5mCMqJ9OnmEU5vHlxMGr/31fheAlMkAQI/d
         ssOI4qflSmrHI4ue8FY8hCsaOjSH/87iqFDlVlxVVbn6qCwcgtJIgODh0BiU8HVLEFtg
         JDDtXSfIrZ1oH8ylsOX1pTJm58WgTVZ5IpjcAlwOUmKrfI9GvWNTtRkfDaKpj0fq5svv
         Xd1Q==
X-Gm-Message-State: AOAM5331pEgSJ48pa9L1VNpUc1402f/3GwcGy5AU14SKIVEzKZGoDgq/
        Xoms/5bil+yB0ZqTP9r+Mbeel+chmJ8D7S7wK1A=
X-Google-Smtp-Source: ABdhPJxQ4E8QnsbmqO3EZO6txiQD37jFX04p93gcdE/1YLnV3YAWltpIKi/mcrTNopQ2Ayq1ac6N0Ls0Fa9Cpq5Tvyg=
X-Received: by 2002:a25:508:0:b0:633:bcf2:d29a with SMTP id
 8-20020a250508000000b00633bcf2d29amr19967378ybf.81.1647970891362; Tue, 22 Mar
 2022 10:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220321012216.23724-1-rdunlap@infradead.org>
In-Reply-To: <20220321012216.23724-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Mar 2022 18:41:20 +0100
Message-ID: <CAJZ5v0jBFOWZZrGuBb0GyJa3rKRwSYXrMFOtGu8jLnQ+OPtXHw@mail.gmail.com>
Subject: Re: [PATCH] Docs: admin/kernel-parameters: edit a few boot options
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 2:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Clean up some of admin-guide/kernel-parameters.txt:
>
> a. "smt" should be "smt=" (S390)
> b. add "smt-enabled" for POWERPC
> c. Sparc supports the vdso= boot option
> d. make the tp_printk options (2) formatting similar to other options
>    by adding spacing
> e. add "trace_clock=" with a reference to Documentation/trace/ftrace.rst
> f. use [IA-64] as documented instead of [ia64]
> g. fix formatting and text for test_suspend=

This ->

> h. fix formatting for swapaccount=
> i. fix formatting and grammar for video.brightness_switch_enabled=

-> and the last one are fine with me, but I suppose that there will be a v2?

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-ia64@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   33 +++++++++-----
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> --- linux-next-20220318.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20220318/Documentation/admin-guide/kernel-parameters.txt
> @@ -2814,7 +2814,7 @@
>                         different yeeloong laptops.
>                         Example: machtype=lemote-yeeloong-2f-7inch
>
> -       max_addr=nn[KMG]        [KNL,BOOT,ia64] All physical memory greater
> +       max_addr=nn[KMG]        [KNL,BOOT,IA-64] All physical memory greater
>                         than or equal to this physical address is ignored.
>
>         maxcpus=        [SMP] Maximum number of processors that an SMP kernel
> @@ -3057,7 +3057,7 @@
>
>         mga=            [HW,DRM]
>
> -       min_addr=nn[KMG]        [KNL,BOOT,ia64] All physical memory below this
> +       min_addr=nn[KMG]        [KNL,BOOT,IA-64] All physical memory below this
>                         physical address is ignored.
>
>         mini2440=       [ARM,HW,KNL]
> @@ -5382,13 +5382,19 @@
>                                 1: Fast pin select (default)
>                                 2: ATC IRMode
>
> -       smt             [KNL,S390] Set the maximum number of threads (logical
> +       smt=            [KNL,S390] Set the maximum number of threads (logical
>                         CPUs) to use per physical CPU on systems capable of
>                         symmetric multithreading (SMT). Will be capped to the
>                         actual hardware limit.
>                         Format: <integer>
>                         Default: -1 (no limit)
>
> +       smt-enabled=    [PPC 64-bit] Enable SMT, disable SMT, or set the
> +                       maximum number of threads. This can be used to override
> +                       the Open Firmware (OF) option.
> +                       Format: on | off | <integer>
> +                       Default: all threads enabled
> +
>         softlockup_panic=
>                         [KNL] Should the soft-lockup detector generate panics.
>                         Format: 0 | 1
> @@ -5768,8 +5774,9 @@
>                         This parameter controls use of the Protected
>                         Execution Facility on pSeries.
>
> -       swapaccount=[0|1]
> -                       [KNL] Enable accounting of swap in memory resource
> +       swapaccount=    [KNL]
> +                       Format: [0|1]
> +                       Enable accounting of swap in memory resource
>                         controller if no parameter or 1 is given or disable
>                         it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
>
> @@ -5815,7 +5822,8 @@
>
>         tdfx=           [HW,DRM]
>
> -       test_suspend=   [SUSPEND][,N]
> +       test_suspend=   [SUSPEND]
> +                       Format: { "mem" | "standby" | "freeze" }[,N]
>                         Specify "mem" (for Suspend-to-RAM) or "standby" (for
>                         standby suspend) or "freeze" (for suspend type freeze)
>                         as the system sleep state during system startup with
> @@ -5902,6 +5910,8 @@
>         trace_buf_size=nn[KMG]
>                         [FTRACE] will set tracing buffer size on each cpu.
>
> +       trace_clock=    [FTRACE] See Documentation/trace/ftrace.rst
> +
>         trace_event=[event-list]
>                         [FTRACE] Set and start specified trace events in order
>                         to facilitate early boot debugging. The event-list is a
> @@ -5924,7 +5934,7 @@
>                         See also Documentation/trace/ftrace.rst "trace options"
>                         section.
>
> -       tp_printk[FTRACE]
> +       tp_printk       [FTRACE]
>                         Have the tracepoints sent to printk as well as the
>                         tracing ring buffer. This is useful for early boot up
>                         where the system hangs or reboots and does not give the
> @@ -5946,7 +5956,7 @@
>                         frequency tracepoints such as irq or sched, can cause
>                         the system to live lock.
>
> -       tp_printk_stop_on_boot[FTRACE]
> +       tp_printk_stop_on_boot [FTRACE]
>                         When tp_printk (above) is set, it can cause a lot of noise
>                         on the console. It may be useful to only include the
>                         printing of events during boot up, as user space may
> @@ -6295,7 +6305,7 @@
>                                         HIGHMEM regardless of setting
>                                         of CONFIG_HIGHPTE.
>
> -       vdso=           [X86,SH]
> +       vdso=           [X86,SH,SPARC]
>                         On X86_32, this is an alias for vdso32=.  Otherwise:
>
>                         vdso=1: enable VDSO (the default)
> @@ -6321,11 +6331,12 @@
>         video=          [FB] Frame buffer configuration
>                         See Documentation/fb/modedb.rst.
>
> -       video.brightness_switch_enabled= [0,1]
> +       video.brightness_switch_enabled= [ACPI]
> +                       Format: [0|1]
>                         If set to 1, on receiving an ACPI notify event
>                         generated by hotkey, video driver will adjust brightness
>                         level and then send out the event to user space through
> -                       the allocated input device; If set to 0, video driver
> +                       the allocated input device. If set to 0, video driver
>                         will only send out the event without touching backlight
>                         brightness level.
>                         default: 1
