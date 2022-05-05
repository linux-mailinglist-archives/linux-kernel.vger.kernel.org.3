Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A551C233
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379395AbiEEOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiEEOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:21:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1056410;
        Thu,  5 May 2022 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651760247; x=1683296247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rZ47qt24YNYTgsRKaNj73tbOKZqNZZlJgOgPoM3XEqg=;
  b=QiSGtH8V3kiNSKN4kd0suB0lgF3cmx758OuHGzYXiXKlhZSk6FqtRZEu
   piBMVViuQ8bIM/1ZaqTU1lPBkYyHpTNrrXsaKwCy5yJqXmTYOvmQaZNBc
   T5jSqFiA0P83SAZBnbXuXcUHMVq615LovjIGFRJD0ZXxR3To70SEBmhdt
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 07:17:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 07:17:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 07:17:27 -0700
Received: from [10.216.34.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 07:17:22 -0700
Message-ID: <ca629ee8-caf7-85c1-8f58-995de822cac1@quicinc.com>
Date:   Thu, 5 May 2022 19:47:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v13 4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi
 pinmux properties for CRD 3.0/3.1
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1651662987-11704-1-git-send-email-quic_srivasam@quicinc.com>
 <1651662987-11704-5-git-send-email-quic_srivasam@quicinc.com>
 <YnL+qwoSHt/95PcU@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YnL+qwoSHt/95PcU@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/2022 4:01 AM, Matthias Kaehlcke wrote:
Thanks for Your time Matthias!!!
> On Wed, May 04, 2022 at 04:46:27PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add LPASS LPI pinctrl properties, which are required for Audio
>> functionality on herobrine based platforms of rev5+
>> (aka CRD 3.0/3.1) boards.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 63 +++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> index deaea3a..dc61bad 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> @@ -110,6 +110,69 @@ ap_ts_pen_1v8: &i2c13 {
>>    * - If a pin is totally internal to Qcard then it gets Qcard name.
>>    * - If a pin is not hooked up on Qcard, it gets no name.
>>    */
>> +&lpass_dmic01_clk {
>> +	drive-strength = <8>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_dmic01_data {
>> +	bias-pull-down;
>> +};
>> +
>> +&lpass_dmic01_clk_sleep {
>> +	drive-strength = <2>;
>> +};
> should be after 'lpass_dmic01_clk'
Okay. Will sort accordingly.
>
>> +
>> +&lpass_dmic23_clk {
>> +	drive-strength = <8>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_dmic23_data {
>> +	bias-pull-down;
>> +};
>> +
>> +&lpass_dmic23_clk_sleep {
>> +	drive-strength = <2>;
>> +};
> see above
Okay.
>
>> +
>> +&lpass_rx_swr_clk {
>> +	drive-strength = <2>;
>> +	slew-rate = <1>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_rx_swr_data {
>> +	drive-strength = <2>;
>> +	slew-rate = <1>;
>> +	bias-bus-hold;
>> +};
>> +
>> +&lpass_rx_swr_clk_sleep {
>> +	drive-strength = <2>;
> drive strengh is the same as for 'lpass_rx_swr_clk', can be omitted?
Okay. Will remove it.
>
>> +	bias-pull-down;
>> +};
> see 'lpass_dmic23_clk_sleep'
Okay. Will sort accordingly.
>
>> +
>> +&lpass_rx_swr_data_sleep {
>> +	drive-strength = <2>;
> is drive strength really needed here?
Okay. Will remove it.
>
>> +	bias-pull-down;
>> +};
>> +
>> +&lpass_tx_swr_clk {
>> +	drive-strength = <2>;
>> +	slew-rate = <1>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_tx_swr_data {
>> +	slew-rate = <1>;
>> +	bias-bus-hold;
>> +};
>> +
>> +&lpass_tx_swr_clk_sleep {
>> +	drive-strength = <2>;
> is drive strength really needed here?
Okay. Will remove it.
>
>> +	bias-pull-down;
>> +};
> see 'lpass_dmic23_clk_sleep'
Okay. Will sort accordingly.
>
>>   
>>   &mi2s1_data0 {
>>   	drive-strength = <6>;
>> -- 
>> 2.7.4
>>
