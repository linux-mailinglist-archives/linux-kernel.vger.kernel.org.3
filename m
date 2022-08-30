Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780755A5C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiH3Gt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH3Gtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:49:55 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05F64E8;
        Mon, 29 Aug 2022 23:49:54 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id z41so5489954ede.0;
        Mon, 29 Aug 2022 23:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=boAep88D4XZp1LD0LR4NzDV89yRIoicIDrOaKH7mAVQ=;
        b=rwHzKTSVRgWdgDai7AhMM2okwXWfFMYvRxbL8AwfHM5k5pkElntu9EVTjBo+TxgD4G
         EHFKnJoJMxpwhbElAD0KWbHwFU6Rg62gNrmtelAUQMYfqXDnheYimeG/E0ihSN6s44K5
         zIjrs4dwQahyCiSA2Q0BVF3OPrR+W6MfPY/bjcilItp5FcN8GAmCabd+OGGtPIJLFgth
         73yCCn8g2kk+LpAACOcD1c9atRGoZDC9+JC3HsRhv3m7quXCrYYjlj6Hr7AhU/mhYg8m
         dUYE6MkO9CXd0mWBdrBt1MT/D23/V231GTAgDHcw5s1QE9UVOi98nE3OmaJgT/HjKhFz
         zf7A==
X-Gm-Message-State: ACgBeo3x0LnI07bgldyHJMDEr/Li71Ozg6A6j1KhaJiHpw6Zj5r9Qt8I
        25jAEDsvvGoQj6x19HGkuC3ZZzTHS1zqQQ==
X-Google-Smtp-Source: AA6agR72X+62vzFRHtysREv1VKJf6q1jWGac4BIZmkBbWGdt+yBxerdm9zbpzV1SfPJtqrf8WUEZ+w==
X-Received: by 2002:a05:6402:26c2:b0:43d:d885:451a with SMTP id x2-20020a05640226c200b0043dd885451amr19162175edd.287.1661842192654;
        Mon, 29 Aug 2022 23:49:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e16-20020a056402089000b0043cab10f702sm6663863edy.90.2022.08.29.23.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:49:52 -0700 (PDT)
Message-ID: <dae848f0-6817-a281-94b3-9d2b6f84c90d@kernel.org>
Date:   Tue, 30 Aug 2022 08:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/6] tty: n_gsm: name gsm tty device minors
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220823062259.4754-1-daniel.starke@siemens.com>
 <20220823062259.4754-2-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823062259.4754-2-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 08. 22, 8:22, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Add a macro which defines the possible number of virtual devices for n_gsm
> to improve code readability.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> No changes since v1.
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5bf09d129357..ed399d57b197 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -164,6 +164,9 @@ struct gsm_dlci {
>   	struct net_device *net; /* network interface, if created */
>   };
>   
> +/* Total number of supported devices */
> +#define GSM_TTY_MINORS		256
> +
>   /* DLCI 0, 62/63 are special or reserved see gsmtty_open */
>   
>   #define NUM_DLCI		64
> @@ -3748,7 +3751,7 @@ static int __init gsm_init(void)
>   		return status;
>   	}
>   
> -	gsm_tty_driver = tty_alloc_driver(256, TTY_DRIVER_REAL_RAW |
> +	gsm_tty_driver = tty_alloc_driver(GSM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
>   			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_HARDWARE_BREAK);
>   	if (IS_ERR(gsm_tty_driver)) {
>   		pr_err("gsm_init: tty allocation failed.\n");

-- 
js
suse labs

