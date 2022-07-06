Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5BB56866B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGFLIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiGFLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151126AE2;
        Wed,  6 Jul 2022 04:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98E061E80;
        Wed,  6 Jul 2022 11:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9469CC341CA;
        Wed,  6 Jul 2022 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657105687;
        bh=tJJ+5MPN/oG82eYpJBXpRDJ/8GpcbhDDoR+MV9YNgrs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=klhrRaPFnI9RN+S7/luot2a7VHGRsjzSF3kxGEdUWAFasuw50Ah2kERLVj+AW1XNj
         oh8RLLzGt2UDszMS9IAq0z97fI1bhswPaEGYw5VTgOwr/fzfGv4YIvgB90aQ3XJmTT
         vveMtPMvIuju9pE30CPq+xal8/WupA6ztfUfK7MASA+bHyYpzSxEpUfRqs8YhR1JG7
         tc6l6Eu0dARYWq+8uQw+TVUPhCoPN0ncMWoI7WifIPW5uH5urjzv++LEen5fuNcBo7
         wWMhMRVMiuLrxkeeAFQluKxkRssDC1aef8q+I1v6YReiU4MN5Y9N8TbtieTebHhdoI
         KZK6ZUs3MNx4Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        bjorn.andersson@linaro.org
Cc:     stephan@gerhold.net
In-Reply-To: <20220705182802.775803-1-krzysztof.kozlowski@linaro.org>
References: <20220705182802.775803-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] ASoC: dt-bindings: qcom,sm8250: add SDM845 sound
Message-Id: <165710568432.237380.17718065730024815126.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 12:08:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 20:28:02 +0200, Krzysztof Kozlowski wrote:
> The Qualcomm SDM845 sound card bindings are almost the same as SM8250,
> except "pin-switches" and "widgets" properties.  These were not
> documented in SDM845 text bindings but are actually valid for SDM845.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,sm8250: add SDM845 sound
      commit: 50791dcb7de32f9f78061f7f460966ac5616b38e

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
