Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B814D528D40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbiEPSjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbiEPSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:39:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B43EA89;
        Mon, 16 May 2022 11:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F19DB815BA;
        Mon, 16 May 2022 18:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41F0C34100;
        Mon, 16 May 2022 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652726367;
        bh=uB3ceHjdyIYIrq6O7Ou3iUbDoNJSf6Vwwjiv6bTT8sk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aethkcieAmzy7b8cGKRBdAPWSFwCkpCHnoew6BVpYkR+d2cK4K/pBjL1t5aVjwjsL
         IKpSpsuuA4p7ZkjTiArGHGzCf71Dzd/T8Q5T3tVT1bDrJO5E0ISnK9Ju7tDX45aqn9
         kOaTmja9a8ZIy8icvgXmoAeRwygYc23PkmOJ/mfuu1TK+ovdHbvDVf/+kGhLlOI4oc
         Mtssfd4RwKymKzutwv7n/tF6lUnOABU1zSBy+Z3GOfUU27g/NeHFoZ8EApXL0jvwP/
         5WeV1TkuII719KFikxqcfPVelTHUqHpL05ggq0iMFgbWtBbDoMimfQnteSigwpQ55w
         zJkZhLPRfmpLg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        clg@kaod.org
Cc:     andrew@aj.id.au, robh+dt@kernel.org, devicetree@vger.kernel.org,
        p.yadav@ti.com, linux-arm-kernel@lists.infradead.org,
        richard@nod.at, joel@jms.id.au, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, chin-ting_kuo@aspeedtech.com,
        linux-aspeed@lists.ozlabs.org, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
Subject: Re: (subset) [PATCH v7 00/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
Message-Id: <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
Date:   Mon, 16 May 2022 19:39:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 19:56:05 +0200, Cédric Le Goater wrote:
> This series adds a new SPI driver using the spi-mem interface for the
> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> SoCs.
> 
>  * AST2600 Firmware SPI Memory Controller (FMC)
>  * AST2600 SPI Flash Controller (SPI1 and SPI2)
>  * AST2500 Firmware SPI Memory Controller (FMC)
>  * AST2500 SPI Flash Controller (SPI1 and SPI2)
>  * AST2400 New Static Memory Controller (also referred as FMC)
>  * AST2400 SPI Flash Controller (SPI)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[02/11] dt-bindings: spi: Convert the Aspeed SMC controllers device tree binding
        commit: ce9858ea499da025684a7a5f19823c2c3f14bdce
[03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
        commit: 9c63b846e6df43e5b3d31263f7db545f32deeda3
[04/11] spi: aspeed: Add support for direct mapping
        commit: 9da06d7bdec7dad8018c23b180e410ef2e7a4367
[05/11] spi: aspeed: Adjust direct mapping to device size
        commit: bb084f94e1bca4a5c4f689d7aa9b410220c1ed71
[06/11] spi: aspeed: Workaround AST2500 limitations
        commit: 5785eedee42c34cfec496199a80fa8ec9ddcf7fe
[07/11] spi: aspeed: Add support for the AST2400 SPI controller
        commit: 53526ab27d9c256504f267713aea60db7af18fb0
[08/11] spi: aspeed: Calibrate read timings
        commit: eeaec1ea05c0e0f08e04c6844f20cc24a2fcc0f4
[11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB for AST2600
        commit: 73ae97e3cabb580639f02f12a192324a53c4bebb

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
