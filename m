Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA66552C1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbiERSG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiERSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:06:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6732062;
        Wed, 18 May 2022 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652897168;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=WH4R/8z9rzWbXEm3FrtBFRwKnFDQg/1bSROECox2rfQ=;
    b=s24Qwh5nmFh8U/7/rX4qH9Qb9qR4ywbMnoyECyZhmGUVWm+g0lRAGhRCpOZPr8jncw
    dXsyLrb6cxzjeqTY8M4bzI0BwsD/uqoZbj+e/gMQmPyBz+9fE9vjr49CAc/sYnk2DxLw
    o31i5NQ7nBm0Cew0GsTGmC5YfEx4duWHZ/6Ia//FJCt3tHGQ08jO2O25DIJEZLcRSIsD
    Ar9k3UGG7HT2udsM8i4NixZzV2LFl2tzstX3WXb4FnAKs9rPVOcASIY+wLAy1NIr5FhM
    ByLrd5moV4plKr1E7KmTC0hFNfyeJ+PEhZJGbHhEIU12sBrPZU1A+hCovM8hI/+Xlr+I
    PfvA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy4II66AKl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 18 May 2022 20:06:06 +0200 (CEST)
Date:   Wed, 18 May 2022 20:05:59 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: Add BAM DMUX Ethernet/IP device
Message-ID: <YoU1h9uUo+0Q4Ecq@gerhold.net>
References: <20220517203450.1155696-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517203450.1155696-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:34:51PM +0200, Luca Weiss wrote:
> BAM DMUX is used as the network interface to the modem.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Thanks for sending this patch!

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 814ad0b46232..ffa6f874917a 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1146,6 +1146,18 @@ spmi_bus: spmi@fc4cf000 {
>  			#interrupt-cells = <4>;
>  		};
>  
> +		bam_dmux_dma: dma-controller@fc834000 {
> +			compatible = "qcom,bam-v1.4.0";
> +			reg = <0xfc834000 0x7000>;
> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +
> +			num-channels = <6>;
> +			qcom,num-ees = <1>;
> +			qcom,powered-remotely;
> +		};
> +
>  		remoteproc_mss: remoteproc@fc880000 {
>  			compatible = "qcom,msm8974-mss-pil";
>  			reg = <0xfc880000 0x100>, <0xfc820000 0x020>;
> @@ -1180,6 +1192,20 @@ mpss {
>  				memory-region = <&mpss_region>;
>  			};
>  
> +			bam_dmux: bam-dmux {
> +				compatible = "qcom,bam-dmux";
> +
> +				interrupt-parent = <&modem_smsm>;
> +				interrupts = <1 IRQ_TYPE_EDGE_BOTH>, <11 IRQ_TYPE_EDGE_BOTH>;
> +				interrupt-names = "pc", "pc-ack";
> +
> +				qcom,smem-states = <&apps_smsm 1>, <&apps_smsm 11>;
> +				qcom,smem-state-names = "pc", "pc-ack";
> +
> +				dmas = <&bam_dmux_dma 4>, <&bam_dmux_dma 5>;
> +				dma-names = "tx", "rx";
> +			};
> +
>  			smd-edge {
>  				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
>  
> -- 
> 2.36.0
> 
