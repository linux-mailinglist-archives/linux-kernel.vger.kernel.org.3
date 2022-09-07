Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329675B0E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIGU22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIGU20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:28:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABFC12FB;
        Wed,  7 Sep 2022 13:28:25 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287CsQoT027894;
        Wed, 7 Sep 2022 20:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VTYnbFfItbD2eeVt8XMypC5FTJdGeIjzqhO7xjMlzVA=;
 b=Alu5oe3DPqO0JOeSwj1rptTpY7lDqsjHt7majaTACid4yIZxRoaJgj6R+h0Xjx3gtEvg
 E0ODkCiG92wgVwqzzAJ+NR4d86fSPfjWClHqExvtxyYdP+VohI4XEhM13y3ywXv7vJYe
 XXKMz/sge3Xsv6eiL2lyfVg2n5JQxKWpmNdpQCwyy0fpN7zbvltfYHkCsh60Unr94093
 XlchvTUzxlRAtyZ7B7Erzwq54SjfA4cpQMH3TbDiVp+RXHb2oVMEMoZLHcJlVmpyPb0C
 H7eapD2yi+fvJuNfzr+9XnIgP8iQ6x6m7+E2+hAxef2kjT4fPQQXNRPYG/m72DRmVUn/ NA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jer7njm58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 20:28:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287KSLoN004646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 20:28:21 GMT
Received: from [10.110.115.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 13:28:20 -0700
Message-ID: <b9f7be44-1857-2598-c9c1-a2888889daef@quicinc.com>
Date:   Wed, 7 Sep 2022 13:28:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] power: reset: qcom-pon: add support for
 qcom,pmk8350-pon compatible string
Content-Language: en-US
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220725191314.19456-1-quic_amelende@quicinc.com>
 <20220725191314.19456-3-quic_amelende@quicinc.com>
 <57f8d9c4-6f49-ad3d-fc82-7a0f66d1775a@linaro.org>
 <f9853511-e64c-9daf-b4e3-e334035771a8@quicinc.com>
In-Reply-To: <f9853511-e64c-9daf-b4e3-e334035771a8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VGk2XdNINz_mwVWts4StFVS3G2GgBh3v
X-Proofpoint-GUID: VGk2XdNINz_mwVWts4StFVS3G2GgBh3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070076
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Wanted to send a reminder for this patch conversation.

Thanks,
Anjelique

On 8/19/2022 1:26 PM, Anjelique Melendez wrote:
> 
> 
> On 7/26/2022 3:27 AM, Krzysztof Kozlowski wrote:
>> On 25/07/2022 21:13, Anjelique Melendez wrote:
>>> Add support for the new "qcom,pmk8350-pon" comptaible string.
>>>
>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> ---
>>>  drivers/power/reset/qcom-pon.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
>>> index 4a688741a88a..16bc01738be9 100644
>>> --- a/drivers/power/reset/qcom-pon.c
>>> +++ b/drivers/power/reset/qcom-pon.c
>>> @@ -82,6 +82,7 @@ static const struct of_device_id pm8916_pon_id_table[] = {
>>>  	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
>>>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>>>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
>>> +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
>>>  	{ }
>>>  };
>>>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
>>
>> This is now confusing. The new device has entirely different first and
>> second IO address spaces, but you do not code here any differences.
>>
> 
> Based on previous responses to this patch series, it was decided that a new
> "qcom,pmk8350-pon" compatible string is needed to differentiate between gen1/gen2
> vs gen3 children pon devices. Currently the child handles obtaining the register
> address(es) from its parent's regmap in drivers/input/misc/pm8941-pwrkey.c
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/misc/pm8941-pwrkey.c?h=v6.0-rc1#n287).
> The patch that handled that change can be found at
> https://lore.kernel.org/linux-arm-msm/20220422191239.6271-4-quic_amelende@quicinc.com/.
> 
> This driver, as the parent, does not actually need any changes besides adding the
> new parent compatible string. Specifically this driver handles reboot mode support.
> Everything needed to handle reboot mode is in the first register and reboot mode
> is handled the same as a "qcom,pm8998-pon" parent. The split of the pon register
> in pmk8350 does not affect reboot mode. This is why before we added a new compatible
> string "qcom,pm8998-pon" still worked for gen3 children devices. Even though 2
> registers could be defined in the device tree, as a 2nd register is optional for gen3
> children devices,the fact that this driver uses of_property_read_u32() will ensure that
> the base address used for reboot mode comes from the first register.  
> 
> I do understand that this can be confusing but since "qcom,pmk8350-pon" still needs the
> shift reason = 1 we could do
> 
>         #define GEN1_REASON_SHIFT		2
>         #define GEN2_REASON_SHIFT		1	
>    +    #define GEN3_REASON_SHIFT		1
>  
>   	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
>   	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>   	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
>    +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN3_REASON_SHIFT },
>  	{ }
> 
> 
> It would still have the exact same functionality but it may visually make more sense.
> 
> 
> Thanks,
> Anjelique
> 
