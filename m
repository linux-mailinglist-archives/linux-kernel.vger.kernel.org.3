Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FEE481383
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhL2NaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:30:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49586 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbhL2N3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:29:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 454F4B8190A;
        Wed, 29 Dec 2021 13:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4942C36AE7;
        Wed, 29 Dec 2021 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640784579;
        bh=bk4jM8QLUK3Drk+Pn2dYURwUnfzbNco8xaPEn3dvdCU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m9AaPfcgi8aWZin3GD1ksPkBlmIPdqIomyB3jW5OoIpD/gsOcT6zhF5p66aDhNV8S
         hwuNZGkxqEs/oPTd3q++pI+nP+KEv//q5cDaZM32iwENl54VNBw5fF2gK1uNzyiK6O
         omj3L4FEMSljFBVkKKw5UsNDC43krAeYAGbvQQDU5uy9C5ZwK1gMp3mcAmhMb6OxO2
         9vPE/c2tShHhkv8q+qKVl1CzrYrZ+VCTyhRmcMdLQy7kPYOPZG8fz6CqMUwWVk1Nsp
         Bp6Qb0NCHFlqj66vfkBs9XNqrKyV5FlxZGcuR3Hy8XZWvg74/k301qNSxj0qn1gHh6
         kSgIek5StfNEA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, matthias.bgg@gmail.com,
        Trevor Wu <trevor.wu@mediatek.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tzungbi@google.com, jiaxin.yu@mediatek.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20211228064821.27865-1-trevor.wu@mediatek.com>
References: <20211228064821.27865-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: update control for RT5682 series
Message-Id: <164078457646.1246652.7413539172267193137.b4-ty@kernel.org>
Date:   Wed, 29 Dec 2021 13:29:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 14:48:21 +0800, Trevor Wu wrote:
> Playback pop is observed and the root cause is the reference clock
> provided by MT8195 is diabled before RT5682 finishes the control flow.
> 
> To ensure the reference clock supplied to RT5682 is disabled after RT5682
> finishes all register controls. We replace BCLK with MCLK for RT5682
> reference clock, and makes use of set_bias_level_post to handle MCLK
> which guarantees MCLK is off after all RT5682 register access.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: update control for RT5682 series
      commit: c5ab93e289ce554a4e0d47330dde120284541aa1

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
