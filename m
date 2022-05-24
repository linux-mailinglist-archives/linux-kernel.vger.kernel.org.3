Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401F8531FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiEXAmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiEXAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:42:36 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2273EA8F;
        Mon, 23 May 2022 17:42:35 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f1d5464c48so20510319fac.6;
        Mon, 23 May 2022 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ETvvkhpQrw7shYB9haUbVAUaap8xo2ExD5sxPwIi74=;
        b=MNmGJ+mct0/1TBw6ndmG1LtwQNJRV/NNa15sy8R0fVeN2H3v+3qoAmBKThwSSy+amV
         eGWDwg8ndA4nhKGaJ8aNkmuezWRxdfBKwEHNG+TWeGqdwGgNTPPpx7j4ZNrDf2wWiRIc
         eiuxRtClIcgJC35EuBaMVCHwpcPBI7hBbk8wBWaINepSKtVP+acrOXfkR/5xQCEaGlbN
         9HnOVcwkuqhpgmtVShkKiIotIFLkdSLJKXXVeJAU31VQRxNqsPgSmUtGaHOVT2Q9Vdpb
         /MvFa7S6SjpPEnmNt+GVkTxIrEsD6Lc4a/uqlBFr97ZLVYhH5DdaPUog2mqEwEYdvg2i
         efjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8ETvvkhpQrw7shYB9haUbVAUaap8xo2ExD5sxPwIi74=;
        b=FL1FtLpZOpxtQVxr2Vl8Sl2Sm/7WS3rSS7IhGv1YWs7n1rGWZ9kiz0kD+Qxve38Io6
         PQtBHcr5g15QiO2wFPgHOjqT5Qkqri+gkNRj7S42WnJjw8jYHgufmtEu7DhXA31TGeHM
         MBXMGeJHURQHqBHN+nGtxdsqBprAb/YmmTQsradTy/CLwXxFFgV2SRQH6F1cyX35qKyw
         WNF1YjMX1cdePBxbksWIDxfjn7y2RoB15f41s+zWdUf6dtfjteaDi6Z7tbjBfuhSEcEh
         qU9Bl8gXCrAUTq3HvLhTUt9puVU0dtJmebV7J/spyNcyXP5HhuGD+SVEg9pdUIh1bQeo
         U4MA==
X-Gm-Message-State: AOAM5307Decnz4YemMHzJlrXUjAH0UIHa/8ggH9YjnWdhc51KJGRms2j
        a88Sc+MZGiNhLKtEXEjZDhOHdZk2vei4ew==
X-Google-Smtp-Source: ABdhPJybhTbiHSkZOw8UXTfXdDBF6Py/eEU1EeoDYQHXJadEJGAa9mq/7CcGRKqFZX6rHGYSH0p3LA==
X-Received: by 2002:a05:6870:58a4:b0:f2:2720:884d with SMTP id be36-20020a05687058a400b000f22720884dmr1076063oab.13.1653352954855;
        Mon, 23 May 2022 17:42:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y130-20020aca3288000000b0032b57087f86sm1233869oiy.23.2022.05.23.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 17:42:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 17:42:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     sander@svanheule.net, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: change "char *" string form to "char []"
Message-ID: <20220524004232.GA241892@roeck-us.net>
References: <20220524003335.64801-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524003335.64801-1-yuzhe@nfschina.com>
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

On Mon, May 23, 2022 at 05:33:35PM -0700, Yu Zhe wrote:
> The string form of "char []" declares a single variable. It is better
> than "char *" which creates two variables.
> 

Huh, what ? One is a character array, the other a pointer.
It is still a single variable.

I don't mind if you want to use [] in your own code, but please
stop making such changes in other people's code. 

Guenter

> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/watchdog/realtek_otto_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
> index 60058a0c3ec4..c653ec73a999 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
> @@ -265,7 +265,7 @@ static int otto_wdt_probe_clk(struct otto_wdt_ctrl *ctrl)
>  
>  static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
>  {
> -	static const char *mode_property = "realtek,reset-mode";
> +	static const char mode_property[] = "realtek,reset-mode";
>  	const struct fwnode_handle *node = ctrl->dev->fwnode;
>  	int mode_count;
>  	u32 mode;
> -- 
> 2.25.1
> 
