Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FF4B1390
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiBJQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:53:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244896AbiBJQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF12EE;
        Thu, 10 Feb 2022 08:53:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6092EB82663;
        Thu, 10 Feb 2022 16:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6A0C340EB;
        Thu, 10 Feb 2022 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644511999;
        bh=jU4woLASpR6Ex/J6X55lhs4XNVlGTKqO4+sal3OhZzg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=MtSnP5goZivyhhcyM1qavOq0s+jAuT2xOsOPztOxRfCVXqxOgtmL+EzpUdD9Ie9vd
         /CaIzzqw2YbXKjaqPVdI3x7xrep0rLJ6CIkSuMoPdN4SsWxGi/nTvSOj757LD/taku
         HqLDfWdBeO3X9hcDWADDFwCpzQAt1ZA5/IM39/JQCorHxM3kCLpyD4MLqPNl83lXXY
         L7xmwvYH5Lyo7SRGDOGn7IXMcwkfxDzp5iT5sL3PIoNO+bz9n3Xd3t2wcnqNN/RtvK
         MHoyLVYSdYuhw5dyN3rk3YxbnXMwIOtXTxSWHcsfE8iMvQIS9aj/137kyiFQPzoIUr
         xvXkJ5VSiCpVQ==
From:   Mark Brown <broonie@kernel.org>
To:     bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        robh+dt@kernel.org, judyhsiao@chromium.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com, agross@kernel.org,
        swboyd@chromium.org, alsa-devel@alsa-project.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1644497415-25291-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644497415-25291-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v9 0/3] Machine driver to support LPASS SC7280 sound card registration
Message-Id: <164451199562.2625306.8749637139176937235.b4-ty@kernel.org>
Date:   Thu, 10 Feb 2022 16:53:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 18:20:12 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add support for SC7280 sound card registration and
> to add dt-bindings documentation file.
> 
> Srinivasa Rao Mandadapu (3):
>   ASoC: google: dt-bindings: Add sc7280-herobrine machine bindings
>   ASoC: qcom: Add macro for lpass DAI id's max limit
>   ASoC: qcom: SC7280: Add machine driver
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: google: dt-bindings: Add sc7280-herobrine machine bindings
      commit: 7bd431486511482b6e789dd69d07654a1d8c5eba
[2/3] ASoC: qcom: Add macro for lpass DAI id's max limit
      commit: 77d0ffef793da818741127f4905a3e3d45d05ac7
[3/3] ASoC: qcom: SC7280: Add machine driver
      commit: 57350bd41c3ac01bcae1d94e2c85d47dd90b6a3f

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
