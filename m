Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18755AC1C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiFYSaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 14:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiFYSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D5F5A3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2964560AE4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E415AC341CA;
        Sat, 25 Jun 2022 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656181805;
        bh=p5lnAOp8Ka1Nf9m8kWcAqfb5qFPlAkmK//Hiy5DW9Uc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gKYKhhN1y05s8T6AirLLQ/bTLm5zqVHxfdRU9ASvHPd3PxKqaEKYx90uIe09hzw5L
         kLORSOzufLJKKMFywLNE3ONEGmU3zXlUsr6NHnD5V9czyzvcTiPt1NxAzyxmeH2m3J
         2906Gaw4ebZ2rUuHgS67f9xohXduAov9UO+RJLcFTU8IHGprIFU1U68yzbc+WcPDQE
         g/Ngjp67zqanY7Zo6E1Dsul7VKZ3c1HnNBvHY5kYMNpYamF884ZftH3WxHkHvaIDMs
         82iX3pmF/gw37X9uddlkhHNq2QCP75wgK8LqnioPJwJR67ipwAeofchGbnBonGjz6O
         smlsXmNygJ7lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9CADE7386C;
        Sat, 25 Jun 2022 18:30:05 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YrZZmp8qBSDM28iy@google.com>
References: <YrZZmp8qBSDM28iy@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YrZZmp8qBSDM28iy@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.19-rc4
X-PR-Tracked-Commit-Id: 82c7863ed95d0914f02c7c8c011200a763bc6725
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29eeafc661f283a7412ecf8d9899a5ffd0c80f59
Message-Id: <165618180582.26648.18370768969071109222.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jun 2022 18:30:05 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 17:40:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29eeafc661f283a7412ecf8d9899a5ffd0c80f59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
