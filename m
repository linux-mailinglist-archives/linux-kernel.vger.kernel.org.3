Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5679451AFD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378406AbiEDU6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378384AbiEDU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:58:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D92C515AD;
        Wed,  4 May 2022 13:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 536BA618BC;
        Wed,  4 May 2022 20:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D266C385A4;
        Wed,  4 May 2022 20:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651697697;
        bh=5SzYt/sdxGyX0aFu3eWeIhd+krhgteWDOIQ/tDpca38=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=VaHXLHTDEvly3pOdOXT1eGVx6pr1XRcWjbzxrN6lgW8HRvQqUrt0eT7Pn5GfYTGxM
         fHySfJ+iYz9KPkUi8n20pr+CWSY77t+TnkACcqS93b8Dan/ya/+rFVcmq4mcZqpebZ
         TqkAXOl9mSZUqXw4wN7tGXXJzDAm3ZRmbRo2CnEgBD5JaQoloBwt4t6QP0c980ke7Y
         valwEjh7Awtbx+l5FliNbfi1mqUZG3030Qr3isS01311g2fNbTYg0g4Ph5ua4GID7s
         aqpXjlUWmV2iFXYmQCwTlf3CLbZyeByTf5361r/1DbHzuFpsWh8dG6FL96n038dS9h
         r0qgWcwx920RA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, andreazanottifo@gmail.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20220502111300.24754-1-andreazanottifo@gmail.com>
References: <20220502111300.24754-1-andreazanottifo@gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: add support for interword delay
Message-Id: <165169769677.1749597.11425165483130918572.b4-ty@kernel.org>
Date:   Wed, 04 May 2022 21:54:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 13:13:00 +0200, Andrea Zanotti wrote:
> The module omap2-mcspi does not support the interword delay
> parameter present in the spi transfer. On one side, if the module
> is instructed to use the dma, this parameter is correctly ignored.
> However, without the usage of the dma, that parameter should be
> used.
> 
> The patch introduce the handling of such delay in the omap2-mcspi
> module, using standard spi_delay struct. The patch has been tested
> using as benchmark a DM3730.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: add support for interword delay
      commit: 2cd757e6292e23b898791d71978c6edf60a251ad

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
