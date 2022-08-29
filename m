Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD55A57FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiH2XrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiH2Xqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F8D9A6B0;
        Mon, 29 Aug 2022 16:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB74961388;
        Mon, 29 Aug 2022 23:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87465C43143;
        Mon, 29 Aug 2022 23:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816796;
        bh=Xe0AiPAXqd6d0HMSI6ha37E94CBe1MxRquAHj06900k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gve7eaLF88odRKHDOIBNx/aGLEJAD1hcuE0FJsZGp52P5ssX9XlS8lApXv1gNYwfU
         7vPAjksT/fLCLWthPti9r7ElV811eO/KhRKc4zNDF1igRrAHYZzY40m2jFuWr47iI2
         86taBBPOnGPc+vMpoeyCnRmE89Y7QT6eJJaqc9gZuxoPhFrQ7G81eLSx/ozLBGjCES
         RTZ4juJRqoadb4SDuyGTXlYl54YIolDAd272eZFmOodPpLCx9xno8OFocXzY/jJ7mV
         iqBqzieP1T4+tV3R3QsHbKNXjUZTg2vEp0fqCrMkrW5lN5aoQ71AyTNotpAz4ejHxJ
         0hW6MgjEaMCFQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org, lee@kernel.org
Subject: Re: [RFT PATCH v3 00/16] arm64: dts: qcom: improvements to TCSR mutex in DTS
Date:   Mon, 29 Aug 2022 18:45:58 -0500
Message-Id: <166181675969.322065.9380869593332139505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 19 Aug 2022 11:31:53 +0300, Krzysztof Kozlowski wrote:
> Changes since v2
> ================
> 1. Patch 1 (bindings): add more compatibles.
> 2. New patches:
>    arm64: dts: qcom: sdm630: split TCSR halt regs out of mutex
>    arm64: dts: qcom: sm8150: split TCSR halt regs out of mutex
> 3. Add Rb tags.
> 
> [...]

Applied, thanks!

[01/16] dt-bindings: mfd: qcom,tcsr: add several devices
        commit: 4f2e28b2cc2e07c61028d27d964ff79705b5eb8f
[02/16] arm64: dts: qcom: msm8996: split TCSR halt regs out of mutex
        commit: 100ce2205924a5253f73b598354d5dca97d37356
[03/16] arm64: dts: qcom: msm8996: switch TCSR mutex to MMIO
        commit: 31df41b59b0e97bab38644903ec9111cfa2a0e53
[04/16] arm64: dts: qcom: msm8998: split TCSR halt regs out of mutex
        commit: fc10cfa38580a09d150c14f71812f86f0babec7a
[05/16] arm64: dts: qcom: msm8998: switch TCSR mutex to MMIO
        commit: 408c4eadd5d641b899db5eeacc2221273118a287
[06/16] arm64: dts: qcom: sc7180: add missing TCSR syscon compatible
        commit: b5cc3e52d9932b382b5f72f108cd7da742b64450
[07/16] arm64: dts: qcom: sc7180: split TCSR halt regs out of mutex
        commit: ce1ac53c7faa5b7930c3a7e30b2fad547b1efe67
[08/16] arm64: dts: qcom: sc7180: switch TCSR mutex to MMIO
        commit: e66e548bab5e93dfe0b958187785215c3c5d05b5
[09/16] arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
        commit: d9a2214d6ba5b68ffbfc5798f23bd3e1720f7b3d
[10/16] arm64: dts: qcom: sdm845: split TCSR halt regs out of mutex
        commit: 8a8531e69b2db1df8bfcf66c990ba36919c48e21
[11/16] arm64: dts: qcom: sdm845: switch TCSR mutex to MMIO
        commit: 3ed99307ec842fdb63b1519a011cb74e66b8d9cd
[12/16] arm64: dts: qcom: qcs404: switch TCSR mutex to MMIO
        commit: a465a9877e3a898925c1af80cb1acd88ce7816e6
[13/16] arm64: dts: qcom: sdm630: split TCSR halt regs out of mutex
        commit: 0da6033872256e0f25f92a6b5cc311efee529966
[14/16] arm64: dts: qcom: sdm630: switch TCSR mutex to MMIO
        commit: a4c82270f0f441977d8d54505fb269c1ee762234
[15/16] arm64: dts: qcom: sm8150: split TCSR halt regs out of mutex
        commit: 86d7c9460e2c0095bec80892b247f8c9f77bec82
[16/16] arm64: dts: qcom: sm8150: switch TCSR mutex to MMIO
        commit: c752d491cd599b3205800678708e8b1f45844774

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
