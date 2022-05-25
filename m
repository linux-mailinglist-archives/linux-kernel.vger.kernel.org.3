Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A42534078
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbiEYPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiEYPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:37:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D83011175
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:37:09 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PDJY1N020622;
        Wed, 25 May 2022 17:36:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=O1fbynHXZxn47QZYa7EtoOen0o3Zv/2OzioTq8MA5lI=;
 b=KvSV8vitnhgpPfXH0qa6uago2zKPAgMRrR1UCMVeqKPxgV6bFHaP6eiOaf9BJ784zhAT
 zGZZ9rLjsakRuC5A42rsTuuG/g425a+xniK1YlDITzBBCBr8PETzYH2vjSy2yuDDVzkr
 cgZaQwcjDOCuTx1/KCp1kagsnhtEMhj/ODImaq5IoI907+l5zHfSJmqRfycE3UJkGg5g
 O0OdotLU9riCDrGRMqLlRV9N3SCn4HUhb2SUU1My/6uWbLO8BLljMEqJcxv1jp/A1+IP
 f1OKiLg+tiUGMMFEckToy94PNshGw5+gSUmWIg5dYPiz8e1ojDr6+yRkiLEvfporkcTG Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g93ur7d2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 17:36:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6475100034;
        Wed, 25 May 2022 17:36:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 17861237D61;
        Wed, 25 May 2022 17:36:08 +0200 (CEST)
Received: from [10.211.12.178] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 25 May
 2022 17:36:07 +0200
Message-ID: <06f99968-15a5-1138-2151-859b3e68c81d@foss.st.com>
Date:   Wed, 25 May 2022 17:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ASoC: stm32: sai: Remove useless define
Content-Language: en-US
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        <arnaud.pouliquen@foss.st.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220525135023.6792-1-tangbin@cmss.chinamobile.com>
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20220525135023.6792-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 15:50, Tang Bin wrote:
> STM_SAI_IS_SUB_B(x) and STM_SAI_BLOCK_NAME(x) are
> not being used, so remove them.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>   sound/soc/stm/stm32_sai_sub.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index d300605a2..4b33257c5 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -45,8 +45,6 @@
>   #define STM_SAI_B_ID		0x1
>   
>   #define STM_SAI_IS_SUB_A(x)	((x)->id == STM_SAI_A_ID)
> -#define STM_SAI_IS_SUB_B(x)	((x)->id == STM_SAI_B_ID)
> -#define STM_SAI_BLOCK_NAME(x)	(((x)->id == STM_SAI_A_ID) ? "A" : "B")
>   
>   #define SAI_SYNC_NONE		0x0
>   #define SAI_SYNC_INTERNAL	0x1

Acked-by: Olivier Moysan <olivier.moysan@st.com>

Thanks
Olivier
