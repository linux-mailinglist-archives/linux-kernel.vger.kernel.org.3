Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC14AD772
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245381AbiBHLfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346317AbiBHLOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:14:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300BC03FEC0;
        Tue,  8 Feb 2022 03:14:06 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF189210DD;
        Tue,  8 Feb 2022 11:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644318844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vVM/VGi/Mx0uj8ZZWDQcTDJFzi5jYBIJPgJzLEJehto=;
        b=g2o1KbKBcwgrMFpemw0oAjIWiFWmkwBzg4DGWj8IQr2CR+vZ0j9f8dbo+sOOUuY8ENdBFL
        KGGwFV4AGoLBnFIEn6tL4TxQeXynn6bR5AACjq6VWRDGoxz+zYklZWjcIXUJIzsSyNhz9l
        5+WjlRPlwDX29N1cgKjPN/wsm2K3iHg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 092C6A3B83;
        Tue,  8 Feb 2022 11:14:03 +0000 (UTC)
Date:   Tue, 8 Feb 2022 12:14:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Yu Zhao <yuzhao@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v7 00/12] Multigenerational LRU Framework
Message-ID: <YgJQeBUDaPbuDHi+@dhcp22.suse.cz>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <4714886.31r3eYUQgx@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4714886.31r3eYUQgx@natalenko.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-02-22 11:11:02, Oleksandr Natalenko wrote:
[...]
> Is the patch submission broken for everyone, or for me only? I see raw
> emails cluttered with some garbage like =2D, and hence I cannot apply
> those neither from my email client nor from lore.

The patchset seems to be OK both in my inbox and b4[1] has downloaded
the full thread without any issues and I could apply all the patches
just fine

[1] https://git.kernel.org/pub/scm/utils/b4/b4.git

-- 
Michal Hocko
SUSE Labs
