Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0515A514E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiH2QQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiH2QPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:15:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C86BD7D;
        Mon, 29 Aug 2022 09:15:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 202so8109856pgc.8;
        Mon, 29 Aug 2022 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=g0kw5xZnZw7q+3ffQUpIQkZqCeOEYk4EXLB4t2SfoOo=;
        b=KoZq++r5Al1IE642Kn8OHluF6t0LVR2jzSy+IxDcqTMJJXnOWTXgysnx1yG7/Ist5O
         D+wesfr8SnPIujDL/U29ZjknlRlfAXVfIKjRGl1knwLncJzNKwIuUdTPF38xfksvpozp
         7LIG3BQX5DpN1HdGQn+0wW7t/5AgOO/0SvuLy3pjenLNCgYUsYMkzzcgUXhnshXPAUt7
         Q0Iw8Sg531kjadbThFESQWYRvrW09fkxa/YJPOQ1taXad+64/zVgYTIm6nJIZneAP/pX
         QzHhz5LibboNYLwckSS1iKOzfAmeyErDm4cEp0zqHbUf2C3CsL/LFHW4rhpAU+P8zO14
         ZwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=g0kw5xZnZw7q+3ffQUpIQkZqCeOEYk4EXLB4t2SfoOo=;
        b=VmCks0NP4vRGZvE9Re+rPFVgP57dw6HeAkJjuu9W4a5Ypz0NHa6yHnG5gmv7KTL/rU
         npntBrZfE53I11NpK+jgeZhu+Cwp5Dc/Mx8U3h0zVfL3ktCj7DizcfUEs0ecxlQUUgz7
         6PTtBUyh77kurM4c3cRx8IddO1nRsvJmH+3MPhUD0H2Ht1y3ttvY4c8evIkqt/TjTJD1
         sPnptF+70igo/xYrRN+tmQoChEDA1/dniHXaAhv1A4da0dnv6qdRFXnPCttiFsBBQFz2
         OYAOoiCXVDZxWFcipPGeY8lXOEeEpu4ZtRW6TW7yOxQ4/2RZlw/xOmuw4DRfjtasZdfH
         nEVg==
X-Gm-Message-State: ACgBeo2E+d+xkDzAiBlLMvrM3+0RYWVvT2Y9KpmO1qZ4xrua/trNVSTJ
        8gQN2ylQEUmp4P37DqKXxn7S6vWJQ/0k+A==
X-Google-Smtp-Source: AA6agR7XHQ7d2f9pmuh5EJ73k4GdRHVcJa6qm4yCOJ8HAZRIaAHPWYVOGGecRZ3peEQglvDoazMFmQ==
X-Received: by 2002:a05:6a00:1947:b0:536:6730:7d33 with SMTP id s7-20020a056a00194700b0053667307d33mr17300259pfk.10.1661789747637;
        Mon, 29 Aug 2022 09:15:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090a46c300b001fa80cde150sm6835833pjg.20.2022.08.29.09.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:15:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dd3be720-2e7e-b390-f304-12344d65ce88@roeck-us.net>
Date:   Mon, 29 Aug 2022 09:15:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] watchdog: Enable HP_WATCHDOG for ARM64 systems.
Content-Language: en-US
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
 <20220820202821.1263837-3-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220820202821.1263837-3-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 13:28, Jerry Hoemann wrote:
> Enable HP_WATCHDOG for ARM64 systems.
> HPWDT_NMI_DECODING requires X86 as NMI handlers are X86 specific.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9295492d24f7..cd643e50681e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1315,7 +1315,7 @@ config IT87_WDT
>   config HP_WATCHDOG
>   	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
>   	select WATCHDOG_CORE
> -	depends on X86 && PCI
> +	depends on (ARM64 || X86) && PCI
>   	help
>   	  A software monitoring watchdog and NMI handling driver. This driver
>   	  will detect lockups and provide a stack trace. This is a driver that
> @@ -1325,7 +1325,7 @@ config HP_WATCHDOG
>   
>   config HPWDT_NMI_DECODING
>   	bool "NMI support for the HP ProLiant iLO2+ Hardware Watchdog Timer"
> -	depends on HP_WATCHDOG
> +	depends on X86 && HP_WATCHDOG
>   	default y
>   	help
>   	  Enables the NMI handler for the watchdog pretimeout NMI and the iLO

