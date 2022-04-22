Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5D50B913
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448199AbiDVNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385747AbiDVNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:52:16 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC65A09F;
        Fri, 22 Apr 2022 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650635362; x=1682171362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p2nLtiw5tb+6f8IShlQjWXJQ8XDpnfFpGdABA8N54Wc=;
  b=ceLX91Xd/Pyphzbuu/iV/2epf+u3pBxxVp3Y0WWsNx9n/zVNng8iDfay
   1AE/p2Qz+FZPwIFpoUQ5TXaJThIO1QkiXzIgULr0bdcapUw5DTiTHyyGt
   +EgFbgdoZv9Wxt5hT7t++fGxIsDs/OfWma2DOeLVsL8YTk0Y214/7gzDp
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2022 06:49:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:49:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 06:49:20 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 06:49:15 -0700
Message-ID: <3dbb92ca-2ae0-d04b-acd4-1d75019adb3b@quicinc.com>
Date:   Fri, 22 Apr 2022 19:19:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9 09/12] arm64: dts: qcom: sc7280: Enable lpass cpu node
 for CRD 1.0 and CRD 2.0
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
 <1650552459-21077-10-git-send-email-quic_srivasam@quicinc.com>
 <YmGQv7CN16yoLn82@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmGQv7CN16yoLn82@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2022 10:43 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Thu, Apr 21, 2022 at 08:17:36PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> Subject: arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0 and CRD 2.0
> nit: and the IDP boards?
Okay.
>
>> Enable lpass cpu node for audio on sc7280 based platforms of revision 3
>> and 4 (aka CRD 1.0 and 2.0) boards.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 24196a1..2e991e8 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -274,6 +274,34 @@
>>   	modem-init;
>>   };
>>   
>> +&lpass_cpu {
>> +	status = "okay";
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
>> +
>> +	dai-link@1 {
>> +		reg = <MI2S_SECONDARY>;
>> +		qcom,playback-sd-lines = <0>;
>> +	};
>> +
>> +	dai-link@5 {
>> +		reg = <LPASS_DP_RX>;
>> +	};
>> +
>> +	dai-link@6 {
>> +		reg = <LPASS_CDC_DMA_RX0>;
>> +	};
>> +
>> +	dai-link@19 {
>> +		reg = <LPASS_CDC_DMA_TX3>;
>> +	};
>> +
>> +	dai-link@25 {
>> +		reg = <LPASS_CDC_DMA_VA_TX0>;
>> +	};
>> +};
>> +
>>   &lpass_rx_macro {
>>   	status = "okay";
>>   };
>> -- 
>> 2.7.4
>>
