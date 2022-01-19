Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C497C493F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356563AbiASSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:02:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60738 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiASSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:02:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 240C36164B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0858EC340E1;
        Wed, 19 Jan 2022 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642615355;
        bh=lFbFmk/aY3Awpx6kg8ejVPc7bOfnP/ly0j3vvYiYSLk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X13pX4fJy3fRJZKI7F7MRVUE9FDrT6nBmOjzxghhUmAx2oa89pVuGluI1ZYQomcy6
         J+u9NeebYvDBhaYmNBCPyWnAjj843aXJvGQIg5lEMex3rGmpPraZKtS0Sx3GixOSWu
         vOFCHvDwIjpsucj9Dm3JF8fyjUVl+U1NJKul284TSlhz9ilYs39lj11XWUJ/f0eAWA
         aoMRjTtdGCjJ1nOQKkTsTFwusUiXG8pCTiSkWRpA4jWRHdLqZ9X43k7TEqlfTQxDbf
         s7aV3RXj48GWZ8ij+1oHhON0CDe042M5476jVs1mtL2ADTwQ7m1iF2hjoGebAbAjNd
         8fitwOsx/LB2w==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com,
        Julian Braha <julianbraha@gmail.com>, matthias.bgg@gmail.com,
        tzungbi@google.com, geert+renesas@glider.be, perex@perex.cz,
        trevor.wu@mediatek.com
Cc:     linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, fazilyildiran@gmail.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220117050324.68371-1-julianbraha@gmail.com>
References: <20220117050324.68371-1-julianbraha@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: fix unmet dependency on GPIOLIB for SND_SOC_DMIC
Message-Id: <164261535273.2816847.12797426159265748718.b4-ty@kernel.org>
Date:   Wed, 19 Jan 2022 18:02:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 00:03:24 -0500, Julian Braha wrote:
> When SND_SOC_MT8195_MT6359_RT1011_RT5682 is selected,
> and GPIOLIB is not selected,
> Kbuild gives the following warning:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_MT8195_MT6359_RT1011_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8195 [=y] && MTK_PMIC_WRAP [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: mediatek: fix unmet dependency on GPIOLIB for SND_SOC_DMIC
      commit: 579b2c8f72d974f27d85bbd53846f34675ee3b01

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
