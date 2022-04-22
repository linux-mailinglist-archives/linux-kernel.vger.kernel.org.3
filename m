Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7EB50B8D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448117AbiDVNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiDVNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:45:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89E57145;
        Fri, 22 Apr 2022 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650634942; x=1682170942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BliAkzt/VqvzT87u88KRdUVKa89JJ5OCX1k3Cs96BY0=;
  b=n5sr/dfuEZC0KFuUPQpvkQWls8ng1oMqNWri5ezV0jmqsMf4VVQ1vyXd
   btHp9ngREadUaqJob043Cmc+O8JGQxF6XnmUoa1a3o/lerq/M0YpwAjUw
   oJPoDa8WxY6ssjOHczJQdH6FI/3pFO3mCTUfGlj9UshKBKLUAPYO1ibgR
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2022 06:42:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:42:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 06:42:20 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 06:42:15 -0700
Message-ID: <aa034975-0daa-f42c-d03b-cfa4a98fee45@quicinc.com>
Date:   Fri, 22 Apr 2022 19:12:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9 02/12] arm64: dts: qcom: sc7280: Enable digital codecs
 and soundwire for CRD 1.0 and CRD 2.0
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
 <1650552459-21077-3-git-send-email-quic_srivasam@quicinc.com>
 <YmGDl4+os6Wkxn1G@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmGDl4+os6Wkxn1G@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2022 9:47 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Thu, Apr 21, 2022 at 08:17:29PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> Subject: arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 1.0 and CRD 2.0
> This also enables things for IDP boards, right? If that isn't intended
> then these changes should be in sc7280-crd-r3.dts
These changes are required for IDP boards also. Will update the commit 
message accordingly.
>
>> Enable rx, tx and va macro codecs and soundwire nodes on revision 3
>> and 4 (aka CRD 1.0 and 2.0) boards.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 35 ++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 2f863c0..6cb5fc4 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -238,6 +238,19 @@
>>   	modem-init;
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
>>   &pcie1 {
>>   	status = "okay";
>>   	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> @@ -298,6 +311,28 @@
>>   	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
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
>> +
>>   &uart5 {
>>   	compatible = "qcom,geni-debug-uart";
>>   	status = "okay";
>> -- 
>> 2.7.4
>>
