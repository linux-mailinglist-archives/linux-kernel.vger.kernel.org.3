Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45EE468476
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384657AbhLDL3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbhLDL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:29:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2390C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bVB5oIsXQHv4ziTx9938Q2uNGGtepbHu4+yJBjfeTCE=; b=kZeHnS8DVZ4A6f7CkGLYe7B2mN
        XrsByLAbrSXCcLyGyIV0PzKclteS2iio9YoTW4s5LuQLH14IbHgcVIFEbVW3xzigMhuuyfdDVNnIe
        uNlH8DXA2aiOP+WdXdSBWSH+0uWo99InJThK2EQ7DHH522sCw6gm3Zg1218/otMGVBDgEDd67ANL2
        8JL2jIP0d1ovBK2gMm6I7BL+2uoIRNi7c5usU6Pr7HCceuoNDQi3oEIrr5WYA73845LWLlnLcoWsX
        mXsTvC1OLKewixGR7hpsxfgOezT33fR2h4lyP861Rz5SzJKjuuhizvQr7lXl0YkYQdm4COKXu8Fst
        NQvth2Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtT9S-00Co5l-MR; Sat, 04 Dec 2021 11:24:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1EF598106D; Sat,  4 Dec 2021 12:24:22 +0100 (CET)
Date:   Sat, 4 Dec 2021 12:24:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, mgorman@suse.de, mingo@redhat.com,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yangyicong@hisilicon.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2] sched/fair: Document the slow path and fast path in
 select_task_rq_fair
Message-ID: <20211204112422.GU16608@worktop.programming.kicks-ass.net>
References: <20211016111109.5559-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016111109.5559-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 07:11:09PM +0800, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> All People I know including myself took a long time to figure out
> that typical wakeup will always go to fast path and never go to
> slow path except WF_FORK and WF_EXEC.
> Vincent reminded me once in a linaro meeting and made me understand
> slow path won't happen for WF_TTWU. But my other friends repeatedly
> wasted a lot of time on testing this path like me before I reminded
> them.
> So obviously the code needs some document.
> 
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---

Thanks!
