Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE358C97A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiHHNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbiHHNaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:30:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56682C70;
        Mon,  8 Aug 2022 06:30:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so8093222pfb.7;
        Mon, 08 Aug 2022 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=/cwKw1oXK2BAcUZBUF1HGlwJN39sE5gD8XqZTYnWCZg=;
        b=O8HGM/CeMJZUbrN9QYtc5puFOw69OoCjnsj+YVQ3CZSGm0Fvwt26dd/DtxV4JvMrCG
         /EUEYfVm/fdmqjEi6aC2yslfCFN+QT+UGVRt6dDw3dQypyDHuyw7zDb7wpwqoJTeOqV+
         f1qgrvRtmW9gFk12p0PwxEywL5rKRUKR9BS1O3dczs9/7rUAShXHEG3m3YedQnXkv7QD
         wILcO3RdeZ3WeuGFMzXYOah/pmYH1cUTJtlqDDjkmHcnC7clnoBqFStbOLAIOXT2bhqG
         pU7o0HXjqRQLubWcm0kTag9lPTJa1uKUc9m6GaKUaJu6zuB/1PpcDJeE5VXgfxzKUu+2
         S5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=/cwKw1oXK2BAcUZBUF1HGlwJN39sE5gD8XqZTYnWCZg=;
        b=a2jYIhsk7Oc3PCuO6s/bAXfuXmNbgpNxvaKVe8oTx9QmYLAUfUC2GnoqEAhjfTrSMe
         5GbaGTgsadm+dH6u8ngRldSxdLbKtC1Z1/GNrtazPd/N2P0cmmk+0EURl9SzPuFvmtg9
         jNW8NK5V3h1vUsEuzqzDhLs7aaIZNYO5/nKUJWu1hjTv1N1chRzc6WCY6VDS0N/CBNbo
         9COXCSiGnMNIgx9qjf0SxMZ0666i21Gq333TPJfZ5I+xQkTgT+6EpBmt1UejsZt9VYV2
         8mlYLgTEelIFt8KHgb1efAXD8LC1J+B9oHDNgb4VZnZfmTjq4BpXFqreCvpu2lGqFQES
         qStA==
X-Gm-Message-State: ACgBeo0bECyGNVyDWbukrIBNfnIoAbDKWycJfQnCZuO2gAhmhpXqI6Ir
        to3qVwyi3Pzuii1c+J+SRwg=
X-Google-Smtp-Source: AA6agR5leQTGI3Gn3ICBtJwZcaOBSYYMxYgXEWbc/mQAjoNsb13pkDAcSWetVYSPKlW/WcBvsNVI5A==
X-Received: by 2002:a65:604f:0:b0:41a:77fe:2bbe with SMTP id a15-20020a65604f000000b0041a77fe2bbemr15196528pgp.242.1659965450820;
        Mon, 08 Aug 2022 06:30:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bg22-20020a17090b0d9600b001f10c959aa2sm8104487pjb.42.2022.08.08.06.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:30:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 Aug 2022 06:30:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     sunliming <sunliming@kylinos.cn>
Cc:     wim@linux-watchdog.org, arnd@arndb.de,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] watchdog: sa1100: make variable sa1100dog_driver static
Message-ID: <20220808133046.GA2347272@roeck-us.net>
References: <20220802020819.1226454-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802020819.1226454-1-sunliming@kylinos.cn>
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

On Tue, Aug 02, 2022 at 10:08:19AM +0800, sunliming wrote:
> This symbol is not used outside of sa1100_wdt.c, so marks it static.
> 
> Fixes the following warning:
> 
> >> drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol 'sa1100dog_driver'
> was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sa1100_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
> index 2d0a06a158a8..82ac5d19f519 100644
> --- a/drivers/watchdog/sa1100_wdt.c
> +++ b/drivers/watchdog/sa1100_wdt.c
> @@ -238,7 +238,7 @@ static int sa1100dog_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -struct platform_driver sa1100dog_driver = {
> +static struct platform_driver sa1100dog_driver = {
>  	.driver.name = "sa1100_wdt",
>  	.probe	  = sa1100dog_probe,
>  	.remove	  = sa1100dog_remove,
> -- 
> 2.25.1
> 
