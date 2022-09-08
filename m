Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95D5B20F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiIHOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiIHOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:43:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947BD2777;
        Thu,  8 Sep 2022 07:43:53 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288DZ7Zq016893;
        Thu, 8 Sep 2022 14:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MDFsiyVxKlxb2IykLyL7WXyRlrugQKzQNnjQEfykscY=;
 b=EfFkMrSecf5t2XpVMXNCyESk1zAmeOfkNLOx20YdUqiTd2jf91/stLVX2oIIlGfa8ogo
 FbrcfrRl7ocGsi6exXgUlZRKB8aWDqDrcL1GBdtJ/lBgFgwRpwF86yKlc4TyNyCNhCPz
 0yiWQPNs6ACbcvopo9VsQjDF3y3asMbV6DbZoz9q+ETMEuTuSihgOsFX/ZF9wfbxpNbk
 NT0dRcDoAT+vuhfQDgtIrptpjoKd8QqO5+HuoDXx0FjzOiXmxwdbwZns4ZI6onVkUDD6
 gZ8ivQ5LRS5o+8Bn+MGvHLjJNDh35qiG74nlnS8JYmdIs14AWP4oJbTTik9vlW0noe/F Mw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfdc70tu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 14:43:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288Ehggm009612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 14:43:43 GMT
Received: from [10.216.56.128] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 07:43:40 -0700
Message-ID: <0b0da58e-7281-32e7-2aab-8a89c70ba574@quicinc.com>
Date:   Thu, 8 Sep 2022 20:13:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] drivers/remoteproc: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220908123237.16911-1-wangjianli@cdjrlc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220908123237.16911-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ht1DqY_iwPNB2DiDz-6jDy_pZ4XZ6YIE
X-Proofpoint-ORIG-GUID: Ht1DqY_iwPNB2DiDz-6jDy_pZ4XZ6YIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080053
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/8/2022 6:02 PM, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>   drivers/remoteproc/remoteproc_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e5279ed9a8d7..6e8849f0df18 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -346,7 +346,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>   		if (rproc_check_carveout_da(rproc, mem, rsc->vring[i].da, size))
>   			return -ENOMEM;
>   	} else {
> -		/* Register carveout in in list */
> +		/* Register carveout in list */

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
>   		mem = rproc_mem_entry_init(dev, NULL, 0,
>   					   size, rsc->vring[i].da,
>   					   rproc_alloc_carveout,
