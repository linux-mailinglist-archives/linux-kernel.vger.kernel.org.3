Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C759A363
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354494AbiHSRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351022AbiHSRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:25:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA054A839;
        Fri, 19 Aug 2022 09:44:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JF9vGx002286;
        Fri, 19 Aug 2022 16:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GtJ4fiAXcF1nuHF+341AhR1Z8kc+y5XsUhmSuM+SNWI=;
 b=SN21T1oFreUxbl2+DeAP/z7JXQG2z2p5jzVI/4etDJwnmhC01cl4SPFHLKaNjly9pe/D
 Cmy3vbr88Km+34PAp2q/elx0YbnTIwUOGr0scmszhjUfrweGwPWpScD8dYbaDrzp1Ori
 FInrif5KtiAtW5vUn57FgKbfsunIyPqmtAKYLATJL3MLcIFOaCpkcITID78l4fzQrwwo
 1koi8o8MAj27b4FXaHPmKEH7PekySEGu1uxRTa29O6eiNNQU2vRWSXnB9P5uto/HEEa6
 TGmWw1FUB00nYbZo4P84tEj2KBDybcillhUZ5s5V/G48Lw7JGQOE82s253+BiYz9nAn6 FQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2bu7ghg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 16:43:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27JGhP6j010224
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 16:43:25 GMT
Received: from [10.216.8.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 19 Aug
 2022 09:43:20 -0700
Message-ID: <eb18b9ce-95c2-a7a1-7429-57b82cc70de8@quicinc.com>
Date:   Fri, 19 Aug 2022 22:13:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sc7280: Add Reset support for
 gpu
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1660853919-987-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220819014758.v3.5.I6a1fca5d53c886c05ea3e24cd4282d31c9c0cd0b@changeid>
 <0cdca889-1193-1595-e524-5a0cfc633d14@linaro.org>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <0cdca889-1193-1595-e524-5a0cfc633d14@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dd6w9iYiMKaBSkVittxn115KEOQ2O4cM
X-Proofpoint-GUID: dd6w9iYiMKaBSkVittxn115KEOQ2O4cM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/2022 11:47 AM, Krzysztof Kozlowski wrote:
> On 18/08/2022 23:18, Akhil P Oommen wrote:
>> Add support for Reset using GPUCC driver for GPU. This helps to ensure
>> that GPU state is reset by making sure that CX head switch is collapsed.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>
>> (no changes since v1)
>>
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index e66fc67..f5257d6 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2243,6 +2243,9 @@
>>   			nvmem-cells = <&gpu_speed_bin>;
>>   			nvmem-cell-names = "speed_bin";
>>   
>> +			resets = <&gpucc GPU_CX_COLLAPSE>;
>> +			reset-names = "cx_collapse";
>> +
> I think this is not allowed by bindings. Did you test your change with
> dtbs_check?
>
> Best regards,
> Krzysztof
My bad! Thanks for pointing this out. Fixed in v4 with patch 5/6.

-Akhil.
