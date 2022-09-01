Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426AD5A8B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiIACU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiIACUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76FF48C8B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2027EB823C5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5F57C433D7;
        Thu,  1 Sep 2022 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661998815;
        bh=CV4e68OrdHTDsa+YEHfNuPGhWonkwMbg7a9yZjjZxQ4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ch1h7wEbzARK7GUUwFHlTrHvAaZE1+w3layli9Go+9UFxv7ngmKiCI6oSgOS76Doj
         mDC125zR4yIDWB0cQMUMuLVH8I84Rt0fvreyrklgpEqrkl+HtmON/KE2Ol/OUyB6S/
         P1LXA4JpW6/eJu/JkDDFR9PZ0hVbPMmbQkX1FdmrGGBd0f5CZL8hYZPXjKpzedhZze
         Fl0n49lCQqH7AmojGdhIERuDUSNYwkmdx6Gu6h71uAswvszal3QJrpF4kVddoQ86ma
         Z4Dr4WMfKO7YbkYcfw/mFvVZVzxcBtyvGmaJ2vtBX1KNrLh6aGYNXtj6lbxtks/bFT
         nZ2WkJnKhcgZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B270CE924DA;
        Thu,  1 Sep 2022 02:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: Minor cleanups to cros_typec_switch
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166199881572.11608.8310453204504471124.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Sep 2022 02:20:15 +0000
References: <20220830225831.2362403-1-swboyd@chromium.org>
In-Reply-To: <20220830225831.2362403-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     pmalani@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev, tzungbi@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 30 Aug 2022 15:58:27 -0700 you wrote:
> A small cleanup patch pile for the new cros_typec_switch driver.
> 
> Stephen Boyd (4):
>   platform/chrome: cros_typec_switch: Add missing newline on printk
>   platform/chrome: cros_typec_switch: Remove impossible condition
>   platform/chrome: cros_typec_switch: Use PTR_ERR_OR_ZERO() to simplify
>   platform/chrome: cros_typec_switch: Inline DRV_NAME
> 
> [...]

Here is the summary with links:
  - [1/4] platform/chrome: cros_typec_switch: Add missing newline on printk
    https://git.kernel.org/chrome-platform/c/8dab6a593919
  - [2/4] platform/chrome: cros_typec_switch: Remove impossible condition
    https://git.kernel.org/chrome-platform/c/bbb5fb85cf48
  - [3/4] platform/chrome: cros_typec_switch: Use PTR_ERR_OR_ZERO() to simplify
    https://git.kernel.org/chrome-platform/c/dc22a33e3585
  - [4/4] platform/chrome: cros_typec_switch: Inline DRV_NAME
    https://git.kernel.org/chrome-platform/c/20dfb7478309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


