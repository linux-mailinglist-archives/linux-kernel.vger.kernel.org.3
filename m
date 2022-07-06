Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1767568AED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiGFOJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiGFOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD762186C5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46BA561E5F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DE0C3411C;
        Wed,  6 Jul 2022 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657116574;
        bh=ulTlpfjbk/4uoDVcSwnQVB7MKrB8P0kwZfVfx8hedBI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nNVyXRtRCGd4bW5DiB+WK22OcXr3lSBJ6ESdap38p60CBgbpvG3HH709pU7sPreow
         LIaRC1PdYQpLkjsLbui1lx8PQohdLDT6mfjeALZoaWeLNp04aLy8G2BK+wZUSDHCsZ
         87lJQiN7s5D4raN2X8spFcKMkkV1CYeBe3YNC0k0/Onw5uzjYBju8JfYPeYWfbP34F
         J7rHEU2BbsVQfn3rjokMbi32K4MHS+2R6I8Zu2Xf0wZjlB5fK+2TSTIr1pgsipQQO5
         4YS+eVGNWrjJ5Y++6sbFyiInsvnNCpmrexNacMi2wVQPN8vYspW2ZQKEHR8Xvg+WvE
         FlmYol7PBZTUw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        shengjiu.wang@nxp.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
        festevam@gmail.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1657100575-8261-1-git-send-email-shengjiu.wang@nxp.com>
References: <1657100575-8261-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-card: Fix DSD/PDM mclk frequency
Message-Id: <165711657225.3718491.10041938555621440041.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 15:09:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 17:42:55 +0800, Shengjiu Wang wrote:
> The DSD/PDM rate not only DSD64/128/256/512, which are the
> multiple rate of 44.1kHz,  but also support the multiple
> rate of 8kHz, so can't force all mclk frequency to be
> 22579200Hz, need to assign the frequency according to
> rate.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-card: Fix DSD/PDM mclk frequency
      commit: c0fabd12a8570cb932f13d9388f3d887ad44369b

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
