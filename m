Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE64683B2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384517AbhLDJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbhLDJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:44:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF1C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=atNqR1ZQmBEyCgWQMgvM1y8uPShMWM87rWOU5BV02Dw=; b=Icmphn4JO4Q3NXjJOJCax1aM7V
        vQ2N9iGS+hRVOEz4hiJosv8bmB3eBemsONGFXwPCdlfz51nvJtt+oa+tQv0tK4iIKY6PbkmbVlsXf
        QUSSbmmNWAw53dLJrZUtqQK5G4vGQkiGjA9tdQMVJDG6XVr77gSllbU/mQjCGrSkp3YblxsUjDAst
        q2nE1HqsndI2smbR9EkqH8XfEJsPbQcwT3i9T8IFusMOveBMpUByf79wUBkZh4ecypCN47bkk+d8y
        3u3jtSC2Tw2WICt8EsxK7uL6opT5cnJw/asRRQhqb5GA0VZm7yVaNbuMDDF3JYcG98WnjPRMG0Tc6
        dtiyWL+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtRXM-00CTs9-8P; Sat, 04 Dec 2021 09:40:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B33298106D; Sat,  4 Dec 2021 10:40:56 +0100 (CET)
Date:   Sat, 4 Dec 2021 10:40:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, frederic@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt/dynamic: Fix setup_preempt_mode() return value
Message-ID: <20211204094056.GO16608@worktop.programming.kicks-ass.net>
References: <20211203233203.133581-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203233203.133581-1-ahalaney@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:32:03PM -0600, Andrew Halaney wrote:
> __setup() callbacks expect 1 for success and 0 for failure. Correct the
> usage here to reflect that.
> 
> Fixes: 826bfeb37bb4 ("preempt/dynamic: Support dynamic preempt with preempt= boot option")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Thanks!
