Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B835572C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiFWGAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWGAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:00:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461884475D;
        Wed, 22 Jun 2022 23:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655964051; x=1687500051;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=NU10NFbm9+LYVn9Wa6u9gj8rbdUOfKAwCwn45TEVlXI=;
  b=BvcM9efA16dnVK89y3iN6Ew2O10ccIPSPRAdhR8l7JSUEbkNSYdAfFPI
   +8StAwJokq23dWXwSUcSiw3SHFtTfRlIdEXeufpyE3ZhT7EOYn6nTQtlD
   VUiz61MkeEz2W4H8hDcPlPJSO8I+ZIhFBkYO2kr7HxmReZVb/W+4QQ+w2
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jun 2022 23:00:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 23:00:50 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 23:00:49 -0700
Received: from [10.242.242.148] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 23:00:44 -0700
Message-ID: <2263d169-e898-c639-b0ae-204746e48b22@quicinc.com>
Date:   Thu, 23 Jun 2022 11:30:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 2/8] dt-bindings: arm64: ipq5018: Add binding
 descriptions for clock and reset
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-3-quic_srichara@quicinc.com>
 <534c4112-f965-c32b-0c24-e2e6be1a663f@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <534c4112-f965-c32b-0c24-e2e6be1a663f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

    Thanks a lot for your reviews in all patches.

On 6/22/2022 8:34 PM, Krzysztof Kozlowski wrote:
> On 21/06/2022 18:11, Sricharan R wrote:
>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>
>> This patch adds support for the global clock controller found on
>> the IPQ5018 based devices.
>>
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,gcc-other.yaml        |   3 +
>>   include/dt-bindings/clock/qcom,gcc-ipq5018.h  | 188 ++++++++++++++++++
>>   include/dt-bindings/reset/qcom,gcc-ipq5018.h  | 122 ++++++++++++
>>   3 files changed, 313 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5018.h
>>   create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq5018.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
>> index 6c45e0f85494..3852346dbcad 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
>> @@ -29,6 +29,8 @@ description: |
>>     - dt-bindings/clock/qcom,gcc-mdm9615.h
>>     - dt-bindings/reset/qcom,gcc-mdm9615.h
>>     - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
>> +  - dt-bindings/clock/qcom,gcc-ipq5018.h
>> +  - dt-bindings/reset/qcom,gcc-ipq5018.h
>>   
>>   allOf:
>>     - $ref: "qcom,gcc.yaml#"
>> @@ -51,6 +53,7 @@ properties:
>>         - qcom,gcc-mdm9615
>>         - qcom,gcc-sdm630
>>         - qcom,gcc-sdm660
>> +      - qcom,gcc-ipq5018
>>   
>>   required:
>>     - compatible
>> diff --git a/include/dt-bindings/clock/qcom,gcc-ipq5018.h b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
>> new file mode 100644
>> index 000000000000..14916600e2a7
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
>> @@ -0,0 +1,188 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> This should be dual-license, as Rob asked last time. It's also favorable
> for Qualcomm, so there is no problem in that.
>
> GPL-2.0-only OR BSD-2-Clause

  Sure, will change it.

>> +/*
>> + * Copyright (c) 2017-2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_IPQ_GCC_5018_H
>> +#define _DT_BINDINGS_CLOCK_IPQ_GCC_5018_H
>> +
>> +#define GPLL0_MAIN					0
>> +#define GPLL0						1
>> +#define GPLL2_MAIN					2
>> +#define GPLL2						3
>> +#define GPLL4_MAIN					4
>> +#define GPLL4						5
>> +#define UBI32_PLL_MAIN					6
>> +#define UBI32_PLL					7
>> +#define APSS_AHB_CLK_SRC				9
>> +#define APSS_AHB_POSTDIV_CLK_SRC			10
>> +#define APSS_AXI_CLK_SRC				11
>> +#define BLSP1_QUP1_I2C_APPS_CLK_SRC			12
>> +#define BLSP1_QUP1_SPI_APPS_CLK_SRC			13
>> +#define BLSP1_QUP2_I2C_APPS_CLK_SRC			14
>> +#define BLSP1_QUP2_SPI_APPS_CLK_SRC			15
>> +#define BLSP1_QUP3_I2C_APPS_CLK_SRC			16
>> +#define BLSP1_QUP3_SPI_APPS_CLK_SRC			17
>> +#define BLSP1_UART1_APPS_CLK_SRC			18
>> +#define BLSP1_UART2_APPS_CLK_SRC			19
>> +#define CRYPTO_CLK_SRC					20
>> +#define GCC_APSS_AHB_CLK				23
> No holes in IDs. The IDs are integers incremented by one, serving as an
> abstract number, not some register offset or register value.

  ok.


>> +#define GCC_APSS_AXI_CLK				24
>> +#define GCC_BLSP1_AHB_CLK				25
>> +#define GCC_BLSP1_QUP1_I2C_APPS_CLK			26
>> +#define GCC_BLSP1_QUP1_SPI_APPS_CLK			27
>> +#define GCC_BLSP1_QUP2_I2C_APPS_CLK			28
>> +#define GCC_BLSP1_QUP2_SPI_APPS_CLK			29
>> +#define GCC_BLSP1_QUP3_I2C_APPS_CLK			30
>> +#define GCC_BLSP1_QUP3_SPI_APPS_CLK			31
>> +#define GCC_BLSP1_UART1_APPS_CLK			33
>> +#define GCC_BLSP1_UART2_APPS_CLK			34
>> +#define GCC_BTSS_LPO_CLK				36
>> +#define GCC_CMN_BLK_AHB_CLK				40
>> +#define GCC_CMN_BLK_SYS_CLK				41
>> +#define GCC_CRYPTO_AHB_CLK				44
>> +#define GCC_CRYPTO_AXI_CLK				45
>> +#define GCC_CRYPTO_CLK					46
>> +#define GCC_CRYPTO_PPE_CLK				47
>> +#define GCC_DCC_CLK					48
>> +#define GCC_GEPHY_RX_CLK				53
> No holes.

  ok.


>> +#define GCC_GEPHY_TX_CLK				54
>> +#define GCC_GMAC0_CFG_CLK				55
>> +#define GCC_GMAC0_PTP_CLK				56
>> +#define GCC_GMAC0_RX_CLK				57
>> +#define GCC_GMAC0_SYS_CLK				58
>> +#define GCC_GMAC0_TX_CLK				59
>> +#define GCC_GMAC1_CFG_CLK				60
>> +#define GCC_GMAC1_PTP_CLK				61
>> +#define GCC_GMAC1_RX_CLK				62
>> +#define GCC_GMAC1_SYS_CLK				63
>> +#define GCC_GMAC1_TX_CLK				64
>> +#define GCC_GP1_CLK					65
>> +#define GCC_GP2_CLK					66
>> +#define GCC_GP3_CLK					67
>> +#define GCC_LPASS_CORE_AXIM_CLK				69
> Ditto.
>
>> +#define GCC_LPASS_SWAY_CLK				70
>> +#define GCC_MDIO0_AHB_CLK				71
>> +#define GCC_MDIO1_AHB_CLK				72
>> +#define GCC_PCIE0_AHB_CLK				74
>> +#define GCC_PCIE0_AUX_CLK				75
>> +#define GCC_PCIE0_AXI_M_CLK				76
>> +#define GCC_PCIE0_AXI_S_BRIDGE_CLK			77
>> +#define GCC_PCIE0_AXI_S_CLK				78
>> +#define GCC_PCIE1_AHB_CLK				79
>> +#define GCC_PCIE1_AUX_CLK				80
>> +#define GCC_PCIE1_AXI_M_CLK				81
>> +#define GCC_PCIE1_AXI_S_BRIDGE_CLK			82
>> +#define GCC_PCIE1_AXI_S_CLK				83
>> +#define GCC_PRNG_AHB_CLK				84
>> +#define GCC_Q6_AXIM_CLK					85
>> +#define GCC_Q6_AXIM2_CLK				86
>> +#define GCC_Q6_AXIS_CLK					87
>> +#define GCC_Q6_AHB_CLK					88
>> +#define GCC_Q6_AHB_S_CLK				89
>> +#define GCC_Q6_TSCTR_1TO2_CLK				90
>> +#define GCC_Q6SS_ATBM_CLK				91
>> +#define GCC_Q6SS_PCLKDBG_CLK				92
>> +#define GCC_Q6SS_TRIG_CLK				93
>> +#define GCC_QDSS_AT_CLK					94
>> +#define GCC_QDSS_CFG_AHB_CLK				95
>> +#define GCC_QDSS_DAP_AHB_CLK				96
>> +#define GCC_QDSS_DAP_CLK				97
>> +#define GCC_QDSS_ETR_USB_CLK				98
>> +#define GCC_QDSS_EUD_AT_CLK				99
>> +#define GCC_QDSS_STM_CLK				100
>> +#define GCC_QDSS_TRACECLKIN_CLK				101
>> +#define GCC_QDSS_TSCTR_DIV8_CLK				102
>> +#define GCC_QPIC_AHB_CLK				103
>> +#define GCC_QPIC_CLK					104
>> +#define GCC_QPIC_IO_MACRO_CLK				105
>> +#define GCC_SDCC1_AHB_CLK				107
>> +#define GCC_SDCC1_APPS_CLK				108
>> +#define GCC_SLEEP_CLK_SRC				109
>> +#define GCC_SNOC_GMAC0_AHB_CLK				110
>> +#define GCC_SNOC_GMAC0_AXI_CLK				111
>> +#define GCC_SNOC_GMAC1_AHB_CLK				112
>> +#define GCC_SNOC_GMAC1_AXI_CLK				113
>> +#define GCC_SNOC_LPASS_AXIM_CLK				114
>> +#define GCC_SNOC_LPASS_SWAY_CLK				115
>> +#define GCC_SNOC_UBI0_AXI_CLK				118
> Ditto... and in all other places.

  ok.


>> +#define GCC_SYS_NOC_PCIE0_AXI_CLK			119
>> +#define GCC_SYS_NOC_PCIE1_AXI_CLK			120
>> +#define GCC_SYS_NOC_QDSS_STM_AXI_CLK			121
>> +#define GCC_SYS_NOC_USB0_AXI_CLK			123
>> +#define GCC_SYS_NOC_WCSS_AHB_CLK			124
>> +#define GCC_UBI0_AXI_CLK				128
>> +#define GCC_UBI0_CFG_CLK				129
>> +#define GCC_UBI0_CORE_CLK				130
>> +#define GCC_UBI0_DBG_CLK				131
>> +#define GCC_UBI0_NC_AXI_CLK				132
>> +#define GCC_UBI0_UTCM_CLK				133
>> +#define GCC_UNIPHY_AHB_CLK				134
>> +#define GCC_UNIPHY_RX_CLK				135
>> +#define GCC_UNIPHY_SYS_CLK				136
>> +#define GCC_UNIPHY_TX_CLK				137
>> +#define GCC_USB0_AUX_CLK				138
>> +#define GCC_USB0_EUD_AT_CLK				139
>> +#define GCC_USB0_LFPS_CLK				140
>> +#define GCC_USB0_MASTER_CLK				141
>> +#define GCC_USB0_MOCK_UTMI_CLK				142
>> +#define GCC_USB0_PHY_CFG_AHB_CLK			143
>> +#define GCC_USB0_SLEEP_CLK				144
>> +#define GCC_WCSS_ACMT_CLK				145
>> +#define GCC_WCSS_AHB_S_CLK				146
>> +#define GCC_WCSS_AXI_M_CLK				147
>> +#define GCC_WCSS_AXI_S_CLK				148
>> +#define GCC_WCSS_DBG_IFC_APB_BDG_CLK			149
>> +#define GCC_WCSS_DBG_IFC_APB_CLK			150
>> +#define GCC_WCSS_DBG_IFC_ATB_BDG_CLK			151
>> +#define GCC_WCSS_DBG_IFC_ATB_CLK			152
>> +#define GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK			153
>> +#define GCC_WCSS_DBG_IFC_DAPBUS_CLK			154
>> +#define GCC_WCSS_DBG_IFC_NTS_BDG_CLK			155
>> +#define GCC_WCSS_DBG_IFC_NTS_CLK			156
>> +#define GCC_WCSS_ECAHB_CLK				157
>> +#define GCC_XO_CLK					158
>> +#define GCC_XO_CLK_SRC					159
>> +#define GMAC0_RX_CLK_SRC				161
>> +#define GMAC0_TX_CLK_SRC				162
>> +#define GMAC1_RX_CLK_SRC				163
>> +#define GMAC1_TX_CLK_SRC				164
>> +#define GMAC_CLK_SRC					165
>> +#define GP1_CLK_SRC					166
>> +#define GP2_CLK_SRC					167
>> +#define GP3_CLK_SRC					168
>> +#define LPASS_AXIM_CLK_SRC				169
>> +#define LPASS_SWAY_CLK_SRC				170
>> +#define PCIE0_AUX_CLK_SRC				171
>> +#define PCIE0_AXI_CLK_SRC				172
>> +#define PCIE1_AUX_CLK_SRC				173
>> +#define PCIE1_AXI_CLK_SRC				174
>> +#define PCNOC_BFDCD_CLK_SRC				175
>> +#define Q6_AXI_CLK_SRC					176
>> +#define QDSS_AT_CLK_SRC					177
>> +#define QDSS_STM_CLK_SRC				178
>> +#define QDSS_TSCTR_CLK_SRC				179
>> +#define QDSS_TRACECLKIN_CLK_SRC				180
>> +#define QPIC_IO_MACRO_CLK_SRC				181
>> +#define SDCC1_APPS_CLK_SRC				182
>> +#define SYSTEM_NOC_BFDCD_CLK_SRC			184
>> +#define UBI0_AXI_CLK_SRC				185
>> +#define UBI0_CORE_CLK_SRC				186
>> +#define USB0_AUX_CLK_SRC				187
>> +#define USB0_LFPS_CLK_SRC				188
>> +#define USB0_MASTER_CLK_SRC				189
>> +#define USB0_MOCK_UTMI_CLK_SRC				190
>> +#define WCSS_AHB_CLK_SRC				191
>> +#define PCIE0_PIPE_CLK_SRC				192
>> +#define PCIE1_PIPE_CLK_SRC				193
>> +#define GCC_PCIE0_PIPE_CLK				194
>> +#define GCC_PCIE1_PIPE_CLK				195
>> +#define USB0_PIPE_CLK_SRC				196
>> +#define GCC_USB0_PIPE_CLK				197
>> +#define GMAC0_RX_DIV_CLK_SRC				198
>> +#define GMAC0_TX_DIV_CLK_SRC				199
>> +#define GMAC1_RX_DIV_CLK_SRC				200
>> +#define GMAC1_TX_DIV_CLK_SRC				201
>> +#define ADSS_PWM_CLK_SRC				202
>> +#define GCC_ADSS_PWM_CLK				203
>> +#endif
>> diff --git a/include/dt-bindings/reset/qcom,gcc-ipq5018.h b/include/dt-bindings/reset/qcom,gcc-ipq5018.h
>> new file mode 100644
>> index 000000000000..bdbc974cb6ea
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/qcom,gcc-ipq5018.h
>> @@ -0,0 +1,122 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> Dual license
>
  ok.


>> +/*
>> + * Copyright (c) 2017-2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RESET_IPQ_GCC_5018_H
>> +#define _DT_BINDINGS_RESET_IPQ_GCC_5018_H
>> +
>> +#define GCC_APC0_VOLTAGE_DROOP_DETECTOR_BCR	0
>> +#define	GCC_BLSP1_BCR				1
>> +#define GCC_BLSP1_QUP1_BCR			2
>> +#define	GCC_BLSP1_QUP2_BCR			3
> Such indentation is not Linux coding style. Please drop it.

  ok, will fix it.

Regards,

   Sricharan

