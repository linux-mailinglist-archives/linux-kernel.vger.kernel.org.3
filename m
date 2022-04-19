Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF75071D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353075AbiDSPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350872AbiDSPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EAD13F91;
        Tue, 19 Apr 2022 08:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C09616C2;
        Tue, 19 Apr 2022 15:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91631C385A5;
        Tue, 19 Apr 2022 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650382182;
        bh=ko3RAF/kN6O+ylXY84hZCl0PJ8FXOQQ2/ef3C7UkP24=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fIi23HToxUsC8+EqGrh1ntRjKbOsovdIeAVT320F/X8DbBivQExY7i5K/tQXsKRMG
         lNA4Up3CP4VwyfdKrm7zudTxiQrOdz+Wi5s78Nk9FTsgfMj+jVJnz3WpyJeETZzrqZ
         X8RklYMLoSxkWCw8/9j4SAVgVby/+hQOQmf+85KFeT3I64hSw8oysBhXYTdp5NosNA
         hoUZQyDfUVV0ZCtpI7B0vcchn00mus8ifQH5jI9xiSeH+pfmjnhX1svIx6IbQB1Tx3
         EBUzf9TglxFD+uNH5tGk+hXRt7eMi++LN1AFLyvrByRKNqHHPZd1HHbEP1qMYmg18l
         wNmfpIsr8Fz4w==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, swboyd@chromium.org, tiwai@suse.com,
        quic_srivasam@quicinc.com, agross@kernel.org,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, quic_rohkumar@quicinc.com,
        linux-kernel@vger.kernel.org, judyhsiao@chromium.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_plai@quicinc.com, devicetree@vger.kernel.org, perex@perex.cz
Cc:     quic_potturu@quicinc.com
In-Reply-To: <1649844596-5264-1-git-send-email-quic_srivasam@quicinc.com>
References: <1649844596-5264-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-platform: Update memremap flag to MEMREMAP_WC
Message-Id: <165038217929.995461.3857305274282871060.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 16:29:39 +0100
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

On Wed, 13 Apr 2022 15:39:56 +0530, Srinivasa Rao Mandadapu wrote:
> Update memremap flag from MEMREMAP_WT to MEMREMAP_WC for better
> performance.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-platform: Update memremap flag to MEMREMAP_WC
      commit: 0a8ff26dea6e9aeb11db3f1af9fc1848b7042661

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
