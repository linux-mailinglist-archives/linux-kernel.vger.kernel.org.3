Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787465A92FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiIAJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiIAJUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:20:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E41839C;
        Thu,  1 Sep 2022 02:19:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28194Q5D023183;
        Thu, 1 Sep 2022 09:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FAV0K99sOO+vFi8gDLIlrXCyZVBT3gh3GSY44qD7inw=;
 b=C2UZK0PDFJO1341d6syy4pBy5hGCdEAvVP5GnExk38GP5UC+1VYPm798y1aicfXfzMlv
 hALW9znlamyQngTaJ8kNkElsbepCB/2eHMcwgmyRqQrQyDT7nyJh65ETqzXtwyljQc0n
 YO7Pvt49Nj+o2t75p0fBm4zbDVx9Tz2FsttGEf3Qkk5SmlAPD2OOb5sOeAiG+jNpSz4r
 OsyI2J0wTuCOB7ui1TCedhjuwXNatxiiTJ4H7MQVA0wN3hwwBPvJVlOf2VLeKWG11xBI
 7kogv70DWL1DI2wql3bGCrYAsQ4FYEDGRaFBGg1NxMtHtn9AMy6oyibXm4qn1aG9Y4sc og== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jaeb4sy5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:19:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2819Eii8010871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 09:14:44 GMT
Received: from [10.216.21.166] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 02:14:40 -0700
Message-ID: <7dad556c-f806-01e7-79c1-3841574669c3@quicinc.com>
Date:   Thu, 1 Sep 2022 14:44:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4] arm64: defconfig: Config that had RPMSG_CHAR now gets
 RPMSG_CTRL
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20220826125400.2199429-1-arnaud.pouliquen@foss.st.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220826125400.2199429-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VFWxxMCFFJNTanGnpbJx5ReSYCFlEB1r
X-Proofpoint-ORIG-GUID: VFWxxMCFFJNTanGnpbJx5ReSYCFlEB1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=545
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/26/2022 6:24 PM, Arnaud Pouliquen wrote:
> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
> 
> update from v3 [2]
> - resent after rebase on Linux kernel v6.0-rc2.
> 
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> [2]https://lore.kernel.org/linux-arm-kernel/YpdutV3%2FjOsfPb5c@arm.com/t/
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d5b2d2dd4904..b9e6b17305f6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1093,6 +1093,7 @@ CONFIG_QCOM_Q6V5_PAS=m
>   CONFIG_QCOM_SYSMON=m
>   CONFIG_QCOM_WCNSS_PIL=m
>   CONFIG_RPMSG_CHAR=m
> +CONFIG_RPMSG_CTRL=m
>   CONFIG_RPMSG_QCOM_GLINK_RPM=y
>   CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>   CONFIG_RPMSG_QCOM_SMD=y


LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
