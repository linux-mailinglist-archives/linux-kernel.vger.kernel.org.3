Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78F4ECDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350878AbiC3UEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350870AbiC3UEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:04:09 -0400
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF44419B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:02:24 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id AA92065EB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:02:23 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id ZeWJn0meG9AGSZeWJnkcgb; Wed, 30 Mar 2022 15:02:22 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DrUu3f6Vg70A9S/e0ENsULeFLvIkUNgEiXVJ565JLzM=; b=dDDchv22UZx7S9aVL6BuhPFHoX
        K+2861O1HC8rPmzN2ZaiTGoflxh53IzGBZ5EdHlqW5L6ICtftxsebDPSzuFktdght6c9yH2mECk3o
        hLsWYXTJn9H3SwYhiHZfPPOXC/1lXTRDSYoEX9pJoM8dxdCPLPVLqms0Qt098Vul4I53VkR3nQVHI
        wOMhdbWDZT9nLBtwTF0hK4AV+ZtXbiviUIGWNDFCZsx/+6f8zcp0aGaHlMR2wswTvg4dBO+7CezGy
        6Ss2GnHToaslE/5DM42PTv+ri9c94/USznJ3FiAGdSgbE30796l7gzBBI1tqHXmOyusJoumjPqycM
        5A2964cA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54582)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nZeWI-001X75-Mk; Wed, 30 Mar 2022 20:02:18 +0000
Message-ID: <45acc349-8fea-f755-065c-c561949c45af@roeck-us.net>
Date:   Wed, 30 Mar 2022 13:02:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v20 1/4] mfd: silergy,sy7636a: Add config option
Content-Language: en-US
To:     Alistair Francis <alistair@alistair23.me>, lgirdwood@gmail.com,
        robh+dt@kernel.org, kernel@pengutronix.de, lee.jones@linaro.org,
        broonie@kernel.org
Cc:     linux-hwmon@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, amitk@kernel.org
References: <20220330094126.30252-1-alistair@alistair23.me>
 <20220330094126.30252-2-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220330094126.30252-2-alistair@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nZeWI-001X75-Mk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54582
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 18
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 02:41, Alistair Francis wrote:
> Add a specific MFD_SY7636A config option.
> 
> As part of this change we can use MFD_SY7636A as a dependency for all
> SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C as
> it no longer needs to be selectable.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/Kconfig     |  1 +
>   drivers/mfd/Kconfig       | 12 +++++++++++-
>   drivers/regulator/Kconfig |  1 +
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68a8a27ab3b7..74b60d24e740 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1693,6 +1693,7 @@ config SENSORS_SIS5595
>   
>   config SENSORS_SY7636A
>   	tristate "Silergy SY7636A"
> +	depends on MFD_SY7636A
>   	help
>   	  If you say yes here you get support for the thermistor readout of
>   	  the Silergy SY7636A PMIC.
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..c47cb755757b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1095,6 +1095,16 @@ config MFD_SPMI_PMIC
>   	  Say M here if you want to include support for the SPMI PMIC
>   	  series as a module.  The module will be called "qcom-spmi-pmic".
>   
> +config MFD_SY7636A
> +	tristate "Silergy SY7636A voltage regulator"
> +	depends on I2C
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	  Enable support for Silergy SY7636A voltage regulator.
> +
> +	  To enable support for building sub-devices as modules,
> +	  choose M here.
> +
>   config MFD_RDC321X
>   	tristate "RDC R-321x southbridge"
>   	select MFD_CORE
> @@ -1202,7 +1212,7 @@ config MFD_SI476X_CORE
>   	  module will be called si476x-core.
>   
>   config MFD_SIMPLE_MFD_I2C
> -	tristate "Simple Multi-Functional Device support (I2C)"
> +	tristate
>   	depends on I2C
>   	select MFD_CORE
>   	select REGMAP_I2C
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 5ef2306fce04..c8ce6e5eea24 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1219,6 +1219,7 @@ config REGULATOR_STW481X_VMMC
>   
>   config REGULATOR_SY7636A
>   	tristate "Silergy SY7636A voltage regulator"
> +	depends on MFD_SY7636A
>   	help
>   	  This driver supports Silergy SY3686A voltage regulator.
>   

