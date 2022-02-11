Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF394B22FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348856AbiBKKWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:22:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348839AbiBKKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:22:30 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2142D4;
        Fri, 11 Feb 2022 02:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644574950; x=1676110950;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eJp1a9RXLsgWN+zpXdHYpgstUUfDJYU8LPLMioibWrU=;
  b=QqpCQHCAWVLzXw1NDR1w5II3rkrOTZ0k4FcmVk8RCxRXcnlf5tvTWfYf
   nIDE6F2dV4kdKjGcSlwyDgAY0XBE5SMUiJvzcy6xKYwW5VohOROqcB5mL
   aFkNGKK+hmaeQK8gVNqC8YWAOmyzLN+3LoYfmO6yBK0cDbq2j6W6FKxzW
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 02:22:30 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:22:29 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 02:22:24 -0800
Subject: Re: [PATCH V5 5/6] arm64: dts: qcom: pm8008: Add base dts file
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-6-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52vX-50GEZ5X3PhnZaLyriALRtoqGiWSydi4WSAvGmf9A@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <ca23ad3b-7799-cd30-f11e-0bc9fb93be79@quicinc.com>
Date:   Fri, 11 Feb 2022 15:52:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52vX-50GEZ5X3PhnZaLyriALRtoqGiWSydi4WSAvGmf9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/10/2022 7:11 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-02-08 06:52:19)
>> Add base DTS file for pm8008 with infra and regulator nodes.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>> Changes in V4:
>>   - This is newly added in V4, to add all the pm8008 common stuff.
>>
>> Changes in V5:
>>   - Changed the mfd node names from pm8008_chip to pm8008_infra and
>>     pm8008_ldo to pm8008_regulators as they re more appropriate.
>>   - Changed the compatible for pm8008@9 mfd node to differentiate from
>>     pm8008@8 node in driver.
>>   - Removed compatible for regulators node.
>>   - Removed reg property for LDOs and added in driver.
>>
>>   arch/arm64/boot/dts/qcom/pm8008.dtsi | 46 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> new file mode 100644
>> index 0000000..8e04983
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +// Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> +
>> +pm8008_infra: pm8008@8 {
>> +       compatible = "qcom,pm8008";
>> +       reg = <0x8>;
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +};
>> +
>> +pm8008_regulators: pm8008@9 {
>> +       compatible = "qcom,pm8008-regulators";
>> +       reg = <0x9>;
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +
>> +       regulators {
> What is the point of the 'regulators' node? Why can't we just put LDO1
> directly underneath the node that has the "qcom,pm8008-regulators"
> compatible?


It is not mandatory to have it but I think it makes the layout look a 
little better. And it seems to be commonly used upstream.


>> +               pm8008_l1: LDO1 {
>> +                       regulator-name = "pm8008_l1";
>> +               };
>> +
