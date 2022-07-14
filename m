Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9357567B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiGNUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiGNUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F94854C9B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B5B60C17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED096C34114;
        Thu, 14 Jul 2022 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831354;
        bh=F3n8P90icfC9993ShPHuypWR7iLxPcQuxDC5KAAQVD4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FicGBYTsnw1Btd4e02EYWj26dJF3Z5G/t83pX5vEwCPE4zeQT7QNdt9TrSyT/HpJj
         Q3Pm0YlwCExD7bgrhZ80X6dv6RN6V6riJEIalfFZHTgth/op7JyQuWmahUIvCG6tWI
         QG6g4fhK0jvtGrd/+KAmu3vJiJeZZBOwtnVwIFUmcNzcrPVh7o49/tHzpp5dMsNDVG
         bCcdQb65VC61+x95Dnf99sx92uuDktgmMU9zA5l1jBz5Zsf/aEJ16d6m/4zERkNcj4
         KlNQu7F32szuqz17Zx4a3wOIo1i3VnMBQ29PkX+XzTSriSJIh7VEmvcyUr/spxXyOm
         Rq+ROFIvJbVNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA523E45225;
        Thu, 14 Jul 2022 20:42:33 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871quoxful.wl-tiwai@suse.de>
References: <871quoxful.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871quoxful.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc7
X-PR-Tracked-Commit-Id: 9b043a8f386485c74c0f8eea2c287d5bdbdf3279
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4634a3c7dcabed7321304efc00b5a81559adeca
Message-Id: <165783135389.13350.14150346691064570698.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Jul 2022 20:42:33 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Jul 2022 10:23:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4634a3c7dcabed7321304efc00b5a81559adeca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
