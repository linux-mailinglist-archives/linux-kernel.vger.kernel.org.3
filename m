Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0226F53D3A7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349554AbiFCWd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348633AbiFCWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:33:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615F12FE4A;
        Fri,  3 Jun 2022 15:33:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b135so8125903pfb.12;
        Fri, 03 Jun 2022 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7spu2rzPMkeoBhrHijWu4VEzaLPZluC22QeM3SMgIcQ=;
        b=hPoAlBVjQOROOx9g8K5qk9LkKK+3ku/GvGIHASJLthgVfiLgJ8s+CczNM+vyk2Akzo
         3hBqvLNlBUgEcv50Rk2AbPLQPsLzCzlcVj0A7/wXBFxqCwCishZ2EG8MW2yk1Lg2u6AJ
         CEggLktKGAlqdcClo/cyUqH+Z0Yc5+tsoG9J8xjxWrNQ1OBbY9ptoVF1E9Yia3VfESgf
         MxQ7QgWIbb9bIeT0eAnme0LFKoHiEuK8wrNMTeN5iuUrlf8vqSulX5CshOMBRkA9iYSv
         5JST09Gl8xORpI22eiHZh9+vB4HIFYAsFs+08ziC04DoGrN/sasjjUSQfdsXGqClDKZU
         gqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7spu2rzPMkeoBhrHijWu4VEzaLPZluC22QeM3SMgIcQ=;
        b=i6HvEYB3xTl7kE5lTDwaJPKvt9JLStivAVJlMA3UGOnr6oLZcKkpdBIvjS6ur16UDJ
         H2x2kcCvuarEElmyi116GmW61Cjfr1EKypdbBlAOK1rimUoqSHHJn+34XQaVsO3A7q9R
         AS/4a/+PJZA6Pcg6JPzA2tgWbAYvGELqinu/ROqioEHbjzRpar7BM5YqMY5UY6BpltPS
         aVZHKwTa6fNwZvbe3JKvqBmomHIddi+CgVZ4Q9NB6wby65B44uxPaBVyvwbl3pF9zZh4
         G03oDGDAjaalcKGrPLn2DJy/wRnvPBOW7PEL5v/JEuYNQUyxbmLuFiq+LaZVtsaORzTx
         t21w==
X-Gm-Message-State: AOAM5319qCKPb4xuZZU9YO2oFofb7VGTMopUHU8T5mfyFGOtmKdA34MZ
        wQjnBcO0/SZoKf1vDYfToFXWH0xz7n8=
X-Google-Smtp-Source: ABdhPJw9Ry/YCHEcc4m1fA4rhsLeyMXcDtco4DmSZoR4cxFOKRa4zbS8iDoByCq+2T5MojgVTivJFg==
X-Received: by 2002:a65:6552:0:b0:3db:772a:2465 with SMTP id a18-20020a656552000000b003db772a2465mr10783786pgw.225.1654295605590;
        Fri, 03 Jun 2022 15:33:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:aea8:f22c:dcaf:b60e])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902cf4300b0015e8d4eb29csm5807377plg.230.2022.06.03.15.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:33:24 -0700 (PDT)
Date:   Fri, 3 Jun 2022 15:33:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marius Hoch <mail@mariushoch.de>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: soc_button_array - also add Lenovo Yoga Tablet2
 1051F to dmi_use_low_level_irq
Message-ID: <YpqMMmIH6Rr0RbeP@google.com>
References: <20220603120246.3065-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603120246.3065-1-mail@mariushoch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:02:46PM +0200, Marius Hoch wrote:
> Commit 223f61b8c5ad ("Input: soc_button_array - add Lenovo Yoga Tablet2
> 1051L to the dmi_use_low_level_irq list") added the 1051L to this list
> already, but the same problem applies to the 1051F. As there are no
> further 1051 variants (just the F/L), we can just DMI match 1051.
> 
> Tested on a Lenovo Yoga Tablet2 1051F: Without this patch the
> home-button stops working after a wakeup from suspend.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Adding Hans for his input...

> ---
>  drivers/input/misc/soc_button_array.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index cbb1599a520e..480476121c01 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -85,13 +85,13 @@ static const struct dmi_system_id dmi_use_low_level_irq[] = {
>  	},
>  	{
>  		/*
> -		 * Lenovo Yoga Tab2 1051L, something messes with the home-button
> +		 * Lenovo Yoga Tab2 1051F/1051L, something messes with the home-button
>  		 * IRQ settings, leading to a non working home-button.
>  		 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "60073"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "1051L"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "1051"),
>  		},
>  	},
>  	{} /* Terminating entry */
> -- 
> 2.36.1
> 

-- 
Dmitry
