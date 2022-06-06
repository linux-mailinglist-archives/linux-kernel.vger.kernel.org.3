Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B8F53E023
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiFFDeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349346AbiFFDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:33:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B949937A9C;
        Sun,  5 Jun 2022 20:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4AACCE10AE;
        Mon,  6 Jun 2022 03:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E19D7C34115;
        Mon,  6 Jun 2022 03:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654486429;
        bh=5lMsvTgNqHwId8R4Z7qHKxUwFEmIqu84tPBV+aaRuDQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pMJhDRWAYep1eOF51qKIMIjJOk7+gOMW7/oTZz7Kd6iU9+aYUPadVnOnToeMxjfPy
         MU2mFmmV1Ni3eHtvbPpMNWGzITvRhGTggJ1nTyutceflXbZinkmGV6bxJKmYkyQ0RJ
         MF5zM6FL4SoKBOnTW9k/VwRGQ4W+nG2fqaWdmV5Jx75ZBs1UJY8gIE/TLSRJ2IJ5Lc
         dxisd4xlM6TZhssB0DrPUgcQrO28qNlTbleAzo4ZWuo4BSrjjO15wWqLvKKAuVF+Qr
         2YTcsmRrXZZeTT1SOmVjANWHtAudh/fzR3nIIZGW1/6W6A4Hmld9+KbbO3daW5EgBD
         QpCfjnyfC//5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3244E737E8;
        Mon,  6 Jun 2022 03:33:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/4] Add channel type support to pwm-cros-ec
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165448642979.20111.8721457645475666607.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Jun 2022 03:33:49 +0000
References: <20220428100421.247471-1-fabiobaltieri@chromium.org>
In-Reply-To: <20220428100421.247471-1-fabiobaltieri@chromium.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, chrome-platform@lists.linux.dev,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Thierry Reding <thierry.reding@gmail.com>:

On Thu, 28 Apr 2022 10:04:17 +0000 you wrote:
> Hi,
> 
> The ChromiumOS EC PWM host command protocol supports specifying the
> requested PWM by type rather than channel. [1]
> 
> This series adds support for specifying PWM by type rather than channel
> number in the pwm-cros-ec driver, which abstracts the node definitions
> from the actual hardware configuration from the kernel perspective,
> aligns the API with the one used by the bootloader, and allows removing
> some dtsi overrides.
> 
> [...]

Here is the summary with links:
  - [v6,1/4] dt-bindings: add mfd/cros_ec definitions
    https://git.kernel.org/chrome-platform/c/84d0940454a3
  - [v6,2/4] pwm: pwm-cros-ec: add channel type support
    https://git.kernel.org/chrome-platform/c/3d593b6e80ad
  - [v6,3/4] dt-bindings: google,cros-ec-pwm: add the new -type compatible
    https://git.kernel.org/chrome-platform/c/a48d66d87274
  - [v6,4/4] arm64: dts: address cros-ec-pwm channels by type
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


