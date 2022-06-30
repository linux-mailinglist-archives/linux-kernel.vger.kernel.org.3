Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7429E56213B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiF3R13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiF3R1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:27:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276723E5FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C10FFB82CC8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 17:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30009C34115;
        Thu, 30 Jun 2022 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656610041;
        bh=DWocVQAQKTzcsE0GNMYLLy6zvr3QRXobX8pB3gDiOSk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W+keUrsDv2kRHnLd7KBxxZZTzKb3Hr7+CNn9uAAsdnIuNrIBumG1lmfZPdp4ozrfI
         kmxq5dNZIxZ7kb0T8gblDpT3CeqAxBLJy83vpkBoTDaR5q/WIOri3IFIOdvL57GRIR
         wU4d655+zozfwoPg7egjhgL+0bwQIpe/GLUSHegUo77nk9xUDYwP+TIBFIVy1DyAqY
         JhZnHh9K6LudBtJrQiH4hMAxOpc8VBP/SHJANO8VIxvGy6/Vg6ka+MfV2XufQeoOro
         6G2tVI3J9vcD2ilWPkiqnLJERqdGP+Ieta54tafHlEHNgu6U6H7++nMHUaM+HFmktK
         T7M5ciyoJQeaQ==
From:   Mark Brown <broonie@kernel.org>
To:     aidanmacdonald.0x0@gmail.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        mazziesaccount@gmail.com
In-Reply-To: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 00/12] regmap-irq cleanups and refactoring
Message-Id: <165661003990.804095.5523996755387042887.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 18:27:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 22:14:08 +0100, Aidan MacDonald wrote:
> This series is an attempt at cleaning up the regmap-irq API in order
> to simplify things and consolidate existing features, while at the
> same time generalizing it to support a wider range of hardware.
> 
> There is a new system for IRQ type configuration, some tweaks to
> unmask registers so they're more intuitive and useful, and a new
> callback for calculating register addresses. There's also a few
> minor code cleanups in here.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[01/12] regmap-irq: Convert bool bitfields to unsigned int
        commit: 445cbd219ac3b8f451153c210aaf97adcbf4bd02
[02/12] regmap-irq: Remove unused type_reg_stride field
        commit: 53a1a16dcc972163bd5816192d5d63ae433c9e56
[03/12] regmap-irq: Cleanup sizeof(...) use in memory allocation
        commit: cffc2be30288786e242bceb9fedde4dfe6ce442d
[04/12] regmap-irq: Remove an unnecessary restriction on type_in_mask
        commit: 610fdd668e6af48fcae7908161d14eee3a95ec92
[05/12] regmap-irq: Remove inappropriate uses of regmap_irq_update_bits()
        commit: 6b0c31747722936101d56e71e809bfd7a6a440b7
[06/12] regmap-irq: Remove mask_writeonly and regmap_irq_update_bits()
        commit: ad22b3e98f9430896bd4bd8f4fbff4667f02a0c8
[07/12] regmap-irq: Refactor checks for status bulk read support
        commit: f7cc5062d6e5ca439708e8403b1a622cca75adf7
[08/12] regmap-irq: Introduce config registers for irq types
        commit: faa87ce9196dbb074d75bd4aecb8bacf18f19b4e
[09/12] regmap-irq: Deprecate type registers and virtual registers
        commit: 9edd4f5aee8470dcfd0db04005908f61fbfae8e0
[10/12] regmap-irq: Fix inverted handling of unmask registers
        commit: e8ffb12e7f065db616a3eba79ff138bececf0825
[11/12] regmap-irq: Add get_irq_reg() callback
        commit: bdf9b86cd3adbbcf590ab82b74ab8554534c9b6e
[12/12] regmap-irq: Deprecate the not_fixed_stride flag
        commit: 48e014ee9a61e8f4700987b82f7cb1dc3c89fa76

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
