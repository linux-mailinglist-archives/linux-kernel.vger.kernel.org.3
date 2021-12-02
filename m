Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496B466B72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376911AbhLBVQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376289AbhLBVQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:16:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3603C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fqRoRE2K7Q81+lr5ELTYwEJc4onjPMD/PfhGxE8TtFI=; b=jTgV2q+Re04Omh/YVAepuvzBNT
        m1KGHUkFHQezlGvw/oyBq8mie8eQ0ZC4mRjMXNviBGs568buxQ5uXg9um8HSUHwt/Ne1wKmO1W337
        yoxZlcU1TMzrqXdRbsCTxgt09Tjt9hJpKpsJXW3eHV136AdsZd38f6f5Ds0R+22AD9XgM7S7Gf6XI
        qVIRVG3pAJ30D58NByuUSDJDKNXI9+ky+F4WNePFLQjvw71lbrKTUiA4lOD3rzHYD8PQPJZuAGnru
        S0o3qglT4Zjg4LpPqdeodZsjITBJog6wZAC+dCV7VyO/PScrCTdC8CPIa1NMsxgE3hL/k1ykOwIr9
        KMsH0lxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mstNt-005e3t-DA; Thu, 02 Dec 2021 21:12:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABC469810D4; Thu,  2 Dec 2021 22:12:53 +0100 (CET)
Date:   Thu, 2 Dec 2021 22:12:53 +0100
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
Message-ID: <20211202211253.GC16608@worktop.programming.kicks-ass.net>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 06:46:43PM +0100, Sebastian Andrzej Siewior wrote:
> This mini-series unbreaks lockdep's selftest on PREEMPT_RT.
> The last two are needed to compile the rtmutex based spinlock
> implementation which is used on PREEMPT_RT.

Thanks! (fixed up that first thiny), lemme feed it to the robots.
