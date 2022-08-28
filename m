Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EE5A3F09
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiH1SSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiH1SSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F9526AE9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 11:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA77C60DE4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 18:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18EBBC43145;
        Sun, 28 Aug 2022 18:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661710710;
        bh=YTvkWASclGi6du3IEshkyFP23h/YHZfmuTWMsoNDOkU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uafTnjOWT37Lv9kVKovGjDZEEFz8wCzqDxS9kZfO+pcI5+7WK6rIvTK2Df5G3G8un
         YEn8BEOSgcnXFDFh/1Eo1ypy9LmQmJ/DV6vp5qO9ity3h7OegNECOumfgiH82wFWa4
         xij87MlzbnRgVUbgdFvPbXPN7HRsBC9XbQXEMZXr3IUXkfQ3W6KEweDFIWLAglzp+J
         FxNnixlEDiP85A1EVQS34ESH76J9Vz6M9XJBokgymAGBUlSdkJyqjVG4DJR1+KgMB/
         /XDllRpQHuuMbmkViTObirwmCX11a6WUZB/LdATUwi71cw7iwGkVsGPEKS6ZKDsqEq
         N+btzb6IQWSFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E50C4166E;
        Sun, 28 Aug 2022 18:18:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YwuCUO5KPNJ2QaE/@gmail.com>
References: <YwuCUO5KPNJ2QaE/@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YwuCUO5KPNJ2QaE/@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-28
X-PR-Tracked-Commit-Id: 00da0cb385d05a89226e150a102eb49d8abb0359
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f23a7c914317ac0b2a7e2bbe48dc00213652f98
Message-Id: <166171071001.6107.17962108419054737525.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Aug 2022 18:18:30 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Aug 2022 16:57:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f23a7c914317ac0b2a7e2bbe48dc00213652f98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
