Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F695B131D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIHEBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHEBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:01:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27303CAC60;
        Wed,  7 Sep 2022 21:01:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2883oR2b014005;
        Thu, 8 Sep 2022 04:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kJBLT2+zrYtiO5ltSxXKAVs/CvkF+GrLAMeVdzzKsVs=;
 b=ZJXs6T5th/Vpr3rPgI/Nm+qOkhq2rpivMImGVLMR3M/aNxrizW/orDbnTQHfils4hOk3
 P6i5H9eq2QhbCC4MB/sBn39vqx/AsXoHxujS3Na7pIj92JzEVuoHarcpDIisaFEw6KwS
 SNI6LwpQwWdXvR+Lvi1H+5rj0189cOvyxxEugvSzDAGP0ewrhnHkoHcKi3WqXGh1MLmA
 IG6Xo/nxVmMul4P+B60BpfZa7cYPZql8jE7jLTbkoqjxelusYX5zEBM/859PpXEh24rq
 x5a8i5oKsbsNRakenwOeyA8TD2FK+SSm3n95Awzm79W1RW5GL3AZ48NQbb5DaGxgjTtA Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jeahhddby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 04:01:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28840wwG020822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 04:00:58 GMT
Received: from [10.50.32.28] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 21:00:54 -0700
Message-ID: <6afb53e1-0d1e-1665-d354-f3b270c8b62e@quicinc.com>
Date:   Thu, 8 Sep 2022 09:30:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Fix Dmic no sound on
 villager-r1
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
CC:     Judy Hsiao <judyhsiao@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20220826065621.2255795-1-judyhsiao@chromium.org>
 <CAD=FV=VrgrvJb_sJ8AO6pN8dRNXzzOJ9WvngeJrtVYw_wD1Akg@mail.gmail.com>
 <Yw07xSlVpQcXDqe7@google.com> <Yxi8vnmtowA83WLm@google.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <Yxi8vnmtowA83WLm@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y2EWZK7KAWWRpPrBSP4dmaOR73SgkuAR
X-Proofpoint-ORIG-GUID: Y2EWZK7KAWWRpPrBSP4dmaOR73SgkuAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_02,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 spamscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080012
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,


On 9/7/2022 9:16 PM, Matthias Kaehlcke wrote:
>
>> Add support for audio clock gating resets for SC7280 (v8)
>> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=671887
>>    ready to land? (patch 2 has a minor comment about SoB tag)
> The comment has been addressed in v9:
>
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=673055
>
> So it seems all the audio bits should be ready to land.
>
> Satya: please make sure to include change logs in all future patches to
> help reviewers understand what changed in each version.


I have added the change log in the cover letter, I'll add it to all the 
patches of series from next time.


Thanks,

Satya Priya

