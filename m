Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01504A0302
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351563AbiA1Vjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:39:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59648 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343843AbiA1Vjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:39:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD46BB82712
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 21:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2412AC340E7;
        Fri, 28 Jan 2022 21:39:50 +0000 (UTC)
Date:   Fri, 28 Jan 2022 16:39:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ftrace: Have architectures opt-in for mcount build time
 sorting
Message-ID: <20220128163948.721c8b12@gandalf.local.home>
In-Reply-To: <YfRcC/ggq90jw7Uc@redhat.com>
References: <20220127114249.03b1b52b@gandalf.local.home>
        <YfRcC/ggq90jw7Uc@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 16:11:39 -0500
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> The bisect finally landed on:
> 
>   72b3942a173c387b27860ba1069636726e208777 is the first bad commit
>   commit 72b3942a173c387b27860ba1069636726e208777
>   Author: Yinan Liu <yinan@linux.alibaba.com>
>   Date:   Sun Dec 12 19:33:58 2021 +0800
> 
>       scripts: ftrace - move the sort-processing in ftrace_init
> 
> and I can confirm that your updates today in "[for-linus][PATCH 00/10]
> tracing: Fixes for 5.17-rc1" fix or avoid the issue.  I just wanted to
> add my report in case this adds any future complications for mcount
> build time sorting.  Let me know if any additional tests would be
> helpful.

Thanks for letting me know. That patch set has already landed in Linus's
tree.


-- Steve
