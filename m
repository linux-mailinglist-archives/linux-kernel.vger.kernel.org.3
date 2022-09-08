Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C35B2457
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiIHRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiIHRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB371ED98B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41BC361DC4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 962C8C433B5;
        Thu,  8 Sep 2022 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657826;
        bh=q5n8yxqH9JdXbI1cDy3o6YZHSeaXPxPTJk6SFP7CZrU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hml2p6pKsnwu1ggWBJo+ZZMuY/144I6c16+PAkQI4svvgbCPXAZELLpx46sN6YLH5
         hHFB79QlitMgaeREa2uyY1NMgTmU+uj/cXZwAwDzf8z8qsFY9NY5sHFEtx+hqnp+t6
         5Gp2f86mBIItXIuZuP5JHUww3PKaplqZ4c0ieiMeZgsqImckSfFuvUcZD+7t+yDTDx
         UBiulzzRVvpcyEi03Tn0NjBTbPwH04ilnI/MWcp7jmRsPxd+Z/Rh3j3yjCoRCpn75H
         XSRhd9cHG3foH4SckWsMCVHDHf8xtZIHtwi9vgjX8iqttUruB7ToW8eu8XT8jxO+zO
         CQPINEwYqZflQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 810E8E1CABD;
        Thu,  8 Sep 2022 17:23:46 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220908122117.93570C433C1@smtp.kernel.org>
References: <20220908122117.93570C433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220908122117.93570C433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.0-rc4
X-PR-Tracked-Commit-Id: 475043fabe8c58fb18c32c7942d8754897bd11fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5e68c4fa55c0d65e28b4b566b50aee6c4185dab
Message-Id: <166265782652.29466.8260575232856573093.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Sep 2022 17:23:46 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 08 Sep 2022 13:21:06 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5e68c4fa55c0d65e28b4b566b50aee6c4185dab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
