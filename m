Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BC357C6D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiGUIu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiGUIuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14F364DD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87560B8239A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10101C341CE;
        Thu, 21 Jul 2022 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658393416;
        bh=fJEbxj/rLvARqpZfUp6BagahrLnkUsF2v0RN86pTDVE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FgqOVNjdr3+5kUXtlfmfgR2ts/rl/UP5B0lSbv5uqKFCNbuRtsb7eRIbzZYIl4tYm
         Wpi0SZbUL3SiXPyG+wjXsUriIfyzXiAlLLRzLiuJfXIRoJntN3zpw62GP24NsF+AuQ
         xOGoeVszdxGby9ocbXQ/0eOUcjH8IOrQJkXxfCRNhWac+azi5AABOsGPtW2doAevyG
         52AlvsgmWvXxZr2PrJ1GAMH/f58RByerTt5heLAn+Pkg0U9pYSRrjGLrqPGDuDGNBh
         x1ct4xjIp4NaBM1xhI2ttknt6jJYqsSmN8ADglHsNCMME+6Ef1dwxuAfl/X7j4a4LW
         51Z54gi1op2vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8DCCE451BD;
        Thu, 21 Jul 2022 08:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: cros_kbd_led_backlight: fix build warning
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165839341595.29073.14151139321094625998.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 08:50:15 +0000
References: <20220718105047.2356542-1-tzungbi@kernel.org>
In-Reply-To: <20220718105047.2356542-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        lkp@intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 18 Jul 2022 10:50:47 +0000 you wrote:
> drivers/platform/chrome/cros_kbd_led_backlight.c got a new build warning
> when using the randconfig in [1]:
> >>> warning: unused variable 'keyboard_led_drvdata_ec_pwm'
> 
> The warning happens when CONFIG_CROS_EC is set but CONFIG_OF is not set.
> Reproduce:
> - mkdir build_dir
> - wget [1] -O build_dir/.config
> - COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 \
>   O=build_dir ARCH=s390 SHELL=/bin/bash drivers/platform/chrome/
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: cros_kbd_led_backlight: fix build warning
    https://git.kernel.org/chrome-platform/c/7e76e4bc0099

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


