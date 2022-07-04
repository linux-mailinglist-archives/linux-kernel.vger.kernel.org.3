Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77788565A79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiGDP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiGDP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:57:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DDDEA8;
        Mon,  4 Jul 2022 08:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08C060C02;
        Mon,  4 Jul 2022 15:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E96EC341C7;
        Mon,  4 Jul 2022 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656950261;
        bh=a6RKJQCid/UVv8Ya1NMJAoisbLIXHGq7RKNAj6q9jqY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=liVaWde7+wohy/TzijN+e9VpNx+o7oVFjqX6YuhohjCaFOqnFvVH6MAAQhFQKcd5m
         dHcBDnEsWyrp6Y6Ecqaj30o9zJ13g+RdVWV7KI10m8Xq51yUJ2FEd8BduThGsdBCHV
         LRcTXM1AZ2Rtnc7/g/zgrEFVFpS2SFXVDZKoj7v0TeNF3WHXCHUkD3AknhNRZy+aDj
         zdx8tbGMLhrigom1OxQbLik2Lw8k7WezQ9ACXFiJcv0VbpgTPtWF0GzzoLkpuJ3AEn
         dGvEOJCUkjKUYyciE5eCVBtFgHmz3OXqp6ab6dUjVGTHzzZhqRH5yOy4lM5cPsqbk6
         fuo87rNqLQMyA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, jiapeng.chong@linux.alibaba.com
Cc:     linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
In-Reply-To: <20220701072850.62408-1-jiapeng.chong@linux.alibaba.com>
References: <20220701072850.62408-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: tegra20_ac97: Fix missing error code in tegra20_ac97_platform_probe()
Message-Id: <165695025874.481068.18415928227093341712.b4-ty@kernel.org>
Date:   Mon, 04 Jul 2022 16:57:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 15:28:50 +0800, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> This was found by coccicheck:
> 
> sound/soc/tegra/tegra20_ac97.c:357 tegra20_ac97_platform_probe() warn: missing error code 'ret'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra20_ac97: Fix missing error code in tegra20_ac97_platform_probe()
      commit: acf981f94edca13c85fa24dd8511cdc6bd4c98ed

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
