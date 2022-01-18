Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D034923DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiARKkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:40:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46300 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiARKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:40:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 573E2212C5;
        Tue, 18 Jan 2022 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642502402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrtQwpIli1olIAxE1ZEuZMwWPlqM62Vt1aaY+np8W18=;
        b=ICriZCo3DEC5eN6tcZl3zYVoc5jrG2PTfQ04NvTuFnGCqURluAGSmyh7ZkMacqknPDL2az
        BPHYI5Qgx2fWsajjsIaMVEZK9RwT/nbJIZOiBhfETMmLHcfJKTAevhfVXuk2UQRX2Vz9Ix
        fQg1ld/THFLw3rVwg1tthqQJGYnIR10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642502402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrtQwpIli1olIAxE1ZEuZMwWPlqM62Vt1aaY+np8W18=;
        b=3Cf4h9Y3w4VcrnD9Y04sqQXH038++nuDZxs1u0yt4hLZ+lp558bcYAEF5fwhzsjxksMTXS
        lDJkZqdcReMNFqBQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 393D1A3B83;
        Tue, 18 Jan 2022 10:40:00 +0000 (UTC)
Date:   Tue, 18 Jan 2022 10:39:58 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Honglei Wang <wanghonglei@didichuxing.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Honglei Wang <jameshongleiwang@126.com>
Subject: Re: [PATCH] sched/numa: initialize numa statistics when forking new
 task
Message-ID: <20220118103958.GT3301@suse.de>
References: <20220113133920.49900-1-wanghonglei@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220113133920.49900-1-wanghonglei@didichuxing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:39:20PM +0800, Honglei Wang wrote:
> The child processes will inherit numa_pages_migrated and
> total_numa_faults from the parent. It means even if there is no numa
> fault happen on the child, the statistics in /proc/$pid of the child
> process might show huge amount. This is a bit weird. Let's initialize
> them when do fork.
> 
> Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
