Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8892C589A01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiHDJkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiHDJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:39:57 -0400
Received: from outbound-smtp10.blacknight.com (outbound-smtp10.blacknight.com [46.22.139.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1590A43317
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:39:56 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id A98F81C4017
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:39:54 +0100 (IST)
Received: (qmail 16661 invoked from network); 4 Aug 2022 09:39:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Aug 2022 09:39:54 -0000
Date:   Thu, 4 Aug 2022 10:39:48 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: only search higher order when fallback
Message-ID: <20220804093948.sq64wsfhtsbnsc3g@techsingularity.net>
References: <20220803025121.47018-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220803025121.47018-1-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 10:51:21AM +0800, Abel Wu wrote:
> It seems unnecessary to search pages with order < alloc_order in
> fallback allocation.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
