Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDE5A6073
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiH3KON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiH3KNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F83DED
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F12E661468
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBFCC433B5;
        Tue, 30 Aug 2022 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661854144;
        bh=Z9reXcsrIkZplDNMS02kQlXf12HDGnUx9tXgDy6f+6g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fFrm9OKfAgFgpYV2gknVg/eV61X6HNOuAgbFpOOS2MeVcE8lk3wMi1LdDnrFqV1v0
         vjdTWL1LViLVPOpvSxBwNGX8OImrfoKC6gyZIgzdnxdxvPzkY3rGqXKRIjui+NEo8m
         G3VCSaCxbyz7Cn0EMdqiJDPs0M1Jx3UvvqrYfQ+vJkpqFUHZnZdUfTu2HN5nUbL8RR
         tls+V9wxQaLO8xe+10HawNWxUxeEJDUyOKNPn/wn1uHE9WhTv8e+/v98wpsPw9keRh
         665dxvuxsjIDIuCm9L7ogNWVFBkW4ybd+FOeyjcYi82QLuVT/pCXUdJZOB9w56Yoso
         d6dsdjtDL+1CA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Cc:     kernel test robot <lkp@intel.com>
In-Reply-To: <20220830075855.278046-1-krzysztof.kozlowski@linaro.org>
References: <20220830075855.278046-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: rk817: fix missing I2C dependency in compile test
Message-Id: <166185414198.1099664.6211983817122051754.b4-ty@kernel.org>
Date:   Tue, 30 Aug 2022 11:09:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 10:58:55 +0300, Krzysztof Kozlowski wrote:
> SND_SOC_RK817 uses I2C regmap so compile testing without parent MFD_RK808, requires I2C:
> 
>   WARNING: unmet direct dependencies detected for REGMAP_I2C
>     Depends on [n]: I2C [=n]
>     Selected by [y]:
>     - SND_SOC_RK817 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (MFD_RK808 [=n] || COMPILE_TEST [=y])
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: rk817: fix missing I2C dependency in compile test
      commit: 5204e836544763cb085e653c82d4da77a427591a

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
