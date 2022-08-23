Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7E259EE40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiHWVcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHWVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:32:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F3F65839;
        Tue, 23 Aug 2022 14:32:13 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NLW7bS011625;
        Tue, 23 Aug 2022 21:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h0aO62+G+YfcVYCThJzkvFqcAo2TIB8hzkh/wXB67Fk=;
 b=Ehj15mU2m4+GO7Cr41oSHXS/zytgF+n2ZuJBz+mIHV+BhWWov4oLfK0836ME/istwzim
 m0nWwCt2vn+9C3yJQVweMV0NM8JF55MkRBw/vZFufGqHJ84Vx1EFi0LldE8O6JAwmwtO
 d1FzTG0unf8UsbzUF2D1+VAWQ7ShgT0CH91LnbJmT4ircH1XLB9AVoGz1BTHTqDj2Eor
 dgAWmY5fRT00/1n7AkjrTT5gf9CN17qs0zubbV/PG2MfhpQJoqHAPEDxQeSSwmEm382S
 qxlpVb6P2O8jgcN1cjgnb7cLU+X9timIDH7mwRQ3oS/q0Nlo5opdNKycH3M6/jyMFMa6 hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pjgtj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 21:32:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27NLW5ug018321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 21:32:05 GMT
Received: from [10.216.10.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 14:32:00 -0700
Message-ID: <d67c4007-5d76-71e3-265f-701951be311a@quicinc.com>
Date:   Wed, 24 Aug 2022 03:01:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 5/6] dt-bindings: drm/msm/gpu: Add optional resets
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1660927246-11327-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220819221017.v4.5.Ieffadd08a071a233213ced4406bf84bb5922ab9a@changeid>
 <e8a02030-d114-fa4b-1978-15327501b7e9@linaro.org>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <e8a02030-d114-fa4b-1978-15327501b7e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VfNAwgDg6H3IO-xF8qFb4dY-up1gInch
X-Proofpoint-GUID: VfNAwgDg6H3IO-xF8qFb4dY-up1gInch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/2022 4:41 PM, Krzysztof Kozlowski wrote:
> On 19/08/2022 19:40, Akhil P Oommen wrote:
>>   Documentation/devicetree/bindings/display/msm/gpu.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> index 3397bc3..4576b31 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> @@ -109,6 +109,13 @@ properties:
>>         For GMU attached devices a phandle to the GMU device that will
>>         control the power for the GPU.
>>   
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: cx_collapse
>> +
> Just one blank line, not two. You can keep Rob's ack with that change.
Sure.

-Akhil.
>>   required:
>>     - compatible
>
> Best regards,
> Krzysztof

