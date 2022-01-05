Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782204851BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiAELZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiAELZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:25:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6459C061761;
        Wed,  5 Jan 2022 03:25:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34ED6B81A20;
        Wed,  5 Jan 2022 11:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5E9C36AE9;
        Wed,  5 Jan 2022 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641381932;
        bh=pMGgyT4wR0n1pq4O32zNw0ilrjrmkSRYx/1mYiFCClY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=L3i7h1Q4SgxY77tkvMvsub8g/k31gW5g1CiIoRdjB+J8uT50TLwCVwtqZvw94SJoS
         ZG9bXOV8Ls63n5fNCVwiEh9tuPKon+ujytI+yylhsM0uWz/TGXFukoJr+Gmwg7xmbw
         S3lqMG3k7YS0YePNYl7JP/SSeOQLskPVkwDKttblhNOecyII6RFAXm9efmxzHDi8hg
         Yp4xhIyWyM8TnhcwaoQGuoixdS7uBuGjmtDTPCNYIDGSU7HfPx6ERWAf/y1Mw1ECUN
         ipHbGbZDAL0ZkCP3VlSk25WAjxBiGW1Hc3henkpKlyrguX6AbtGecdTV30FxFly7TK
         ba4rLzNT81PQw==
From:   SeongJae Park <sj@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Date:   Wed,  5 Jan 2022 11:25:27 +0000
Message-Id: <20220105112527.23399-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YdV4k1+zEbtzmUkK@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 03:53:07 -0700 Yu Zhao <yuzhao@google.com> wrote:

> On Wed, Jan 05, 2022 at 08:55:34AM +0000, SeongJae Park wrote:
> > Hi Yu,
> > 
> > On Tue, 4 Jan 2022 13:22:19 -0700 Yu Zhao <yuzhao@google.com> wrote:
[...]
> > I think similar works are already available out of the box with the latest
> > mainline tree, though it might be suboptimal in some cases.
> 
> Ok, I will sound harsh because I hate it when people challenge facts
> while having no idea what they are talking about.
> 
> Our jobs are help the leadership make best decisions by providing them
> with facts, not feeding them crap.

I was using the word "similar", to represent this is only for a rough concept
level similarity, rather than detailed facts.  But, seems it was not enough,
sorry.  Anyway, I will not talk more and thus disturb you having the important
discussion with leaders here, as you are asking.

> 
> Don't get me wrong -- you are welcome to start another thread and have
> a casual discussion with me. But this thread is not for that; it's for
> the leadership and stakeholder to make a decision. Check who are in
> "To" and "Cc" and what my request is.

Haha.  Ok, good luck for you.


Thanks,
SJ

[...]
