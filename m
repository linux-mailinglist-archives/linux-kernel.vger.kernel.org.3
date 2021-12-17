Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA314791E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbhLQQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:52:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:39488 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbhLQQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639759974; x=1671295974;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iO4uINCczmYLYeM2/AnU1KacYcfGgrDWAAuMG5ogDok=;
  b=MCD8NS2QIt/fnvE8jKjhgsKOfMXXXh9MXfL0MH76x607XuggNvDgstUl
   YhdUcuJCIakDnYYDIwhTpKjqMV59X6WPa0WPqfWSHX62//JFHvfCLduo0
   naIEJvJdzV41qN4b0M5aYJxHmFH+2VDgFyn/2cnNDqdG0qiqwkzK0zlEb
   u64kkYK4EWxvUVOLlupbmbBii6VbkSwYo3ZVFPE+6OcRtEq7Kz2nsx8AC
   Dn3BYrb0pXQ89FIwbINm1uoSUwCmdrmKmELcBTweVCXZAJVHkzD6LQeab
   DO7p4sJpDXWt5vmYyGrNQeOp5SIqb1OvVxFUi7kG8ArQOItlU7tBeNXE2
   w==;
IronPort-SDR: 7mBRlMm6IGT4dTpqn8iABGA5wPpvelC6FuryohQ7Z5Yn+WMUtLfba5FqxwO6M8qcr2T0JMBf2O
 +noG+d01dqpDeo7W+Wg8hRmj4PVR0y667yZ3wTUQLre7R/Xu9fVhsi+8aIU4mDHb57qW91cviA
 Cq6TOQbytRlmchIRHp3mHWwvDBOtO2mlF2cDz+gJrny/u2JwGBp4vY7g1Pb/YdS1RLJVSspnKD
 au9pmJZlN16UBO1/lIavTGC3M+n/jbZxoAzWtwEgG/pC+h2hX6T0768ktmbcyJ6DKWSl9Ihpbe
 fLzB5fwCdhuB71nA9FGnjlry
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="142784408"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 09:52:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 09:52:53 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 09:52:51 -0700
Subject: Re: [PATCH v3] ARM: configs: at91: Enable crypto software
 implementations
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>, <dianders@chromium.org>,
        <emil.velikov@collabora.com>, <sam@ravnborg.org>,
        <codrin.ciubotariu@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211215134311.304427-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <c161698a-8b18-8aa7-9f61-1f82cc2252ed@microchip.com>
Date:   Fri, 17 Dec 2021 17:52:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211215134311.304427-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 at 14:43, Tudor Ambarus wrote:
> Enable at least the same amount of algs as the hardware IPs are
> supporting so that they are able to fallback to the software
> implementations in case they need it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

And queued on at91-defconfig for 5.17.

Thanks, best regards,
   Nicolas


> ---
> v3: drop CONFIG_CRYPTO_MD5, as MD5 is not hw accelerated.
> 
> v2:
> - add CONFIG_CRYPTO_HMAC
> - update commit message
> - ignore other non-crypto changes that are revealed with
>    "make savedefconfig"
> 
>   arch/arm/configs/at91_dt_defconfig | 9 ++++++++-
>   arch/arm/configs/sama5_defconfig   | 8 ++++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index a6310c8abcc3..549d01be0b47 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -216,7 +216,14 @@ CONFIG_NLS_CODEPAGE_437=y
>   CONFIG_NLS_CODEPAGE_850=y
>   CONFIG_NLS_ISO8859_1=y
>   CONFIG_NLS_UTF8=y
> -CONFIG_CRYPTO_ECB=y
> +CONFIG_CRYPTO_CBC=y
> +CONFIG_CRYPTO_CFB=y
> +CONFIG_CRYPTO_OFB=y
> +CONFIG_CRYPTO_XTS=y
> +CONFIG_CRYPTO_HMAC=y
> +CONFIG_CRYPTO_SHA1=y
> +CONFIG_CRYPTO_SHA512=y
> +CONFIG_CRYPTO_DES=y
>   CONFIG_CRYPTO_USER_API_HASH=m
>   CONFIG_CRYPTO_USER_API_SKCIPHER=m
>   CONFIG_CRYPTO_DEV_ATMEL_AES=y
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index fe0d7ccc8fb2..03dd80c2a19e 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -232,6 +232,14 @@ CONFIG_NLS_CODEPAGE_437=y
>   CONFIG_NLS_CODEPAGE_850=y
>   CONFIG_NLS_ISO8859_1=y
>   CONFIG_NLS_UTF8=y
> +CONFIG_CRYPTO_CBC=y
> +CONFIG_CRYPTO_CFB=y
> +CONFIG_CRYPTO_OFB=y
> +CONFIG_CRYPTO_XTS=y
> +CONFIG_CRYPTO_HMAC=y
> +CONFIG_CRYPTO_SHA1=y
> +CONFIG_CRYPTO_SHA512=y
> +CONFIG_CRYPTO_DES=y
>   CONFIG_CRYPTO_USER_API_HASH=m
>   CONFIG_CRYPTO_USER_API_SKCIPHER=m
>   CONFIG_CRYPTO_DEV_ATMEL_AES=y
> 


-- 
Nicolas Ferre
