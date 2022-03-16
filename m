Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC24DB97C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiCPUhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358051AbiCPUh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB3769CC8;
        Wed, 16 Mar 2022 13:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC440B81D42;
        Wed, 16 Mar 2022 20:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DC2C340E9;
        Wed, 16 Mar 2022 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462971;
        bh=hPywN4Hc+VWnx8HZ9pRvRyevbb+miQ7224hVJAhUwEY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q8KJtzSLaYTDnj4b6Z96x655UGVx8qCbRjp8AveB2+kJ3G++9OjVeMuJvYRWVLet2
         ve9k1OfO2ICO8m70pSilaF1yFsTBK0/Al7LC61drC1NgC4yxd9rhvWirl4pndSbRrZ
         y53pDJkz+qp7oLwxNtbrzk//sJ3rVdUWdr9/iVcoVwuHMu0W/Zb7q30dYfR9bAkchG
         AiM4Og29jwnUDsrVTxBMp5LcVdAYm/OGTnGcBvgNXKRxmq4zONkTG6NCK+dim5cDcZ
         pSZU0MyAWqAJxbEQRdRYYVKXH5GdIIoV7EWkiy/uzWamaa09QL5tMygwIk69mojpX/
         NwBGaCUHZBtUQ==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, tiwai@suse.com, judyhsiao@chromium.org,
        perex@perex.cz, alsa-devel@alsa-project.org, agross@kernel.org,
        swboyd@chromium.org, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, lgirdwood@gmail.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, quic_plai@quicinc.com,
        rohitkr@codeaurora.org, bjorn.andersson@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
In-Reply-To: <1647355531-4150-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647355531-4150-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH] ASoC: codecs: Fix misplaced lpass_macro_pds_exit call
Message-Id: <164746296665.1220201.1306280283439888806.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:36:06 +0000
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

On Tue, 15 Mar 2022 20:15:31 +0530, Srinivasa Rao Mandadapu wrote:
> Update power domains exit function calling from runtime resume
> to remove function which was wrongly placed and causing crash in
> device suspend and resume.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix misplaced lpass_macro_pds_exit call
      commit: 1c19601ddceda1517511e4bad3d24619e765c78c

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
