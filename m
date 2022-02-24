Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD134C3968
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiBXXAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiBXXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:00:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA02177FC;
        Thu, 24 Feb 2022 14:59:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4CCAB829EB;
        Thu, 24 Feb 2022 22:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E25C340EF;
        Thu, 24 Feb 2022 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743575;
        bh=qE4XyM/mZdO91/dwF8RysGfMurvwkXipPfmnP9dak8w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dR3hi76re7kAtMsa+aJ7Ekrp3v5K2UbVEcjxAdiN7XhYIzNYrXKO1m1NJm3nYAKIU
         AtHWIkO8jqFoyP/QgLY3aAntINce8+mf8mA3D6pDUpeodQug+3EgkduRkTz+5MIIAS
         e/raYQB2aNNXY1KjR23Ug/C7R42CdvlR8Twpb7Bv3phXikIleWLfDIrHpo++uU1Q+n
         N84RQqW6VM+nafp//BmyuJpadaCRKOX9/HZ1cAubSoyE5dcFH79iT7gBx3D15qxKMA
         0E1zQiXAv+hJCGgVDCwzaH2Uu/uqbdiI9MWxixr/v2K+2z7Tuhk5YT8G1Djt2oAgQj
         IdEyss2gmVj+A==
From:   Mark Brown <broonie@kernel.org>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-spi@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        skomatineni@nvidia.com, ldewangan@nvidia.com
In-Reply-To: <20220222175611.58051-1-kyarlagadda@nvidia.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
Subject: Re: (subset) [PATCH v2 0/5] Tegra QUAD SPI combined sequence mode
Message-Id: <164574357320.4024751.14439329373672289056.b4-ty@kernel.org>
Date:   Thu, 24 Feb 2022 22:59:33 +0000
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

On Tue, 22 Feb 2022 23:26:06 +0530, Krishna Yarlagadda wrote:
> Add ACPI support for Tegra210 QUAD SPI driver and support
> new Tegra194 feature, combined sequence mode.
> 
> v2 changes:
> - use combined sequence mode as default
> - remove property to switch transfer modes
> - fix compilation warnings
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: tegra210-quad: use device_reset method
      commit: ac982578e7d340dc4f4fd243f4a4b24787d28c3f
[2/5] dt-bindings: spi: Tegra234 QUAD SPI compatible
      commit: de2f678b11bdcbabb6d804c543f9a3325c0e83bf
[3/5] spi: tegra210-quad: add new chips to compatible
      commit: ea23f0e148b82e5bcbc6c814926f53133552f0f3

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
