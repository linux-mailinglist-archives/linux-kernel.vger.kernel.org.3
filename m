Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3949B1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347518AbiAYKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbiAYKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B1C06175B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE2E61614
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B62BC340E8;
        Tue, 25 Jan 2022 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106040;
        bh=PPeOvJVjKQk1sgWBgXTRE3M3X/ghG6GwBr17kd9EHAs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dx/CfScUZ2xfA9Ast+sVlMjDabJlKwxJVNGShS4Hgc0IGSpT5qNBm6ZqUhnQpAZJi
         NH2erSXALoBz7bbfLbkg+qEWYIUHQX9RRCES3p8LkA6B4aMDTvm0nz4SVY2dDKI6jq
         iTCNsb+6BbxmzEoLzFfzv/9Ad9ggJGLzIkpya2QNTT48/9508YL9LrppFc/Sc8iMOT
         f6OewycNyKOE50sDAcMHATWyLYlC3UT1UuAiFDdY6CLMtLtasVBlSWEK0K/6cbLmnT
         2VUGbhU9IG32KLJ/mreOtm/s55njGS16GBCwKEUcsj1A9N+aJCGnuwOEtj1mruyQ+x
         BNS4Z69RrKCUw==
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     cezary.rojewski@intel.com, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org
In-Reply-To: <20220121171031.2826198-1-jiasheng@iscas.ac.cn>
References: <20220121171031.2826198-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v3] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
Message-Id: <164310603890.74844.13333058824598578375.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2022 01:10:31 +0800, Jiasheng Jiang wrote:
> Since the potential failure of the devm_regmap_init_mmio(), it will
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
