Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E55835E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiG1AEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiG1AEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9360491F1;
        Wed, 27 Jul 2022 17:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1115F6175A;
        Thu, 28 Jul 2022 00:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721D3C433C1;
        Thu, 28 Jul 2022 00:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658966677;
        bh=wINtCHc5eLNlHmB53FT2rtl/5x4h8+wHWDC1bCkxcbk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=dju8klrp1eA2utIGaZDOwT8k5dc/FhHAPdDk5VpUIfEfc2/96bAGzrm/SsqnTYT2h
         ktBwE2mZh3wrLUhVR5j5FVCkuaovYlx+Y/PjI1Y5df5ALqHc7vYdpalpE2sU9aTwSg
         HZefOC0ohmx3Dxn7exySpyC8Q/TsbqoCBULagkrEv3XgILB3SdkkPTuhZyVnPcuUX6
         ptwCgH2eVJyA6JW1MbISoBB26Hm6phQkr43nJ/Nyj4KnISW2ZX06sDoMfNZYk4KWTl
         P/VWWvZdyC1wgi88hNTcmD+YS96uWLS8mNcETiWYvQLTabtOohrZmkmocRFAHHWAhx
         KXW2WYFdQcIOw==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        - <patches@opensource.cirrus.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20220727164050.385241-1-krzysztof.kozlowski@linaro.org>
References: <20220727164050.385241-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: use spi-peripheral-props.yaml
Message-Id: <165896667516.3927242.3602967595765365551.b4-ty@kernel.org>
Date:   Thu, 28 Jul 2022 01:04:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d1cc2
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 18:40:50 +0200, Krzysztof Kozlowski wrote:
> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: use spi-peripheral-props.yaml
      commit: abed2baf6814597f244cd879285b2210b0870548

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
