Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FED56C327
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiGHUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGHUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:33:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC30A2E48
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AADA7B8296A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C962C341C7;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657312358;
        bh=cCMSc5tjtyJqTxkk7RX8y8rvJpw+8lHQ9/nGU97hNHY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B2QNUzgYJ2T1N0PsbLXA6ZGvzy5t5VjVptc9Hz99v10dzp++4ORbul4QfDpyb3FQZ
         /WT9f0t20PMAfTIYdPUYavGSkz6AtCJ8JzvIOxw+hz0xJVFXcJSnJfT4/e80wootEs
         TLweWD0vdSqS0uO+H61IIfmLDsa140AHnJTtkUt4shvUeqPjl8xMpt0FLvGcQYpG+J
         HANJwTiidDQOB06wWxhg0HxMDifYjMETHW2SWCVGCXv1AuHcdHwcMijGf0+sv1i40t
         ImnuORN8IDGBJ0NRyck57T91/TY1Up4P/Jozfgql6zaMmqTwHgD5wk8ZVk74nTR4HR
         VRHC6JtbDe8AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38601E45BE0;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YshSTPK8g5U2NZtR@8bytes.org>
References: <YshSTPK8g5U2NZtR@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YshSTPK8g5U2NZtR@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc5
X-PR-Tracked-Commit-Id: c51b8f85c4157eb91c2f4ab34b0c52fea642e77c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5645edf6cffb97d976c6eef31fb536a09f114fd
Message-Id: <165731235821.2541.7723074584367889774.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 20:32:38 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Jul 2022 17:50:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5645edf6cffb97d976c6eef31fb536a09f114fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
