Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1F4B1393
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiBJQxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:53:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244896AbiBJQxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C1EE;
        Thu, 10 Feb 2022 08:53:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80AF61D98;
        Thu, 10 Feb 2022 16:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF44C004E1;
        Thu, 10 Feb 2022 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644511993;
        bh=HAU9jECp8vk3akhAHZrT9sbV+MlXVMIjLGnKhGgo6v8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=o7Nw65ZDQ0K80ka/Paeu31omt3SmW1dxm5+mHMvPCzvzT8ogIfUh35GZN+m7Eg/+r
         XfaDIwJIsoKicy+eicDxgiQ4oF+GZtqA+W1TqbLJA4PiIUhAXAScr4x9TUoR7N8NrN
         /oMsmG8XQSx9FeT7lXtrkow9T339kvIwcLnxnHucMfLk4HnTBDDHLbQjNHc/B4MMnw
         ZgY7i8cUbMJwIfid6XO0Wbr8gDqL2kec1T0zSSJbCzKqh/9pSVRbmCMWMsILc89MIb
         7B5LPhwNmT7xCEttNiFrzKo6UqlEYgoDw2D74IECu83ZEJcKt+2nMtQmP0JieZiDFa
         VkRj2hsuITVZQ==
From:   Mark Brown <broonie@kernel.org>
To:     bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        bjorn.andersson@linaro.org, judyhsiao@chromium.org,
        agross@kernel.org, swboyd@chromium.org,
        alsa-devel@alsa-project.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <1644413181-26358-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644413181-26358-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [RESEND v8 0/3] Machine driver to support LPASS SC7280 sound card registration
Message-Id: <164451198976.2625306.6596305549471507379.b4-ty@kernel.org>
Date:   Thu, 10 Feb 2022 16:53:09 +0000
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

On Wed, 9 Feb 2022 18:56:18 +0530, Srinivasa Rao Mandadapu wrote:
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
