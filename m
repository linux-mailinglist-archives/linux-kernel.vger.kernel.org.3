Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660C5573C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiFWHTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFWHTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:19:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62FE45AF1;
        Thu, 23 Jun 2022 00:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655968772; x=1687504772;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5lPbECoT8Z/3W+qVNGRvi8kQA8ZEoBHnTPns26WjHgc=;
  b=QPQ6piBxkIrny11+I9J4z1WGGryt8s6tpzMOHOZqzHPtZ1iiFrWio0S9
   9U1nirZwqAehycDt4SlHEsmUQ391WzU+ae4zNfHuHOvMXD7kxbK5l9o5g
   oxj6g1DITMeA5GsDQV6FnTtVwxPErq6EoMoH+Jp/NTGq6W2c8agdtQfmD
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Jun 2022 00:19:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 00:19:32 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 23 Jun 2022 00:19:31 -0700
Received: from [10.242.242.148] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 23 Jun
 2022 00:19:25 -0700
Message-ID: <dfccfc26-ce21-1355-6103-14e921f8e29c@quicinc.com>
Date:   Thu, 23 Jun 2022 12:49:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 7/8] arm64: dts: Add ipq5018 SoC and MP03 board support
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
 <20220621161126.15883-8-quic_srichara@quicinc.com>
 <876c9580-48ca-0491-24bc-4f20871277f0@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <876c9580-48ca-0491-24bc-4f20871277f0@linaro.org>
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


On 6/22/2022 8:48 PM, Krzysztof Kozlowski wrote:
> On 21/06/2022 18:11, Sricharan R wrote:
>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>
>> Add initial device tree support for the Qualcomm IPQ5018 SoC and
>> MP03.1-C2 board.
>>
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Chain needs fixes.

  ok.


>> ---
>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>   .../arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts |  29 +++
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 221 ++++++++++++++++++
>>   3 files changed, 251 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index f9e6343acd03..c44e701f093c 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.1-c2.dtb
> This does not look like in proper order.

   ok, will fix.

>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>> new file mode 100644
>> index 000000000000..d1cd080ec3db
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +/*
>> + * IPQ5018 CP01 board device tree source
>> + *
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq5018.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03-C2";
>> +	compatible = "qcom,ipq5018-mp03", "qcom,ipq5018";
>> +
>> +	aliases {
>> +		serial0 = &blsp1_uart1;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&blsp1_uart1 {
>> +	pinctrl-0 = <&serial_1_pins>;
>> +	pinctrl-names = "default";
>> +	status = "ok";
> "okay" is preferred.

   ok.


>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> new file mode 100644
>> index 000000000000..084fb7b30dfd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -0,0 +1,221 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>> +/*
>> + * Copyright (c) 2017-2021, The Linux Foundation. All rights reserved.
>> + */
>> +/*
>> + * IPQ5018 SoC device tree source
>> + *
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> Combine these two comments.

   ok.


>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>> +#include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>> +
>> +/ {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	interrupt-parent = <&intc>;
>> +
>> +	sleep_clk: sleep-clk {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <32000>;
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	xo: xo {
> Node name: xo-clk

  ok.


>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
> The clock is provided by board, so at least frequency should be defined
> there.

   ok, will move to board file. Somehow all other boards are defining it 
in soc dts itself, so
   followed it.

>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	gen2clk0: gen2clk0 {
> Keep consistent prefixes, so gen2-clk or gen2-0-clk

  ok, will fix.


>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <125000000>;
>> +		clock-output-names = "pcie20_phy0_pipe_clk";
>> +	};
>> +
>> +	gen2clk1: gen2clk1 {
> gen2-1-clk

  ok, will fix.

Regards,
   Sricharan

