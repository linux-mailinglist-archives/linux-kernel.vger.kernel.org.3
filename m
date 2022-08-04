Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D085898AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiHDHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHDHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:51:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37E22AC5A;
        Thu,  4 Aug 2022 00:51:31 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274617BL010780;
        Thu, 4 Aug 2022 09:51:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=AxEhqXR+BgMHTMXYkqN7E9/KUwMbMhiGx5L1azHvekM=;
 b=gVZl+Codjvn3W6tj1e9+gRsG66KyTRecb6Lv9ckZCyzAXKrGlxmGxLRmx0yhcBFeN5DQ
 mVFjR9hZBCZccuiIfZ7JnsxkX20TZoCFtO8QlQSZ/6X4x83Wx0xkwPTIOmbXYgw8jo2F
 d9nKEvSQpVrSsMie5gR2Na73SmFGIPCiethGzCax7O/0H6Q+YWbM6PBl81zaU3XnpqgL
 ceY36dxqodiP7O8OJ13Obo6yQpqQ3oErEjl0k/STcyOCm5JOILfbkXVAWHoXslSoBHrZ
 iFF7M/fpG4hOHYk13p3mx3Gi1b64+c4dhLBhW+ssJr+m4JT6own7TWlQA8ECpmcod1vE XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hqs8awnkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 09:51:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BDEF10002A;
        Thu,  4 Aug 2022 09:51:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 948C2216EE1;
        Thu,  4 Aug 2022 09:51:07 +0200 (CEST)
Received: from [10.252.10.254] (10.75.127.45) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 4 Aug
 2022 09:51:04 +0200
Message-ID: <d38963a7-0263-cbc5-3f3a-8e5d65381f9e@foss.st.com>
Date:   Thu, 4 Aug 2022 09:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH][next] usb: typec: ucsi: stm32g0: Fix spelling mistake
 "booloader" -> "bootloader"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220803123018.913710-1-colin.i.king@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220803123018.913710-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_01,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 14:30, Colin Ian King wrote:
> There is a spelling mistake in a dev_err_probe message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Hi Colin,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index 061551d464f1..6ced49e4d208 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -599,7 +599,7 @@ static int ucsi_stm32g0_probe_bootloader(struct ucsi *ucsi)
>  		g0->i2c_bl = i2c_new_dummy_device(g0->client->adapter, STM32G0_I2C_BL_ADDR);
>  		if (IS_ERR(g0->i2c_bl)) {
>  			ret = dev_err_probe(g0->dev, PTR_ERR(g0->i2c_bl),
> -					    "Failed to register booloader I2C address\n");
> +					    "Failed to register bootloader I2C address\n");
>  			return ret;
>  		}
>  	}
