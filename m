Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA5524887
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351796AbiELJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351776AbiELJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:04:44 -0400
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D41C9678
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:04:41 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 98E481C5606
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:04:39 +0100 (IST)
Received: (qmail 31775 invoked from network); 12 May 2022 09:04:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 May 2022 09:04:39 -0000
Date:   Thu, 12 May 2022 10:04:38 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     akpm@linux-foundation.org, vvghjk1234@gmail.com, aquini@redhat.com,
        ddutile@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return
 pfn in the target zone
Message-ID: <20220512090438.GG3441@techsingularity.net>
References: <20220511044300.4069-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220511044300.4069-1-yamamoto.rei@jp.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:43:00PM +0900, Rei Yamamoto wrote:
> Prevent returning a pfn outside the target zone in case that not
> aligned with pageblock boundary.
> Otherwise isolate_migratepages_block() would handle pages not in
> the target zone.
> 
> Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
