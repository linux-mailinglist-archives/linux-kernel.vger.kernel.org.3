Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A684B56C390
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiGHUdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbiGHUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:33:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F2A2E40;
        Fri,  8 Jul 2022 13:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DF34B824AB;
        Fri,  8 Jul 2022 20:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AAC2C341C6;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657312358;
        bh=tt5X7DVwV3aK76dXmIged+6JIg7rTdBVxRSnB4WfOvQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ocLJR2EqyFzkkLpC50YVqLxr0Q/zDwRekFBBJU+hMQMLP1RTWqyDcNWy8if1Fo811
         HQRyKGOEXzOL+La7McAGi7tddXnwaBJ6fUHAgApGDi7QacCBZCoj+X8hYZ4Nrc0kIZ
         kKBvXBlEh7jAGtrz2nAgSbc6/hXlhEVB0qkKaLreIHDq4oGehkWE2KwEJv9ytTSr6E
         oVtoj/BSSTPCGKK6tFAr5lKEvFNyrMHg8gVeFH4kOj5v8L8ryimZhimsshBBeFqx1X
         Mqlp2k8RvQ1PobvzRsaVrD7EZfWmTDFDXYuNEqhrXm0np1b6ElAiJFIVvK1qLt/mmX
         6hsQfrrxSzDtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25070E45BDA;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220708154832.67452-1-brgl@bgdev.pl>
References: <20220708154832.67452-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220708154832.67452-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc6
X-PR-Tracked-Commit-Id: c8e27a4a5136e7230f9e4ffcf132705bf56864cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b93fe647c0a901e00eba0adab84a6ecba3f25c4
Message-Id: <165731235814.2541.6221974252312376295.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 20:32:38 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  8 Jul 2022 17:48:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b93fe647c0a901e00eba0adab84a6ecba3f25c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
