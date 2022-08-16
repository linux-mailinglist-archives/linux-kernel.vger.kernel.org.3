Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF2595D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiHPN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiHPN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:26:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F988DFD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93524CE192B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A021DC43150;
        Tue, 16 Aug 2022 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656393;
        bh=JDyNLxdszbDFx0pcncicVcptLBlcDYeGRE01CIKegz8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pJZBp4LN1ZZ7CxpAD+cuw0otGky4k3qxoaYECLg8TO+b7Z/kopPUHJ0Mq/6a5rlZy
         xFKGED1YrZDGY6KwcrtGnfDLqHpjokiyDeBDMYV0wUD4YsZUoOvxSJaVipZTrw5lMV
         0EL5AqY0S779KBdn7hCkNt1Qf2lBPlQaqOt8gdGbsBC/BuqEG94ZJDmHDIofght8he
         CtFHdNYYLpvfgfYR0C/iyrhfY0fcxryVuZKu8YuM4tzRbDpP/B0careeK04LzeYLY3
         +Tn/1iI+fuXcxIJLzqFv25yxpX1mUY8SCTFn7afHIeUAf8BK8SPmqvJkFatOdFe4VN
         DtFoIzHXX+vtA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220813083353.8959-1-pieterjan.camerlynck@gmail.com>
References: <20220813083353.8959-1-pieterjan.camerlynck@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: fix incorrect mclk number in error message
Message-Id: <166065639137.1257437.16040745730898665354.b4-ty@kernel.org>
Date:   Tue, 16 Aug 2022 14:26:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2022 10:33:52 +0200, Pieterjan Camerlynck wrote:
> In commit c3ecef21c3f26 ("ASoC: fsl_sai: add sai master mode support")
> the loop was changed to start iterating from 1 instead of 0. The error
> message however was not updated, reporting the wrong clock to the user.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: fix incorrect mclk number in error message
      commit: dcdfa3471f9c28ee716c687d85701353e2e86fde

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
