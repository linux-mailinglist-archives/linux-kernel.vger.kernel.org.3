Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CD4CF20B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiCGGji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCGGjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:39:25 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215F21E1E;
        Sun,  6 Mar 2022 22:38:27 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id g20so18439693edw.6;
        Sun, 06 Mar 2022 22:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9RhIAjzasxR4eX7FzaVOgWlxabsqBx2x17G0bYv+CRg=;
        b=gsJg5tHL7b+L+r7AkeMCIsLaWy2Cf4TYJudC+daOBzRbrHr8D6GugIzqUTJZH1BK39
         dHNQXyM9tR9OzW6AnBOUCT3FBKUUnbhNnlwYo4YZo1lAN0jsQvJaiN/rXWKe02f3FMAG
         7pwy2IKiPoN2a7YqjN97hx/MSaQVuLarP2j5vnmakYE+bV3tOwnATiXAz0ik6/nE7dB+
         6Y6ACwoSe+Hdbdbbia9ca5LDDc4bFbBr1bV70nzF3BDLBzcpj/bkZehgSdkGeuZE+doM
         33uo3jofazXGtsrxVDea+U+h9YkLvWt1BleilYi6cMdoh1pzVY8zeLFm22MdhyaVBQsx
         YLqg==
X-Gm-Message-State: AOAM532lrplzAA4BgL6hTcO0VeFnxIBBANK5iq+pS13EdKkcFMEjtuzb
        yto2/4Ok3ibIDzrLQ8JkwoCwTr/6pBE=
X-Google-Smtp-Source: ABdhPJwdgubxYBuiYoTzQceUVMm6boCorMzuF0z62sATkZSq7DWyqlQRv533Ri0VBGFeJVgnbg8jJQ==
X-Received: by 2002:a05:6402:370b:b0:413:3bcd:3d0e with SMTP id ek11-20020a056402370b00b004133bcd3d0emr9885718edb.178.1646635106494;
        Sun, 06 Mar 2022 22:38:26 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id t3-20020a170906268300b006db02dda82fsm2194278ejc.168.2022.03.06.22.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 22:38:25 -0800 (PST)
Message-ID: <06f2b1a8-301e-6a54-50bb-58eca6b93850@kernel.org>
Date:   Mon, 7 Mar 2022 07:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 5/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data members
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
 <20220304080348.218581-5-krzysztof.kozlowski@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220304080348.218581-5-krzysztof.kozlowski@canonical.com>
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

On 04. 03. 22, 9:03, Krzysztof Kozlowski wrote:
> The driver data (struct s3c24xx_serial_drv_data) is never modified, so
> also its members can be make const.  Except code style this has no

s/make/made/ if you do a v2.

> impact because the structure itself is always a const.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/samsung_tty.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 279c413f2300..eecefff5c4a4 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -85,9 +85,9 @@ struct s3c24xx_uart_info {
>   };
>   
>   struct s3c24xx_serial_drv_data {
> -	struct s3c24xx_uart_info	info;
> -	struct s3c2410_uartcfg		def_cfg;
> -	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
> +	const struct s3c24xx_uart_info	info;
> +	const struct s3c2410_uartcfg	def_cfg;
> +	const unsigned int		fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
>   };
>   
>   struct s3c24xx_uart_dma {


-- 
js
suse labs
