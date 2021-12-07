Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C946BCC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhLGNoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:44:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:14364 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhLGNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638884447; x=1670420447;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WNJLasJh7PSmGafOUj4IYrF7rqQGpNgB7ftRFsVYGwc=;
  b=0//ZkRhDcznIJuMZYdp1ixTv2WRBiPu1805sZYfW8n7nyGntAaTJKO0d
   eGq1N0lBDTmYdYEh7v9ezlXV59aFJK9MJR27uU/BxnIAjplBtnpzel0Vl
   oosRCcZzNfdqnAYEh51CIhRyzxYMYOGyO7LypC8jNOpWDqobkv1iMXpAW
   VV1lcd3kx+uTYFVsjwLPznFh8cfzeBnlsmbebLHyrTZUvpGOTqzCmTcvi
   ScXgT9iYLeh6lqArA8wvJ9lZqfsHwIS+ugR2X7lFRvGnshOhIdK8j4roV
   F+F0XJFqmHCeF10Oca5QSxgYvC5HpqEE+4PKlxekBWhSTO9L0IA6Aguw9
   A==;
IronPort-SDR: tRIw679/fUNUAPCFKcUYgvRVvvJ+9ZxymZTg3fB5YFvWcedp+1Sl8VQugvvYccbE0IWWMB3iDb
 4/G/1NqhJIrfmzWqbI8mnGvdw8wD7lY5tDJOSjfAcA1/AesENbvG1jG3I5Vs0+3LclbmVz58+f
 jiPSaNTuJz6EkVChLr98+rDiV/kBy/VSuIKoMCLUnexErJWosjSAS5R0DLhmIT/yigYZSnUY25
 MZ4/PD6Fooe/x38z0BwmSWCm+Qk76dNxFm2A2chiaC/ws1rDJ9Ixc4DqB13PIe1TDEpXZ4FX3L
 3Yy1wM2GbmR6C77yDIn4bSwd
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="146379053"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 06:40:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 06:40:46 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 7 Dec 2021 06:40:45 -0700
Subject: Re: [PATCH] mfd: atmel-flexcom: fix compilation warning
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <lee.jones@linaro.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
References: <20211207111515.814653-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <ff7a186b-1a99-e45b-1231-18b957abd88d@microchip.com>
Date:   Tue, 7 Dec 2021 14:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211207111515.814653-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 at 12:15, Claudiu Beznea wrote:
> Fix "unused variable 'atmel_flexcom_pm_ops' [-Wunused-const-variable]"
> compilation warning by using __maybe_unused on PM ops.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu. Best regards,
   Nicolas

> ---
>   drivers/mfd/atmel-flexcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 559eb4d352b6..33caa4fba6af 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -105,7 +105,7 @@ static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
>   	return 0;
>   }
>   
> -static const struct dev_pm_ops atmel_flexcom_pm_ops = {
> +static const struct dev_pm_ops __maybe_unused atmel_flexcom_pm_ops = {
>   	.resume_noirq = atmel_flexcom_resume_noirq,
>   };
>   
> 


-- 
Nicolas Ferre
