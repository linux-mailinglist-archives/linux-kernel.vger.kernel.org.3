Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C659310C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiHOOx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiHOOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:53:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654BA19C01;
        Mon, 15 Aug 2022 07:53:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FBuiPC018423;
        Mon, 15 Aug 2022 14:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=leuB2TllawcOxoVe7P41dJgowaB/d3bn/6ayhMIUrns=;
 b=gRPJV7LB1m43H6CfjhcgavoN1asJ9Te0FKjfMme4eJGwrkawDQGVFP5g54DWmnA1ZZR3
 XLBx6AlcvxK8giyp9ydU/HipuJkcr4h8Xnhp8/K9o0maM4JjIB1pOF2Hu9Bwlsb/K74b
 JiQ988a4h0pLHs17vDHcFy/cmR3xu5JjqLAUcIVhG/MpyY2G9QZC9N/bWT3MAnJm0l9U
 xPrEtBE7sVFxz+wafpfKgu07WqTT3F0u6wY6IBzZHIvs4liOCZg5jfNVyu59T3TSyfRk
 niAJBbjb38iyUZfJwRkrBwdrDHraeEiHvTINAcAjjKJg6qywWWTTmKEBZNP9+7JxiOfS jw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx1audnsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:53:25 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FErOcx030966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:53:24 GMT
Received: from [10.216.30.233] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 15 Aug
 2022 07:53:20 -0700
Message-ID: <99b85bdb-3366-a266-35d8-f856c2677008@quicinc.com>
Date:   Mon, 15 Aug 2022 20:23:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: fix argument 2 of
 rproc_mem_entry_init
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1660567398-24495-1-git-send-email-shengjiu.wang@nxp.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1660567398-24495-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oSY_hWj6CM9UYg5xG3Jbu6jYj7_hq4vy
X-Proofpoint-ORIG-GUID: oSY_hWj6CM9UYg5xG3Jbu6jYj7_hq4vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/15/2022 6:13 PM, Shengjiu Wang wrote:
> There are sparse warning:
> drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
> drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     expected void *va
> drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr
> drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
> drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     expected void *va
> drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr
> 
> Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>   drivers/remoteproc/imx_dsp_rproc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index ca0817f8e41e..899aa8dd12f0 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -599,7 +599,7 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
>   		}
>   
>   		/* Register memory region */
> -		mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)att->sa,
> +		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)att->sa,
>   					   att->size, da, NULL, NULL, "dsp_mem");
>   
>   		if (mem)
> @@ -635,7 +635,7 @@ static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
>   		}
>   
>   		/* Register memory region */
> -		mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)rmem->base,
> +		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)rmem->base,
>   					   rmem->size, da, NULL, NULL, it.node->name);
>   
>   		if (mem)

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
