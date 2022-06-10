Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52CD545B30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiFJEkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiFJEkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCA2B71;
        Thu,  9 Jun 2022 21:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA33B61DDB;
        Fri, 10 Jun 2022 04:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42863C385A5;
        Fri, 10 Jun 2022 04:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654836017;
        bh=dJlNq2TyFXmhv3KP0VOW3PAskcPpHWhMtmrEcpvN1/o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Mi6kiS+3KSU9X7pGDW7C+m2AX7Yg23wsVYRbUqnNm+hBiUmiBkgHnlfmAoy9DG9nM
         y/4Cy05bW3bb0PY5zMAjtB6Y359WAEKA+kmVwmqdJnCLlNYOmoAQQVA2szbnDtsMwY
         DDhftjcI7zoc9sgHz1f6l0yB6WODTVDxFkR1wHPojoWslvMDwPHYKDmEvkLgwXTs8K
         P8vyppUU0kyq5nUmaBMlEy1x8chHTTi7uYqyjQr/GrBz0FB5AbltpAYo7iZBV9HmKZ
         12nEEGc2yUmHLLa5Ek6tRO3aIsWOXY+Piiz/02ATYrKFbKMTGaWfdvAQqWgZfsQFW/
         44mONSXdeJg3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 282F8E737FE;
        Fri, 10 Jun 2022 04:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/5] platform/chrome: cros_kbd_led_backlight: add EC PWM
 backend
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165483601716.17399.13464543301386484643.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Jun 2022 04:40:17 +0000
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

This series was applied to chrome-platform/linux.git (for-next)
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


