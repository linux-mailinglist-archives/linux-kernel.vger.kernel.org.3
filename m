Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994A53FBD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbiFGKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbiFGKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37367ED3F2;
        Tue,  7 Jun 2022 03:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93A76B81EF8;
        Tue,  7 Jun 2022 10:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A813C385A5;
        Tue,  7 Jun 2022 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598750;
        bh=L5UprDm+eFlKd0eGBmXLIaDF8ATDo8XW9lH/TYTLBUc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=U7ZorcJLYtG28or0KrIhV9ZevaqjS5ymiucoZSkHfYPcE3YjOmj0B/QVxKNkj3da8
         f+kCqKjDbZSmZtpqK8bYzAcqF+3cPgA67OdHbz08NByI37/CipYjTroKGhS37O26Mz
         hr5E7cTIpc7LLBrmkE+6fm6SD255/oI2Avclic0U7T/a+B8BEr0qWrDMkX32lisIme
         1ZMc1qfOgErzEpLbmr90uMNlcVHXuVJqkNqSdW2usEdvoLF00xRJRkbCz58RngY0i+
         nB4JLb0O1eTfMhmF5sHNDXfyANzPSJcsnd+aLDSFx4RMOrcnC/YIIGw4tUxzPeVLmJ
         aPG5K1EM/a9Yg==
From:   Mark Brown <broonie@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, amartinz@shiftphones.com
Cc:     krzysztof.kozlowski+dt@linaro.org, stephan@gerhold.net,
        Liam Girdwood <lgirdwood@gmail.com>, caleb@connolly.tech,
        me@dylanvanassche.be, Takashi Iwai <tiwai@suse.com>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
In-Reply-To: <20220602164504.261361-1-amartinz@shiftphones.com>
References: <20220602164504.261361-1-amartinz@shiftphones.com>
Subject: Re: [PATCH 1/2] ASoC: codecs: tfa989x: Add support for tfa9890
Message-Id: <165459874728.301808.2918260334640693383.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 18:45:03 +0200, Alexander Martinz wrote:
> The initialization sequence is taken from the version provided
> by the supplier [1].
> 
> This allows speakers using the TFA9890 amplifier to work, which are
> used by various mobile phones such as the SHIFT6mq.
> 
> [1]: https://source.codeaurora.org/external/mas/tfa98xx/tree/src/tfa_init.c?id=d2cd12931fbc48df988b62931fb9960d4e9dc05d#n1827
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: tfa989x: Add support for tfa9890
      commit: ef6c320942a2f057204702d769d507186fd7f0b7
[2/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
      commit: d0da7c8668dc19df157d927a67721ca00e29ff2b

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
