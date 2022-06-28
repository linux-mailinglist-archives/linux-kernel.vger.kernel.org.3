Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8755ED82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiF1TE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiF1TEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:04:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457903819C;
        Tue, 28 Jun 2022 12:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1F67B81E05;
        Tue, 28 Jun 2022 19:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CD7C3411D;
        Tue, 28 Jun 2022 19:02:46 +0000 (UTC)
Date:   Tue, 28 Jun 2022 15:02:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 09/20] rv/monitor: wip instrumentation and
 Makefile/Kconfig entries
Message-ID: <20220628150245.6c59ea52@gandalf.local.home>
In-Reply-To: <4d975ef5-7e50-9241-1a3e-f0f9bad9c5b5@infradead.org>
References: <cover.1655368610.git.bristot@kernel.org>
        <9c05a95927c18bebcf0eb79bef15ec59667bc08c.1655368610.git.bristot@kernel.org>
        <4d975ef5-7e50-9241-1a3e-f0f9bad9c5b5@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 14:00:10 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 6/16/22 01:44, Daniel Bristot de Oliveira wrote:
> > diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> > index 1eafb5adcfcb..e9246b0bec9d 100644
> > --- a/kernel/trace/rv/Kconfig
> > +++ b/kernel/trace/rv/Kconfig
> > @@ -26,6 +26,13 @@ menuconfig RV
> >  	  the system behavior.
> >  
> >  if RV
> > +config RV_MON_WIP
> > +	depends on PREEMPTIRQ_TRACEPOINTS
> > +	select DA_MON_EVENTS_IMPLICIT
> > +	bool "WIP monitor"  
> 
> Does WIP mean work-in-progress?  (It does to me.)
> 
> If not, please explain what it means in the help text.

Yeah, that's exactly what I thought too ;-)

-- Steve

> 
> > +	help
> > +	  Enable WIP sample monitor, this is a sample monitor that
> > +	  illustrates the usage of per-cpu monitors.  
> 
> thanks.

