Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04253FBC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbiFGKpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241496AbiFGKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED5ED727
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C055B81F06
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6013C385A5;
        Tue,  7 Jun 2022 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598729;
        bh=R+CU8uOFsboE67tcWswALzxrVxNJ9/fwY9T7Z6JoQQE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rUsdBeGHRSqPeYVORNrw4+DZQJhvpktD8/FMpQPXWUdW1GHK3ThE6OvHGqjGRwEPa
         w/1RwMkLUUkuiLJEo8q5bMIf7VxGC916INr9ZaGnV8to+xQMWXUSMwYo8QYi1RmyvO
         bnEvSqpbIEEdnjzHOWaXB/TyE5Nl5eOJG2s0ahFBZew0rCQBZLwrnikPHwoSPaBCvz
         Ol+2/rfIm0lQfpVrlfRZ9oFtr/m3bE7vLNTrCKEwWuysevAXy/MvMTCFRrTqbfCu3a
         TX3bpcHZJhnNrsqPhQwKTfrA0WG1uGIP2DZeQVTItULpdBY+fA1nmm1r6vfDeJjePg
         li9XmSsSkZ+Rw==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com, lgirdwood@gmail.com,
        shengjiu.wang@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1653456221-21613-1-git-send-email-shengjiu.wang@nxp.com>
References: <1653456221-21613-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: simplify the code with adding fsl_mqs_soc_data
Message-Id: <165459872746.301808.3491254402471419212.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 13:23:41 +0800, Shengjiu Wang wrote:
> Add soc specific data struct fsl_mqs_soc_data, move the
> definition of control register, each function bits to it,
> then the code can be simplified.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_mqs: simplify the code with adding fsl_mqs_soc_data
      commit: 063c915502b914a5a621458c763dfc28286f7606

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
