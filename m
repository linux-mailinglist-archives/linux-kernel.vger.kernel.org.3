Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E37497A26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiAXIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbiAXIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:20:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75ABC06173D;
        Mon, 24 Jan 2022 00:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S+s+1k8TBEfl6EiqPR+PCwqN5ZZ/aAVkdNebbqcmQbw=; b=iLPCI1pgHuoZl1SU8Pj6J0sGTe
        Ll+ptW1BzmGCBF1JGUqbJWWu64GvEiy+5pYYxht67aZMK5pnfD354KP7Jgnp+Sa+uIq3z/VedhxMh
        3fgTjv7vnZ8WSXoTJVpUJdV32iFHdQXf1z2t4LRHpkoQ5fEp30iU87lfzd4YkV6+NmJUXAdb3cZck
        E/bIJ0eOzkDAuAqVvRMzSCUkf+GqtGRQdfBpfj8lRg/mko7IbM7tDrPQFh5smDIWVLQ9XXo0nBktz
        UlSbBiV2o23M9+E3E0a45IyFgiREdNKXwAhAfZA+bASkMloy5y/XDnAIjaPVfW7GBNobQ4fBepRPs
        kavy21Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBuaK-000KJQ-Q7; Mon, 24 Jan 2022 08:20:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5B4598624A; Mon, 24 Jan 2022 09:20:20 +0100 (CET)
Date:   Mon, 24 Jan 2022 09:20:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Subject: Re: [RFC][PATCH v2 0/5] sched: User Managed Concurrency Groups
Message-ID: <20220124082020.GM20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220121130145.1bba70d3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121130145.1bba70d3@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:01:45PM -0500, Steven Rostedt wrote:

> Should the below be added to samples/ ?

Maybe eventually, it needs a little TLC to build with clang at the very
least.
