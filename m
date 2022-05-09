Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3E52016C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiEIPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiEIPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:49:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAEF21
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25036CE19A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB82C385B2;
        Mon,  9 May 2022 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111141;
        bh=CrQ0/ckWEfkQpNpOlG4urFcVG9MU01f9luLgk3xayCw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IN9glv31dJR7fqENxy/LCDLC2pYcHK+AF0DM3+q+KDWhAym3fbo0tp048BRPR/IHt
         1TMwlaey9GDbWC+x7VVcNY99YleePiKoD8PkeGX1VzKCGKh1ArehVAbgobMumRROQC
         eozZYfroUnnA4I21SZKXRcbAURT+cUGD3Na3rJW8UjnN+7HnTdbGAHUh6uSA+r4NFj
         5L5nTQt+LPFkjOSNmeREoFMhUUFXh1z3IC+yKdItaKvZKj2gR7P66FaePUZz6crOtC
         7PMKpPN/VjoqI0qxGAMWpUkKFQ8V/NQXiHhj2hnKONLzo5D7kp3rWmH11ZUCvh/Ju0
         dFR0iJvOhATdQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, zealci@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220505021808.54337-1-chi.minghao@zte.com.cn>
References: <20220505021808.54337-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: mediatek: simplify the return expression of mtk_dai_pcm_prepare()
Message-Id: <165211113943.774487.12508036435286420554.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 16:45:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 02:18:08 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: simplify the return expression of mtk_dai_pcm_prepare()
      commit: 74eaa8126f50e52a19f055eed002cc76cf3122dc

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
