Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F44C7C93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiB1WA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiB1WA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:00:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15444419B8;
        Mon, 28 Feb 2022 14:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B336126A;
        Mon, 28 Feb 2022 22:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE2C340EE;
        Mon, 28 Feb 2022 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646085616;
        bh=V10F6G+Ou93QZQhjU3zUSK5DVxdlopzoLXcCA9mIEro=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=peXbZxUHSdQtM3E93xRmmd9CMefeNsZlYPzW7CpKbdirkPw64OzQroQu9aiBRLdu2
         CIxyD+6o378o9ZHJwKf4lu+ex2Y5I99AuIHnRlVhkts47H/SxrUu7Oz0FnT9oO9Sg/
         jMQijsk4TVkZ4nex1Nk2zifYmg25ybuu1rnChebHqWKhsS+VGmdikgd9jCWbQkkcVE
         Th4JV7g0mvWZTDJpo5xECFnLOK09RRvCpNFl6by+yEmYwNt49amHMIN1SMnk4FnMou
         3EBfXNsAsKfIlQc9mhm0wypETFZLqbSWCT5E9qm7gJPVblFoGBm9Z7R3K32WhI+Uyt
         a3xvCQI8jYvBw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 01/11] spi: pxa2xx-pci: Refactor CE4100 to use ->setup()
Message-Id: <164608561385.2299679.8193005267074778230.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 22:00:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 19:23:40 +0200, Andy Shevchenko wrote:
> Refactor CE4100 handling code to use ->setup() instead of spreading
> potentially confusing conditional.
> 
> Besides that, it will allow to refactor further to avoid intermediate
> storage for the used configuration parameters.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/11] spi: pxa2xx-pci: Refactor CE4100 to use ->setup()
        commit: 78e27f970f73a4ee57dc050a6233e09a56963391
[02/11] spi: pxa2xx-pci: Refactor Quark X1000 to use ->setup()
        commit: 71ea0e3ac70a50b0c56105e116ed903f8e504e8f
[03/11] spi: pxa2xx-pci: Drop redundant NULL check in ->probe()
        commit: 1d9d62959f1b52eb939df38b9fda8beea455c751
[04/11] spi: pxa2xx-pci: Move port_id assignment to ->setup()
        commit: 108607ce4e39a51caca51aa97c44c31041a597d1
[05/11] spi: pxa2xx-pci: Move dma_burst_size assignment to ->setup()
        commit: bd2e24de10da015147b02f8c2c4b8ebea8fa9574
[06/11] spi: pxa2xx-pci: Move max_clk_rate assignment to ->setup()
        commit: 03f8e04e9f9be8d28c52ae801f37d49988f02ce4
[07/11] spi: pxa2xx-pci: Replace enum with direct use of PCI IDs
        commit: 7e425c3c3d15241aa5b6c442a83f11b8bc4fee91
[08/11] spi: pxa2xx-pci: Drop unneeded checks in lpss_spi_setup()
        commit: cb50f3f32a044ea45192a43e756b26048d35ba95
[09/11] spi: pxa2xx-pci: Extract pxa2xx_spi_pci_clk_register()
        commit: c3f4fc096b37bc2e4535f16ac3d65d517bbc14eb
[10/11] spi: pxa2xx-pci: Drop temporary storage use for a handful of members
        commit: ba8d1353d9c2d9190a523860e37bd7cb7b9de31b
[11/11] spi: pxa2xx-pci: Constify struct pxa_spi_info variables
        commit: fcaaf76ed5f3bbf346db9e49d9d9c0978d8f8dce

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
