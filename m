Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2464F5EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiDFNDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiDFNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:03:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5DD5CCC92;
        Wed,  6 Apr 2022 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649237449; x=1680773449;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SFtc5Cx+6Nw5kBcMc7124XPPOGKJlKRghgQoJVTH32U=;
  b=qQZdlqzBL4KzIAEwj1Qq+TFHVB8V6MozN6gKjS/caMY1LveIGpoi4iP+
   5KOAGeWKQe3a9yhWouxmj1HMAPYa8x9YmixZ7/RUHqYNqi8Z2u40wr0r8
   yMVgq3v40Bdn14hgu68sGyy9Uk+HxyChY2ZcX7PIkH7OBJeA0Pxt1Katw
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2022 02:28:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:28:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 02:28:07 -0700
Received: from [10.216.50.162] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 02:28:02 -0700
Subject: Re: [PATCH V9 5/6] arm64: dts: qcom: pm8008: Add base dts file
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-6-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n51rLRcWE+h3zaWNy-nJYK4tQoivjdbfgYrwTJbjYYxWFw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <8c8bf971-b6d3-9669-4da4-e81701d9c79e@quicinc.com>
Date:   Wed, 6 Apr 2022 14:57:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51rLRcWE+h3zaWNy-nJYK4tQoivjdbfgYrwTJbjYYxWFw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2022 12:41 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-04-05 06:50:32)
>> diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> new file mode 100644
>> index 0000000..24bd832
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +// Copyright (c) 2022, The Linux Foundation. All rights reserved.
>> +
>> +&pm8008_bus {
>> +       pm8008: pm8008@8 {
> pmic@8


Sorry I missed this change. I'll change it in next post.


>> +               compatible = "qcom,pm8008";
>> +               reg = <0x8>;
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               #interrupt-cells = <2>;
>> +       };
>> +
>> +       pm8008_regulators: pm8008@9 {
> pmic@9
>
>> +               compatible = "qcom,pm8008-regulators";
>> +               reg = <0x9>;
>> +               #address-cells = <0>;
>> +               #size-cells = <0>;
>> +
