Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E065B0557
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiIGNi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIGNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:38:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266D9C518;
        Wed,  7 Sep 2022 06:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A969B81CE0;
        Wed,  7 Sep 2022 13:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE208C433D6;
        Wed,  7 Sep 2022 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662557870;
        bh=JKL1A4uDw3eUkWb1gxMvwAzQoLvUzjVP5BQQd7t5e+A=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=HOzquzxAh7+m2PKERBU0uXXOm8FN9n98uxekjmgI7YoSKdeQSrmLU/em089H9QMfD
         VB6nZzWIrMRmpkdAcQXlr8gATjISg7fSPzl9ilRAMdtbrBc8pkouKwONq/eIplfNDw
         SoAM3jk9Pg4Hhu5qmvzoyCisIqN7mej0jMn81LD5U3TVTirHRg2AdbkywbQvkAgbiR
         /Vp9NT3ESVfUmmYocoEfmTR8AluwbnbJvIxA9+WKvjRCsCTz5rIp3abQG5OK63730j
         /fNC/fAy4QuOnYv8ktoapbDbmLbllzHU9FRfUAcpofoP4h3iT4/VXD5RRhmf1D6N/X
         sVRtGsbC0Ln0A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20220906121110.301900-1-krzysztof.kozlowski@linaro.org>
References: <20220906121110.301900-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,q6core: remove binding
Message-Id: <166255786763.130875.2656165891607180417.b4-ty@kernel.org>
Date:   Wed, 07 Sep 2022 14:37:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 14:11:10 +0200, Krzysztof Kozlowski wrote:
> qcom,q6core is already described in soc/qcom/qcom,apr.yaml.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,q6core: remove binding
      commit: e9d967679e803e7472f06642156f0bb029e26655

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
