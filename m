Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B91546C55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350440AbiFJS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350407AbiFJS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:26:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4295429C9A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45347B836F4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7148C36AFE;
        Fri, 10 Jun 2022 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885570;
        bh=svkAq2tOTjMSRAbrrYZGRESQfBfrJRQDFbCpkIhiqr8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DRsGVKpHL8EpceaWREzmTTYW6lPVt1Yx2wrix1hvH3ZCb4ncQgq54S5yxh4y6R8ys
         eHuXD5AL1w5FKQjdossnIlxWqbY0DWgeCPqlFDCBgEK7y5d7jPGNwxrQ3U05yb2TT5
         m9atizaR+8pDjYjzwMYIuvFnfAaMT/1Q9TE/WhzuVSBSpOwHl8i/O4qRFxolRl1aSI
         nE/tTZe4hkr//AE6N38prheLOUDsETEopLWU/Jne6hrXn6vsJgtQWNNc/5flJ7AHp6
         kPC+8ng+/xUBOpj6G5I/nXGqlXtRup1CZ2sgUPd1BW8lzfyJ8Vh7e60YlNnOsCVq2q
         Y7QDhY2IcCSlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D563EE737EE;
        Fri, 10 Jun 2022 18:26:09 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqN+t6VQhpYv36Ll@arm.com>
References: <YqN+t6VQhpYv36Ll@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YqN+t6VQhpYv36Ll@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 78cdaf3f4257ab10a6cec308ed774e7c7f7e5f72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36a236637971923c85dae45cb8638eb47ae62954
Message-Id: <165488556987.32117.17778352070995190239.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:26:09 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 18:26:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36a236637971923c85dae45cb8638eb47ae62954

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
