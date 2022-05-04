Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887F451ACEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376930AbiEDShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377094AbiEDShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:37:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCB264
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29609B827EE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6630C385A4;
        Wed,  4 May 2022 18:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651688685;
        bh=liG3cYrRGvwUoDwAWoGZTFZHsaA/cjuphBPla3ASGr4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IcIaAa0SXapMwNmAECOJ2njWBcGB8NcJoxGpTGGAAhSIcnVLM/44GNLc487aQsQXB
         UHhKlGxASMSCGrjro4FjGoiLHPyL4aWij4ynx6fTlBJ23TSABlPFrvGt9KiltnLy20
         rFhsM2p2IJ8YSpywhx3cATlI08np/uhH88gSzIpzPppdYN2E887dDVTSkOLd7FT4gc
         MJEdlsDhD/cfgMfz1m0LMyjx8ET8Vs3G05p01zTLWBj9SXzCTlhORFZchU34UAZxic
         II9WkVULbHqOPXI0EPTYZKX5zLC4piiVr+UP+9Z9fpYUJ7GoRVyYSWe1l6pm8HorKN
         iUIry776ssAXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1035E5D087;
        Wed,  4 May 2022 18:24:45 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YnKie9R0RhJsGMz9@8bytes.org>
References: <YnKie9R0RhJsGMz9@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YnKie9R0RhJsGMz9@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iomm-fixes-v5.18-rc5
X-PR-Tracked-Commit-Id: 392bf51946c2463436a1ba237c1ec5865b234825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7391ad3572431a354c927cf8896e86e50d7d0bf
Message-Id: <165168868571.19526.14478834492995171046.pr-tracker-bot@kernel.org>
Date:   Wed, 04 May 2022 18:24:45 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 4 May 2022 17:57:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iomm-fixes-v5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7391ad3572431a354c927cf8896e86e50d7d0bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
