Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A24DCE97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiCQTQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiCQTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:16:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38171E530A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47727CE2458
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689FCC340EC;
        Thu, 17 Mar 2022 19:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647544517;
        bh=Y+apd5wGVAcbGhJSYKEioR4SaIWjP+1tnLbv+JCtuTs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YyV2Y3NNRcDkNQ91mK4rRWosiPM6MGwZq9m1P8FwcGCGV1iQiSijyjAMR981+MIjF
         znFuwFdxgDM6391YZkQ4Ifm91A01c3yN77rkj0ag3e1rY2BFnh7VrTevnW7GYICvaG
         HeBRWJamGYKtyjiyw963tqomW9uZXWe/zllzz4mT1nv6RRCFWBXQaUtfeUKRNBbv5X
         fHirIWXXn/2rxHB/MW3ttc4gy21na47hxcx7XwrfUYjWyEOk4pybewsEI4Li55SWL7
         nRTVqvyJ/06aaLd1v+B8FN94HkSge75odjzuSx4IJkCo9/YskymnkRcX3Da06dGsmP
         Lgn3XryG/Ey5Q==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
        tiwai@suse.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1647408538-2982-1-git-send-email-shengjiu.wang@nxp.com>
References: <1647408538-2982-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add new registers included on i.MX8ULP
Message-Id: <164754451515.3036648.9457796820741527004.b4-ty@kernel.org>
Date:   Thu, 17 Mar 2022 19:15:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 13:28:58 +0800, Shengjiu Wang wrote:
> There are some new registers added on i.MX8ULP, they are
> the SPDIF transmit Professional C channel registers,
> 192bit SPDIF receive C channel registers, and 192bit SPDIF
> transmit C channel registers.
> 
> There are two output lines, SPDIF_OUT1 and SPDIF_OUT2, the
> original REG_SPDIF_STCSCH and REG_SPDIF_STCSCL are used for
> SPDIF_OUT1, the new REG_SPDIF_STCSPH and REG_SPDIF_STCSPL
> are used for SPDIF_OUT2, the 192bit SPDIF C channel registers
> are used for both.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Add new registers included on i.MX8ULP
      commit: 638cec39339db40df9fc2ece0411a64856669b93

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
