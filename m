Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382453E77A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiFFNd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiFFNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:33:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C341A7D31;
        Mon,  6 Jun 2022 06:33:52 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256DBY7X017132;
        Mon, 6 Jun 2022 13:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NyTJDh7PPGeAi5t+/Wm1kKgWU3Azl2FjpYMzUs8x3NU=;
 b=dz7hZx3MIIEX6kGUhwj1jlHdHYB73K+uBQSlgQsTRMJTa7SOG8dqBNKCCeqguLBI9bxl
 B4bTptLslLiffnxGfuJKxdkR0cwq7xNa4JBH3pVDCik579u8a2cxzZCZgbx4xKUmfCbH
 it3+n//HFSxLOzXVMUn3Nw35UiihbkQ/vHjvh1ojF2qUM4FRiPLjXChnLzr/8u8JiV0l
 GtYGShP50E5al0fhNkPWyHN8/PMKvUVWRquT29mkdEFQE1szyJx7WwFGBz/SrojwmSkd
 pifKVXFWWysmVx+O8mmuk0TEko0D4OU+c0cf1gtIoRPs7P//Xb/kv6U3zM3UEShVPYsc bQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gg2070u69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 13:33:27 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 256DKAMC015353;
        Mon, 6 Jun 2022 13:33:27 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3gfy19du2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 13:33:27 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 256DXQC836766058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 13:33:26 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 260EEBE05F;
        Mon,  6 Jun 2022 13:33:26 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E926BE053;
        Mon,  6 Jun 2022 13:33:25 +0000 (GMT)
Received: from [9.160.184.8] (unknown [9.160.184.8])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 13:33:25 +0000 (GMT)
Message-ID: <bc88300d-9321-e4f6-4215-1754fa3a0444@linux.ibm.com>
Date:   Mon, 6 Jun 2022 08:33:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] hwmon: (occ) Delete unnecessary NULL check
Content-Language: en-US
To:     Ziyang Xuan <william.xuanziyang@huawei.com>, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, penberg@kernel.org,
        akpm@linux-foundation.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220606131401.4053036-1-william.xuanziyang@huawei.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220606131401.4053036-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -aXpynAMbtfUyqlf4LawYpHQQCSLItl8
X-Proofpoint-GUID: -aXpynAMbtfUyqlf4LawYpHQQCSLItl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060062
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/22 08:14, Ziyang Xuan wrote:
> kvfree(NULL) is safe. NULL check before kvfree() is not needed.
> Delete them to simplify the code.
>
> Generated by coccinelle script:
> 	scripts/coccinelle/free/ifnullfree.cocci


Thanks for the patch!

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>   drivers/hwmon/occ/p9_sbe.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 42fc7b97bb34..01405ae2f9bd 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -55,8 +55,7 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
>   	mutex_lock(&ctx->sbe_error_lock);
>   	if (!ctx->sbe_error) {
>   		if (resp_len > ctx->ffdc_size) {
> -			if (ctx->ffdc)
> -				kvfree(ctx->ffdc);
> +			kvfree(ctx->ffdc);
>   			ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
>   			if (!ctx->ffdc) {
>   				ctx->ffdc_len = 0;
> @@ -171,8 +170,7 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>   	ctx->sbe = NULL;
>   	occ_shutdown(occ);
>   
> -	if (ctx->ffdc)
> -		kvfree(ctx->ffdc);
> +	kvfree(ctx->ffdc);
>   
>   	return 0;
>   }
