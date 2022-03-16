Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F24DAF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355599AbiCPMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiCPMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:14:08 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892142BF9;
        Wed, 16 Mar 2022 05:12:52 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GAMqwg029508;
        Wed, 16 Mar 2022 12:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=JmMrDY3qgcfdrpFWCQo1xrngGV3/hBkNB6odRhoB4NE=;
 b=Zax3xgntGE8whhL8gfqHR5Dr1sDIl7QclHno9/U5YXqWVibKwgaqMBlqowLDCHsNETUF
 F92Sk7k8um+E+aIq2jRkMQzMWhX47xGfoJsHZE/rVvpQ1Zyxn5SetgW7NXn3r4u0Sich
 6p9Ul9fD0Lt1Ddux6VJx7vMxhcrC07oy5ypaxxH23kuw4kZYE/jgpKMEEkhzyUAzlNUz
 2kBp32Y3e3QTn4ai6QvUjYvgKB4xzTOQ1Iz29QdMCHV/UUHGWRCNhcYoLeBEJSiobevN
 7U6OwtH4AS1+cayDZ9IigFenJ0X/eS9ox26ZnQ9vg1A/0JAvIlX7v+OJbcvZNjw+9YoP fw== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eue3ds62f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 12:12:48 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 5EE8D5C;
        Wed, 16 Mar 2022 12:12:46 +0000 (UTC)
Received: from hpe.com (unknown [10.207.164.19])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 6995E48;
        Wed, 16 Mar 2022 12:12:45 +0000 (UTC)
Date:   Wed, 16 Mar 2022 07:12:44 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: sgi-gru: Fix spelling mistake "unexpect" ->
 "unexpected"
Message-ID: <20220316121244.GA30540@hpe.com>
References: <20220315222253.2960047-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315222253.2960047-1-colin.i.king@gmail.com>
X-Proofpoint-ORIG-GUID: coJvM7KnAKxBLN-u04jNGiD9bnwGAGCT
X-Proofpoint-GUID: coJvM7KnAKxBLN-u04jNGiD9bnwGAGCT
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 clxscore=1011 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203160076
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dimitri Sivanich <sivanich@hpe.com>

On Tue, Mar 15, 2022 at 10:22:53PM +0000, Colin Ian King wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/misc/sgi-gru/grukservices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
> index 0ea923fe6371..19dbdad8ad8a 100644
> --- a/drivers/misc/sgi-gru/grukservices.c
> +++ b/drivers/misc/sgi-gru/grukservices.c
> @@ -1016,7 +1016,7 @@ static int quicktest1(unsigned long arg)
>  			break;
>  	}
>  	if (ret != MQE_QUEUE_FULL || i != 4) {
> -		printk(KERN_DEBUG "GRU:%d quicktest1: unexpect status %d, i %d\n",
> +		printk(KERN_DEBUG "GRU:%d quicktest1: unexpected status %d, i %d\n",
>  		       smp_processor_id(), ret, i);
>  		goto done;
>  	}
> -- 
> 2.35.1
