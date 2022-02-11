Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957AE4B22AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348443AbiBKKBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:01:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiBKKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:01:37 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74A133;
        Fri, 11 Feb 2022 02:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644573697; x=1676109697;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KXt8RH49BT2ugl4NpxEWl0Nk134PTxSvylNHpuxCxj4=;
  b=QFexRJs7CN3Z3+k6zBb4fsizDO3SjM0L1emLLXYASaZlAW8UQjjq62x1
   LuVJR/uByPhHqFR1nW6nragpx0VBsXN5xY/SC4n2DErdsHMjDpMn/qXWx
   xlohluMB4ijhJTo2zl8Zz9t3irWmtw3U8/NWYL/uUrE9418Gd7fI1293E
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 02:01:37 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:01:36 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 02:01:31 -0800
Subject: Re: [PATCH V5 1/6] dt-bindings: regulator: Add pm8008 regulator
 bindings
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
 <1644331940-18986-2-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n51AYxeWMpgS=Ya-_5Ly_h3uB346aZc9j596iZxQ+ZtcMQ@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <8bc29e46-77c4-93e5-db98-f4ed06d31e89@quicinc.com>
Date:   Fri, 11 Feb 2022 15:31:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51AYxeWMpgS=Ya-_5Ly_h3uB346aZc9j596iZxQ+ZtcMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 2/10/2022 6:54 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-02-08 06:52:15)
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
>> new file mode 100644
>> index 0000000..0098845
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
>> @@ -0,0 +1,31 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/qcom,pm8008-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. PM8008 Regulator bindings
>> +
>> +maintainers:
>> +  - Satya Priya <skakit@codeaurora.org>
>> +
>> +description:
>> +  Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
>> +  containing 7 LDO regulators.
>> +
>> +patternProperties:
>> +  "^LDO[1-7]$":
> Any reason it needs to be capitalized vs. lowercase ldo?


I'll change this to lowercase.


>> +    type: object
>> +    $ref: "regulator.yaml#"
>> +    description: PM8008 regulator peripherals of PM8008 regulator device
>> +
>> +    properties:
>> +      regulator-name: true
>> +
>> +    required:
>> +      - regulator-name
