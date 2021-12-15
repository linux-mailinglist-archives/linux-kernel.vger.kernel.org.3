Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7040A47606D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbhLOSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:14:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbhLOSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:14:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3C7BB82056
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4193CC36AE0;
        Wed, 15 Dec 2021 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639592044;
        bh=Qb6bAw7Yfc9ExsT/6JSWE8AUnkp9FXA4Nxscx9lbVAc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b/m6fdROGoRDZ9dZZ5ErnWwO5gN1DTjK4jrqwDidzf+r6gRauKxDaVlmlQrTVQ6x3
         Fzs5w8j8HS6OabcUKAtpmPQrz0NVGIoQxOY0J1+2INW688ZF9b4DAhcMN8ujCd/iv1
         FYCUNM6tMXUXn+cdNVYgnhdfVRFqEJPoKy4x4zaNdSyjw3h+ZFEweUVKu8WgpfTEj2
         NC26IhuT3UmDnEc65mjt9NvdsFZF8fQaRF0BNM39UV4kgx1cmSC3tzrao98a0gjpzl
         iMoEsBtPvm+J+A5uh2msne5ApRiEtBP2AnEotLQd/ANPtt1d0o3et3eop2y7kK7vjO
         VCHiyrCBTOCAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jbrunet@baylibre.com
In-Reply-To: <20211206210804.2512999-1-martin.blumenstingl@googlemail.com>
References: <20211206210804.2512999-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/2] ASoC: meson: aiu: two fixes (for 5.16)
Message-Id: <163959204298.2212554.815832977637183114.b4-ty@kernel.org>
Date:   Wed, 15 Dec 2021 18:14:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 22:08:02 +0100, Martin Blumenstingl wrote:
> In this series I am proposing two fixes for the "aiu" driver, used on
> Amlogic Meson8, Meson8b, Meson8m2, GXBB, GXL and GXM SoCs.
> 
> The first patch is the result of me trying to understand the way how
> we get the DMA buffer and address for the audio data. I'm not an expert
> in terms of DMA. From what I understand we need to inform DMA core
> about the limitations of the hardware. In case of AIU it's DMA address
> registers only take 32 bits, so DMA core should be aware of this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/2] ASoC: meson: aiu: fifo: Add missing dma_coerce_mask_and_coherent()
      commit: 1bcd326631dc4faa3322d60b4fc45e8b3747993e
[2/2] ASoC: meson: aiu: Move AIU_I2S_MISC hold setting to aiu-fifo-i2s
      commit: ee907afb0c39a41ee74b862882cfe12820c74b98

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
