Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4471575241
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiGNP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGNP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:56:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9154598F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 075CCB8272B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE719C3411C;
        Thu, 14 Jul 2022 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657814189;
        bh=l/7hRN4WBQbSvci6mqULbBaU902KAwpVi4j/fQvDzlw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ox4wpyWy2PvpTfJ+HDniKnCVAg6Y9hFPbO5mxH7hNIYgoduJlwiPYoCCmPLHoF5+g
         UiMFvV6bxdGjtOsU+c7P1dIpTj0lVB4GQwknht/Dtue5eLHy9ZZ7XXCTJm1n7pEA+L
         rJjreoXazdQx+VnZJ1SoV4+2yuflW4KaVmItM/agHcC8vmi1OOffEDd5cacZ8IGWsq
         /UnxsciYR3JAurxI8DFCBqzhiu1OQJ6m/X7LIj58wTRb2l9swQ6aTHLAGps6BSgQOi
         Q89yFmXCtoYJrtqWm4QawSxFYBllkJLoj1haoqbKHgKJ/9e+TrX9bJSXOOde/FgGkE
         v0fS091emYCsg==
From:   Mark Brown <broonie@kernel.org>
To:     lee.jones@linaro.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
Subject: Re: (subset) [PATCH 0/8] MAINTAINERS and Docs: Use Lee Jones' kernel.org address going forward
Message-Id: <165781418870.107719.11036926748201645413.b4-ty@kernel.org>
Date:   Thu, 14 Jul 2022 16:56:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 12:25:25 +0100, Lee Jones wrote:
> Moving over to my kernel.org address for upstream work.
> 
> Also remove myself from PWM.  Nothing left to do here.
> 
> Lee Jones (8):
>   MAINTAINERS: Use Lee Jones' kernel.org address for MFD submissions
>   MAINTAINERS: Use Lee Jones' kernel.org address for Syscon submissions
>   MAINTAINERS: Remove myself as PWM maintainer
>   docs: ABI: sysfs-class-pwm: Update Lee Jones' email address
>   docs: ABI: sysfs-devices-soc: Update Lee Jones' email address
>   dt-bindings: backlight: Update Lee Jones' email address
>   dt-bindings: mfd: syscon: Update Lee Jones' email address
>   dt-bindings: regulator: pwm: Update Lee Jones' email address
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[8/8] dt-bindings: regulator: pwm: Update Lee Jones' email address
      commit: 2f3d2e96b8ea34f21989b75f28d8a6a0e6e6c756

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
