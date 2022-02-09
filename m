Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580B04AF61E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiBIQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiBIQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:10:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10FFC05CB87;
        Wed,  9 Feb 2022 08:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6026A61727;
        Wed,  9 Feb 2022 16:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388CCC340ED;
        Wed,  9 Feb 2022 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423017;
        bh=0ViYHYGupp0RVHwWiup4TjHH132SXczPULdGlmJS4Sk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pdie2qDQcx/nuhGYnF+wph5D3XjR0Tnjb9L+uB/2bd/qP86rzAlZ82l8L1AY/DKlq
         p4LZFO6bs/a3nO2T+Tpd1Ecltklu8c0R0iAS+j6FoQaZw/qSqaUp80YhDL7eIHJksF
         mxdXmSvKIk/SkAR6kP5YRaOfz/m6/6yltTyxl/+5o7PkJxfegbEwFB0NsB5qeMKAyu
         +NJp30CtYoPOBqiU/Uh0KV59kuir4eInH4MEtTizRvTl8qgE2gG0Op+OjhEWBsjxvM
         PrLHGR+Rwb8QmTWZa+fzrgbRHyoWrpnY+baRwa+cfHvo32pNJXy5Ypn04PgbcygSkT
         lNxSb4XtBNDBg==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Jayesh Choudhary <j-choudhary@ti.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        peter.ujfalusi@gmail.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, krzysztof.kozlowski@canonical.com
In-Reply-To: <20220209063008.2928-1-j-choudhary@ti.com>
References: <20220209063008.2928-1-j-choudhary@ti.com>
Subject: Re: [PATCH v6] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Message-Id: <164442301594.4135858.14145086977040876727.b4-ty@kernel.org>
Date:   Wed, 09 Feb 2022 16:10:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 12:00:08 +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SoCs from txt
> to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains',
> '#sound-dai-cells' and 'port' which were missing from the txt file.
> Removes properties 'sram-size-playback' and 'sram-size-capture'
> since they are not used.
> Adds 'dmas' and 'dma-names' in the example which were missing from
> the txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> Changes 'op-modes', 'serial-dir' to optional properties as they are
> not needed if the McASP is used only as GPIO.
> Changes 'tdm-slots' to required property only for I2S operation mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
      commit: 8be90641a0bbd9a3606547aa6a0f70b020e74c8f

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
