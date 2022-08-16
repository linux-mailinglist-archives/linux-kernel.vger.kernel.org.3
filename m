Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13DD5959A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiHPLPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiHPLOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:14:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3778CABD6A;
        Tue, 16 Aug 2022 02:53:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G8NjSa003123;
        Tue, 16 Aug 2022 09:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dR/uvLs6SiwPEgsqsis5avHAdp7Zj1BQdn9EYbxX6NM=;
 b=ay6d4TjFdW1k3vlXkHbZZlKeiRL7Y1DVQ+uNbgJU07e/OmQwPpB8vuLOc+KIqR+GDNIt
 sS6ONLnAbQ+TF3Y5eImFs/DfCABP8LmOuNHRuXHxql//dj4yjJtP5q72mSHvllBLFJv0
 ajUeMEnAT8/eMBhq+TtxFcD+SlQfCoc+0oEQ6VFF/qrGLxcx7354ta+QPr3sDljn41BJ
 4h+1rNk7dWob939LaGfWg0CCDOP7CTAiX6Gw85aoz3navYDpCUndU9W7OaoMaGYZN8YF
 xrasAWNvUZSd31/3B7PI0M6IkPzbChHYe3bLQt9xOc4O1mywS1dm3XbCwjiTcYnsXLiP gw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j06wr0c60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:53:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27G9r57Y001431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:53:05 GMT
Received: from [10.216.49.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 02:52:58 -0700
Message-ID: <b9c56267-05f8-04ac-405c-bd3dca9f0add@quicinc.com>
Date:   Tue, 16 Aug 2022 15:22:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP pil
 loader as generic
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <bjorn.andersson@linaro.org>, <agross@kernel.org>,
        <quic_plai@quicinc.com>, <linux-remoteproc@vger.kernel.org>,
        <robh+dt@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <quic_rohkumar@quicinc.com>, <bgoswami@quicinc.com>,
        <swboyd@chromium.org>, <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <judyhsiao@chromium.org>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
 <1660117558-21829-2-git-send-email-quic_srivasam@quicinc.com>
 <20220814204505.GA677523-robh@kernel.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <20220814204505.GA677523-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3VhQ6nOFnHdI4jGJYBLjMSx8Hq2May52
X-Proofpoint-GUID: 3VhQ6nOFnHdI4jGJYBLjMSx8Hq2May52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=880 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/15/2022 2:15 AM, Rob Herring wrote:
Thanks for Your time Rob!!!
> On Wed, 10 Aug 2022 13:15:51 +0530, Srinivasa Rao Mandadapu wrote:
>> Rename sdm845 adsp pil bindings to generic name, for using same binings
>> file for subsequent SoCs.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>> Changes since V2:
>> 	-- Generate patch with -M flag.
>>
>>   .../{qcom,sdm845-adsp-pil.yaml => qcom,lpass-adsp-pil.yaml}           | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>   rename Documentation/devicetree/bindings/remoteproc/{qcom,sdm845-adsp-pil.yaml => qcom,lpass-adsp-pil.yaml} (97%)
>>
> Reviewed-by: Rob Herring <robh@kernel.org>
This patch dropped in consequent series. Please ignore this patch.
