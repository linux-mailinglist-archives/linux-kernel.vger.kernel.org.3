Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586504621E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhK2UPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhK2UNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:13:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D984C08ECB7;
        Mon, 29 Nov 2021 08:45:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE1CB615B4;
        Mon, 29 Nov 2021 16:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56DCC53FC7;
        Mon, 29 Nov 2021 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638204356;
        bh=BDOCaXVF64qmbKixmffTWgJrkuezOZ8u43wxCYDH+Gg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G2PyIpIEtaa89eQ6Q/AfTZ1/UXMT2PvKvhUAdSFEAeeQ9clvKKjiTOcUH56XK/uUJ
         CVQEgs2tDHv8Amsavg1urOKwXyAauV5mN0daMZmo2O4C742eTw+2fwllbDUOqsD8i6
         5VoaM7h1I55M3sEJbhinEOE3eQlluFxNBZylFhWtTE7jmz9uU4rOl+Ru88utYiNVWt
         4eMf8iVp+JJcAuH78KVCHqooBwyDY90Ub7/AYDFeVu6taJmDI3w5JxLxpUDhqlCQxO
         eb/4zL4ywXY/pUsqCvQXj5KKzetnFyem94/FU01DMgpFz+HcVj/QUztPw065K8TAns
         eCcnE4sfMGXfA==
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
References: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
Subject: Re: (subset) [PATCH 0/3] RK356x/Quartz64 Model A SPI
Message-Id: <163820435465.1716901.11036840063339929110.b4-ty@kernel.org>
Date:   Mon, 29 Nov 2021 16:45:54 +0000
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
      commit: 07fb78a78de4e67b5d6d5407aeee1250a327a698

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
