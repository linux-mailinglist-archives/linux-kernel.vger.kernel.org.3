Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282944EF915
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350426AbiDARmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350517AbiDARl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:41:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCA13D0B;
        Fri,  1 Apr 2022 10:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0044EB82599;
        Fri,  1 Apr 2022 17:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A43ECC340EE;
        Fri,  1 Apr 2022 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834805;
        bh=S9uVY5PHuQCRmxoR9ST8cWgwclMaD6f++3PLK4VLVv4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T1Uj92iu90ITjJ8YXUr006zFaiFGHYvYDFXC5TxSjCjUIOrj4/zunKBi07ed6XfPs
         GYrmfZMpx+eZ1Ov/XQFkxe2kTPmBUxHDgK/TcOdIruFqy1TRwM5mnvfhllpRhy/gp0
         cEiaa3pGCS4f+MZaVyLCUyp4CL+2XGoHZQaeqruerxjOA+xDJFtDZEwIasbIpXKbnu
         B76eQLVw9E83O24327ignHsesFJTbl6U7fDnnU8JzDjzjthcUW6VIxZgPue7bESGmS
         rOPO645bf/h7twPgbZBp2xWEIEG3ToNCEp4NtP/dNhtNN3nd/Jor9H5zh8SXJ1pgu3
         UvsY5OdLFM1xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90012E6BBCA;
        Fri,  1 Apr 2022 17:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220401140016.831088-1-brgl@bgdev.pl>
References: <20220401140016.831088-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220401140016.831088-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc1
X-PR-Tracked-Commit-Id: 24f71ae5447e661813228677d343208d624fc141
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26803bac2b70a7314f19d56c588cf7d55e4ddc3e
Message-Id: <164883480556.11835.15976199703132415068.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 17:40:05 +0000
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

The pull request you sent on Fri,  1 Apr 2022 16:00:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26803bac2b70a7314f19d56c588cf7d55e4ddc3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
