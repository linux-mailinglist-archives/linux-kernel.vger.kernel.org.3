Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA84651A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350966AbhLAPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350940AbhLAPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:31:10 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875FAC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:27:49 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q25so49325671oiw.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l8xvI7A1E9TM1mnTTh/elERLIoIv5XuFcEsenm8X46c=;
        b=CJSNuzL5FZ4vD2YdNJaFkBHPsdq8Q75EJUibVdfMzsByDMjf4O2OPHoJZQb7AZUHKK
         G9cFhJhLp3WJpOO723anVekYeYP5heuYtdd1o5Mq0VuXBWGhKB7D6vX4+3ngB9ogULTX
         G+zHLqpbuGckZ+IJiwzS92N8DcCYbMN/zTeDsfsVz30OnlIZ9oljVTN6BvXSbLY+8OR/
         LnogDQdKcktXc7ZczHZiLDfSZtoVHqxquLt9KKpozlUskLlsz55f8/dXrawBkGESlBaE
         TB2vjVhtFONu6//r+iI7wFP7SCNoCh2nBB2Z+F0TYDWpPbdxxx0D32S/zz30btnPV3mJ
         I+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8xvI7A1E9TM1mnTTh/elERLIoIv5XuFcEsenm8X46c=;
        b=w5w4Z5NhFQh7ht2Z8Wfqd5nKcdTqZr0ljgv+bn+9/m+pb94KHQ64I4JtPfu2XWXIwK
         +YWRdssL/w/uBgN8/V8gWD+clLb/VVl4FWwY+CT4c6J/3KtLjDxLaLhPYLd4PxD2TeHu
         mRZ2PWK/ar1UeAMuDDFow8GWKrfwGqGNtBsRzLrf+PNlXTb71u2MZhNog5LFoz2xufrO
         vnXO5b/SpWvTesDuyJVdjgczGzKg4tRPLKdBFTF/w84PvQYj5w6D1rv96zXFTkD6M1K8
         0aX8/I9O/NoYHuKHGpJc2sw1vtkMTV78GKc+5LZtvyw9WBQQEVJ7w6mWwFVCYST3P7ir
         EG9Q==
X-Gm-Message-State: AOAM531TkeRDEig8V6fIduXycQEI5z6pixs78hPRhKfOT5fp3ozhNJ7X
        PK/TxszKal4xTDTpjFasLggkRA==
X-Google-Smtp-Source: ABdhPJy5IWSG0Z56Aao5MD9rx1W1Z4XlN7RCDNKzOtZifdcw5Ab9jHuNe8u+8GN33eec2iny0QlcgQ==
X-Received: by 2002:aca:d704:: with SMTP id o4mr6755870oig.99.1638372468903;
        Wed, 01 Dec 2021 07:27:48 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s13sm21532otv.34.2021.12.01.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:27:48 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:27:43 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org, robh+dt@kernel.org,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com
Subject: Re: [PATCH v4 1/4] arm64: dts: qcom: sc7280: add display dt nodes
Message-ID: <YaeUb7A1VpiJQxdk@builder.lan>
References: <1637580369-876-1-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637580369-876-1-git-send-email-quic_sbillaka@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Nov 05:26 CST 2021, Sankeerth Billakanti wrote:

> From: Krishna Manikandan <quic_mkrishn@quicinc.com>
> 
> Add mdss and mdp DT nodes for sc7280.
> 
> Signed-off-by: Krishna Manikandan <quic_mkrishn@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>

Sorry, missed this one before sending my reply.

"kernel test robot" did not report the lack of mdss nodes in your dts.
So please drop this as well.

> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reported-by: kernel test robot <lkp@intel.com>

And again.

Thanks,
Bjorn

> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> 
> Changes in v4:
>     None
> 
> Changes in v3:
>     None
> 
> Changes in v2:
>     - Rename display dt nodes (Stephen Boyd)
>     - Add clock names one per line for readability (Stephen Boyd)
> 
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 90 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 365a2e0..a4536b6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2704,6 +2704,96 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		mdss: display-subsystem@ae00000 {
> +			compatible = "qcom,sc7280-mdss";
> +			reg = <0 0x0ae00000 0 0x1000>;
> +			reg-names = "mdss";
> +
> +			power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
> +
> +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> +				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				<&dispcc DISP_CC_MDSS_MDP_CLK>;
> +			clock-names = "iface",
> +				      "ahb",
> +				      "core";
> +
> +			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +			assigned-clock-rates = <300000000>;
> +
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "mdp0-mem";
> +
> +			iommus = <&apps_smmu 0x900 0x402>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdp: display-controller@ae01000 {
> +				compatible = "qcom,sc7280-dpu";
> +				reg = <0 0x0ae01000 0 0x8f030>,
> +					<0 0x0aeb0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					<&gcc GCC_DISP_SF_AXI_CLK>,
> +					<&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					<&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +					<&dispcc DISP_CC_MDSS_MDP_CLK>,
> +					<&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +						<&dispcc DISP_CC_MDSS_VSYNC_CLK>,
> +						<&dispcc DISP_CC_MDSS_AHB_CLK>;
> +				assigned-clock-rates = <300000000>,
> +							<19200000>,
> +							<19200000>;
> +				operating-points-v2 = <&mdp_opp_table>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
> +
> +				status = "disabled";
> +
> +				mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-200000000 {
> +						opp-hz = /bits/ 64 <200000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-300000000 {
> +						opp-hz = /bits/ 64 <300000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-380000000 {
> +						opp-hz = /bits/ 64 <380000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-506666667 {
> +						opp-hz = /bits/ 64 <506666667>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sc7280-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>;
> -- 
> 2.7.4
> 
