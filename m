Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D949B189
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbiAYKXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:23:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60440 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiAYKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A3361637
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A70AC340E0;
        Tue, 25 Jan 2022 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106019;
        bh=ExbJRYNtfVD1s5WkJJibRPzKPc9HJ2TEz1/Xye0GnXE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XbBlcFolcJ6CjYh6lffKWnbPXVNuKPmolwII2mPN6HFOtV+DbYrhaOxuxUHzCwQBK
         QVsKwUNhkAVuBSHAJsACTa5GGTBWURu+7HHedxIe4nYy2KyD4ThndS1Ssd+DzfGT18
         oHN3VHIyY9u5+HnKdh8ngPTPDHky+2SsurRy3YRAQaw18DNQ6qp05ikAx9qWHxYslS
         x9SFRb/9fpYATYGMxkvIEOMoJYQZ5tGpYKJXY7wcSDnb5dG9WK7JuncBzMCY133C9r
         ES23EZdRWJ4MXm3YZQfCKvUJJiZIPR87gD1mvsXOAhK6wLybyck9eTzPVPpbxcS39Q
         PHK9zlqoS1fcA==
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     cezary.rojewski@intel.com, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org
In-Reply-To: <20220114065713.1246619-1-jiasheng@iscas.ac.cn>
References: <20220114065713.1246619-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
Message-Id: <164310601716.74844.9223636725378282440.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 14:57:13 +0800, Jiasheng Jiang wrote:
> Since the possible failure of the devm_regmap_init_mmio(), it will
> return error pointer and be assigned to the regmap.
> Then the error pointer will be dereferenced.
> For example rx->regmap will be used in rx_macro_mclk_enable().
> Therefore, it should be better to check it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
      commit: aa505ecccf2ae7546e0e262d574e18a9241f3005

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
