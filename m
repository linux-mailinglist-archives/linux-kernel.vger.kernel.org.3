Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9135B245A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiIHRX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:23:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1FED39E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A057AB821D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 651F2C433C1;
        Thu,  8 Sep 2022 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657826;
        bh=8OqwvFNC70O9dp+clJXjyf5FvP5swqKr9IAtX8gTzxY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K3/NrNhnocHjNl4B1/DFtXmZi3QRXUbly0XiETqIEy10ynMC/KPvk04dAtK+wzBZM
         OBJuPHr1DcZXeBNKEunq5baOiYprPZGTbi+HYE1AhfgIu/Vf2nOfnpAc3WwWx+MRQj
         KX/PEw0tCJOsYE6HoFSvGFxzIku4td5zhUGSXAtK6ihVC0osQlujAPafl2iW54GILA
         WCRp5/XEVMm7+Fw9twUedZs6UUmktDO+qxJ9UUTaptnvGPzXbbS4PfVEuJvXaR2uFC
         Ah+MwZcmDK5STOVmKxijGDWRBDnp+upsmkNIDfYtdvRZMfUSojiamaZbw9WRFfbKv7
         Nlw4I370CbAwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49504E1CABD;
        Thu,  8 Sep 2022 17:23:46 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220908122100.1E690C433D6@smtp.kernel.org>
References: <20220908122100.1E690C433D6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220908122100.1E690C433D6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.0-rc4
X-PR-Tracked-Commit-Id: f5723cfc01932c7a8d5c78dbf7e067e537c91439
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1d27aa3b16a4689d5598abc545a88e5cda93f1d
Message-Id: <166265782629.29466.8295613044747778738.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Sep 2022 17:23:46 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Thu, 08 Sep 2022 13:20:50 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1d27aa3b16a4689d5598abc545a88e5cda93f1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
