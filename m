Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84E52F30C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352881AbiETSgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352789AbiETSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028948E46;
        Fri, 20 May 2022 11:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B6B661A39;
        Fri, 20 May 2022 18:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2B72C34117;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653071783;
        bh=JWiWTC+alje1MLpD9hvhHudkn1B2FU5SEi1F4LoWsJI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lFHgdCHCjWtoa4d5dgql085AOV6RthGTVk4MNqqNTRpygElgkwZPbO2kAqY8ktPCV
         yp3JdARlX74ryJc6Fr/SL53l9S9bZezxgU5pwaklnVII71UT2vBEcrpbAPHG+MsrxM
         B9TCz+jevwdRxlJJn36j/s0eCZq+qJHxR6ZFkACA/TLLHAJsVXnlBi1cruZEQ0ResD
         OeB6YHVyucSHXkKtF380nGtJ7/JwvsBGhWeH2H835i6BXG5TaDrBn3kdtdnP8eL3EJ
         amR3rf62VGwnm3hTt5R10teMlBYj+PfNVSTw7rg/ewn7AgNmq5J8GklB5aYV1Qnc76
         PK/C9/0qp9mZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D507AF0393C;
        Fri, 20 May 2022 18:36:22 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520171930.1029663-1-brgl@bgdev.pl>
References: <20220520171930.1029663-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520171930.1029663-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18
X-PR-Tracked-Commit-Id: 3ecb10175b1f776f076553c24e2689e42953fef5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b5e1590a26713a8c76896f0f1b99f52ec24e72f
Message-Id: <165307178286.15282.13722611357472088743.pr-tracker-bot@kernel.org>
Date:   Fri, 20 May 2022 18:36:22 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 19:19:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b5e1590a26713a8c76896f0f1b99f52ec24e72f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
