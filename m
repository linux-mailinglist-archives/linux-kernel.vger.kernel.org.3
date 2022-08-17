Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603B6596F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiHQNKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiHQNJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B59853D12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806756124F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4658C433C1;
        Wed, 17 Aug 2022 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741747;
        bh=1kDRuQaxZT7BKS6Qe8EMQuwWIj3108NrId+NWFrzBUA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uRD3ocUHnu4NrnoDsgslKAosvNWNfT8/Xuik1yfbOvBe1Irrkk3VYUB+xta2lc0dj
         OWVHywVvd9R19kzH/xsmb7H5yVr82PSPHI/x12q5ydDQA1OQd88sdHrKawMRWEEJzz
         jyJAWBc5C4CjNwNs7sVHd2pG2MPNxtCUA29Q8Epje1NNC4f4sqHt267ycOD2UcTRtJ
         UGL6+9XAunJna0E2KqzTmtBAyKDggnFDtWwylTDzKmvFEZn7pMBUMUE3CnWevKJf47
         nxYxDL1ICbI3sdcX4kx8OmL/R/v2x6PaAWZiXVMbybu/kEdFL3d/WO5bNNN7SgTiKc
         ppdvHYx1TIb1g==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
In-Reply-To: <20220816165229.7971-1-srinivas.kandagatla@linaro.org>
References: <20220816165229.7971-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: sm8250: add missing module owner
Message-Id: <166074174646.88107.2289850693615815412.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 14:09:06 +0100
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

On Tue, 16 Aug 2022 17:52:29 +0100, Srinivas Kandagatla wrote:
> Add missing module owner to able to build and load this driver as module.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: sm8250: add missing module owner
      commit: c6e14bb9f50df7126ca64405ae807d8bc7b39f9a

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
