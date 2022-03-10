Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3574D45C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiCJLg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiCJLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:36:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC65142361
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:35:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6122ACE2334
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED5C340E9;
        Thu, 10 Mar 2022 11:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646912122;
        bh=L1YRU57z+t1MV+KfRtHvqyjYc86lOQpafAuQ+QMnSkU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VJ8IdfaHULgmtZbnG12wBjgsKUabfVGLpNiMjU4HwmiBJPUB4G45haTmR7eJecfrE
         7/VEEts2D4wpUDV9H+16U+SxgXOFTqQinFlZrkiOHEIOK5g5bk3tcxUBDmaQdmVXXx
         Qk408BeOg5XDYK+cyUNZfBeUrfF2V6+WCRBRNAQ9INFHSMZmHb4aywv/VAniF/osPs
         MC8dMCIuBuyB8p2/mLZgDc7qaQWnfAh50GokZ9/VYNRmlVyYtIwQ7VcBT7hEk6BM2O
         6Fc28SkLDNNlaktdI9eyovVZ55ewbl31QgjpxIQ+gpx/YOAkXdzfr5Eovl4mO/ggcB
         kkvXes9LVW2+w==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, perex@perex.cz,
        tiwai@suse.com, nicoleotsuka@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, festevam@gmail.com,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1646817523-26800-1-git-send-email-shengjiu.wang@nxp.com>
References: <1646817523-26800-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: keep all TxClk sources by txclk array
Message-Id: <164691212026.13798.15345880576925268759.b4-ty@kernel.org>
Date:   Thu, 10 Mar 2022 11:35:20 +0000
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

On Wed, 9 Mar 2022 17:18:43 +0800, Shengjiu Wang wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Use txclk array to keep all TxClk sources instead of keeping
> clocks per rate - need to do this in order to avoid multiple
> prepare_enable/disable_unprepare of the same clock during
> suspend/resume.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: keep all TxClk sources by txclk array
      commit: 5bd998af5b69cf21fd4db5eaf7e9db85a4a35295

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
