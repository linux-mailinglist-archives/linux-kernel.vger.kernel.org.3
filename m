Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A4B58E672
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiHJEiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHJEix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:38:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C41785BC;
        Tue,  9 Aug 2022 21:38:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A3LlZY008854;
        Wed, 10 Aug 2022 04:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8CCKMKUDEkkgwAPeru2SlBoysIQo+FYrwolDljJHCLM=;
 b=mEvR1VZABFpkSdUkakfpDg43lWPPBD3rozFyv+RciJTxBv2dbk2wld8A2r+YnAWdpkit
 2XdjP5BCIoJJFxjH8/u3ZqU1gKPl7P1ypDQVNAg7zEVAjuARW1BVvx7VHYb9wRGm0w2r
 bpX/+LVVGzIF89amVHEHnJ8rKbapYO6ltdTuyrlgnSVvzzDXPxx0xNTtUlt8zwRr7JLi
 /5nVntAE71TGSZp8M+61TADDXyHwucYYnqXg4Xz5gzS7JXI4k8eB0LgIGDV8MRBMJ9HF
 gQRl6XmkcIlVB63633E+LPWyg5ULTV14b8AvASUA2MujPnk3rYOG0Hr/i3Zkq7VBG5tG kQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwra16sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 04:38:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A4ciSL017406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 04:38:44 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 21:38:44 -0700
Received: from [10.50.1.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 21:38:40 -0700
Message-ID: <8b75f110-9c36-8a02-5c98-f638ec6a878e@quicinc.com>
Date:   Wed, 10 Aug 2022 10:08:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4 1/3] arm64: dts: qcom: sc7280: Cleanup the lpasscc node
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>
References: <1660026909-7365-1-git-send-email-quic_c_skakit@quicinc.com>
 <1660026909-7365-2-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52t0MPDxGQNEdhNaqOBhUhr8FBew_cuEwmruN12k4f15A@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n52t0MPDxGQNEdhNaqOBhUhr8FBew_cuEwmruN12k4f15A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DodwyBeyljnxpgxcJrCNlKMdnQNNA6Xd
X-Proofpoint-GUID: DodwyBeyljnxpgxcJrCNlKMdnQNNA6Xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/2022 10:04 PM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-08-08 23:35:07)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 13d7f26..71735bb 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2168,9 +2168,8 @@
>>                  lpasscc: lpasscc@3000000 {
>>                          compatible = "qcom,sc7280-lpasscc";
>>                          reg = <0 0x03000000 0 0x40>,
>> -                             <0 0x03c04000 0 0x4>,
>> -                             <0 0x03389000 0 0x24>;
>> -                       reg-names = "qdsp6ss", "top_cc", "cc";
>> +                                 <0 0x03c04000 0 0x4>;
> This looks oddly tabbed out? I'd expect it to align with the first reg
> property, so be unchanged.


Okay, I will correct the tabbing. But this wouldn't remain unchanged 
because the comma is being replaced by semi-colon.


>> +                       reg-names = "qdsp6ss", "top_cc";
>>                          clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
>>                          clock-names = "iface";
