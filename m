Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4793A58558B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbiG2TXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2TXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658E5A2C4;
        Fri, 29 Jul 2022 12:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9ABF61FAD;
        Fri, 29 Jul 2022 19:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DDEC433D6;
        Fri, 29 Jul 2022 19:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659122588;
        bh=2zs4loLiG2NHp7f2Cx4otysQzAR7dF+KLdjZ4DQy/dg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GmE3xQtsjEETj+q11L55TRTQVQY36tlsTpzRMqvZVswR8sd2D9it4gSkzBVyJwxDC
         s9FYAsk+ZKh9nBE4AhAl3CwEHxWJ4DMjFqJh+ngIvvw/u31daeQKb8TORWuh79AE+t
         KtklZemfZfjFsnpogab6RtGKb8TozA+gD/iGGv1c6eUznGUwh4bOXw4s+ys6LADApj
         Tpi9/ped/PDNYXxA1L+97Djo5VEM+wkioMO9uO+mwOJZdcrDEu/xvYT+8O0LaXEe9U
         btnpov5uWvfsFw9O07QbWlvU0/GACpu4cW8mHiTegXOOcYAj9WliwT+YNN+FKdYLwN
         o6V4GzI114M6Q==
From:   Mark Brown <broonie@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, verdun@hpe.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk
In-Reply-To: <20220728161459.7738-1-nick.hawkins@hpe.com>
References: <20220728161459.7738-1-nick.hawkins@hpe.com>
Subject: Re: (subset) [PATCH v6 0/5] Add SPI Driver to HPE GXP Architecture
Message-Id: <165912258592.2735119.5654882155337365652.b4-ty@kernel.org>
Date:   Fri, 29 Jul 2022 20:23:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d1cc2
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 11:14:54 -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Changes since v6:
>  *Removed spaces between tags on commit descriptions
> 
> Changes since v5:
>  *Fixed indentation in Kconfig file
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: spi-gxp: Add support for HPE GXP SoCs
      commit: 730bc8ba5e9ec103065142975015a793558f09a0
[2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
      commit: 8cc35b86546dc35fb4f5ff7d1d163c5efc78bf0e
[5/5] MAINTAINERS: add spi support to GXP
      commit: a1848b0fa2517a8d0bbc2783c90aefd4b7e7567a

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
