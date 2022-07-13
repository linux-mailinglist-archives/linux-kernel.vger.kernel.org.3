Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A557389C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiGMOUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiGMOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:20:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8524B326FF;
        Wed, 13 Jul 2022 07:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EE1DB82011;
        Wed, 13 Jul 2022 14:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76FFC341C0;
        Wed, 13 Jul 2022 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657721997;
        bh=gZlZ9XEUO5Tr8VlBA2Fy3TMHOnEzakxg3l035XJS0ew=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sXmw8e0T8l3/UhBWRTNHdZt1I2FAsDabkybIwxE8ZSVsvo3XpM7EVxvoGFoCuFFby
         mrDnJv2plFpgTEqQUdMBC/GJad8zgFGmWr53rhHX/OhYSp8T8Z/KVSYBqRbyXlltvv
         eMoB+bHhBaCksiIngXRQRhMY5UhMN7fTYIcuAe0vHexHuw5cURbWveLEJPqDQMvURH
         TYBbaYkJTR10pWjb8KIuTqdaxuaoKSZ3yJICfmiN+h5C97EL3MR1vNrjhA077Ma8yo
         FwRhDK5fBz4zyJJ4wtQx+wQ1a/DnFeUxmN7jiMgm1xLi01Hpffxeu8nc1GpI4sGCXX
         SNwLEpeC8AOoQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com
Cc:     daire.mcnamara@microchip.com, conor.dooley@microchip.com
In-Reply-To: <20220713025657.3524506-1-yangyingliang@huawei.com>
References: <20220713025657.3524506-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next v2 0/3] spi: microchip-core: fix and cleanups
Message-Id: <165772199640.105087.16657528468194823666.b4-ty@kernel.org>
Date:   Wed, 13 Jul 2022 15:19:56 +0100
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

On Wed, 13 Jul 2022 10:56:54 +0800, Yang Yingliang wrote:
> Patch #1 fix a UAF in mchp_corespi_remove().
> Patch #2 and #3 some cleanups to simpify code.
> 
> v1 -> v2:
>   add patch #3 to use dev_err_probe to simpify code.
> 
> Yang Yingliang (3):
>   spi: microchip-core: fix UAF in mchp_corespi_remove()
>   spi: microchip-core: switch to use devm_spi_alloc_master()
>   spi: microchip-core: switch to use dev_err_probe()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: microchip-core: fix UAF in mchp_corespi_remove()
      commit: e82c6d62a1f2347cde69c169fcf37e4d26f89b98
[2/3] spi: microchip-core: switch to use devm_spi_alloc_master()
      commit: 5d56d8974d1e5fa5d7d0761037377e03f6edcc66
[3/3] spi: microchip-core: switch to use dev_err_probe()
      commit: cdeaf3a99a02b6f8566bcaacc9c3501c6cceda74

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
