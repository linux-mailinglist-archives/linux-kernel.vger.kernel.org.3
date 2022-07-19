Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81357A6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiGSSsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGSSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32061550E0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF7726178E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5448EC341C6;
        Tue, 19 Jul 2022 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658256511;
        bh=zbulZOF43Lo4y1LlDu/RufmuQSFJCxdW4Q4Up9s3Q3c=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=XvbCpr8ol9RaFxoDziToGIuuMd5W8I7QINOLcGaxCzoDFfGUozcBAfRiuxhTE+NiG
         gws/lBiqhdF0DVU6dB3oOpLELfE5xHwcu6NnXVq0WJMDSmZin34ELwDxmGqUONL0yL
         aur/51rLX/bU/dcsib0ecVPIRd1Y5/+M4pPhhgpPguI2KbR17q7E3/94s0+UN6Uilb
         EkhCcqRQGRAsVR5LxGYAR8mf1Td6d1+N60mRLwwH16AbUm4X/Nxyiqk4lGzej6Tb1q
         vUCBuLkIdjrSOFP+7MNz6OycBWVhc3PSTZDwkEL1i5OVGe3yOOdaB8XyUpZhjTnBqq
         FRADVLfJh3yng==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        christian@kohlschuetter.com
In-Reply-To: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
Subject: Re: [PATCH] regulator: core: Fix off-on-delay-us for always-on/boot-on regulators
Message-Id: <165825650907.448796.8615168597184870557.b4-ty@kernel.org>
Date:   Tue, 19 Jul 2022 19:48:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2022 13:30:36 +0200, Christian Kohlschuetter wrote:
> Regulators marked with "regulator-always-on" or "regulator-boot-on"
> as well as an "off-on-delay-us", may run into cycling issues that are
> hard to detect.
> 
> This is caused by the "last_off" state not being initialized in this
> case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix off-on-delay-us for always-on/boot-on regulators
      commit: 218320fec29430438016f88dd4fbebfa1b95ad8d

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
