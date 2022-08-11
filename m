Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D94C58FB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiHKLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiHKLK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:10:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDF6D9D2;
        Thu, 11 Aug 2022 04:10:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B5j6Sw007479;
        Thu, 11 Aug 2022 11:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2674oZnW8cIAdGGYcRjAh9jRe1rHnEv6Ok9YFjEqHFs=;
 b=ZwZ4Btl5R0j/a+Lm0cbaXYflrYWeMNf2SPeJTEtuqeKo3hsSJssZk4FoQrhcGgbXSr4i
 4mxaS+w2NyuJFx/D6eFu6hu/QRY/GYPZgKjWnZO4vmEkoFQhD85FITTApRI0gBiTJeVj
 xbx7TFsP+ajKJEYFiGzA7xOLX69xUw/v9cchMWYAGlOmPrYlXKFFsgX7iBnkKeQMsE8I
 zQZHcEbPjx9KPsbBbxwzpKvtoy3bNSMPR4sD+fjb70NpLgMMdphPHhXtb2+f0Eex2/QG
 TLkIW2TIocTI1DjxgvSXHjD2/rwQaZ7AmBKPFHlc/JaCML4GJj1c8qHKbcz6w/mvpK9R Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqg5rth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 11:10:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27BAhpQG020277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 10:43:51 GMT
Received: from [10.50.48.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 11 Aug
 2022 03:43:47 -0700
Message-ID: <4f76baa7-afca-b902-a024-c3f916bef753@quicinc.com>
Date:   Thu, 11 Aug 2022 16:13:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V7 1/5] dt-bindings: clock: Add "qcom,adsp-pil-mode"
 property
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
References: <1658910477-6494-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658910477-6494-2-git-send-email-quic_c_skakit@quicinc.com>
 <YvLPdVv2/7pJLeru@baldur>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <YvLPdVv2/7pJLeru@baldur>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZZpssgsGpOmnm78PSxYQCioxPMhLVY86
X-Proofpoint-GUID: ZZpssgsGpOmnm78PSxYQCioxPMhLVY86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2022 2:49 AM, Bjorn Andersson wrote:
> On Wed 27 Jul 03:27 CDT 2022, Satya Priya wrote:
>
>> The LPASS Peripheral loader clocks would be used to bring
>> LPASS out of reset, when this property is present.
>>
> Can you please elaborate on what you mean here?
>
> When this property is set you assume that remoteproc is used to boot the
> LPASS and therefor some clocks should be handled differently?


Yes, you are right, I'll add this to the description.


> This needs to be written in a way that someone outside of your project
> can understand the purpose.
>
>> This is a cleanup done to handle overlap of regmap of
>> lpasscc and lpass_aon blocks. As a part of this, remove
>> the "cc" regmap from lpasscc node.
>>
> "regmap" is an implementation detail, the binding change should describe
> the changes to the representation of the hardware description.


Okay I'll remove the last part from description while re-posting.


> Thanks,
> Bjorn
>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml   | 6 ++----
>>   .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml         | 7 +++++++
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
>> index 47028d7..633887d 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
>> @@ -36,13 +36,11 @@ properties:
>>       items:
>>         - description: LPASS qdsp6ss register
>>         - description: LPASS top-cc register
>> -      - description: LPASS cc register
>>   
>>     reg-names:
>>       items:
>>         - const: qdsp6ss
>>         - const: top_cc
>> -      - const: cc
>>   
>>   required:
>>     - compatible
>> @@ -59,8 +57,8 @@ examples:
>>       #include <dt-bindings/clock/qcom,lpass-sc7280.h>
>>       clock-controller@3000000 {
>>         compatible = "qcom,sc7280-lpasscc";
>> -      reg = <0x03000000 0x40>, <0x03c04000 0x4>, <0x03389000 0x24>;
>> -      reg-names = "qdsp6ss", "top_cc", "cc";
>> +      reg = <0x03000000 0x40>, <0x03c04000 0x4>;
>> +      reg-names = "qdsp6ss", "top_cc";
>>         clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
>>         clock-names = "iface";
>>         #clock-cells = <1>;
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
>> index bad9135..5ccfb24 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
>> @@ -41,6 +41,12 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  qcom,adsp-pil-mode:
>> +    description:
>> +      Indicates if the LPASS would be brought out of reset using
>> +      peripheral loader.
>> +    type: boolean
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -165,6 +171,7 @@ examples:
>>         clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>,
>>                  <&lpasscore LPASS_CORE_CC_CORE_CLK>;
>>         clock-names = "bi_tcxo", "bi_tcxo_ao","iface";
>> +      qcom,adsp-pil-mode;
>>         #clock-cells = <1>;
>>         #power-domain-cells = <1>;
>>       };
>> -- 
>> 2.7.4
>>
