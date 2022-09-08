Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13525B1161
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIHAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiIHAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38902A951
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20CA261B11
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CC9EC433C1;
        Thu,  8 Sep 2022 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662597617;
        bh=b6yDN9tL08hslGgkBfYdfe20UmnjH2C2An5qrfEe4l0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g2D0zVoaxfwjt7EgshshVXT3i8tRgOvLpgcU0t7KuhI7qf2lW1jxlQTU0zmOxdAGA
         tf4piocTSKuxcKH7LRIoaYWdWlCy6yjSV/23p+pdEjexdFm7O88toNDAoiJYm9PFRj
         sWjbxVWs/utmlymcWQ53afnzks0MBUDaZNeJrAfbX63z/HsNRifAaSUOkTl3h4H5Xq
         vuiz46B/vIC7bBoW3MZyppsIqbbmpcPTgNgSBeeeME9bYLhmA69fwLbLifpVn38vV/
         OtP/HjwR+KBqtFfTP65IT+sBi+av1e2UtMXUOQuL0WcijJd80bN+SuHbolwac3grgs
         PcTyFl8L+EmvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D8CBC73FE7;
        Thu,  8 Sep 2022 00:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: Minor cleanups to cros_typec_switch
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166259761737.4687.8715779672113750090.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Sep 2022 00:40:17 +0000
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

This series was applied to chrome-platform/linux.git (for-next)
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


