Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538764FBD78
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbiDKNn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbiDKNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:43:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4B015FD1;
        Mon, 11 Apr 2022 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649684464; x=1681220464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B4MQ7T14IRb4CS1kUI7tBVcKJAmTTsUChGoW5RsNlM8=;
  b=mm8wHjO3i5GBlvyQmDv2i4qTJoSijm/n+AnPkNBonMlVR7mPuKGGYzO4
   34UKBAyH4qyYIv4GLBRVi9GV+HyoyPtSVhnXa/Xu4jrJOuToEmtJqqktw
   xVAASLXNHSZIu2AFUt03ed3Ub5qGCE9X5lVM0ek3lVgyY+k6zsZ53O3lT
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Apr 2022 06:41:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:41:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 06:41:03 -0700
Received: from [10.216.15.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 06:40:58 -0700
Message-ID: <da9d1c86-0d99-9199-fc4f-1c158ec47993@quicinc.com>
Date:   Mon, 11 Apr 2022 19:10:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohitkr@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1649157167-29106-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157167-29106-2-git-send-email-quic_srivasam@quicinc.com>
 <YkyLuemETXD97Jv1@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YkyLuemETXD97Jv1@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2022 12:04 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Tue, Apr 05, 2022 at 04:42:46PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add AMP enable node and pinmux for primary and secondary I2S
>> for SC7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 34 +++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 20 +++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi           | 41 ++++++++++++++++++++++++++
>>   3 files changed, 95 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> index dc17f20..de646d9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> @@ -530,6 +530,26 @@ ap_ec_spi: &spi10 {
>>   	drive-strength = <2>;
>>   };
>>   
>> +&pri_mi2s_data0 {
>> +	drive-strength = <6>;
> Isn't this pin used as an input (HP_DIN)? Is specifying the drive strength
> really needed?
Okay. will remove this.
>
>> +};
>> +
>> +&pri_mi2s_data1 {
>> +	drive-strength = <6>;
>> +};
>> +
>> +&pri_mi2s_mclk {
>> +	drive-strength = <6>;
>> +};
>> +
>> +&pri_mi2s_sclk {
>> +	drive-strength = <6>;
>> +};
>> +
>> +&pri_mi2s_ws {
>> +	drive-strength = <6>;
>> +};
>> +
>>   &qspi_cs0 {
>>   	bias-disable;
>>   	drive-strength = <8>;
>> @@ -610,6 +630,20 @@ ap_ec_spi: &spi10 {
>>   	drive-strength = <10>;
>>   };
>>   
>> +&sec_mi2s_data0 {
>> +	drive-strength = <6>;
>> +	bias-disable;
>> +};
>> +
>> +&sec_mi2s_sclk {
>> +	drive-strength = <6>;
>> +	bias-disable;
>> +};
>> +
>> +&sec_mi2s_ws {
>> +	drive-strength = <6>;
>> +};
> Actually there are several sound configs for herobrine boards. For now I
> think it's ok to specify the config for herobrine -rev1 (as this patch
> does) and we can sort out later how to best support the different configs.
Okay. Will skip this for now.
>
>>   /* PINCTRL - board-specific pinctrl */
>>   
>>   &pm7325_gpios {
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ecbf2b8..2afbbe3 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -462,7 +462,27 @@
>>   	drive-strength = <10>;
>>   };
>>   
>> +&sec_mi2s_data0 {
>> +	drive-strength = <6>;
>> +	bias-disable;
>> +};
>> +
>> +&sec_mi2s_sclk {
>> +	drive-strength = <6>;
>> +	bias-disable;
>> +};
>> +
>> +&sec_mi2s_ws {
>> +	drive-strength = <6>;
>> +};
>> +
>>   &tlmm {
>> +	amp_en: amp-en {
>> +		pins = "gpio63";
>> +		bias-pull-down;
>> +		drive-strength = <2>;
>> +	};
> nit: all the other pins are i2s related, it might make sense to add amp_en
> in a separate patch.
Okay. will add it in corresponding consumer patch.
>
>> +
>>   	bt_en: bt-en {
>>   		pins = "gpio85";
>>   		function = "gpio";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index f0b64be..8d8cec5 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3527,6 +3527,31 @@
>>   				function = "pcie1_clkreqn";
>>   			};
>>   
>> +			pri_mi2s_data0: pri-mi2s-data0 {
>> +				pins = "gpio98";
>> +				function = "mi2s0_data0";
>> +			};
>> +
>> +			pri_mi2s_data1: pri-mi2s-data1 {
>> +				pins = "gpio99";
>> +				function = "mi2s0_data1";
>> +			};
>> +
>> +			pri_mi2s_mclk: pri-mi2s-mclk {
>> +				pins = "gpio96";
>> +				function = "pri_mi2s";
>> +			};
>> +
>> +			pri_mi2s_sclk: pri-mi2s-sclk {
>> +				pins = "gpio97";
>> +				function = "mi2s0_sck";
>> +			};
>> +
>> +			pri_mi2s_ws: pri-mi2s-ws {
>> +				pins = "gpio100";
>> +				function = "mi2s0_ws";
>> +			};
>> +
>>   			qspi_clk: qspi-clk {
>>   				pins = "gpio14";
>>   				function = "qspi_clk";
>> @@ -4261,6 +4286,22 @@
>>   				drive-strength = <2>;
>>   				bias-bus-hold;
>>   			};
>> +
>> +			sec_mi2s_data0: sec-mi2s-data0 {
>> +				pins = "gpio107";
>> +				function = "mi2s1_data0";
>> +			};
>> +
>> +			sec_mi2s_sclk: sec-mi2s-sclk {
>> +				pins = "gpio106";
>> +				function = "mi2s1_sck";
>> +			};
>> +
>> +			sec_mi2s_ws: sec-mi2s-ws {
>> +				pins = "gpio108";
>> +				function = "mi2s1_ws";
>> +			};
> Is there a particular reason for the pri/sec nomenclature? The datasheet and
> schematics call the pin mi2sN_xyz, it seems it would be clearer to follow
> that naming. Primary/secondary seems to imply a 'master/slave' topology, but
> these are independent controllers IIUC. The datasheet refers to pin 96 as
> PRI_MI2S_MCLK and pin 105 SEC_MI2S_MCLK, I guess the naming was derived from
> that.
>
> My suggestion would be to follow the naming in the datasheet/schematic, i.e.
> mi2sN_data0, mi2sN_data1, pri/sec_mi2s_mclk, mi2sN_sck, mi2sN_ws.
Okay. Actually we followed same in Rennel architecture. Will change 
accordingly.
