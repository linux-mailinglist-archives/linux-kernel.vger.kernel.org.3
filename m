Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03014C3961
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiBXXAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiBXXAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:00:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756E1D1793;
        Thu, 24 Feb 2022 14:59:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7678617FB;
        Thu, 24 Feb 2022 22:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DD9C340F1;
        Thu, 24 Feb 2022 22:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743571;
        bh=5Lj6LMv7fKK2xpulDVH0f1NMaqxcLDTpqnyPjloUf3o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V37E3SHNRe1LtZJ2kxqJqurmDCXIDo1DXWSGCwvhsu5zdhrhqK5ZhXtMx7AWZqThK
         pXk/msjVKWmCEjzx1kOgCwmKTPjMXYHu27/L9li4vNd4qdpXcLzLNbrVaqFteEEMkH
         qoUf3ux8lRgQ+7NXIJELFI74e3v661MpWyaSsUoMGN37YQjsm1S1dQH3fjw9ohP7l+
         Srr0MX9EipWO4proabal1ER0Saeo8orG0aG9IujUMpaRq5Glp3HQHAHNOu9f7YP8D2
         LSMBJYTY1IyVIIMxI5ip8Xvm8GKTyyCL1mK+YVCRRnNBILMDYdXR86MdNZW3FsyX5L
         l5gqmrLc+VuqQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>, Wang Qing <wangqing@vivo.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20220223191637.31147-1-andriy.shevchenko@linux.intel.com>
References: <20220223191637.31147-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx-pci: Balance reference count for PCI DMA device
Message-Id: <164574356932.4024751.9943744576271174109.b4-ty@kernel.org>
Date:   Thu, 24 Feb 2022 22:59:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 21:16:37 +0200, Andy Shevchenko wrote:
> The pci_get_slot() increases its reference count, the caller
> must decrement the reference count by calling pci_dev_put().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx-pci: Balance reference count for PCI DMA device
      commit: 609d7ffdc42199a0ec949db057e3b4be6745d6c5

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
