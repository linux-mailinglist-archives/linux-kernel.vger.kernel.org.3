Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1728758F85F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiHKHaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiHKH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:29:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B374923FF;
        Thu, 11 Aug 2022 00:29:53 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B7MBou019139;
        Thu, 11 Aug 2022 07:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BJGCRmyYQPJGbgLAMygRFr672dkJN7Q+xPPqyqu4g8w=;
 b=NnOzCRBwUkGgo/fj2qVd7xrxv3Vh9wGDU8fNQuZhIfXX9XekUeDD3yTWiNUSS/vi17di
 x1jsT0aculT6QP6qlDhsMFNaJOaRbhWHiG2xCOdT2i/0WIsGJDRXDMwlzxlEkMuWD3jT
 hAQoyYnuXJteHn1lkvR5Rdn2CrBXaDQ/J07zO0xlcx4T3SZLEZuATWfdiEXJePWxRQPm
 ZyIY2K+pHsMd8lXhyz2ac3oFamACDe66MDAjOTGyyPfcJHEmgYAKTvJvxAI0gjeluSMI
 OrNXonm8ln9F9z9Qtt81Z+wvTuLs2VrkNV1yIUwFhbiWowU0asrEXBmN67LOZod7tIPS QA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvsaaghu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 07:29:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27B7T7Zw024814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 07:29:08 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 11 Aug 2022 00:29:07 -0700
Received: from [10.216.37.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 11 Aug
 2022 00:29:02 -0700
Message-ID: <9e8f79c8-466a-91b1-63b6-38c99022e735@quicinc.com>
Date:   Thu, 11 Aug 2022 12:58:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP pil
 loader as generic
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1659611751-7928-1-git-send-email-quic_srivasam@quicinc.com>
 <1659611751-7928-2-git-send-email-quic_srivasam@quicinc.com>
 <20220809183636.GA2158474-robh@kernel.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <20220809183636.GA2158474-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VmOfpVif20bhFYcJLEp--zzOua1HooPC
X-Proofpoint-GUID: VmOfpVif20bhFYcJLEp--zzOua1HooPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_03,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=986 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2022 12:06 AM, Rob Herring wrote:
Thanks for Your time Rob!!!
> On Thu, Aug 04, 2022 at 04:45:44PM +0530, Srinivasa Rao Mandadapu wrote:
>> Rename sdm845 adsp pil bindings to generic name, for using same binings
>> file for subsequent SoCs.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml   | 160 +++++++++++++++++++++
>>   .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 ---------------------
>>   2 files changed, 160 insertions(+), 160 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
> Please use the git-format-patch -M option so I'm not reviewing the whole
> doc again. You also can (and should) change your git config to default
> to this.

Actually here Common dt bindings for SDM845 and SC7280 is not working, 
as it has conflicts with clock headers.

I Would like to revert this patch and create new dt bindings file for 
SC7280 platform.

>
> Rob
