Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05074924A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiARLUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbiARLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:19:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E18C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFZUkU5fxILimkrsOSgEsRNPJsOZCUf1BuMxwFRoTH0=; b=QeyVfgIopjN5XrtQB0oeboW0dQ
        uAPVgRvwTLVImLLBIVSJo7RulFuEq0rxJj2wYJAIx4KYsLJop2BEMN9iepogU1czEHFDB9R5N0LMM
        UA61gmmW0YfhNqvfi8ZtlIhhJstQiDEDYEQGSOrkYRebM4Y65sCnjfM7V+DEbruxhjTs9Vvd8LC1Q
        oGR2jkXpxjQLjNJh7CrE2vpVpr7u6bYzRtQToVpGcfLsWvm1LIuJceZ3NGqIfowHMXa82L+dLtB+D
        Gy7gRa0Re1KpjxsBFebbjSXdpXm+2p4+qP1g0roSg5hnqmSTUbUCpunrLmQCD1sbe155zl4eeZ2QO
        d+x6kRrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9mWK-001pn0-Rt; Tue, 18 Jan 2022 11:19:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D2F3300237;
        Tue, 18 Jan 2022 12:19:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA0BC2B56E8B4; Tue, 18 Jan 2022 12:19:20 +0100 (CET)
Date:   Tue, 18 Jan 2022 12:19:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, srikar@linux.vnet.ibm.com,
        riel@surriel.com
Subject: Re: [PATCH] sched/debug: Remove mpol_get/put and task_lock/unlock
 from sched_show_numa
Message-ID: <YeaiOKUS32zcwXBC@hirez.programming.kicks-ass.net>
References: <20220118050515.2973-1-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118050515.2973-1-bharata@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:35:15AM +0530, Bharata B Rao wrote:
> The older format of /proc/pid/sched printed home node info which
> required the mempolicy and task lock around mpol_get(). However
> the format has changed since then and there is no need for
> sched_show_numa() any more to have mempolicy argument,
> asssociated mpol_get/put and task_lock/unlock. Remove them.
> 
> Fixes: 397f2378f1361 ("sched/numa: Fix numa balancing stats in /proc/pid/sched")
> Signed-off-by: Bharata B Rao <bharata@amd.com>

Thanks!
