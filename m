Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D528050B90E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448184AbiDVNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385747AbiDVNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:51:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE425A092;
        Fri, 22 Apr 2022 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650635326; x=1682171326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v53C41vr54/QMfBd7haf9M00t1XTwfFbjuAT2Hy3lU4=;
  b=T3Njc8M+iNpVBfzI8PLoQDqIQTjN/gPK+6kTgCWB4caDNU/Inf6MNdmx
   kIj+t+nNpID3FHTQIDqC+sBY7skL1z/ebhsFcEnFOueEKWxjV+ctjCfxj
   A+WyYqtc5MGXJvG6jn5Cdd4WJXzk/qGGcEBj/31uFxBi12rNLsPYJ/rhL
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Apr 2022 06:48:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:48:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 06:48:46 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 06:48:40 -0700
Message-ID: <1088246f-73f5-c060-d0d3-b03eb680a4a2@quicinc.com>
Date:   Fri, 22 Apr 2022 19:18:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9 07/12] arm64: dts: qcom: sc7280: Add max98360a codec
 node for CRD 3.0/3.1
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
 <1650552459-21077-8-git-send-email-quic_srivasam@quicinc.com>
 <YmGQKKYfkrwmxmf8@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmGQKKYfkrwmxmf8@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 4/21/2022 10:41 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Thu, Apr 21, 2022 at 08:17:34PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> Subject: arm64: dts: qcom: sc7280: Add max98360a codec node for CRD 3.0/3.1
> This isn´t limited to the CRD 3.x, but applies to all herobrine boards,
> so it should be something like "arm64: dts: qcom: sc7280: herobrine:
> Add max98360a codec".
Okay. Will modify commit message accordingly.
>
>> Add max98360a codec node for audio use case on CRD rev5
>> (aka CRD 3.0/3.1) boards.
> ditto
Okay.
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> index d58045d..f247403 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> @@ -20,6 +20,14 @@
>>   #include "sc7280-chrome-common.dtsi"
>>   
>>   / {
>> +	max98360a: audio-codec-0 {
>> +		compatible = "maxim,max98360a";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&amp_en>;
>> +		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
> This node should be added before 'pwmleds' (alphabetical order
> within the board-specific top level nodes).
Okay. will sort it accordingly.
>
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> -- 
>> 2.7.4
>>
