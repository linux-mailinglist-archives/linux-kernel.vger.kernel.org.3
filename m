Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748BE4CF1F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiCGGhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiCGGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:37:01 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F765523D;
        Sun,  6 Mar 2022 22:36:07 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id bi12so16499446ejb.3;
        Sun, 06 Mar 2022 22:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CLWBvEKY0bZFqdu8keT0kKq+r86IcfvnbkU0z1432mo=;
        b=1Oj/Q2dD8xBFE2ITh/pgIK4sZZ1C4HqN1y0Zi+H68qV/Fj4Gd8QDXTAFczdZKzZMCa
         umScqz7CdrmOHKaavYe84+L5P/x1ubBJAOqJEgoAbLenhYvHiH9fE8ojZjm7420at/lE
         9I9L9yc8hZ8oJ/Y836xLQz6IETK+MiqjC0nS2xtpf42YClc7+JWxDP/bL4Jk8Zw6r5/n
         XMD6/2a56HJuWyTtR4iBn3uXT1oATWb06rmHtd9k5EUJyUSNWEOiFe33rF3UYu2vslln
         KAgFT0157GXk35/qW7S9GP4gYjhma8HglS6l3y8DXVNO5Yb9QmdHeNJz/bhlgdx6q4Sf
         d56w==
X-Gm-Message-State: AOAM533fEnucljcsK2hjAcK3EZPX7yKgS4lyxsJnlg5EKM0Bsay9LXJu
        ypJYnRpcBC81ADloF7xZh5Wn0ppbg/U=
X-Google-Smtp-Source: ABdhPJyghdxWDdZZiQiAA3A7jAfnXkNCsCEMdJbKxV9nI2lKjSqvi1c13Wt3y029SncPbA34DLhP5g==
X-Received: by 2002:a17:907:1c0e:b0:6da:a5cc:95a9 with SMTP id nc14-20020a1709071c0e00b006daa5cc95a9mr8026023ejc.631.1646634966342;
        Sun, 06 Mar 2022 22:36:06 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm5696583edu.51.2022.03.06.22.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 22:36:05 -0800 (PST)
Message-ID: <ba2a4504-b886-09b6-71ea-528c99a869f6@kernel.org>
Date:   Mon, 7 Mar 2022 07:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
 <20220304080348.218581-3-krzysztof.kozlowski@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220304080348.218581-3-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 03. 22, 9:03, Krzysztof Kozlowski wrote:
> The driver data (struct s3c24xx_serial_drv_data) is only used to
> initialize the driver properly and is not modified.  Make it const.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
...
> @@ -2726,13 +2726,13 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
>   		.ufcon		= S3C2410_UFCON_DEFAULT,
>   	},
>   };
> -#define S3C6400_SERIAL_DRV_DATA ((kernel_ulong_t)&s3c6400_serial_drv_data)
> +#define S3C6400_SERIAL_DRV_DATA (&s3c6400_serial_drv_data)
>   #else
> -#define S3C6400_SERIAL_DRV_DATA (kernel_ulong_t)NULL
> +#define S3C6400_SERIAL_DRV_DATA (NULL)
>   #endif
>   
>   #ifdef CONFIG_CPU_S5PV210
> -static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
> +static const struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   	.info = {
>   		.name		= "Samsung S5PV210 UART",
>   		.type		= TYPE_S3C6400,
> @@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   	},
>   	.fifosize = { 256, 64, 16, 16 },
>   };
> -#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
> +#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
>   #else
> -#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
> +#define S5PV210_SERIAL_DRV_DATA	(NULL)


All these changes are somehow irrelevant to the subject/to this patch. 
Care to put them into a separate patch?

There is no need to put NULL into parentheses.

> @@ -3062,7 +3062,6 @@ static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
>   OF_EARLYCON_DECLARE(s5l, "apple,s5l-uart", apple_s5l_early_console_setup);
>   #endif
>   
> -MODULE_ALIAS("platform:samsung-uart");

This is as well a different change to what is claimed.

thanks,
-- 
js
suse labs
