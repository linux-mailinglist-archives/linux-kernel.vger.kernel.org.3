Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E09524452
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347515AbiELEgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347286AbiELEgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:36:10 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C2115A25;
        Wed, 11 May 2022 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=1d1tM
        H+vnpjo4OFLZKcFG1r3ENVDriGXTVUEOuHNaZI=; b=d9n4eEEfilh7piLG7UENr
        1Boj9hwQtUtl1CeaNiYFDlYuMRUTBDhRUZJGikc9OnvLgYlFR0xkvUp1YI9vtuJY
        pgSoSaCc/Fi1/78Q5RTpzeje4bYF9ONLeZuBR5sU/jKzE4obNA4yLCs3sMrbB/bn
        TY12O6FCtnLzkTlCi8bxIM=
Received: from [192.168.3.102] (unknown [218.201.129.19])
        by smtp9 (Coremail) with SMTP id DcCowABHmR9ejnxi3XKFCQ--.35242S2;
        Thu, 12 May 2022 12:34:39 +0800 (CST)
Message-ID: <01c2c11f-71fd-b735-b935-109865d62de5@163.com>
Date:   Thu, 12 May 2022 12:34:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] drivers: cpufreq: sun8i-r40: Add cpufreq support
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220510003611.1812-1-qianfanguijin@163.com>
 <1902551.yKVeVyVuyW@kista>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <1902551.yKVeVyVuyW@kista>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABHmR9ejnxi3XKFCQ--.35242S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF17GFy3tFW5JFWxKr17Jrb_yoW7Zw15pr
        1UCFZ5GF4fWr15t34aqw1DGrn7CFyv9FWY9ryUGa48tr1kZrykXr13tr93KrZ5Xr13J3yI
        vrn5XryI9ws8JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXiSLUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGhn+7VaEBiT6wwABsY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/12 4:13, Jernej Škrabec 写道:
> Dne torek, 10. maj 2022 ob 02:36:11 CEST je qianfanguijin@163.com napisal(a):
>> From: qianfan Zhao <qianfanguijin@163.com>
>>
>> OPP table value is get from allwinner lichee 3.10 kernel.
>> And completed 'cpu-supply' on sun8i based board.
>>
>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>> ---
>>   .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  4 ++
>>   arch/arm/boot/dts/sun8i-r40-feta40i.dtsi      |  4 ++
>>   arch/arm/boot/dts/sun8i-r40.dtsi              | 47 +++++++++++++++++++
>>   arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts      |  4 ++
>>   .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  4 ++
>>   drivers/cpufreq/cpufreq-dt-platdev.c          |  1 +
> This patch needs to be split in two:
> 1. driver change
> 2. DT changes
>
> And please add change log here for next submission.
Maybe there patch is better? one of driver, one of sun8i-r40.dtsi
and the others is the board's changes.
>
>>   6 files changed, 64 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/
> boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> index a6a1087a0c9b..4f30018ec4a2 100644
>> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
>> @@ -113,6 +113,10 @@ &ahci {
>>   	status = "okay";
>>   };
>>   
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>>   &de {
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/
> sun8i-r40-feta40i.dtsi
>> index 265e0fa57a32..b872b51a346d 100644
>> --- a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
>> @@ -6,6 +6,10 @@
>>   
>>   #include "sun8i-r40.dtsi"
>>   
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>>   &i2c0 {
>>   	status = "okay";
>>   
>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-
> r40.dtsi
>> index 291f4784e86c..90de119095fa 100644
>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>> @@ -54,6 +54,41 @@ / {
>>   	#size-cells = <1>;
>>   	interrupt-parent = <&gic>;
>>   
>> +	cpu0_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-720000000 {
>> +			opp-hz = /bits/ 64 <720000000>;
>> +			opp-microvolt = <1000000 1000000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-912000000 {
>> +			opp-hz = /bits/ 64 <912000000>;
>> +			opp-microvolt = <1100000 1100000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <1160000 1160000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-1104000000 {
>> +			opp-hz = /bits/ 64 <1104000000>;
>> +			opp-microvolt = <1240000 1240000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <1300000 1300000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +	};
>> +
>>   	clocks {
>>   		#address-cells = <1>;
>>   		#size-cells = <1>;
>> @@ -84,24 +119,36 @@ cpu0: cpu@0 {
>>   			compatible = "arm,cortex-a7";
>>   			device_type = "cpu";
>>   			reg = <0>;
>> +			clocks = <&ccu CLK_CPU>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>>   		};
>>   
>>   		cpu1: cpu@1 {
>>   			compatible = "arm,cortex-a7";
>>   			device_type = "cpu";
>>   			reg = <1>;
>> +			clocks = <&ccu CLK_CPU>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>>   		};
>>   
>>   		cpu2: cpu@2 {
>>   			compatible = "arm,cortex-a7";
>>   			device_type = "cpu";
>>   			reg = <2>;
>> +			clocks = <&ccu CLK_CPU>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>>   		};
>>   
>>   		cpu3: cpu@3 {
>>   			compatible = "arm,cortex-a7";
>>   			device_type = "cpu";
>>   			reg = <3>;
>> +			clocks = <&ccu CLK_CPU>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>>   		};
>>   	};
>>   
>> diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/
> sun8i-t3-cqa3t-bv3.dts
>> index 6931aaab2382..0eb1990742ff 100644
>> --- a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
>> +++ b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
>> @@ -88,6 +88,10 @@ &ahci {
>>   	status = "okay";
>>   };
>>   
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>>   &de {
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/
> boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> index 47954551f573..fdf8bd12faaa 100644
>> --- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> +++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
>> @@ -107,6 +107,10 @@ &ahci {
>>   	status = "okay";
>>   };
>>   
>> +&cpu0 {
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>>   &de {
>>   	status = "okay";
>>   };
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-
> dt-platdev.c
>> index ca1d103ec449..971a99219d4d 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -26,6 +26,7 @@ static const struct of_device_id allowlist[] __initconst =
> {
>>   	{ .compatible = "allwinner,sun8i-a23", },
>>   	{ .compatible = "allwinner,sun8i-a83t", },
>>   	{ .compatible = "allwinner,sun8i-h3", },
>> +	{ .compatible = "allwinner,sun8i-r40", },
> Why on allow list? Comment says operatings-point-v2 should be on block list,
> just like H6.
Actually I'm not make sure the difference, seems both of them can work.
Most of allwinner device_id is added in allowlist, so I did this.
>
> Best regards,
> Jernej
>
>>   
>>   	{ .compatible = "apm,xgene-shadowcat", },
>>   
>> -- 
>> 2.25.1
>>
>>

