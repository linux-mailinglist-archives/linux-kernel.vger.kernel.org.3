Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9301596309
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiHPTVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiHPTVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD9781B16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AFB761460
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4378C433C1;
        Tue, 16 Aug 2022 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660677676;
        bh=nfEJ9V2d67YVjzG26yxatjFUI4uCUNTHyX8zW3e854c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bB75i6HM6GGT1kBu3Nir38wUbaLLUWitiLp+wv3Dxv9ej7prOkPLnE2QtPrycz2kR
         3BMfHAkFH1cw5CThI2ZSV3PF7KzgBNTrRiZadCgpXNrj647Zyy0GuEUdrzjlAEwjXD
         pcjFsiZLKgIJCc6PIKHhFEhL8eJRZlSKrtNw6sivmI4NV1HD0KpuoISevjkpq5877W
         wpRx77zwdE+Q2hLAlokov44qD1ofLO24wABk2dVatZNhTjBChDpBo43tLVHRK6MNX6
         6ZK3ez6jv2gVscc+r4RQvu7tjCLcbV63H6STQWQbaiZxVGlmQ+KrP0rzXysvZo4tJc
         CsbaOvXCrwmAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 924F4C4166F;
        Tue, 16 Aug 2022 19:21:16 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220816112301.7C3BAC433C1@smtp.kernel.org>
References: <20220816112301.7C3BAC433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220816112301.7C3BAC433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.0-rc1
X-PR-Tracked-Commit-Id: d511e8a7e850db567cd7f633288aa96a19508e5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15df6486ae56f259650159340a495406f427b2ea
Message-Id: <166067767659.31662.16112668333167020586.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Aug 2022 19:21:16 +0000
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

The pull request you sent on Tue, 16 Aug 2022 12:22:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15df6486ae56f259650159340a495406f427b2ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
