Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916674C3965
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiBXXAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiBXXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:00:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270CE18BA70;
        Thu, 24 Feb 2022 14:59:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52AE61BE9;
        Thu, 24 Feb 2022 22:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01172C340E9;
        Thu, 24 Feb 2022 22:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743569;
        bh=mwMf2sXFT+R1GnLD1CG83eIfYZaiUYX3qLQFhuBiwI8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PUB5SVssO6+xc31SxlVYxCAaG2kOvlkuhNj+vxO8vdOkfUZ0JnH+xmhelaehmoeMD
         9GuakJvWc9MfSU2J6pGzUNMOR7yngxN9ufBKDihVuVTND4viomw/CWesm7E/K2r/vN
         sVMQf1EAI9FAWCszr4dOeHi0upiaXDQntz2Tu9aRY29Bd3apJ3Gx7J/qSdCcYim10I
         +4BhkGf5QxK2xrOpfs3EslIhyps7aQ9GUVDDF2B2ByMWMotJBlAfi3mCGPDGoIBK/J
         hoU59IlZL7cwE+K3BAky4CCtEeXY2RitMaP9GHr84gCkk53bL9OipScDeGwFlD/oUF
         RbUcEF6/qH/Eg==
From:   Mark Brown <broonie@kernel.org>
To:     jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-spi@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        skomatineni@nvidia.com, ldewangan@nvidia.com
In-Reply-To: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
Subject: Re: (subset) [PATCH 0/6] Tegra QUAD SPI combined sequence mode
Message-Id: <164574356672.4024751.8070854824917838488.b4-ty@kernel.org>
Date:   Thu, 24 Feb 2022 22:59:26 +0000
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

On Fri, 4 Feb 2022 15:59:30 +0530, Krishna Yarlagadda wrote:
> Add ACPI support for Tegra210 QUAD SPI driver and support
> new Tegra194 feature, combined sequence mode.
> 
> Krishna Yarlagadda (6):
>   spi: tegra210-quad: use device_reset method
>   dt-bindings: spi: Tegra234 QUAD SPI compatible
>   spi: tegra210-quad: add new chips to compatible
>   spi: tegra210-quad: add acpi support
>   dt-bindings: spi: Tegra QUAD SPI combined sequence
>   spi: tegra210-quad: combined sequence mode
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: tegra210-quad: use device_reset method
      commit: ac982578e7d340dc4f4fd243f4a4b24787d28c3f
[2/6] dt-bindings: spi: Tegra234 QUAD SPI compatible
      (no commit info)
[3/6] spi: tegra210-quad: add new chips to compatible
      commit: ea23f0e148b82e5bcbc6c814926f53133552f0f3
[4/6] spi: tegra210-quad: add acpi support
      (no commit info)

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
