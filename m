Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3713259A8C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243016AbiHSWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiHSWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:47:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16A10DCED;
        Fri, 19 Aug 2022 15:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4E00B8297B;
        Fri, 19 Aug 2022 22:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DFAC433D6;
        Fri, 19 Aug 2022 22:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660949264;
        bh=dxI6vf/bStJmVt0I680tMgmCWDQv72BqvXZPaYcJOxQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aPfQwPWYqbO38H6kKJjbb/+kNhw2REJtzZW+Lpf2pz/6fuu+RwNQfkXpPgh9dHEcf
         CG8f3AhCaQHapS3WwYoITlWZI8cbx6jex0WLzBbpVCHuqjf1pW/LAgMXdpKaihu1wM
         /vcm9EcTXHlFcjv3QOzso2K8y1MVRuFN9BfIa61Iq1Rq1ZT7RfG7wQj/icRgXktwCc
         kr99zJbtz1B+mc4vzYLXqwgqVtZGSqUq4LfB2ZO+GpqW8ufV6bL6MLX4iRh0Azd1Fa
         pOGGdewbCQiL/y4OKjbU/dtDazqmnbmG3oORULrBQrIeT9k4/TGcBljxkVYvgO3DiX
         3OrhBH7pWa53Q==
From:   Mark Brown <broonie@kernel.org>
To:     kernel@pengutronix.de, perex@perex.cz,
        ranjani.sridharan@linux.intel.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, s.hauer@pengutronix.de,
        kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
        lgirdwood@gmail.com, shawnguo@kernel.org, daniel.baluta@nxp.com,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, festevam@gmail.com,
        linux-imx@nxp.com, tiwai@suse.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <1660787634-28550-1-git-send-email-shengjiu.wang@nxp.com>
References: <1660787634-28550-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATCH v2 1/2] dt-bindings: dsp: fsl: Add SOF compatile string for i.MX8ULP
Message-Id: <166094926008.19151.7343804058436995082.b4-ty@kernel.org>
Date:   Fri, 19 Aug 2022 23:47:40 +0100
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

On Thu, 18 Aug 2022 09:53:53 +0800, Shengjiu Wang wrote:
> Add SOF compatile string "fsl,imx8ulp-dsp" for supporting DSP
> device on i.MX8ULP platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: dsp: fsl: Add SOF compatile string for i.MX8ULP
      commit: ee6c42ba5c7670c6f8c17c7bcedbcdaf7b8eb72e
[2/2] ASoC: SOF: imx: Add i.MX8ULP HW support
      commit: fb5319af6ad8616b772761ed926ca57e10f30ea4

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
