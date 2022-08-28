Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876825A3FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiH1VEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiH1VD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 17:03:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075431232
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 981F7B80B6E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577B6C433D7;
        Sun, 28 Aug 2022 21:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661720633;
        bh=dvr+0FsOsHb/g/YQGPJX8tDGZzGNU6WJ7c4FEWevhk4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UDXSH6F0xwcjYkF3/UgiFvOJ/gXimbJUsU2LpRndksy/Cht1hAolAVbiGVF+MCnWl
         VpoxRaG1IrAQHa59C2u2CoGecoinG7ud9FLHhatYQvnf4upIPijUlL6hAWTemPkeKd
         826bWsX1/ScEBHAd+XSYAaVT3umH+Q1gC2IVTUZpY+PrAiDuYMBClXZ9qsmD7AOCQB
         NapkFQGs+tax8oQZleKDTBy+hGALKYbf+H4B8qn8u82pcqY+u2OUzr+2vRE2s9jh2r
         WOUmvX4YYrIeMdbjYoTYpbYZmvJAo6BM4RtRs5mQRsIpfZ/DxuD+pILPk/MOCS2D8a
         Pab0O8wmxubLA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, lgirdwood@gmail.com, bgoswami@quicinc.com,
        tiwai@suse.com, aidanmacdonald.0x0@gmail.com,
        srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
References: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH -next 0/2] ASoC: Cleanup deprecated regmap-irq functionality
Message-Id: <166172063107.600125.6867338355172165841.b4-ty@kernel.org>
Date:   Sun, 28 Aug 2022 22:03:51 +0100
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

On Thu, 21 Jul 2022 11:25:56 +0100, Aidan MacDonald wrote:
> Update two ASoC codec drivers to remove uses of regmap-irq type
> registers, which have recently been deprecated by the "regmap-irq
> cleanups and refactoring" series in linux-next.
> 
> Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
> 
> Aidan MacDonald (2):
>   sound: soc: codecs: wcd9335: Convert irq chip to config regs
>   sound: soc: codecs: wcd938x: Remove spurious type_base from irq chip
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] sound: soc: codecs: wcd9335: Convert irq chip to config regs
      commit: 255a03bb1bb3b10d1c1ca785c596db84723f59d7
[2/2] sound: soc: codecs: wcd938x: Remove spurious type_base from irq chip
      commit: de3287f177a5666409978a1a0331a33e2842d43b

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
