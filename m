Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306ED5AADD4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiIBLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIBLnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:43:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BCABD5F;
        Fri,  2 Sep 2022 04:43:17 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282Ar56Q032761;
        Fri, 2 Sep 2022 11:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aLp+BZ1PXvD5mxih1jnhCtGBuPLETtrHyHpzi8hNqg0=;
 b=MnAPLl4lomiGoWK013zzlavMpV6ZVIvS3C6QG0e40Cb7Bxyv5pIpzy/DFNHweOmlcaXB
 3rCl+Zno8oBfqH1jPp5QDwkP+Gm0V1qySy7PWaii9VLrAdQzHfhsTFATrWcTgbzIqn4h
 Q8S+/4aHYHTpAx+LMEyS5D7CePMx7rKLyEY3962k/C1nsBh3B8Qngzh13q57cidKxxRZ
 Wm7iFO3eSjMYfyYrlsFgPHM7PVG1svEDf4A33AcZu5Tqay6AFEAHPm2LMH5tFAXXnJpF
 c8wtm6X3WTFq3TJzx4mJOzwa1iOOk9lPbhjrnDwtyBnoJAkkBjqSfzcJeD3KHZma8r9r SQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbdqqgq1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 11:42:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282Bgb6S005488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 11:42:37 GMT
Received: from [10.253.35.201] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 2 Sep 2022
 04:42:34 -0700
Message-ID: <88ce066b-632a-d76f-c3d8-d100a96e1f11@quicinc.com>
Date:   Fri, 2 Sep 2022 19:41:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RESEND PATCH v6 08/10] dt-bindings: spmi: spmi-pmic-arb: make
 interrupt properties as optional
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <tglx@linutronix.de>, <maz@kernel.org>,
        David Collins <collinsd@codeaurora.org>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com>
 <1655004286-11493-9-git-send-email-quic_fenglinw@quicinc.com>
 <20220831173631.25C83C43470@smtp.kernel.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20220831173631.25C83C43470@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n5mP76U4vLJyzed3CGThR1P8QNy6nisC
X-Proofpoint-GUID: n5mP76U4vLJyzed3CGThR1P8QNy6nisC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/1 1:36, Stephen Boyd wrote:
> Quoting Fenglin Wu (2022-06-11 20:24:44)
>> From: David Collins <collinsd@codeaurora.org>
>>
>> Make all interrupt related properties as optional instead of
>> required.  Some boards do not required PMIC IRQ support and it
>> isn't needed to handle SPMI bus transactions, so specify it as
>> optional.
>>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>> index 55d379c..fee4f0e 100644
>> --- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>> @@ -88,9 +88,6 @@ properties:
>>   required:
>>     - compatible
>>     - reg-names
>> -  - interrupts
>> -  - interrupt-names
>> -  - '#interrupt-cells'
> 
> Let me clarify my comment on the next driver patch here. It looks like
> we're making the properties optional here so that the driver can choose
> to create or not create the irqchip based on the presence of the
> property. Are there PMIC arbiters that don't have irq support? Or is it
> only that some board designs don't use interrupt support of the PMIC,
> because all the devices that use interrupts on the PMIC aren't enabled
> (status = "okay")?
> 
> We shouldn't get into a situation where we're removing the interrupt
> properties because we want the driver to skip creating the irqchip. That
> makes the binding too loose, where we can't validate existing DT files.
> It also makes it confusing to include the DTS files when the device
> always supports interrupt capabilities, just we don't want to use it.

Thanks for reviewing the changes Stephen.

I discussed with the change author David, he mentioned that these two 
changes were made for supporting trust VM features. In the design, there 
are two SPMI arbiter device instances, one is in non-secure world (with 
Linux Android) and the other is in secure world (with LE), both 
instances use the same SPMI arbiter driver but only the LA system 
handles the interrupt, and the irqchip will not be created for LE system 
to prevent any interrupt being fired and routed to the LA system.

There are actually two other changes in SPMI driver made for the same 
secure VM feature. The driver exports a new API which would translate 
the SPMI address (SID+PID+OFFSET) into the SoC physical register address 
range that handles the SPMI write to the corresponding SPMI registers, 
and the secure system would do some protection on these registers to 
block any SPMI write from non-secure world when the secure feature is 
enabled.

There will be 4 changes related in total, I will send them together with 
a new topic next time and you can help to review them after that.
Thank you!
