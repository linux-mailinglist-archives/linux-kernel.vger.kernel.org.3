Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BDD51250B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiD0WKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiD0WJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:09:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA786E08;
        Wed, 27 Apr 2022 15:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36570B82B10;
        Wed, 27 Apr 2022 22:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59B1C385A7;
        Wed, 27 Apr 2022 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651097196;
        bh=489hiLJcs6Ide99fGbIyUUwfO7HB+IkkCGXSwNjrVls=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G/2cUhuQR3ud2rXBziL0oth7g3hoX2Prqkr1UbESIsL88ApimAswbBe4zAQlK9Wz3
         2n7m/Sij2UzhwGpvx/x/Kvv5dDbKMihZSAXPu2i9pjF5+IDOG/MkNgFDQGrF7gVZk1
         cz5l6d4DdoX1AwJFeI3f48y0gyYwzVktJyeA9r1SkR3d9dHgAlgndCdsMcynqgfoNN
         OG3jhzKpU0TJrOskD+z3GrxODGhLsYDa8jLDolSI+R5FptNvMYRbO/fxhYjAi1U8e4
         ss5/qUdaXYIWtAa3eHZ4xilsuuKDV3h3/ms0xIaWu5kKFvE5n6eiNqSL4IBlpUccQd
         VjkMqDrLL/smA==
From:   Mark Brown <broonie@kernel.org>
To:     gch981213@gmail.com, linux-spi@vger.kernel.org
Cc:     cai.huoqing@linux.dev, paul@crapouillou.net, richard@nod.at,
        krzk+dt@kernel.org, yukuai3@huawei.com, colin.king@intel.com,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        f.fainelli@gmail.com, p.yadav@ti.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, rogerq@kernel.org,
        linux-arm-kernel@lists.infradead.org, miquel.raynal@bootlin.com,
        wsa+renesas@sang-engineering.com
In-Reply-To: <20220424032527.673605-1-gch981213@gmail.com>
References: <20220424032527.673605-1-gch981213@gmail.com>
Subject: Re: (subset) [PATCH v6 0/5] spi: add support for Mediatek SPI-NAND controller
Message-Id: <165109719250.501011.1358501844817783587.b4-ty@kernel.org>
Date:   Wed, 27 Apr 2022 23:06:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 11:25:22 +0800, Chuanhong Guo wrote:
> Mediatek has an extended version of their NAND Flash Interface which
> has a SPI-NAND mode. In this mode, the controller can perform 1-bit
> spi-mem ops for up-to 0xa0 bytes and typical SPI-NAND single, dual
> and quad IO page cache ops with 2-byte address. Additionally, the
> page cache ops can be performed with ECC and auto data formatting
> using the ECC engine of the controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/5] spi: add driver for MTK SPI NAND Flash Interface
      commit: 764f1b7481645b2b4488eda26c4da7f331697e6b
[4/5] spi: dt-bindings: add binding doc for spi-mtk-snfi
      commit: 69bb9b29bf67e850beece45e9c99ca707eac7e41

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
