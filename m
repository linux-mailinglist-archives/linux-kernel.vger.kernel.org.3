Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC654B894
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbiFNS1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiFNS1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:27:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24146B05
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:27:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s135so9219221pgs.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hEzvcC++7k61l66axeatSqAP6xU3P4DD1F7VimB/7IY=;
        b=hLwZ57viqZp4/xIL8iY9+2iLb7KM6Gzt40oYSNwx0vK4ki9FY/WBegDPBrPU2Ak4Mp
         5NepIPSuF7N8TfmzG+vR+0I4uiQ5KOuMki7Tj+lOOk55mzbu/iRny7ncAeU1yOyD8Ihp
         8r46sMaV1NZU0Wh9Gcio7p0BlWDeaO5tZ+SOb8OAeEOnbwQEWbMByLW96zJlzDov0POI
         dV62f3W9/oLK+kG2/P8EvCZNzYtDMzeq+DABeHyNgLmPpWtNw9hXUMMn/twaZBASBsfT
         wbOVyEJbFoIaULS/6K3m5aLS4axrvhXQzmtzU2RZaGTUjUd6HlPHgaWrBgE2/T/AFQHq
         AVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hEzvcC++7k61l66axeatSqAP6xU3P4DD1F7VimB/7IY=;
        b=KODQjNSE0kkABsLRiNaGZ/fbuxCoKvpigBeDszwsJGvvf7+sLvCfaVKeBQ1hrwv2WM
         KWBHeQVx8RZLzZxU+9/0ESGwc4Z+izA2PVw84B5yrRzwux0IGdJ5YEfkGaqVG/zzC8Io
         1YWnZh9UkecPWG0cO8o/Jmiv29f3A4sOhFgJtcNlqC2lsU5WywbipCTuWlRJ5yIXAMuX
         p0b9kXmynxW+C7SWWnKeP6IrHWLeGxiOTol6dOkmWe0/E+gAXergVSbc8fnzYamgSwbc
         c1n+KsrTN+JxwViUkc5D1qTzPK3WPkyydo2Y3ep8GLGgof5hMRgsjYFNVKL81ihh/AHO
         2t1Q==
X-Gm-Message-State: AOAM532YCJT9rxKB3rPHwEX5jiHhrCulWx0G/jfLGA6U5ps0nn1emzcr
        k4H8LMwWylPo22qOsjVoDtdmdg==
X-Google-Smtp-Source: ABdhPJxed6m9qCYHAcWHQVgxUvdQNOgqcemvcPHkZVegIMswmJByvqWxISjjIUJgwcKYg8zqshHcgw==
X-Received: by 2002:a63:ea09:0:b0:3fd:3c6a:47c2 with SMTP id c9-20020a63ea09000000b003fd3c6a47c2mr5522805pgi.242.1655231234874;
        Tue, 14 Jun 2022 11:27:14 -0700 (PDT)
Received: from [172.22.33.33] ([192.77.111.2])
        by smtp.googlemail.com with ESMTPSA id h20-20020a170902f7d400b0016232dbd01fsm7539440plw.292.2022.06.14.11.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 11:27:14 -0700 (PDT)
Message-ID: <06ae64cc-80e0-9290-5d9f-1a37184ed900@linaro.org>
Date:   Tue, 14 Jun 2022 11:27:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MAINTAINERS: rectify file pattern in MICROCHIP OTPC
 DRIVER
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220607064220.9296-1-lukas.bulwahn@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220607064220.9296-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2022 23:42, Lukas Bulwahn wrote:
> Commit 6b291610dd57 ("nvmem: microchip-otpc: add support") adds the
> Microchip otpc driver and a corresponding MAINTAINERS section, but slips
> in a slightly wrong file pattern.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Rectify this file pattern in MICROCHIP OTPC DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
Applied thanks,

--srini

> Claudiu, please ack.
> 
> Srinivas, please pick this minor non-urgent patch in your -next tree on
> top of the commit above. Thanks.
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 572f50739fb2..288393564abc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13119,7 +13119,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
>   F:	drivers/nvmem/microchip-otpc.c
> -F:	dt-bindings/nvmem/microchip,sama7g5-otpc.h
> +F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
>   
>   MICROCHIP PWM DRIVER
>   M:	Claudiu Beznea <claudiu.beznea@microchip.com>
