Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C66545A32
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiFJCkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiFJCkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A78168D35;
        Thu,  9 Jun 2022 19:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4470661C17;
        Fri, 10 Jun 2022 02:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E224C3411F;
        Fri, 10 Jun 2022 02:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654828817;
        bh=R4HuNtxd8ll/66acm/7nykeSXEGvgwdz39fdAfHcWFo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LJelhyZ+LByuDvXbqjTZ09bQAsl/11oDl6MtSxqM4dGsQj+ds6/4AiKjhYae0JBzc
         ijDOGuEa6LfSnQlpcZcSVP0Ne1mYeNdBGrtKop76TIdYGw5vJt8XqxwoP4k2a13dSx
         P0sWpTCX6VunqtzloHJGxnfvZ/W81fcUXrwE/MztP+Q0pv3/zmuW/t4HoDjZP8vqQm
         NSYtzGZT+2lYoXwwCKEJGm/iyk5BP52iVfk8cT/y3Y79vmxfiDOVZEFDn8C97/e/cm
         4zYqPzNtiCrNsFstQhitbH0QXRgR3+xEKPs2rBYZfocOHQfME2dWqHUY0/ZzgLkZiV
         Yt0RcBKT1dpOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89DF5E737FE;
        Fri, 10 Jun 2022 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/5] platform/chrome: cros_kbd_led_backlight: add EC PWM
 backend
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165482881756.28809.4443591053162374923.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Jun 2022 02:40:17 +0000
References: <20220523090822.3035189-1-tzungbi@kernel.org>
In-Reply-To: <20220523090822.3035189-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 23 May 2022 17:08:17 +0800 you wrote:
> The series adds EC PWM as an backend option for ChromeOS keyboard LED
> backlight.
> 
> The 1st patch reorder the headers alphabetically.
> 
> The 2nd patch separates the ACPI backend.
> 
> [...]

Here is the summary with links:
  - [v4,1/5] platform/chrome: cros_kbd_led_backlight: sort headers alphabetically
    https://git.kernel.org/chrome-platform/c/337eac8f8499
  - [v4,2/5] platform/chrome: cros_kbd_led_backlight: separate ACPI backend
    https://git.kernel.org/chrome-platform/c/6b1e5ba39c44
  - [v4,3/5] dt-bindings: add google,cros-kbd-led-backlight
    https://git.kernel.org/chrome-platform/c/20f370efddb5
  - [v4,4/5] platform/chrome: cros_kbd_led_backlight: support OF match
    https://git.kernel.org/chrome-platform/c/fd1e8054ff69
  - [v4,5/5] platform/chrome: cros_kbd_led_backlight: support EC PWM backend
    https://git.kernel.org/chrome-platform/c/40f58143745e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


