Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F05045CF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 02:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiDQAOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 20:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiDQAOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 20:14:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBE56204;
        Sat, 16 Apr 2022 17:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA085B80A25;
        Sun, 17 Apr 2022 00:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 557E1C385A1;
        Sun, 17 Apr 2022 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650154323;
        bh=+zOc6jWx4vu0Oby0f8z+pmqLblYr279ZaK63fLF/0BY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kLRY/YuozE4LREyYCupYfpevhDZX68Aeg9bQl3Z875FWSoEndDs296Lu1rDYLs+4I
         flUeeav3Eho4PeGFxMOsKcpL+XVLW0gYzGw9eMS8DIg1UitT2T+Ow06Uu4Axv4gXQm
         smet2LK+fKvSCXwe0eGlgdMwpI25ETiap6F6Zn6xiG/oDLcDRN1GOyPxapFlatJpXG
         x6tnrCmB2xaGYAggl97KVkhcd1FmacLusPoAeLSOf7E4KsGElKeuS68aQNwQuTJTBt
         jxFx90yzOJ5CeV/lh2zqm+OkOuDdYSBjZgjkgZe2BzRT2ObyQ0sf/dPJXGJmu90TdK
         oBVhD4V+femVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40BC2E7399D;
        Sun, 17 Apr 2022 00:12:03 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220416201727.3017-1-brgl@bgdev.pl>
References: <20220416201727.3017-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220416201727.3017-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc3
X-PR-Tracked-Commit-Id: 0ebb4fbe31343a42370a2897ea9424fe78f3a88f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de6e93366828925b58e4a102b6590a8f4798b7e2
Message-Id: <165015432326.20129.3721465694539628414.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 00:12:03 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Apr 2022 22:17:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de6e93366828925b58e4a102b6590a8f4798b7e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
