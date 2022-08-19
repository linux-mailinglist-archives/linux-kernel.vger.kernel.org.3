Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36EF59A4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354689AbiHSRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354683AbiHSRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD19481FE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC86B6188D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2563AC433B5;
        Fri, 19 Aug 2022 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660927804;
        bh=q0RICIStAfuq9Tir8Gn3wiw1jHY3/wzAS6hGfEsXP4w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iHbswFwMMyN1WO8UD5jzvSWJxAyJoxN/QnQRyDzympYTaqdO9bMnWWBYRx1BFlD7g
         wcFe9uH4QJTgy7duXjH9/0rfBebNsxSfm4Cgj6YR9Vdchsm3X1XdRcrI50UsgMOdhy
         J5hX5MqC2YLfeq99l5nhaSPqjMbqNPycTSET3K9SNq3gPIZwoRhrjUhQ9sItHD9pRl
         /fFJm+EEHD7x5nqLcrusGaG1N7ozTC2OvCSOBXBmM+PwtP9GW+z9GJT74LwWT11nWX
         u+Qtd99m3/UDunhWqKXiUxe8OU1MuyD0/ObpmmH6jaJIhNP7T59ncFMQzs211h85wy
         4i9TsJ8WxESdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F533C43142;
        Fri, 19 Aug 2022 16:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bksg7jws.wl-tiwai@suse.de>
References: <87bksg7jws.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bksg7jws.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc2
X-PR-Tracked-Commit-Id: 90d74fdbd8059bf041ac797092c9b1d461555280
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
Message-Id: <166092780405.6250.6766988017882920320.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 16:50:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 09:49:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
