Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDA4A4A62
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377474AbiAaPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:19:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58280 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358630AbiAaPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:19:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 964086136E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99572C340E8;
        Mon, 31 Jan 2022 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643642380;
        bh=U81rLjtR8IWf25YlfkzFt9hF10+zIQLW61njAr/UKkQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LcMKN1a7e9Uw3CSgeFnrAQbtA21WcvH0Nn8y0UfSFiYYR0GBigo5Y+dlss2oK4IIq
         UU9gg2u0WFpYZibW9LuMHXsVWCet5yd1j7EaP9tC8FKwcq9C/l8kcrnQzsRLaDaIJv
         FgYzxi7MfY72iNyor0lhbgHzB3LCaiPPU7ApzW2JSWF/07OHL/Ixtz8dDfnC4pAjXu
         RVqGrhTeu8LZ8MO/rAMeertOSRMvfZpGAKL4VpkeUesX2W91Iv1mt+bLI0licqIL6D
         hJFwAPFvseu/SsZJgNtHTPaoBpBM8Zxj72y9N9y8QjPg93jACT7WBhdTp5edMdyOVl
         CLZ3S25dkawUg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20220129080259.19964-1-rdunlap@infradead.org>
References: <20220129080259.19964-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: max98927: add missing header file
Message-Id: <164364237834.3159101.12950435355735915006.b4-ty@kernel.org>
Date:   Mon, 31 Jan 2022 15:19:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 00:02:59 -0800, Randy Dunlap wrote:
> Add a header file that provides the missing function prototypes
> and macro to fix these build errors (seen on arch/alpha/):
> 
> ../sound/soc/codecs/max98927.c: In function 'max98927_i2c_probe':
> ../sound/soc/codecs/max98927.c:902:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>   902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~
> ../sound/soc/codecs/max98927.c:902:63: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
>   902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
>       |                                                               ^~~~~~~~~~~~~~
> ../sound/soc/codecs/max98927.c:909:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>   909 |                 gpiod_set_value_cansleep(max98927->reset_gpio, 0);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98927: add missing header file
      commit: bb45f689fa62110c263c86070bfcb9ecbb6e1e23

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
