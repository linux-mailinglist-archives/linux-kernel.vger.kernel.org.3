Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FFF55A34C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFXVIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiFXVIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B28131389
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF486234E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 914DCC34114;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656104886;
        bh=fS+jx8P4aZnV8oKAi8Icer+oLHscd1uAmryuXFxfYyA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N3hRhJGqk1QAU9gQ+DPM1qaDTRjQ/+eRY4Jf8isI+JyxWLawDjQvuqytVJsvhOMPV
         cH59Olhh6BBdVfxwiCVCCBArKaLz/rCklY0xBOQ4fU4IsZl6Y1kbZFdvdBBWwP97gc
         1SzJOf339KNxfrLUozURu6uxfUcMr+5OMFwYTV7gLotP+ScOJZ21W4NVIVkcN9cD+y
         4f9S95qmhzqhhcObbzgYSyKDG72T2dZd8sm0e2rjSdCmzyYNHFWJUpWFgI5g1GYZBN
         WhAIf4B+vF/VZ9B08aqcTstqFw2ylPPr4rNgoe687rpv+E88VbTln/vTrPawzFyiJ4
         eXvlIY3VLvnmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B6B3E737F0;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YrXCfic1ua0DdDBQ@8bytes.org>
References: <YrXCfic1ua0DdDBQ@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YrXCfic1ua0DdDBQ@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc3
X-PR-Tracked-Commit-Id: c242507c1b895646b4a25060df13b6214805759f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc3b8977e3747ab8aa54a0760dce5cdfa37ad4d6
Message-Id: <165610488648.13803.4593691440555303262.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 21:08:06 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 15:56:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc3b8977e3747ab8aa54a0760dce5cdfa37ad4d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
