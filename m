Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48C04767DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhLPCVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:21:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50664 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhLPCV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:21:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9861761BCE;
        Thu, 16 Dec 2021 02:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340A9C36AE1;
        Thu, 16 Dec 2021 02:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639621287;
        bh=WPhsqfedMB8Cyx3EEl+Ru9ABU6XVEDXjkCEr6Qxk1qE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dwMhf9YTfmBY2X7bKpYFDwmtxjLed+jwXk+t6bsiutDlhSlU832xFAsxhsJvds2Qm
         LGRLTr9C3fjkSxbA9fWJAz0NARYEu2pO6TXpudteTfFVpVrGUaWjQYQH3FNMLcm8JJ
         zJDrG0EBsPrKJqrXLO2KWdUQ31veZHFXruTwb4hxRxfCHKpIVb4BusU1Qy03lGGI0x
         cci1xZavagvVAU/5r+zDWUesY/jKOn0FQChHOEs4lXvxTV/fIUZjB0ZK4EoKFpwMcT
         hpX6YYKUV8E2FXkG6C/ZOzweTbEf6Kq36eO/9/8SkLrQupDT8PxhQoFvQAJdChC+6F
         2HVbNZcImeZEQ==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209122939.339810-1-tudor.ambarus@microchip.com>
References: <20211209122939.339810-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH 0/2] dt-bindings: spi: atmel,quadspi: Define sama7g5 QSPI
Message-Id: <163962128492.2075495.3678727080606971257.b4-ty@kernel.org>
Date:   Thu, 16 Dec 2021 02:21:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 14:29:37 +0200, Tudor Ambarus wrote:
> Convert the Atmel QuadSPI controller Device Tree binding documentation
> to json-schema. Define sama7g5 QSPI.
> 
> After the conversion to yaml, make dtbs_check reavealed a problem
> that was fixed with:
> https://lore.kernel.org/lkml/20211209102542.254153-1-tudor.ambarus@microchip.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: atmel,quadspi: Convert to json-schema
      commit: 001a41d2a7061694fa31accdbc2013bb5c5d83b5
[2/2] dt-bindings: spi: atmel,quadspi: Define sama7g5 QSPI
      commit: 77850bda360dd9b389d5064c64b79467d613c3d6

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
