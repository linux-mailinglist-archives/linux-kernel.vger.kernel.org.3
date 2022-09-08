Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F305B2411
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIHQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiIHQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:56:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F376E69F5A;
        Thu,  8 Sep 2022 09:55:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288DxiM8000402;
        Thu, 8 Sep 2022 16:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Zb2Vyqb8iMaiwwbB1NgqnHc10eroVhqKB9x097YjH88=;
 b=IUJmGAY3GCy7/JDL2YZG5hyjTnjQAnP720VvPMfD2d+bgDHRWwpruEcXu4NQejj1ItVN
 zL1U8zXnWd6utaC3+zM3VWDP1SGRpqbLv1d++vkzzgwsT17l/jLCcT8xtxIlHk8gkUyl
 Ml5gCEORhLDkVHv89hhoFKIo0GsKuLGJkZ3/tagW0tp5ZDJITvrcm91LoM5rzfsHARdq
 M6wcy2SEcXV4rRR14+OsueCWph9onNVtMQeu8u2CRSOQpxB+1g8gjqPc+d2bLZQBAiNz
 u3RctxnkGwNNrCmsknXgN7f86io+T/kaANR2wjRVZVfCHg4klp9bmREujKPW5qXFci3x 6g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf1swu1jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 16:55:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288GtMAP005128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 16:55:22 GMT
Received: from [10.110.115.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 09:55:21 -0700
Message-ID: <3a772604-e14c-2399-de49-dbabf5f3ee09@quicinc.com>
Date:   Thu, 8 Sep 2022 09:55:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] dt-bindings: qcom-pmic-gpio: Add PM7250B and PM8450
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220907201528.9351-1-quic_amelende@quicinc.com>
 <20220907201528.9351-5-quic_amelende@quicinc.com>
 <70f262d5-8d78-1c9a-2491-106af668f81a@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <70f262d5-8d78-1c9a-2491-106af668f81a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qHJpNJt54oAUTfohzoXwz0KxUWIbRZEf
X-Proofpoint-ORIG-GUID: qHJpNJt54oAUTfohzoXwz0KxUWIbRZEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=994
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080060
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2022 4:13 AM, Krzysztof Kozlowski wrote:
> On 07/09/2022 22:15, Anjelique Melendez wrote:
>> Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
>> to include compatible strings for PM7250B and PM8450 PMICs.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> index 694898f382be..a548323e54f1 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> @@ -24,6 +24,7 @@ properties:
>>            - qcom,pm6150-gpio
>>            - qcom,pm6150l-gpio
>>            - qcom,pm6350-gpio
>> +          - qcom,pm7250b-gpio
>>            - qcom,pm7325-gpio
>>            - qcom,pm8005-gpio
>>            - qcom,pm8008-gpio
> 
> This is incomplete. You need to update allOf.
ACK - will add for next version
> 
> Best regards,
> Krzysztof
