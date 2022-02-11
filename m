Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09C74B2E39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353177AbiBKUF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:05:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353154AbiBKUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA1BCE9;
        Fri, 11 Feb 2022 12:05:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06820B82C0C;
        Fri, 11 Feb 2022 20:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C264BC340E9;
        Fri, 11 Feb 2022 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609919;
        bh=jY8bt3oYToJuW4etmWntREKe5E9VFDAc1jTCuSQSAnE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V48qHYDkmCJvrW3yczLGB7W/yf7D2H3Z1e/uDPFvA+Akt5A4N4OzG6sCRvuD5r1lM
         ea0PugHBXDU4UaHloMHyZmklPUzQP5w0DjKEq+JQl07MRP87h8dQRT9GamxodqnVvt
         LVGIyYjAhc/ojtjMqyVdPmX1JVa/L6EpZ0ni2h9jNfXy9CA/3N4UHok+L2ABw8+Ijm
         9jo6a4ky/y0lqU9YS7bNGdLavN5ICJhsHZ07+t2JoGUN54e2MoMReQ+INOsWDtNZZx
         jzlomQB+hBvw4dIQtn83hdrmB5rtFIIrwAveIwlMAmTpSWHXWhLpED0OFrCb12efhd
         oTjPzNzat3nGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEE9EE5CF96;
        Fri, 11 Feb 2022 20:05:19 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220211130801.280029-1-brgl@bgdev.pl>
References: <20220211130801.280029-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220211130801.280029-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc4
X-PR-Tracked-Commit-Id: c162ca0bcbfb39308c4dff4157e27c751af7032a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b9df436192aae9f9705bfe42f6e618dd4773792
Message-Id: <164460991970.1412.14895238067223319534.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:19 +0000
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

The pull request you sent on Fri, 11 Feb 2022 14:08:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b9df436192aae9f9705bfe42f6e618dd4773792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
