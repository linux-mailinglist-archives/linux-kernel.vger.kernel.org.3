Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF69846A08F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445182AbhLFQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443299AbhLFQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:00:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D9BC08EC6A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+4uYiAUVHEZBdlClpRpv7Z6qgkbEzjWTpwlkwL/Pd+0=; b=P7TOtAW5C3377rW5iY31hbeaNn
        seELf8txe8z0BmT6cMx9qnPDGa3sYr6UKVA2MkCLOHV2XbVm6ngsLNu4d2SGpTAWLbdJ5Wyvh15h6
        ZBd5FCsUtScMA7R6cTQs7EwqPOaQOsb0YH1XcZtxc2GxSYIpcTEpdVENVK0+r5qm8etIHTPsSib9c
        fCluo43Odox3kZMxb6gUOmB5CW6RUyCfIGbvqy5V5U6xJ7z42mxS/SrLUc4XKg5sqk+qJuBxs5jR4
        ZJjKHTgpM/wxvqkH6BD7y6BQMun2RS74ozO1T64q/aM2MD4T7g2ZyZ15Qdwy8PrbWK40OAUmJcn3s
        U3+3PB+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muG94-0058J7-Or; Mon, 06 Dec 2021 15:43:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BABD3002DB;
        Mon,  6 Dec 2021 16:43:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4ED5B2023D0F9; Mon,  6 Dec 2021 16:43:14 +0100 (CET)
Date:   Mon, 6 Dec 2021 16:43:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/11] lockdep: Unbreak lockdep's selftest work on
 PREEMPT_RT.
Message-ID: <Ya4vkmFek71v88+t@hirez.programming.kicks-ass.net>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
 <20211202211253.GC16608@worktop.programming.kicks-ass.net>
 <20211206152618.avqghqegykwjnxm5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206152618.avqghqegykwjnxm5@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:26:18PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-12-02 22:12:53 [+0100], Peter Zijlstra wrote:
> > Thanks! (fixed up that first thiny), lemme feed it to the robots.
> 
> Thank you. I see bots' commit mail for 1-9. I don't see them for 10+11
> but then I also don't see those two in your tree.
> What should I do with them?

I've no idea wth happened there, let me go fix that.
