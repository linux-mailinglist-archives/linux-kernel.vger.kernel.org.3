Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1C4675A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380042AbhLCK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:56:54 -0500
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:55540 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237048AbhLCK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:56:53 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id D76B7BED69
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:53:28 +0000 (GMT)
Received: (qmail 4886 invoked from network); 3 Dec 2021 10:53:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2021 10:53:28 -0000
Date:   Fri, 3 Dec 2021 10:53:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in
 find_busiest_group
Message-ID: <20211203105327.GC3366@techsingularity.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-2-mgorman@techsingularity.net>
 <CAGsJ_4z30yfw=kyBNZuSLMaCcMBmstD=bK4VOsVW3vKO3kO+fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAGsJ_4z30yfw=kyBNZuSLMaCcMBmstD=bK4VOsVW3vKO3kO+fA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 09:38:33PM +1300, Barry Song wrote:
> On Fri, Dec 3, 2021 at 8:27 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > find_busiest_group uses the child domain's group weight instead of
> > the sched_domain's weight that has SD_NUMA set when calculating the
> > allowed imbalance between NUMA nodes. This is wrong and inconsistent
> > with find_idlest_group.
> >
> > This patch uses the SD_NUMA weight in both.
> >
> > Fixes: c4e8f691d926 ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCS")
> 
> Hi Mel,
> 
> sorry I might be missing something. but I have failed to figure out
> where this commit is.
> 

Stupid cut&paste error and failing to check it properly

7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")

-- 
Mel Gorman
SUSE Labs
