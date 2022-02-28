Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7DA4C6F30
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiB1OTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiB1OTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:19:38 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679357B38;
        Mon, 28 Feb 2022 06:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646057940; x=1677593940;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mGXIJ14JDKVbQZzu2QsNGlPduFK+XcbT3JXR8kp0H60=;
  b=uphcYOWAc0GuoS14pTaCKOdzWC6vhPfTQ1R2J6DVusU0gWFniws2/6oZ
   OfGWP/9+jn2ZAfrukHu1m1mStP0GzKPRnERq5cUnFbSwLE7ZFIIY65HHf
   PufhLyPZp18+UrgFZZMsbrGzFrDvMzIYX0cBawelm8Zofi/y4tXcV9cpy
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Feb 2022 06:18:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:19:00 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 06:18:59 -0800
Received: from [10.216.7.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 06:18:54 -0800
Subject: Re: [PATCH V7 4/5] arm64: dts: qcom: pm8008: Add base dts file
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
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
 <1645182064-15843-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53P1HZCjXUFWApEU8qG3_+Vv4XoZou5OwHsHvMJpqMe=g@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <c91d3226-d407-f574-f776-d29be08c892e@quicinc.com>
Date:   Mon, 28 Feb 2022 19:48:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n53P1HZCjXUFWApEU8qG3_+Vv4XoZou5OwHsHvMJpqMe=g@mail.gmail.com>
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


On 2/19/2022 7:27 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-02-18 03:01:02)
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
>> Changes in V6:
>>   - Changed node names to small letters.
>>
>> Changes in V7:
>>   - Removed intermediate regulators node.
>>
>>   arch/arm64/boot/dts/qcom/pm8008.dtsi | 44 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> new file mode 100644
>> index 0000000..0f48572
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +// Copyright (c) 2022, The Linux Foundation. All rights reserved.
>> +
>> +pm8008_infra: pm8008@8 {
> Node name should be generic, pmic@8


Okay.


>> +       compatible = "qcom,pm8008";
>> +       reg = <0x8>;
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +};
>> +
>> +pm8008_regulators: pm8008@9 {
> Node name should be generic, pmic@9


Okay.


>> +       compatible = "qcom,pm8008-regulators";
>> +       reg = <0x9>;
>> +       #address-cells = <1>;
> Address cells is 0 too?


Okay.


>> +       #size-cells = <0>;
>> +
>> +       pm8008_l1: ldo1 {
>> +               regulator-name = "pm8008_l1";
>> +       };
>> +
>> +       pm8008_l2: ldo2 {
>> +               regulator-name = "pm8008_l2";
>> +       };
>> +
>> +       pm8008_l3: ldo3 {
>> +               regulator-name = "pm8008_l3";
>> +       };
>> +
>> +       pm8008_l4: ldo4 {
>> +               regulator-name = "pm8008_l4";
>> +       };
>> +
>> +       pm8008_l5: ldo5 {
>> +               regulator-name = "pm8008_l5";
>> +       };
>> +
>> +       pm8008_l6: ldo6 {
>> +               regulator-name = "pm8008_l6";
>> +       };
>> +
>> +       pm8008_l7: ldo7 {
>> +               regulator-name = "pm8008_l7";
>> +       };
>>
