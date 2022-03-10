Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B44D47D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbiCJNOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbiCJNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:14:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A1583B1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB01D61A2F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E865EC340F3;
        Thu, 10 Mar 2022 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646918031;
        bh=2Ijf7mnkC3H3KU2ylXeDHiFTv2e24/Uk6a1zlh5kRPY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W5a5GfAxUilpGsPS8yY+hkrYHKQPkjoxTrpfjxhl72kvueUSNMuQ0gaapHSZ4ghse
         j32wYoyeRhLegBnEmgZbLNNPOq733ITRasukMHDj/zvYwESBPbqlDgmcmPsiSTP+jy
         2k52aLnRCfRilPvB5XcRmdLaxT28w8eiz8jE6jvysJl8mWnBI0YSi+IAsbPdvSKyF8
         WHgbUbHvF2jlj2lVe2LQRcVNVB5dtgVkt3HL/JVrhG8CO0lESBYn0ncotAZHCRpk0J
         VuzBNMVjFQQUy7O0i7sJA7gFBBZISdtC+LTiidQyG+RywY0L0IoVdWl/3twXqFyanW
         hZMdByCv29iDA==
From:   Mark Brown <broonie@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        codrin.ciubotariu@microchip.com
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        lgirdwood@gmail.com, claudiu.beznea@microchip.com,
        alexandre.belloni@bootlin.com,
        Abaci Robot <abaci@linux.alibaba.com>, perex@perex.cz,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220310082756.1183-1-jiapeng.chong@linux.alibaba.com>
References: <20220310082756.1183-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH v2] ASoC: atmel: mchp-pdmc: Remove unnecessary print function dev_err()
Message-Id: <164691802867.2018412.8160055841689752479.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 13:13:48 +0000
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

On Thu, 10 Mar 2022 16:27:56 +0800, Jiapeng Chong wrote:
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
> 
> Eliminate the follow coccicheck warning:
> 
> ./sound/soc/atmel/mchp-pdmc.c:991:2-9: line 991 is redundant because
> platform_get_irq() already prints an error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: Remove unnecessary print function dev_err()
      commit: 2588a01431a85a9bb8b2eac9023181ddd714a695

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
