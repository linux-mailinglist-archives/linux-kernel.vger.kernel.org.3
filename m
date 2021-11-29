Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DA46117C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhK2KAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:00:46 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:64178 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231590AbhK2J6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:58:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638179721; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rTfcGTR+3GLs3cW3kgd/lC6PwGh1if+M38DrtgJcOGQ=;
 b=GobgZgVGYADasssy6yD2p1R2D6UOgKzUZ17MzqvsuFdwQNj6SgbXg+YiN3orLLFoCa7ZctBn
 cxrckYhhL69vb0GYsMjBMo9mFCX18NYHX1Agbco6c2AAYGyhRTvRBiYTZtnnVrvOXrkd1RFD
 LV1y8DJnyNQXa/PJ7uiE4wagykM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61a4a389bebfa3d4d5084101 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 09:55:21
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 398FEC4360D; Mon, 29 Nov 2021 09:55:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A828C4360C;
        Mon, 29 Nov 2021 09:55:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Nov 2021 15:25:20 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpubbise@codeaurora.org, kuabhs@chromium.org,
        pillair=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v7] arm64: dts: qcom: sc7280: Add WPSS remoteproc node
In-Reply-To: <1637299488-22336-1-git-send-email-pillair@codeaurora.org>
References: <1637299488-22336-1-git-send-email-pillair@codeaurora.org>
Message-ID: <14d31c99d8fe258af3fc1f28c787c8cb@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rakesh,

On 2021-11-19 10:54, Rakesh Pillai wrote:
> Add the WPSS remoteproc node in dts for
> PIL loading.
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> Changes from v6:
> - Swap the oder of two properties in wpss_mem reserved memory
> 
> Changes from v5:
> - Update the clock names
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts |  4 +++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    | 56 
> +++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 9b991ba..ddab150 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -80,3 +80,7 @@
>  		qcom,pre-scaling = <1 1>;
>  	};
>  };
> +
> +&remoteproc_wpss {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 365a2e0..dd93f13 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -134,6 +134,11 @@
>  			no-map;
>  		};
> 
> +		wpss_mem: memory@9ae00000 {
> +			reg = <0x0 0x9ae00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +

wpss_mem is already part of idp
board dts. We no longer include
PIL reserved memory regions in
the base SoC dtsi since the size
varies across boards.

>  		rmtfs_mem: memory@9c900000 {
>  			compatible = "qcom,rmtfs-mem";
>  			reg = <0x0 0x9c900000 0x0 0x280000>;
> @@ -2598,6 +2603,57 @@
>  			status = "disabled";
>  		};
> 
> +		remoteproc_wpss: remoteproc@8a00000 {
> +			compatible = "qcom,sc7280-wpss-pil";
> +			reg = <0 0x08a00000 0 0x10000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
> +					      <&wpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&wpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&wpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&wpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +					      <&wpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover",
> +					  "stop-ack", "shutdown-ack";
> +
> +			clocks = <&gcc GCC_WPSS_AHB_BDG_MST_CLK>,
> +				 <&gcc GCC_WPSS_AHB_CLK>,
> +				 <&gcc GCC_WPSS_RSCP_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ahb_bdg", "ahb",
> +				      "rscp", "xo";
> +
> +			power-domains = <&rpmhpd SC7280_CX>,
> +					<&rpmhpd SC7280_MX>;
> +			power-domain-names = "cx", "mx";
> +
> +			memory-region = <&wpss_mem>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&wpss_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			resets = <&aoss_reset AOSS_CC_WCSS_RESTART>,
> +				 <&pdc_reset PDC_WPSS_SYNC_RESET>;
> +			reset-names = "restart", "pdc_sync";
> +
> +			qcom,halt-regs = <&tcsr_mutex 0x37000>;
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_WPSS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "wpss";
> +				qcom,remote-pid = <13>;
> +			};
> +		};
> +
>  		dc_noc: interconnect@90e0000 {
>  			reg = <0 0x090e0000 0 0x5080>;
>  			compatible = "qcom,sc7280-dc-noc";

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
