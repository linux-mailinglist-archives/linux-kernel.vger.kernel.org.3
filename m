Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48B849B1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiAYKav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:30:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46736 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiAYKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:21:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 934E7B81753;
        Tue, 25 Jan 2022 10:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2B5C340E0;
        Tue, 25 Jan 2022 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106061;
        bh=wE0+LyL9OO9k4KStNlbPC+R0zekIivlZyn3e+XbniJU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lK5HG6+yprEw9b2YOjKBzCBcDXIoaDO/yWMfpv8Jkc4fKqSAaGiDjF5fR/qTHCD2I
         du3z+Gol99X72jgDf9eNOx9VQoM7P8Nqje0R3fvTt8txicv4dvNOp1DMtAJTPFolBj
         H16xI3+7Ov9jONGntXhKgcYEgq0uBk4eJajd0Vp7z/1Di/ZXmcwhfQqyIaZowWc0Wl
         rvAdAGyOqnrPyh+rRzG7KPsukmmyJTGF1uz34fJKPG7/IZtyfWO4HkXmjaItRS9OcA
         WoA09mWuCWZjgISGkqFSfZXAzTuwPTtD2Q0YKCnJE8ojkEWGtxFe5Urmw5MRp15YdE
         iHiHZqvfCG4gA==
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
References: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH 0/3] RK356x/Quartz64 Model A SPI
Message-Id: <164310605968.75043.351730606633700396.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 16:43:41 +0100, Nicolas Frattaroli wrote:
> The first patch of this series adds a compatible for rk3568-spi
> to the DT bindings.
> 
> The second adds the SPI nodes for RK3566 and RK3568 SoCs. The nodes
> were lifted from the downstream vendor kernel's devicetree, and were
> double-checked for correctness.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/3] dt-bindings: spi: spi-rockchip: Add rk3568-spi compatible
      commit: bdac3bbd0dc63873a9c606b8e4f814e6d61d288d
[2/3] arm64: dts: rockchip: Add spi nodes on rk356x
      (no commit info)
[3/3] arm64: dts: rockchip: Add spi1 pins on Quartz64 A
      (no commit info)

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
