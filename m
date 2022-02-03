Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B6A4A90BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355837AbiBCWlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355673AbiBCWlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:41:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F2FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FA+FMEotltkoLgw9JH1xcsF73Nw5GMrYFFo4FihM1Fs=; b=NtDICGlLMd+dDNZde0bnyiFhFz
        U7pBFrDnYL0mrjJ+VG7aJKNyJ0uPpisfLqYL66VYqrQil+XWFBhVqTXL9uQhBSwSuxb+/B94NKxRU
        xRWwftRBS4EI62T+WagTmvhir3ZaZ0vtUBVOhAv+N8UKEvCza+a+Niky7z52xkd/czPK7ojFaTGu+
        c4308Z6sKZlANgHKDB1hJlDCyeI/TJjXjtpv03FZzddJVs8vzpnJ2oBi1wRBLejIQzP4QnME201Ub
        tctizkzXr0DQynwGfqxwKOYrz/zE+odK5BqYUCEbny24fWC8poU8GrbGMnS7+oR1qCOI4zkVyfBg7
        TLYSThQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFkmY-006eRb-Uh; Thu, 03 Feb 2022 22:40:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E00E983276; Thu,  3 Feb 2022 23:40:48 +0100 (CET)
Date:   Thu, 3 Feb 2022 23:40:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, will@kernel.org
Subject: Re: [PATCH 5/6] sched/preempt: add PREEMPT_DYNAMIC using static keys
Message-ID: <20220203224048.GF20638@worktop.programming.kicks-ass.net>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-6-mark.rutland@arm.com>
 <20211213220501.GB786870@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213220501.GB786870@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:05:01PM +0100, Frederic Weisbecker wrote:

> Anyone has an opinion on that? Can we do better on the arm64 static call side
> or should we resign ourself to using that static keys direction?

I don't hate this thing.
