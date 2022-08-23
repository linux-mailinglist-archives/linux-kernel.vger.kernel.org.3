Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9359ECB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiHWTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiHWTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7DD2770
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1077F61711
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA23C433D7;
        Tue, 23 Aug 2022 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280602;
        bh=fNT/ML6CsNqu6evXVhQ1GENE4bqQBehy5fIvG9sMLLI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vAcy88Zbsbm73QG9RIBN7kLheKv9zuhvbQlRaY7AIi5FEIXCshoGeECGld6vuQkAY
         JmT92EdCP5kYMFzPBE/2Bekz1REZJwBuLdTvusoJJv1wRln5cQkXR3wC2NgwKXBx1D
         pyFyPB8IDBVWU8XRQKXBcD+pbHW+As9qsWwsyQEEfpWW/LqfnbZQVCMaJ/DeU1c6Pt
         yfhCKb250jG3LHHYURi4HiQU+Wkg3CWVFs4mtAnPCgjD/TGnKpQJNtmtDEZuDv0Zzh
         ddKlSjcQV8wjpaWD/td+90Vxa3CZuJ9bdtvwrPl0II4b0CMojmeMfWPTvm5pM0RW+t
         TJnFTafdyU06w==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        Xiubo.Lee@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, nicoleotsuka@gmail.com,
        festevam@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1661218573-2154-1-git-send-email-shengjiu.wang@nxp.com>
References: <1661218573-2154-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATCH] ASoC: fsl_sai: Add support multi fifo sdma script
Message-Id: <166128060004.1031684.56373454264278530.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:50:00 +0100
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

On Tue, 23 Aug 2022 09:36:13 +0800, Shengjiu Wang wrote:
> With disabling combine mode, the multiple successive
> FIFO registers or non successive FIFO registers of SAI module
> can work with the sdma multi fifo script.
> 
> This patch is to configure the necessary information to
> the SDMA engine driver for support multi fifo script.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Add support multi fifo sdma script
      commit: 88630575406fdf2a7853545a884484bd55dab8a0

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
