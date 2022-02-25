Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6024C5157
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiBYWPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiBYWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:15:39 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56518F21A;
        Fri, 25 Feb 2022 14:15:06 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id a6so8674192oid.9;
        Fri, 25 Feb 2022 14:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLzHVa6VblDIIv/2rtBDevcFlgWpZwRB8Jw2bt5GgeI=;
        b=u+xNMj7XDxVTQWt+aOfZypWpOlR/2kphe/0qFzydc2VI9p7ya7aiKJe8mcvVADGoBt
         mZtpTkInVhcUpMrve6KPZcOfDqakB/vxmUlmuRy7oxJWwn0mfvJ8ySwGr6MHej2mErf1
         Y3nPH1n2eO/iKHodbest9rQMyuhXE0D6/0+NYGMhq2zXXYKhYgb+oXCHgvIKwl5DcHnQ
         86uELcdCv3a2mOwMgsuBsqG/FY3quAzm0BC3/HTiGEpV1zLf83E1BDPBxoQP4tmoorHf
         PhIBDCnxfCq4GHih6/uo980S8N4ExAuCFThcc4i+a/mqOKj+975xPGu3Vsto1WMJT8rU
         JxfQ==
X-Gm-Message-State: AOAM531oEVxWZt6ZaGJQEj0nP9rXgxGMxPya027h8r0S/dWaMNhWm47l
        U/yvfEZpYar9FJpPsWkdOw==
X-Google-Smtp-Source: ABdhPJzLkmM0JHhGWE1gsCah32S48kzlwvkh005UXJL89YW+pSBySS86HeGpobyGp1mH9sDSegv2pw==
X-Received: by 2002:aca:ab8e:0:b0:2d4:fe46:d02e with SMTP id u136-20020acaab8e000000b002d4fe46d02emr1096692oie.60.1645827305632;
        Fri, 25 Feb 2022 14:15:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l20-20020a056820031400b0031cf5913126sm1621080ooe.36.2022.02.25.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 14:15:05 -0800 (PST)
Received: (nullmailer pid 66005 invoked by uid 1000);
        Fri, 25 Feb 2022 22:15:04 -0000
Date:   Fri, 25 Feb 2022 16:15:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom: Add sc8280xp binding
Message-ID: <YhlU6FnwRJ1zNK7o@robh.at.kernel.org>
References: <20220225042710.2317732-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225042710.2317732-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 08:27:09PM -0800, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has the usual set of busses, add a
> binding for these interconnect providers and port definitions to allow
> interconnect paths to be expressed in the sc8280xp DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  12 +
>  .../dt-bindings/interconnect/qcom,sc8280xp.h  | 232 ++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc8280xp.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 5a911be0c2ea..64f4925e298c 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -60,6 +60,18 @@ properties:
>        - qcom,sc8180x-mc-virt
>        - qcom,sc8180x-mmss-noc
>        - qcom,sc8180x-system-noc
> +      - qcom,sc8280xp-aggre1_noc
> +      - qcom,sc8280xp-aggre2_noc
> +      - qcom,sc8280xp-clk_virt
> +      - qcom,sc8280xp-config_noc
> +      - qcom,sc8280xp-dc_noc
> +      - qcom,sc8280xp-gem_noc
> +      - qcom,sc8280xp-lpass_ag_noc
> +      - qcom,sc8280xp-mc_virt
> +      - qcom,sc8280xp-mmss_noc
> +      - qcom,sc8280xp-nspa_noc
> +      - qcom,sc8280xp-nspb_noc
> +      - qcom,sc8280xp-system_noc_main
>        - qcom,sdm845-aggre1-noc
>        - qcom,sdm845-aggre2-noc
>        - qcom,sdm845-config-noc
> diff --git a/include/dt-bindings/interconnect/qcom,sc8280xp.h b/include/dt-bindings/interconnect/qcom,sc8280xp.h
> new file mode 100644
> index 000000000000..77d23b3da22f
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sc8280xp.h
> @@ -0,0 +1,232 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license please.

> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SC8280XP_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SC8280XP_H
> +
> +/* aggre1_noc */
> +#define MASTER_QSPI_0			0
> +#define MASTER_QUP_1			1
> +#define MASTER_QUP_2			2
> +#define MASTER_A1NOC_CFG		3
> +#define MASTER_IPA			4
> +#define MASTER_EMAC_1			5
> +#define MASTER_SDCC_4			6
> +#define MASTER_UFS_MEM			7
> +#define MASTER_USB3_0			8
> +#define MASTER_USB3_1			9
> +#define MASTER_USB3_MP			10
> +#define MASTER_USB4_0			11
> +#define MASTER_USB4_1			12
> +#define SLAVE_A1NOC_SNOC		13
> +#define SLAVE_USB_NOC_SNOC		14
> +#define SLAVE_SERVICE_A1NOC		15
> +
> +/* aggre2_noc */
> +#define MASTER_QDSS_BAM			0
> +#define MASTER_QUP_0			1
> +#define MASTER_A2NOC_CFG		2
> +#define MASTER_CRYPTO			3
> +#define MASTER_SENSORS_PROC		4
> +#define MASTER_SP			5
> +#define MASTER_EMAC			6
> +#define MASTER_PCIE_0			7
> +#define MASTER_PCIE_1			8
> +#define MASTER_PCIE_2A			9
> +#define MASTER_PCIE_2B			10
> +#define MASTER_PCIE_3A			11
> +#define MASTER_PCIE_3B			12
> +#define MASTER_PCIE_4			13
> +#define MASTER_QDSS_ETR			14
> +#define MASTER_SDCC_2			15
> +#define MASTER_UFS_CARD			16
> +#define SLAVE_A2NOC_SNOC		17
> +#define SLAVE_ANOC_PCIE_GEM_NOC		18
> +#define SLAVE_SERVICE_A2NOC		19
> +
> +/* clk_virt */
> +#define MASTER_IPA_CORE			0
> +#define MASTER_QUP_CORE_0		1
> +#define MASTER_QUP_CORE_1		2
> +#define MASTER_QUP_CORE_2		3
> +#define SLAVE_IPA_CORE			4
> +#define SLAVE_QUP_CORE_0		5
> +#define SLAVE_QUP_CORE_1		6
> +#define SLAVE_QUP_CORE_2		7
> +
> +/* config_noc */
> +#define MASTER_GEM_NOC_CNOC		0
> +#define MASTER_GEM_NOC_PCIE_SNOC	1
> +#define SLAVE_AHB2PHY_0			2
> +#define SLAVE_AHB2PHY_1			3
> +#define SLAVE_AHB2PHY_2			4
> +#define SLAVE_AOSS			5
> +#define SLAVE_APPSS			6
> +#define SLAVE_CAMERA_CFG		7
> +#define SLAVE_CLK_CTL			8
> +#define SLAVE_CDSP_CFG			9
> +#define SLAVE_CDSP1_CFG			10
> +#define SLAVE_RBCPR_CX_CFG		11
> +#define SLAVE_RBCPR_MMCX_CFG		12
> +#define SLAVE_RBCPR_MX_CFG		13
> +#define SLAVE_CPR_NSPCX			14
> +#define SLAVE_CRYPTO_0_CFG		15
> +#define SLAVE_CX_RDPM			16
> +#define SLAVE_DCC_CFG			17
> +#define SLAVE_DISPLAY_CFG		18
> +#define SLAVE_DISPLAY1_CFG		19
> +#define SLAVE_EMAC_CFG			20
> +#define SLAVE_EMAC1_CFG			21
> +#define SLAVE_GFX3D_CFG			22
> +#define SLAVE_HWKM			23
> +#define SLAVE_IMEM_CFG			24
> +#define SLAVE_IPA_CFG			25
> +#define SLAVE_IPC_ROUTER_CFG		26
> +#define SLAVE_LPASS			27
> +#define SLAVE_MX_RDPM			28
> +#define SLAVE_MXC_RDPM			29
> +#define SLAVE_PCIE_0_CFG		30
> +#define SLAVE_PCIE_1_CFG		31
> +#define SLAVE_PCIE_2A_CFG		32
> +#define SLAVE_PCIE_2B_CFG		33
> +#define SLAVE_PCIE_3A_CFG		34
> +#define SLAVE_PCIE_3B_CFG		35
> +#define SLAVE_PCIE_4_CFG		36
> +#define SLAVE_PCIE_RSC_CFG		37
> +#define SLAVE_PDM			38
> +#define SLAVE_PIMEM_CFG			39
> +#define SLAVE_PKA_WRAPPER_CFG		40
> +#define SLAVE_PMU_WRAPPER_CFG		41
> +#define SLAVE_QDSS_CFG			42
> +#define SLAVE_QSPI_0			43
> +#define SLAVE_QUP_0			44
> +#define SLAVE_QUP_1			45
> +#define SLAVE_QUP_2			46
> +#define SLAVE_SDCC_2			47
> +#define SLAVE_SDCC_4			48
> +#define SLAVE_SECURITY			49
> +#define SLAVE_SMMUV3_CFG		50
> +#define SLAVE_SMSS_CFG			51
> +#define SLAVE_SPSS_CFG			52
> +#define SLAVE_TCSR			53
> +#define SLAVE_TLMM			54
> +#define SLAVE_UFS_CARD_CFG		55
> +#define SLAVE_UFS_MEM_CFG		56
> +#define SLAVE_USB3_0			57
> +#define SLAVE_USB3_1			58
> +#define SLAVE_USB3_MP			59
> +#define SLAVE_USB4_0			60
> +#define SLAVE_USB4_1			61
> +#define SLAVE_VENUS_CFG			62
> +#define SLAVE_VSENSE_CTRL_CFG		63
> +#define SLAVE_VSENSE_CTRL_R_CFG		64
> +#define SLAVE_A1NOC_CFG			65
> +#define SLAVE_A2NOC_CFG			66
> +#define SLAVE_ANOC_PCIE_BRIDGE_CFG	67
> +#define SLAVE_DDRSS_CFG			68
> +#define SLAVE_CNOC_MNOC_CFG		69
> +#define SLAVE_SNOC_CFG			70
> +#define SLAVE_SNOC_SF_BRIDGE_CFG	71
> +#define SLAVE_IMEM			72
> +#define SLAVE_PIMEM			73
> +#define SLAVE_SERVICE_CNOC		74
> +#define SLAVE_PCIE_0			75
> +#define SLAVE_PCIE_1			76
> +#define SLAVE_PCIE_2A			77
> +#define SLAVE_PCIE_2B			78
> +#define SLAVE_PCIE_3A			79
> +#define SLAVE_PCIE_3B			80
> +#define SLAVE_PCIE_4			81
> +#define SLAVE_QDSS_STM			82
> +#define SLAVE_SMSS			83
> +#define SLAVE_TCU			84
> +
> +/* dc_noc */
> +#define MASTER_CNOC_DC_NOC		0
> +#define SLAVE_LLCC_CFG			1
> +#define SLAVE_GEM_NOC_CFG		2
> +
> +/* gem_noc */
> +#define MASTER_GPU_TCU			0
> +#define MASTER_PCIE_TCU			1
> +#define MASTER_SYS_TCU			2
> +#define MASTER_APPSS_PROC		3
> +#define MASTER_COMPUTE_NOC		4
> +#define MASTER_COMPUTE_NOC_1		5
> +#define MASTER_GEM_NOC_CFG		6
> +#define MASTER_GFX3D			7
> +#define MASTER_MNOC_HF_MEM_NOC		8
> +#define MASTER_MNOC_SF_MEM_NOC		9
> +#define MASTER_ANOC_PCIE_GEM_NOC	10
> +#define MASTER_SNOC_GC_MEM_NOC		11
> +#define MASTER_SNOC_SF_MEM_NOC		12
> +#define SLAVE_GEM_NOC_CNOC		13
> +#define SLAVE_LLCC			14
> +#define SLAVE_GEM_NOC_PCIE_CNOC		15
> +#define SLAVE_SERVICE_GEM_NOC_1		16
> +#define SLAVE_SERVICE_GEM_NOC_2		17
> +#define SLAVE_SERVICE_GEM_NOC		18
> +
> +/* lpass_ag_noc */
> +#define MASTER_CNOC_LPASS_AG_NOC	0
> +#define MASTER_LPASS_PROC		1
> +#define SLAVE_LPASS_CORE_CFG		2
> +#define SLAVE_LPASS_LPI_CFG		3
> +#define SLAVE_LPASS_MPU_CFG		4
> +#define SLAVE_LPASS_TOP_CFG		5
> +#define SLAVE_LPASS_SNOC		6
> +#define SLAVE_SERVICES_LPASS_AML_NOC	7
> +#define SLAVE_SERVICE_LPASS_AG_NOC	8
> +
> +/* mc_virt */
> +#define MASTER_LLCC			0
> +#define SLAVE_EBI1			1
> +
> +/*mmss_noc */
> +#define MASTER_CAMNOC_HF		0
> +#define MASTER_MDP0			1
> +#define MASTER_MDP1			2
> +#define MASTER_MDP_CORE1_0		3
> +#define MASTER_MDP_CORE1_1		4
> +#define MASTER_CNOC_MNOC_CFG		5
> +#define MASTER_ROTATOR			6
> +#define MASTER_ROTATOR_1		7
> +#define MASTER_VIDEO_P0			8
> +#define MASTER_VIDEO_P1			9
> +#define MASTER_VIDEO_PROC		10
> +#define MASTER_CAMNOC_ICP		11
> +#define MASTER_CAMNOC_SF		12
> +#define SLAVE_MNOC_HF_MEM_NOC		13
> +#define SLAVE_MNOC_SF_MEM_NOC		14
> +#define SLAVE_SERVICE_MNOC		15
> +
> +/* nspa_noc */
> +#define MASTER_CDSP_NOC_CFG		0
> +#define MASTER_CDSP_PROC		1
> +#define SLAVE_CDSP_MEM_NOC		2
> +#define SLAVE_NSP_XFR			3
> +#define SLAVE_SERVICE_NSP_NOC		4
> +
> +/* nspb_noc */
> +#define MASTER_CDSPB_NOC_CFG		0
> +#define MASTER_CDSP_PROC_B		1
> +#define SLAVE_CDSPB_MEM_NOC		2
> +#define SLAVE_NSPB_XFR			3
> +#define SLAVE_SERVICE_NSPB_NOC		4
> +
> +/* system_noc */
> +#define MASTER_A1NOC_SNOC		0
> +#define MASTER_A2NOC_SNOC		1
> +#define MASTER_USB_NOC_SNOC		2
> +#define MASTER_LPASS_ANOC		3
> +#define MASTER_SNOC_CFG			4
> +#define MASTER_PIMEM			5
> +#define MASTER_GIC			6
> +#define SLAVE_SNOC_GEM_NOC_GC		7
> +#define SLAVE_SNOC_GEM_NOC_SF		8
> +#define SLAVE_SERVICE_SNOC		9
> +
> +#endif
> -- 
> 2.33.1
> 
> 
