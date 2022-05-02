Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA5516B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358346AbiEBHIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358215AbiEBHIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:08:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66B3FBC2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:05:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so11817656plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E7GM3tz8optTxbav5Ed4qJexrlVgb0LjVWwJUE4cUd0=;
        b=MpYIp08yi1H01TpL8Sh/HuyfuPVXlp+PjsszsvhpnNdXGqaBlO1hCuFwxMJlPa1Fma
         6dikW1vQwky1JPwcO1Z2xk/zdsLiBDIHDzE2/XVftDiuhiuEkByY0oQACDPr+ejWlIUd
         N3ZGiafZQab3sLffCOOglzBTriQMDg8+1FBob1A0YifCgeEn2G4U3ifm2ObBBvdZdydR
         qorJnFU9vzBbcg+dVMbQMPzYrtGDYppzC14fLo8kl/Jiii6ynURHzmEi7l4Ykc8v8A3s
         KC5utargwHCGqm0MpBDq5Fcwork3KmIflAU1jq7UjyNCiuuiSdHVIDUi2Xg0lby1Zx7a
         UM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7GM3tz8optTxbav5Ed4qJexrlVgb0LjVWwJUE4cUd0=;
        b=qqJ8h9XBu6e4IFs9xkHlC9EglTpaKrGr6ZEWcal6ekvbwn+2BCKrIsvJ6pXotQ/aqm
         u0+uKlg3znMr29Qw3G/UpV2NzOrpAs+/1AnOy8pCETkOknaw8gee6TV/w1YF67hnsEPB
         ufcNSWjytPiucK6zuaCgokrJz3jL9Nf8xXrRk243cNLZm6EqtN9ZDttrLfkqIiAvroJi
         0CMvKjijOH/MxWQ3tZ6uQrpw02ts/JQOBYhjZ4wWJQarigRp8sVR2JbPfnCvHT20VbG2
         ledztfpyEBgFE+YmFQeq3EUXNRE19bwfEJdhIlqFbpAJKJEWnKiUc+4DlWizsvqRBavr
         vUXQ==
X-Gm-Message-State: AOAM5334dYP27frVaMiCKrsCKsS07Lswtr61Mva6cajmg4nN+qRm5nQM
        20HGFDxgio3DYWcnRhMVFjGC
X-Google-Smtp-Source: ABdhPJzRJUicR64+Dut55H/RQG2Y33uYolxH/uFLiqbvoSaN8r8Gf74N0e5RESaWZ4Fd+EVJImxEQQ==
X-Received: by 2002:a17:903:14a:b0:15c:f657:62d0 with SMTP id r10-20020a170903014a00b0015cf65762d0mr10768786plc.81.1651475102865;
        Mon, 02 May 2022 00:05:02 -0700 (PDT)
Received: from thinkpad ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902b41000b0015e8d4eb253sm3887181plr.157.2022.05.02.00.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:05:02 -0700 (PDT)
Date:   Mon, 2 May 2022 12:34:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: qcom: sdx65: Add QPIC BAM support
Message-ID: <20220502070457.GB5053@thinkpad>
References: <1651332610-6334-1-git-send-email-quic_kaushalk@quicinc.com>
 <1651332610-6334-2-git-send-email-quic_kaushalk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651332610-6334-2-git-send-email-quic_kaushalk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 08:30:07AM -0700, Kaushal Kumar wrote:
> Add devicetree node to enable support for QPIC
> BAM DMA controller on Qualcomm SDX65 platform.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index a64be20..d6a6087 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -199,6 +199,18 @@
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		qpic_bam: dma-controller@1b04000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x01b04000 0x1c000>;
> +			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&rpmhcc RPMH_QPIC_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x01f40000 0x40000>;
> -- 
> 2.7.4
> 
