Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E43B509239
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382611AbiDTVoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382624AbiDTVn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83721488A7;
        Wed, 20 Apr 2022 14:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B9D61952;
        Wed, 20 Apr 2022 21:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCC7C385A0;
        Wed, 20 Apr 2022 21:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650490869;
        bh=4o+rRgdBUkHNDZ6Md2nImSgDPD+EYrSKUa+rPtXadeI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ONozDncWv/9yq2y5PKHzUcm2FYVPLlZnFOsIeN0bbgcRTTSRX2WoBwy42E07hdiE6
         NlPH2ISCS3bnvFwDYqDGEXFkpgLr/mj78xJ7eJCbQLpaNCcJKoeF+G0mBegJNxuTBT
         fRdUokWLXUpIWbkoVRYuaWoy557fpTDM4yveQ/p51dleTWq5HjqOiCvCf6s0V0S/zq
         G4mcJhYw4g33cMfkO3pX3p3nvCeX9mqBB9V1yuKlQhpVArMRtzCB4VGNKo5NStiEax
         Ot4k1UyZ6tNtdOQn9ujbJrZI6C8bOWgx5NfpICM4NFaYrlwqErYF2iLO6jatceYW7f
         dM3UXWBDPSALw==
From:   Mark Brown <broonie@kernel.org>
To:     angelogioacchino.delregno@collabora.com
Cc:     linux-mediatek@lists.infradead.org, nfraprado@collabora.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
References: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 0/8] MediaTek SPI controller cleanups and documentation
Message-Id: <165049086768.143449.12761284074720810678.b4-ty@kernel.org>
Date:   Wed, 20 Apr 2022 22:41:07 +0100
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

On Thu, 7 Apr 2022 13:44:20 +0200, AngeloGioacchino Del Regno wrote:
> This series performs some cleanups to the spi-mt65xx driver, removing
> all gotos, simplifying the probe function and adding kerneldoc to the
> driver structures.
> 
> Changes in v2:
> - Rebased over next-20220407 for new spimem commits
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: mt65xx: Simplify probe function with devm_spi_alloc_master
      commit: ace145802350e0f8eec4a40522a1b1d5a4f90114
[2/8] spi: mt65xx: Switch to device_get_match_data()
      commit: 7f7cdef7288a7da117a54249b680b04f503f8a67
[3/8] spi: mt65xx: Add and use pointer to struct device in mtk_spi_probe()
      commit: 6b4440584b92851af44b235ad825c8554dd143c0
[4/8] spi: mt65xx: Move clock parent setting to remove clock disable gotos
      commit: 5dee8bb8d14dc7536cec58cc1d94148dce89dfc5
[5/8] spi: mt65xx: Move pm_runtime_enable() call to remove all gotos
      commit: 5088b3136439896c2858173402f32dada4db69f6
[6/8] spi: mt65xx: Simplify probe function with dev_err_probe()
      commit: 20cdbb80095711decef6401f839aca8476be1910
[7/8] spi: mt65xx: Add kerneldoc for driver structures
      commit: 3c5cd2e23fe4c840b437496e131e1f74afaebbbd
[8/8] spi: mt65xx: Fix definitions indentation
      commit: 8e8a9e364a3b3053f689a649df1107e61b9e3bed

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
