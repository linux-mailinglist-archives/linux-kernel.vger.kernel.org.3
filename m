Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5F50B8EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448174AbiDVNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448151AbiDVNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:47:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151458E74;
        Fri, 22 Apr 2022 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650635079; x=1682171079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ELiewXYUEBaZWPAUkNRAWSBdVKIR+pB80M+9xs/p6Sg=;
  b=aXOy7zqw3aTBks4Lk+unvGtbLUoCuhx85nSIMel2Fa4u4drCIfvWEwQp
   gzpcS2CcJwUznZhqD8i95murZv5Ne43N1PzgtMVuzrxsuXzn/TWgCjVGG
   2xZKdTDgESnf+7WhJTHPuIrvY0TryiWwSU/Bbp7ae0MzsXNzwjrP0Demi
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Apr 2022 06:44:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:44:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 06:44:38 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 06:44:32 -0700
Message-ID: <7332648e-c71b-271f-56ff-0076ef6d0f6d@quicinc.com>
Date:   Fri, 22 Apr 2022 19:14:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9 03/12] arm64: dts: qcom: sc7280: Enable digital codecs
 and soundwire for CRD 3.0/3.1
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-4-git-send-email-quic_srivasam@quicinc.com>
 <YmGGQiD0L2GipcRt@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmGGQiD0L2GipcRt@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2022 9:58 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Thu, Apr 21, 2022 at 08:17:30PM +0530, Srinivasa Rao Mandadapu wrote:
>> Enable rx, tx and va macro codecs and soundwire nodes for
>> CRD rev5 (aka CRD 3.0/3.1) boards.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 35 +++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> index fd6eadc..d0794f2 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> @@ -69,6 +69,19 @@ ap_ts_pen_1v8: &i2c13 {
>>   	};
>>   };
>>   
>> +&lpass_rx_macro {
>> +	status = "okay";
>> +};
>> +
>> +&lpass_tx_macro {
>> +	status = "okay";
>> +};
>> +
>> +&lpass_va_macro {
>> +	status = "okay";
>> +	vdd-micb-supply = <&vreg_bob>;
>> +};
>> +
>>   /* For nvme */
>>   &pcie1 {
>>   	status = "okay";
>> @@ -89,6 +102,28 @@ ap_ts_pen_1v8: &i2c13 {
>>   	status = "okay";
>>   };
>>   
>> +&swr0 {
>> +	status = "okay";
>> +
>> +	wcd_rx: codec@0,4 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 4>;
>> +		#sound-dai-cells = <1>;
>> +		qcom,rx-port-mapping = <1 2 3 4 5>;
>> +	};
>> +};
>> +
>> +&swr1 {
>> +	status = "okay";
>> +
>> +	wcd_tx: codec@0,3 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 3>;
>> +		#sound-dai-cells = <1>;
>> +		qcom,tx-port-mapping = <1 2 3 4>;
>> +	};
>> +};
> The wcd9385 is on the qcard, so the wcd_tx/rx nodes should probably
> be added to sc7280-qcard.dtsi, and the CRD DT would only set 'status'.
Okay. will update accordingly.
