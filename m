Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9D52A1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbiEQMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbiEQMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:46:45 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB22A71A;
        Tue, 17 May 2022 05:46:42 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so12089848otf.11;
        Tue, 17 May 2022 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MyAFOCGSRf6QgAs8MMUC3Q4pwMEz6l2XeUjHz0qfbRg=;
        b=LGqm08ChnahL6Pfjt885QTfjJuXqxYr/qozfd3TXG4SgTM/A8YFWAHu0NZ4qrWb5In
         +Yxuj1PB5994EhbnMBrqYB6LkSJABMd/C6kXFSMiCgq6OSPkUPjvqK8c4/nP9fMy6SBJ
         eBzsVzHIfKEgMebDPSF/8JHsdONOxTH9p8MD877BCQ9Mc3gI35cD68/Il12A4kG5RQ0J
         /PZeTTwUxaJ0cMKAp3BcHWUw1ycteaXHX2isxW0EteU2eF5Lv8AmGY3oYpiFaTRbg0PV
         g2DBqO1PZihIBsvORgrbvVzzNskomImCnPvgG6LfPl+X+JoKOQKl3HC5Scin/oTHflQ5
         hzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MyAFOCGSRf6QgAs8MMUC3Q4pwMEz6l2XeUjHz0qfbRg=;
        b=pvyxzEi0poL7Qk6scmYuFgkPpTvufwVwE0JYOyaGtkujsEdSf+9gzP9gOUabyz9Syv
         bxmpJ11KUnuUSFdnfTVcJ6uxvoMoiyTMWx6q1YV/Oahwq4AAPUUPCs/CGOBoJ/ACQ7uc
         h9GBH+fymbJsfxLOaVeLYqCBZwJ4UdCjBThBU/xbAcXzkpVpfOUXkB2Uo78Mrb3GHLq9
         Kl0xSuhHcaLnvC2oNfmsgqkQCUBVAmViza4e2Zl77jjYAQbotlAUn5R8mE33nCbMWZnY
         ur3Ht6YshK4phigbJaXvoKRfIIaYQPIX/dzDZMJCIbaYWOWOC1XHLKQpH4sWwkPuVSm4
         Xkpw==
X-Gm-Message-State: AOAM532FB3fHDNKL+7TMlNHC3cAEvrsGgGlOeGsLcgflRSsLcbuykT9U
        +XX8YmEZaqtj7ZfRZJoadmM=
X-Google-Smtp-Source: ABdhPJyVxDyJkdmFmkr3TwRR7XNow1e1Wqca7l42zAD8ucJtmdixsdftO82djtxyZTo0srcE3933Zw==
X-Received: by 2002:a05:6830:1e2b:b0:606:d74:dce8 with SMTP id t11-20020a0568301e2b00b006060d74dce8mr7864328otr.373.1652791601865;
        Tue, 17 May 2022 05:46:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z30-20020a056870461e00b000e686d1389fsm6666814oao.57.2022.05.17.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:46:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 17 May 2022 05:46:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) fix Formula VIII definition
Message-ID: <20220517124640.GA3400378@roeck-us.net>
References: <20220517080508.1910953-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517080508.1910953-1-eugene.shalygin@gmail.com>
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

On Tue, May 17, 2022 at 10:05:08AM +0200, Eugene Shalygin wrote:
> The ROG CROSSHAIR VIII FORMULA board has the same sensors as the
> CROSSHAIR VIII HERO [1] thus let's join their definitions which adds
> missing sensors for Formula.
> 
> [1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/740
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 611e897429b1..57e11b2bab74 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -54,7 +54,7 @@ static char *mutex_path_override;
>  /* ACPI mutex for locking access to the EC for the firmware */
>  #define ASUS_HW_ACCESS_MUTEX_ASMX	"\\AMW0.ASMX"
>  
> -#define MAX_IDENTICAL_BOARD_VARIATIONS	2
> +#define MAX_IDENTICAL_BOARD_VARIATIONS	3
>  
>  /* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
>  #define ACPI_GLOBAL_LOCK_PSEUDO_PATH	":GLOBAL_LOCK"
> @@ -257,17 +257,9 @@ static const struct ec_board_info board_info[] = {
>  		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>  		.family = family_amd_500_series,
>  	},
> -	{
> -		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
> -		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> -			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
> -			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
> -		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
> -		.family = family_amd_500_series,
> -	},
>  	{
>  		.board_names = {
> +			"ROG CROSSHAIR VIII FORMULA"
>  			"ROG CROSSHAIR VIII HERO",
>  			"ROG CROSSHAIR VIII HERO (WI-FI)",
>  		},
