Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C659324B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiHOPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiHOPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:45:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245F17075;
        Mon, 15 Aug 2022 08:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4F50B80F2B;
        Mon, 15 Aug 2022 15:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF706C433D7;
        Mon, 15 Aug 2022 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578299;
        bh=k0MrKa0Q1r65Wdc+CzzRsBanpCr4K/PXB+Iu80gw5uk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DpNu4s0L/R4xpsXDP2lXtiZLEtl/wle9s9gjLreo8OR9Uaz2x+KtmwR8N6fgkixEo
         cIaU9CkXllBFBbMO2fJKS5H3hA3c9ec02ojHg9FKNpx1xJzNlHjl3woWDWi08FphGQ
         Lvh9NG33Qjah9Oq5wu/YaeAlAyjG63xdoxLe7Dgau0RF+tPvtRQuRj92cvXWjCnxw1
         1soDmpUPTqOH3XOcWBeOJ9+ee0Eo0IzWzVvbO2dgJ8JK4LWzkTFEkffKE+UnKjBOK5
         D7nFz2hLEjM+0oCezxiblgvxumbBr+Ac8M5mC11e3AKKl9GjIZkuuP8no61s1t/acG
         pLGOUe7BieMWA==
From:   Mark Brown <broonie@kernel.org>
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        kernel test robot <lkp@intel.com>,
        Adithya K V <adithya.kv@samsung.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220808004851.25122-1-chanho61.park@samsung.com>
References: <CGME20220808004253epcas2p3937171a6f89a765d67d5cc7b55afb89a@epcas2p3.samsung.com>
 <20220808004851.25122-1-chanho61.park@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: correct dma_chan pointer initialization
Message-Id: <166057829744.697678.17489335737107175059.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:44:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2022 09:48:51 +0900, Chanho Park wrote:
> Use NULL for dma channel pointer initialization instead of plain integer.
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/spi/spi-s3c64xx.c:387:34: sparse: sparse: Using plain integer as NULL pointer
>    drivers/spi/spi-s3c64xx.c:388:34: sparse: sparse: Using plain integer as NULL pointer
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: correct dma_chan pointer initialization
      commit: dad57a510db9423a4128ae6565854e999cebac51

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
