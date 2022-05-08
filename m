Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34BC51F0E9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiEHT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiEHT75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B05BF7D;
        Sun,  8 May 2022 12:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E27BBB80E77;
        Sun,  8 May 2022 19:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEA1AC385B0;
        Sun,  8 May 2022 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652039762;
        bh=1T4NVr1kfOiAvFXa2/Jc2Ew2SxF3RMivCMa4J9pf6Hs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y90q8YlZrenOe+nHLV9QYGJMEN1y2CsNSv4TK1pt8CVUv2yvUbOVGA0y3yyMg/QV/
         SctCMM59nNOSiLEINepBE+h+j1uNNcsaHyVViTTU9yxWMJTPpsdh3GpSfqfdYym20U
         wTv2FFssWY53n3fYzM09YQw7wD4S2IRG3L//dHzLGKBlSEmV4eOM6BGBSyCZphJJl1
         PDvSNTgkXEUqTPbuRUsd55YebjqtS3pukk+ISKg1QRLsP1jT/u328GHxGUmhksOi9P
         wn6SgwoyoNRfP9cH6miwJmtPOhYH4Ga0xmY48ilggblacO8rZf1cqcErkYj+fc1CXS
         T+oCxZtd/m/ZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BF88E5D087;
        Sun,  8 May 2022 19:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YngaRj/nUEkAKbZL@p100>
References: <YngaRj/nUEkAKbZL@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YngaRj/nUEkAKbZL@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-3
X-PR-Tracked-Commit-Id: ba0c04104082ca211e108dd8eec6db2ad7676528
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f002488d80b557c7dc540457b176011449895fcb
Message-Id: <165203976263.4566.16797864925732683691.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 19:56:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 May 2022 21:30:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f002488d80b557c7dc540457b176011449895fcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
