Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4845A4FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiH2OzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiH2OzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:55:14 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A45618E32;
        Mon, 29 Aug 2022 07:55:09 -0700 (PDT)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 807EB2007F;
        Mon, 29 Aug 2022 16:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1661784906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcOyAdhL0e725PTjlCm05qqk/N8FhIWvp30pFdmFqnc=;
        b=sIevvRJarXsV56W6HXfjQiUGFgV+UK9OMBU3+LLCAunIqa0kN2WxdW1pOHkHyT0AkfMuKO
        eQUQdYfimU9L0FIGVciXny+1ITnMXgA5GPEgHfqXXt7TTIrqI3mSl7SPE/pY1NWJAsjS02
        t3fi+zkXTo0IxDz1VQxgHSHJqxrgScA=
Message-ID: <7d5ee68e-eaad-9269-e276-1844081a2a2e@ixit.cz>
Date:   Mon, 29 Aug 2022 16:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH 00/14] arm64/dt-bindings: mfd: qcom: SPMI PMIC fixes
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1 ‒ 3 and 7 ‒ 13

Reviewed-by: David Heidelberg <david@ixit.cz>

On 28/08/2022 10:43, Krzysztof Kozlowski wrote:
> Hi,
>
> The Qualcomm SPMI PMIC DT schema conversion was not really tested and several
> issues in the bindings and DTS should be corrected.
>
> 1. The DTS patches can go independently.
> 2. The binding change continuous work of PWM reg fix and depends on it in
>     context (diff hunk):
>     https://lore.kernel.org/all/20220827145640.3530878-1-bryan.odonoghue@linaro.org/
>     Binidings changes and above, can be taken via MFD tree (fixed commit was
>     merged in v6.0-rc1).
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (14):
>    ARM: dts: qcom: align SPMI PMIC ADC node name with dtschema
>    ARM: dts: qcom: pm8941: align SPMI PMIC LPG node name with dtschema
>    ARM: dts: qcom: pmx55: align SPMI PMIC Power-on node name with
>      dtschema
>    arm64: dts: qcom: pmk8350: drop incorrect io-channel-ranges
>    arm64: dts: qcom: pmk8350: drop interrupt-names from ADC
>    arm64: dts: qcom: align SPMI PMIC ADC node name with dtschema
>    arm64: dts: qcom: align SPMI PMIC regulators node name with dtschema
>    arm64: dts: qcom: align SPMI PMIC LPG node name with dtschema
>    arm64: dts: qcom: align SPMI PMIC Power-on node name with dtschema
>    arm64: dts: qcom: align PMIC GPIO pin configuration with DT schema
>    arm64: dts: qcom: sc7280-idp: correct ADC channel node name and unit
>      address
>    arm64: dts: qcom: sdm845-mtp: correct ADC settle time
>    dt-bindings: mfd: qcom,spmi-pmic: fix regulator node schema
>    dt-bindings: mfd: qcom,spmi-pmic: fix TM ADC node schema on PM8998
>
>   .../bindings/mfd/qcom,spmi-pmic.yaml          | 20 +++++++++++++++++--
>   arch/arm/boot/dts/qcom-pm8941.dtsi            |  4 ++--
>   arch/arm/boot/dts/qcom-pma8084.dtsi           |  2 +-
>   arch/arm/boot/dts/qcom-pmx55.dtsi             |  2 +-
>   arch/arm64/boot/dts/qcom/pm660.dtsi           |  2 +-
>   arch/arm64/boot/dts/qcom/pm660l.dtsi          |  4 ++--
>   arch/arm64/boot/dts/qcom/pm8150.dtsi          |  2 +-
>   arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  4 ++--
>   arch/arm64/boot/dts/qcom/pm8150l.dtsi         |  4 ++--
>   arch/arm64/boot/dts/qcom/pm8953.dtsi          |  2 +-
>   arch/arm64/boot/dts/qcom/pm8994.dtsi          |  2 +-
>   arch/arm64/boot/dts/qcom/pmi8994.dtsi         |  2 +-
>   arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  2 +-
>   arch/arm64/boot/dts/qcom/pmk8350.dtsi         |  3 ---
>   arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  2 +-
>   arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi     |  2 +-
>   .../boot/dts/qcom/sc7280-herobrine-crd.dts    |  2 +-
>   arch/arm64/boot/dts/qcom/sc7280-idp.dts       |  2 +-
>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 12 +++++------
>   .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  2 +-
>   21 files changed, 46 insertions(+), 33 deletions(-)
>
-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

