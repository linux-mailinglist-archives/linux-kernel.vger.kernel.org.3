Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4574AEFA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiBILIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiBILIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:08:31 -0500
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 02:42:13 PST
Received: from outbound-smtp45.blacknight.com (outbound-smtp45.blacknight.com [46.22.136.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC78E0AE461
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:42:13 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id EDD21FAC06
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:34:00 +0000 (GMT)
Received: (qmail 20693 invoked from network); 9 Feb 2022 10:34:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Feb 2022 10:34:00 -0000
Date:   Wed, 9 Feb 2022 10:33:58 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20220209103358.GP3366@techsingularity.net>
References: <20220208094334.16379-1-mgorman@techsingularity.net>
 <20220208094334.16379-3-mgorman@techsingularity.net>
 <9ab0a2c2-7dee-40b0-edd0-56a5b1915745@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9ab0a2c2-7dee-40b0-edd0-56a5b1915745@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 10:40:15AM +0530, K Prateek Nayak wrote:
> There is a significant improvement throughout the board
> with v6 outperforming tip/sched/core in every case!
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 

Thanks very much Prateek and Gautham for reviewing and testing!

-- 
Mel Gorman
SUSE Labs
