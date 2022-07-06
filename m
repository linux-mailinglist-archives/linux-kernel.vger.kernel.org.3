Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43775692B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiGFTjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiGFTjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A66BE9A;
        Wed,  6 Jul 2022 12:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 365B4620A3;
        Wed,  6 Jul 2022 19:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F88C341CA;
        Wed,  6 Jul 2022 19:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657136354;
        bh=E3mfOerdYVWrCZ85sBYMTVxIttCanPdxxYhCAoaTxh0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=siU6TN1IeX526SjcOgSuPyzEj/JgCuq+FuMuZNxyKU0OLqM6MpzgBtG8m9MsdHHlt
         nX2FJF+Yhl0ILejyjZfTuLjOC3AuKgDWk1gv+pWvun1rqcwIwzQP+IqTlnUgAnfpCV
         xbjBso9+oXiNgDtYyTxM6EuCqpZVKe7zM4d1Wi9ExnNbCy997XFXS/VvFkRuBb5PBL
         T1DL0MdNwc5dCOUFZWLC0lGZCDd+37DlnuAZFzdWDfcFhcwoVN9P/BO/WEyePbdKrn
         g6xeb/6wLbpgdO5+Iiw2gerULqS7TDVwmCbQTURnZ4UXjY98kzC8TcRoJ+sJDcZrJX
         UWJcRNyyviwrg==
From:   Mark Brown <broonie@kernel.org>
To:     cristian.ciocaltea@collabora.com, sanju.mehta@amd.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vacharakis@o2mail.de, kernel@collabora.com
In-Reply-To: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
References: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 0/5] AMD SPI controller driver bug fix and cleanups
Message-Id: <165713635311.1162444.8799219504785646991.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 20:39:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 13:06:21 +0300, Cristian Ciocaltea wrote:
> This patch series addresses an issue in the spi-amd driver and, while
> there, performs some additional cleanups, like simplifying the error
> handling in the probe function and removing an unused struct member.
> 
> For improving code readability, it also adds some kernel-doc comments.
> 
> Cristian Ciocaltea (5):
>   spi: amd: Limit max transfer and message size
>   spi: amd: Make use of devm_spi_alloc_master()
>   spi: amd: Make use of dev_err_probe()
>   spi: amd: Drop io_base_addr member from struct amd_spi
>   spi: amd: Add struct and enum kernel-doc comments
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: amd: Limit max transfer and message size
      commit: 6ece49c56965544262523dae4a071ace3db63507
[2/5] spi: amd: Make use of devm_spi_alloc_master()
      commit: 2e063bb1d4272e7b64ef813566691ea8ea192f9c
[3/5] spi: amd: Make use of dev_err_probe()
      commit: deef4da8be2f7e94a0807e56f856d3e20addce4d
[4/5] spi: amd: Drop io_base_addr member from struct amd_spi
      commit: 1e71ffee97ac02b83b6ff75b52fa7b21b9149f7d
[5/5] spi: amd: Add struct and enum kernel-doc comments
      commit: 55861e36b663f6e584d1b0659c1c5cec0ce26a5d

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
