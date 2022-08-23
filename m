Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA75F59ECD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHWTv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiHWTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC0546DA6;
        Tue, 23 Aug 2022 11:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A822D616F0;
        Tue, 23 Aug 2022 18:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3791EC433C1;
        Tue, 23 Aug 2022 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280892;
        bh=wqZqOz27RQR1a98XGt8nLx/18hL9UVEZJHjpEEk/opA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lDKG1TUllnD9sw5CLYVsYKXcPesJ4J/kyOogGFCe6/jfYRthdUbBNY80keja9esta
         CuL8YpYrpufQZVwhWb2Kv4zgXpu393EISPPcxV8lqI7xb6pNAzVdxPUL1KRNpuHe4n
         yhzLuUcWLSsuGxrWO37TM3LDbhX7nTWJ4+T11J+efmAz4l6TfZU8VSDzwuXMEFoZrD
         CRGPe7Fu3mjUZs0Z+OrqnWTilBYA2prkz4f8ltwU9MathNYAnoH3H15bLvYUjhFDXR
         oygz6S+VgxJoAXnTpGUTYhKUgZ5m5kKEHwOPBu0rvifOCSMjvx/eshQtlGP/p159Ol
         LT7PW7h+KnBkQ==
From:   Mark Brown <broonie@kernel.org>
To:     kristo@kernel.org, Jerome Neanne <jneanne@baylibre.com>,
        dmitry.torokhov@gmail.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        nm@ti.com
Cc:     narmstrong@baylibre.com, lee.jones@linaro.org, msp@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@baylibre.com, j-keerthy@ti.com, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
In-Reply-To: <20220805121852.21254-1-jneanne@baylibre.com>
References: <20220805121852.21254-1-jneanne@baylibre.com>
Subject: Re: (subset) [PATCH v3 00/10] Add support for TI TPS65219 PMIC.
Message-Id: <166128088890.1047495.17882167686293190279.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:54:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 14:18:42 +0200, Jerome Neanne wrote:
> This driver supports
> - 3 Buck regulators and 4 LDOs
> - low-power standby mode
> - warm/soft reset
> - basic fault handling (via interrupts).
> - power button
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[04/10] regulator: dt-bindings: Add TI TPS65219 PMIC bindings
        commit: 4d2aed6ee306ccdcae51f550309bfb82ebf31b01
[08/10] regulator: drivers: Add TI TPS65219 PMIC regulators support
        commit: c12ac5fc3e0af29851785e557e243663b4fc7f4b

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
