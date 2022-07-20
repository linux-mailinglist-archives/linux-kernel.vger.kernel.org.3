Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096AB57BD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiGTSHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiGTSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75813B945;
        Wed, 20 Jul 2022 11:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DCCE61852;
        Wed, 20 Jul 2022 18:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B70C341CA;
        Wed, 20 Jul 2022 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658340432;
        bh=lR63gUICg78m8izbFY3IUAj1OcVt2AkKud5NbNu3U28=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q9xkrKl0ptjQ9oCoAnwoTYVaTrgu2JcmTT7ijdQHsT9ZyltCCmqQIwNjuS8BH7uhv
         AsDiqQFJcZw7+3+i7NsIBw5x2qjbVrhKTLeMyZQf/L3Zbyt2fKJn9xtFN6VhQQMFTJ
         4jrsud8qgBMYFPQYqGEG9P/01eWNzkk2gNksW8JvpBGe1a6n/gwoKGfTb9qbx1KypQ
         XG7evpLOH/Cox7UZW753E7Z3NyDYLiEQIS2FedX+K6/PeJVlwO2us/2jxXj+Pafm6z
         /rA5xXJVwCMHRkIcrXMp2O1ikoml1xwil956XgIBYtrdlZIRudKpaLDhYoXyRr6hn1
         ttXgI/Gp7QZgw==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     robh@kernel.org
In-Reply-To: <20220720163841.7283-1-krzysztof.kozlowski@linaro.org>
References: <20220720163841.7283-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
Message-Id: <165834043032.589042.9308857385820017803.b4-ty@kernel.org>
Date:   Wed, 20 Jul 2022 19:07:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 18:38:41 +0200, Krzysztof Kozlowski wrote:
> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come also with three
> interconnects.  This fixes dtbs_check warnings like:
> 
>   sm8450-qrd.dtb: spi@a98000: interconnects: [[46, 1, 0, 46, 4, 0], [47, 2, 0, 48, 12, 0], [49, 1, 0, 50, 1, 0]] is too long
>   sm8450-qrd.dtb: spi@a98000: interconnect-names: ['qup-core', 'qup-config', 'qup-memory'] is too long
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
      commit: ee912312db5a5e877120b9f519a034fc34315c9b

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
