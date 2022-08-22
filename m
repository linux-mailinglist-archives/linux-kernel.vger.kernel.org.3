Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9403259C293
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiHVPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiHVPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:21:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4CFEB;
        Mon, 22 Aug 2022 08:15:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEN4Tk026992;
        Mon, 22 Aug 2022 15:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ziRHlhdWOqB3+OcKTt2N/6sWF1VDetC0OT1u7hEIOGI=;
 b=YRHiTHehj4Ezf7pXiUctS2ySmleIQdi8iDaVyYjfqKu+En0ejS2hNJNm9uYYqPRSjldF
 87346CxoG81u4HzOY5VAtiROHUAdcmo9wOlNymuTM/yZdFDX9f/30a0g6mI10u7wGLMu
 GC6g/XPyY6FBZb4gd0RuWa47Xx1JcZPyECBRmcX8Ch4ybMlpvOoT0IIBiO8T9vPLWTIJ
 +8mlXNNy/ki5BkwhKctwjCvUl2rpMqUmSrX3notZG68A0a5ZmHFy0hTA8HAa3LJNqqTr
 FaZ5QAlsxs0fPQGckb+bNINrKiwnrM9jRz7GkOctcQdR/TPrL7pFVVoVVSfcRUVJCwWi dQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwn4ude-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:14:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27MFEev4021733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:14:41 GMT
Received: from [10.110.115.186] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 22 Aug
 2022 08:14:40 -0700
Message-ID: <79580753-6290-2da4-2949-c408333b8af5@quicinc.com>
Date:   Mon, 22 Aug 2022 08:14:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] soc: qcom: qmi: use const for struct qmi_elem_info
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220822151146.30366-1-quic_jjohnson@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220822151146.30366-1-quic_jjohnson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _HXF-9hDe2ZBCeh-WdCIq9iSkEEBYFEZ
X-Proofpoint-ORIG-GUID: _HXF-9hDe2ZBCeh-WdCIq9iSkEEBYFEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=644 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore this, rookie git send-email mistake

On 8/22/2022 8:11 AM, Jeff Johnson wrote:
> Currently all usage of struct qmi_elem_info, which is used to define
> the QMI message encoding/decoding rules, does not use const. This
> prevents clients from registering const arrays. Since these arrays are
> always pre-defined, they should be const, so add the const qualifier
> to all places in the QMI interface where struct qmi_elem_info is used.
> 
> Once this patch is in place, clients can independently update their
> pre-defined arrays to be const, as demonstrated in the QMI sample
> code.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> 
> v2:
> Added missing const to skip_to_next_elem() return type
> Reported-by: kernel test robot <lkp@intel.com>
