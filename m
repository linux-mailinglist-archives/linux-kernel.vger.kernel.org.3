Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76F4A8782
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351827AbiBCPUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:20:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59158 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351810AbiBCPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:19:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4A2EB83499;
        Thu,  3 Feb 2022 15:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB126C340E4;
        Thu,  3 Feb 2022 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643901597;
        bh=+oMipdTqeGn3t2g6jeKchCDXYGGczB91ZYbqdBllfk0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=itPTw0gLEjL3s15URQDHf3SmNEb44BLN8VY72AqnLPJOMUFXvMZ8KxtyYKhwCs0hz
         M1IoM9t2k9gjHOz0gWu5RN/riCkIWL9gBa3rVXS8yZnllVmHQmCPTe+9yUt86qDanj
         fKNC8I+KvNwELEOeTzJZhF8LB/Bp1cxY0ccAacqwqBfriC1Abc3mlYDPuluJvr/+pA
         mKxyhtsxWLBqfNQHbkV9+VrfjakjI134e+CnooSkR7F1GhkZT9sDeljhMR6sp6wnEl
         GzKzdCs4bCGMdZyb1SfvY7qoOmR6I1U7EyPDG0/U+rfPYRPhcLuk00v5iIYgIRZbdB
         QKR49XsCHj/Cg==
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220203020116.12279-1-samuel@sholland.org>
References: <20220203020116.12279-1-samuel@sholland.org>
Subject: Re: [PATCH 0/3] ASoC: sun4i-i2s: Support for Allwinner R329 and D1 SoCs
Message-Id: <164390159447.786717.831868545725165555.b4-ty@kernel.org>
Date:   Thu, 03 Feb 2022 15:19:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 20:01:12 -0600, Samuel Holland wrote:
> This series extends the sun4i-i2s binding and driver to support some
> newer versions of the hardware. Each instance of the hardwar now has
> multiple input/output pins, and channels can be muxed between them.
> Since so far the driver only supports a "default" linear channel map,
> the driver changes are minimal.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: sun4i-i2s: Add compatibles for R329 and D1
      commit: 7f97b2ad948343c3be543d12c2965f74bddc34c7
[2/3] ASoC: sun4i-i2s: Update registers for more channels
      commit: c8bbc1de9088fedb5d71db7d185c37db18feb2e1
[3/3] ASoC: sun4i-i2s: Add support for the R329/D1 variant
      commit: e2ce580f1fffc009807da73adf7dc86912ab6a19

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
