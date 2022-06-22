Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5696D5553E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377482AbiFVS7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377559AbiFVS7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:59:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7031227
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1655924195;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0ka+e5CwrN5MVcA+6Ffzw9FiJob8j1H7d6oQqpb8Ud8=;
    b=K6FD2FMfI6s/FXqzJb63CuyoSdVGtQzHaJ8gt8fsPtIJdrWUKLbQ0+nams0qXRGQ1x
    JtSxMyYK0OwadcMjkZXhW5ur1O3uGey3rsc9Pw5XiAClzEPMxzjcrI823nac0G9zAeb2
    oYEdA4CA7g2JDuO504iEZnXlFNKR+E/mOc24AM0ZGoqPQ1LKpCp7adePvJ0VM7TFu4Zv
    tceP2buHrGkYGfpLmKn9YXdCPYqYHZusKnccn+Hdx4+VISLFK7OlogiqUH1M2Xu4AJ16
    oVKqSjL1TrLReYl/VLMfoTbwG/ggQ5nwMoVWuymAlXr2yw5aKnl59hmanYQXO883KuzU
    81vA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK88/6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.46.0 AUTH)
    with ESMTPSA id g32597y5MIuZOtr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 22 Jun 2022 20:56:35 +0200 (CEST)
Date:   Wed, 22 Jun 2022 20:56:26 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: add SC8280XP platform
Message-ID: <YrNl2jS3Stcl2DP8@gerhold.net>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622041224.627803-4-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:12:21PM -0700, Bjorn Andersson wrote:
> Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
> Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
> idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
> interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
> tsens.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2145 ++++++++++++++++++++++++
>  1 file changed, 2145 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> new file mode 100644
> index 000000000000..ac13965a181e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
[...]
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		memory@80000000 {
> +			reg = <0 0x80000000 0 0x860000>;
> +			no-map;
> +		};
> +
> +		cmd_db: memory@80860000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0 0x80860000 0 0x20000>;
> +			no-map;
> +		};
> +
> +		memory@80880000 {
> +			reg = <0 0x80880000 0 0x80000>;
> +			no-map;
> +		};
> +
> +		smem_mem: smem@80900000 {
> +			compatible = "qcom,smem";
> +			reg = <0 0x80900000 0 0x200000>;
> +			no-map;
> +			hwlocks = <&tcsr_mutex 3>;
> +		};
> +
> +		memory@80b00000 {
> +			reg = <0 0x80b00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		memory@83b00000 {
> +			reg = <0 0x83b00000 0 0x1700000>;
> +			no-map;
> +		};
> +
> +		memory@85b00000 {
> +			reg = <0 0x85b00000 0 0xc00000>;
> +			no-map;
> +		};
> +
> +		pil_adsp_mem: memory@86c00000 {
> +			reg = <0 0x86c00000 0 0x2000000>;
> +			no-map;
> +		};
> +
> +		pil_nsp0_mem: memory@8a100000 {
> +			reg = <0 0x8a100000 0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_nsp1_mem: memory@8c600000 {
> +			reg = <0 0x8c600000 0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		memory@aeb00000 {
> +			reg = <0 0xaeb00000 0 0x16600000>;
> +			no-map;
> +		};

Doesn't memory@ still cause the dtbs_check warnings? Similar to

> soc/qcom/qcom,smem.example.dt.yaml: memory@fa00000: 'device_type' is a required property
>         From schema: dtschema/schemas/memory.yaml

as in [1]. If I understood it correctly there Rob said that memory@
shouldn't be used for reserved-memory. Perhaps even reserved-memory@
might be better then.

The device tree specification on the other hand suggests using the
purpose of the reserved memory, like we did on older SoCs:

> 3.5.2 /reserved-memory/ child nodes
> Following the generic-names recommended practice, node names should
> reflect the purpose of the node (ie. “framebuffer” or “dma-pool”).

[1]: https://lore.kernel.org/linux-arm-msm/CAL_Jsq+66j8Y5y+PQ+mezkaxN1pfHFKz524YUF4Lz_OU5E-mZQ@mail.gmail.com/

> +		timer@17c20000 {
> +			compatible = "arm,armv7-timer-mem";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			reg = <0x0 0x17c20000 0x0 0x1000>;
> +			clock-frequency = <19200000>;
[...]
> +		};
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <19200000>;
> +	};

Is the "clock-frequency" really needed for these two?

The binding docs are pretty clear that this should be configured by the
firmware instead:

> Should be present only where necessary to work around broken firmware
> which does not configure CNTFRQ on all CPUs to a uniform correct
> value. Use of this property is strongly discouraged; fix your firmware
> unless absolutely impossible.

I hope Qualcomm's firmware is actually improving on newer platforms
and not making big steps backwards. :-)

Thanks,
Stephan
