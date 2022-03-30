Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C914EBF14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbiC3Kp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245524AbiC3Kp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:45:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A576562;
        Wed, 30 Mar 2022 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648637050; x=1680173050;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1ALKljcPIWRTbJOCCZdSlHSchaW8/tgIbdkkM8LZY/g=;
  b=oImNDtfOXKBBXBj2uBQxpRW8hp4pmpmR5Uqrjb4b2EPspoVPnTJ7SADQ
   qjryFws/ZTZIZEn3nH0My0DESJtak2nf9Gdtdsu/utQfPQkemYCBzhRqI
   1FVdoqrx1bYkAYLbBY0PSk/xR2Xg/gesp2ve4/MifD4D9PIL881FKGpO2
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Mar 2022 03:44:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:44:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 03:44:10 -0700
Received: from [10.216.27.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 03:44:04 -0700
Subject: Re: [PATCH V8 7/7] arm64: dts: qcom: sc7280: Add pm8008 support for
 sc7280-idp
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
 <1648209491-30165-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n511eQTnJHqt0B=uiiSjigy-RHZ52YuYz4kfEpX1x6CMfw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <094d8faa-c42b-be1b-cf92-04232d618a3e@quicinc.com>
Date:   Wed, 30 Mar 2022 16:14:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n511eQTnJHqt0B=uiiSjigy-RHZ52YuYz4kfEpX1x6CMfw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2022 11:18 PM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-03-25 04:58:11)
>> Add pm8008_infra and pm8008_regulators support for sc7280 idp.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>> Changes in V6:
>>   - No changes.
>>
>> Changes in V7:
>>   - No Changes.
>>
>> Changes in V8:
>>   - Add an extra phandle "pm8008_bus" and then include pm8008 dtsi files inside it.
>>   - Remove output-high from pm8008_active node.
>>
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 70 ++++++++++++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ecbf2b8..0843e92 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -263,6 +263,67 @@
>>          };
>>   };
>>
>> +pm8008_bus: &i2c1 {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
> These two properties should already be in the i2c1 node. Can you remove
> them?


Okay.


>> +       status = "okay";
>> +};
>> +
>> +&pm8008_bus {
>> +       #include "pm8008-infra.dtsi"
>> +       #include "pm8008-regulators.dtsi"
>> +};
> I was thinking more of like
>
> 	&pm8008_bus: &i2c1 {
> 		status = "okay";
> 	};
>
> 	#include "pm8008.dtsi"
>
> and then the nodes below.


You mean

pm8008_bus: &i2c1 {

         status = "okay";

};

&pm8008_bus {

     #include "pm8008.dtsi"

};

and remaining nodes, right?

