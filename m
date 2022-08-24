Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6617E59F72E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiHXKMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHXKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:12:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713E732EDC;
        Wed, 24 Aug 2022 03:11:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O96nt8013470;
        Wed, 24 Aug 2022 10:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GmB42AaC1N1dcPtTfq569gVNQMlKUEOV7RVKMg/CtPA=;
 b=auUAha0/vtKATwL/gENfMvWpftg5tmIKOV8j1PkKHU8W6b6hv0+fJJEl8QinZZE2K6vz
 EFM7qgSKCdTGJZ0v2e8bBY8/euHmjGkGDhCGk7oyf0iM3BIHRRjPSZVRJRTZOWwTnCaA
 Qa7oXZQThXUz9i6d4/F4tf0Ancr1hscOEuwUoshQe9vGcFTNNQsEnibyRV421Ca70LkQ
 8ZQJJjKtz7Ty2k472ZRiVviZ36pVnYznjGNuVDBUe1P63ROnB8B7n6wp9+s09fWHNfG8
 EhBE4AZfyabL8Yl/byng5imXja+E/B7bFknE3gdlS29v7WiK8sthHuTQM5vN4sQDImcH pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pjk29v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 10:11:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27OABfeh010665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 10:11:41 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 03:11:38 -0700
Subject: Re: [PATCH v8 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager
 family
To:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
 <SG2PR03MB5006B0C3E57803E3B1E0EDBCCC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <93bf8a59-34e3-e461-35c9-4f0f344dee32@quicinc.com>
Date:   Wed, 24 Aug 2022 15:41:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SG2PR03MB5006B0C3E57803E3B1E0EDBCCC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FnSEZ3M8c3Hy0jcebAqCVKGKO_g0P19Z
X-Proofpoint-GUID: FnSEZ3M8c3Hy0jcebAqCVKGKO_g0P19Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jimmy,

Thanks for the patch.

On 7/26/22 3:15 PM, Jimmy Chen wrote:
> This adds LTE skus for villager device tree files.
> 
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v6)
> 
> Changes in v6:
> - Remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts
> 
> Changes in v5:
> - Reorder '.dtb' in Makefile
> - Put the "interconnects" line back
> 
> Changes in v4:
> - Reorder 'status' last
> 
>   arch/arm64/boot/dts/qcom/Makefile               |  2 ++
>   .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
>   .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
>   .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
>   .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
>   .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
>   .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
>   arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
>   8 files changed, 50 insertions(+), 11 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2c1605e00d349..24eacbf330880 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -103,7 +103,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0-lte.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index cfe2741456a1a..25f31c81b2b74 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -83,17 +83,6 @@ spi_flash: flash@0 {
>   	};
>   };
>   
> -/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> -&remoteproc_mpss {
> -	status = "okay";
> -	compatible = "qcom,sc7280-mss-pil";
> -	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> -	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> -	memory-region = <&mba_mem>, <&mpss_mem>;
> -	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> -			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> -};
> -
>   &remoteproc_wpss {
>   	status = "okay";
>   	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index e9ca6c5d24a16..921eccfec39ae 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -9,6 +9,7 @@
>   
>   #include "sc7280-herobrine.dtsi"
>   #include "sc7280-herobrine-audio-wcd9385.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>   
>   / {
>   	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> index c1647a85a371a..c1a6719687252 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> @@ -8,6 +8,7 @@
>   /dts-v1/;
>   
>   #include "sc7280-herobrine.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>   
>   / {
>   	model = "Google Herobrine (rev1+)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> new file mode 100644
> index 0000000000000..a92eeccd2b2a9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Herobrine dts fragment for LTE SKUs
> + *
> + * Copyright 2022 Google LLC.
> + */
> +/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> +
> +&remoteproc_mpss {
> +	compatible = "qcom,sc7280-mss-pil";
> +	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> +	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> +	memory-region = <&mba_mem>, <&mpss_mem>;
> +	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> +			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> +	status = "okay";
> +};

We shoud probably move the mpss_mem, mba_mem and rmtfs_mem here as
well, that way we save an additional ~255M.

-Sibi

> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
> new file mode 100644
> index 0000000000000..672cb78e3088f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Villager board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r0.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +	model = "Google Villager (rev0) with LTE";
> +	compatible = "google,villager-rev0-sku0", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> new file mode 100644
> index 0000000000000..2f05a19cc388e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Villager board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r1.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +	model = "Google Villager (rev1+) with LTE";
> +	compatible = "google,villager-sku0", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 6d3ff80582ae9..fba7e938ce35a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
>   #include "sc7280-idp.dtsi"
>   #include "pmr735a.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>   
>   / {
>   	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
> 
