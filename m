Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3231C5AC54A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiIDQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIDQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:10:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA9252AD;
        Sun,  4 Sep 2022 09:10:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p18so6384919plr.8;
        Sun, 04 Sep 2022 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=rVLZb4Hf7Ua5TDuZnyaLll5Sbo0H0rw7t+/XBLaglQk=;
        b=Bk6vgmNv7vY/bQPjRqW+JBYTLyjHVIEjfVHUj9iZmbmmbcSIqbFRRHQxaL4bMEUCl9
         n2FAkbD3JGsMU51ladOCDElfd1pVl7A/sqScU0UPy4utn2Kila9+vzEVfboeOI/FFrc4
         z3pWP8k3hZm7o/vCaHC5ZHSYPaRJIjsDum8l+L6I4LCzmBqX7wjDoX/ItxHrTKMOejeF
         GGItN3Dlcx4p5X7uxvJFshBteHKD+ETFcse/ay9lSsHx5cejguz138PqmbEguvEpxtMu
         QoWn9BFUC0jZ8CEQCDcoSnyouZNYpjRpcrowv3+1kPmyQf6mk10psNo2KnhwugJZN9G4
         N8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rVLZb4Hf7Ua5TDuZnyaLll5Sbo0H0rw7t+/XBLaglQk=;
        b=YtLkgqmjrCg3uqBpu+YJLR9I7A/7i0Mtr/36B1Jh8z8N5X1N8Mu1QIB/F7l71f4aGG
         l0iLe5IhobllB/Oc3OhdaVKQOIziapvhKCZOUV4uSojlZPwJNwEPK5pSwDC9MtlsGJh7
         5H7VUBEmfBloH8OzQC5du1jogsN5oOISmEsEDC15/UlmbtBJA9R0TCRWK1RnVQLUNTkL
         cI2trvKmp7kX4hKcMrj3ajklJc+qu6eHxo6291TPtiJF3jwHkFcfZs+Di+wVeyhAQQlG
         9yDeI4niBcjEmqRjEf3TbFT4LyoKqF6oWPFUKmmeZNAckcEW2/CBGgjzE6VrxORAQ9re
         UiiA==
X-Gm-Message-State: ACgBeo2RmTRiMlzwawkqU38z6/gDYT+8NmL2qMdA6AnmyWmRddWyC/vq
        YyQFziXkAchJS4HIUWLrMXs=
X-Google-Smtp-Source: AA6agR5psTPTTWOCJ155h+RGXr5bEoRE6WboX1qy8wy713aVOlHWiOb1Q80F10WMcPPMhPtaNHEXkQ==
X-Received: by 2002:a17:902:e844:b0:174:79c4:9449 with SMTP id t4-20020a170902e84400b0017479c49449mr38921012plg.66.1662307827063;
        Sun, 04 Sep 2022 09:10:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w69-20020a628248000000b00537f16e25d3sm5767736pfd.75.2022.09.04.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 09:10:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Sep 2022 09:10:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] hwmon: (emc2305) Remove unused including
 <linux/version.h>
Message-ID: <20220904161024.GA3007639@roeck-us.net>
References: <20220901022332.40248-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901022332.40248-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:23:32AM +0800, Jiapeng Chong wrote:
> ./drivers/hwmon/emc2305.c: 14 linux/version.h not needed.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2024
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/emc2305.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
> index df4c5816f661..e5e96a895549 100644
> --- a/drivers/hwmon/emc2305.c
> +++ b/drivers/hwmon/emc2305.c
> @@ -11,7 +11,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/emc2305.h>
>  #include <linux/thermal.h>
> -#include <linux/version.h>
>  
>  static const unsigned short
>  emc2305_normal_i2c[] = { 0x27, 0x2c, 0x2d, 0x2e, 0x2f, 0x4c, 0x4d, I2C_CLIENT_END };
