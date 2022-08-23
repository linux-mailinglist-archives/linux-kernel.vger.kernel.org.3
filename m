Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E1859E7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245169AbiHWQnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbiHWQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:41:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27DAE2C7F;
        Tue, 23 Aug 2022 07:36:27 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NDMwqx020875;
        Tue, 23 Aug 2022 14:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6fn2CweGoHgya+2f7Ycyc4pUnLkSVsKXAd7bStPGUB8=;
 b=j9BLx1ZLu3wpqeSX9ENgRVONBz2+SATIc0x6R9vKU3PyybRIJ9LoOQe5x8E9krx8LMnK
 MDqMfkUsPOv68t8QmR5PFYyvZlnjFUOfwSzHo2zdBawfk7+2IsI9by8MoMYn/NJpvx23
 l8P6n5HvrBR969aoOjyx+286KzUF/DecT4hBVpLu9djQpdoUblYHN4/r5KZaEz6P7/jR
 qFpaJYoMCPklTS0e46nLnnljq4o9dfmdrmMp2DhxXNsW5vOyDkPFG0EoiQI67mE7oy/L
 xv57jN9u4vythO++GNz7qAjbPLkNLohCpUhoENtw/hpXxtbjF2uNGUCN5HQftr3NO+ZH TA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4t6xt2ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 14:35:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27NEZhAL018905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 14:35:43 GMT
Received: from [10.216.11.8] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 07:35:37 -0700
Message-ID: <5346e9c8-847d-d39e-5fe9-fbc393bcd57d@quicinc.com>
Date:   Tue, 23 Aug 2022 20:05:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND v5 3/7] remoteproc: qcom: Add compatible name for SC7280
 ADSP
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bgoswami@quicinc.com>, <bjorn.andersson@linaro.org>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <judyhsiao@chromium.org>, <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
 <1661156523-22611-4-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52iLf0R0ovrpzMs0jp_Ty-RsONy0gcUvDsBvCz38R1fWw@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n52iLf0R0ovrpzMs0jp_Ty-RsONy0gcUvDsBvCz38R1fWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oT9_wJEsHpKdwh59s5YAJVVVxdKYY8oh
X-Proofpoint-ORIG-GUID: oT9_wJEsHpKdwh59s5YAJVVVxdKYY8oh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/23/2022 8:35 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-08-22 01:21:59)
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index d0b767f..6d409ca 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -701,6 +701,22 @@ static const struct adsp_pil_data adsp_resource_init = {
>>          },
>>   };
>>
>> +static const struct adsp_pil_data adsp_sc7280_resource_init = {
>> +       .crash_reason_smem = 423,
>> +       .firmware_name = "adsp.mbn",
>> +       .load_state = "adsp",
>> +       .ssr_name = "lpass",
>> +       .sysmon_name = "adsp",
>> +       .ssctl_id = 0x14,
>> +       .is_wpss = false,
> This can be left out, it's the default.
Okay. Will remove it and re-spin the patch.
>
>> +       .adsp_sandbox_needed = true,
>> +       .auto_boot = true,
>> +       .clk_ids = (const char*[]) {
>> +               "gcc_cfg_noc_lpass", NULL
>> +       },
>> +       .num_clks = 1,
