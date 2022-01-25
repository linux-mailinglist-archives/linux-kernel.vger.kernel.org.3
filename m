Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF72049B6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579835AbiAYOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:39:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43802 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiAYOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:35:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67A16158D;
        Tue, 25 Jan 2022 14:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CCFC340E0;
        Tue, 25 Jan 2022 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643121309;
        bh=AtXE1ueZkQ0gD/YVVUt8Nlfb9yoVnUlbr62Nxv00e8g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aUOSrB7eahx+kVWfvtqKQACe0SMJ5/eCsiYIjBeF0gpL3lWBKjx70vzanZY2O14wJ
         +ODbKZxSUgHL+VxW6Y9NqwIlfUF76R2ZyIywUt0cCA9fjiCuXgVmSOkkZw5g6WTK5x
         2TWDPsc1UJq8LHWvlue8u2FSkgxt37XVpbuhdj1DM3mQG/AuRUO1PD690sL+evUEK2
         1TGHlMFnRdA6HU0kqDWODQV7pxiHgyecKiy56SVux5/GCB8bEwZuIllS5Jw66tdNme
         hifq6bgCshbXnzlQxAmznZAxllfKWRtdBozAeCHtyjUiSIRvjrajqdEeEwlfYwMsiW
         q+1v3FaG8s8ow==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Li-hao Kuo <lhjeff911@gmail.com>,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        andyshevchenko@gmail.com
Cc:     lh.kuo@sunplus.com, wells.lu@sunplus.com
In-Reply-To: <cover.1642494310.git.lhjeff911@gmail.com>
References: <cover.1642494310.git.lhjeff911@gmail.com>
Subject: Re: [PATCH v6 0/2] Add spi control driver for Sunplus SP7021 SoC
Message-Id: <164312130733.3602551.286294700422515308.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 14:35:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 16:42:37 +0800, Li-hao Kuo wrote:
> This is a patch series for SPI driver for Sunplus SP7021 SoC.
> 
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
> etc.) into a single chip. It is designed for industrial control.
> 
> Refer to:
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://tibbo.com/store/plus1.html
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Add spi driver for Sunplus SP7021
      commit: f62ca4e2a863033d9b3b5a00a0d897557c9da6c5
[2/2] dt-bindings:spi: Add Sunplus SP7021 schema
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
