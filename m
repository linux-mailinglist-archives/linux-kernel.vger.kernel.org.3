Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E824D1EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbiCHRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349472AbiCHRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F855BFA;
        Tue,  8 Mar 2022 09:21:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D891E610A5;
        Tue,  8 Mar 2022 17:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BF7C36AE2;
        Tue,  8 Mar 2022 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760094;
        bh=KlRfzov3KRSL1cuBCuyq8zTY4jx270V+a07sLCTkRkM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZZHpB33iVP+vk43vDhAvl6lvBs1UVmfXfOsgzP8ejineh60wdgV3YHsvt2b6IRABA
         2pxTwdG9hCyrUKHG1JerAnQhgHJlvUnxJuUkIYhveHjlaMwhnhUu2+VBZgp8mqBKzF
         rVijxpy7/dzwpVtFDcI7mqRWi9BpA1aJeeTHG3cAQVXb7x9wNCvDTTink9umBWFxlf
         CYmIEeHxmXDJtblCveDZaYJd3a1j94+nm4u2Ma0d3N6WPndXNBOafyoRQk1qO3JnGh
         mnQaHzY+mO54CL6kGG9hzKWpgc/O+4JoWsgI58+3vXDs43SKOQI7ynPH88zIYfRymd
         4EEtwqWti4GZg==
From:   Mark Brown <broonie@kernel.org>
To:     thierry.reding@gmail.com,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
        ashishsingha@nvidia.com, jonathanh@nvidia.com
Cc:     ldewangan@nvidia.com, robh+dt@kernel.org, skomatineni@nvidia.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220307165519.38380-1-kyarlagadda@nvidia.com>
References: <20220307165519.38380-1-kyarlagadda@nvidia.com>
Subject: Re: (subset) [PATCH v3 0/3] Tegra QUAD SPI combined sequence mode
Message-Id: <164676009171.54618.4072327060855634430.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 22:25:16 +0530, Krishna Yarlagadda wrote:
> Add ACPI support for Tegra210 QUAD SPI driver
> Support new Tegra194 feature, combined sequence mode.
> Add Tegra234 bindings.
> 
> v3 changes:
> - document runtime pm disabled in ACPI
> - clear cmb register for non combined sequence
> - fixes for errors reported by kernel test robot
> - skip approved patches
> v2 changes:
> - use combined sequence mode as default
> - remove property to switch transfer modes
> - fix compilation warnings
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: tegra210-quad: add acpi support
      commit: 75a1b44a54bd97500e524cf42e8c81cc632672b3
[2/3] spi: tegra210-quad: combined sequence mode
      commit: 1b8342cc4a387933780c50f0cf51c94455be7d11

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
