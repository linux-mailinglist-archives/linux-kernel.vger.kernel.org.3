Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01D53DD61
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbiFERjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiFERjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:39:49 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E47255BE;
        Sun,  5 Jun 2022 10:39:48 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso16685367fac.8;
        Sun, 05 Jun 2022 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0t2KBpV3bOi+Pz+YViAua3xYzzkQCGaNJlHLI0Dc4FU=;
        b=LIIMREu2fe9sT7Qe2DdOwRrA1/sdTGhwfgusaDjTBiSMNDtVFjIrnbFvSqOBXORKNi
         Z478K7rP2FXF2zrBFhGdAIQiuQC1wSwxzQ3P3BUGV1JLyzQrJqwV9sMzSaJ4vWKH/oIJ
         +ilLnhu5yrc6JQXc6K6Ywa4aedEJr94ZyhXg3SPEDuhnVGtho/D2LObxEJtk2/R4EL7V
         NPDx+Gv4c3o0lNIAlT9Dv5ExLcyCBjR4XsixMKn/Gwahu0h59eF5ZtSqtQ0Oao+LkbIg
         1njxm2JtMeqX+nvLKdEFtsz9tkN5BnyHK59CQBpsAbPYZZKErIAaKIQfQe0B/39L1FTS
         LeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0t2KBpV3bOi+Pz+YViAua3xYzzkQCGaNJlHLI0Dc4FU=;
        b=2gNTa3O1jFxADTumFHhVzj0eIwWiIHebhIJ5sMdbPWY/TC8CFUd4K16UtY9GDfKf/Y
         VFWJm7I5xqaUrclz1Vdfj1wlSmP3Hg0kDHPu/MfXPhOGWwUz0m6bS8pOSrmFw3KEHtoF
         PNQGvMCv0UcwwbRPlMzHRdY6dV7WjPTb6YJ0v8NSc7wL/Ep+dMtW2mHkrZI4srGm8Ltc
         AZNpnEtcDBVMP7BhN0ga+8aXtzPa7dLzK69OLGC+Tj3Yd+ILHm40SpwaEk6cZVwHieFA
         DOfzVpRn2zX4am3GVnI09T+R7Rqf5nbeVxXJTiV45F+xcbKQ5TvgE+po9cd36++Axbzn
         qwFg==
X-Gm-Message-State: AOAM532tpsl9j9Hcx8uU9bGZIPdENnFSpHAHWRrzeh+nay+8XtuZ84s+
        LWJWTgow9HDTfdo2iyaB9/bTbYMwZLw=
X-Google-Smtp-Source: ABdhPJzOLk65QYmXKuRayVk8/GezoeOHMXhhEXmgopuFVhqSSKyhF3oYsg/Nr2F50OO82g6MX+Itcw==
X-Received: by 2002:a05:6870:5818:b0:ee:e90:46cc with SMTP id r24-20020a056870581800b000ee0e9046ccmr11332049oap.37.1654450788297;
        Sun, 05 Jun 2022 10:39:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x25-20020a9d4599000000b0060603221258sm6857407ote.40.2022.06.05.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 10:39:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 5 Jun 2022 10:39:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksander Mazur <deweloper@wp.pl>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (f71882fg) Add support for F71858AD (0x0903)
Message-ID: <20220605173946.GA3144440@roeck-us.net>
References: <20220605012114.3d85a75a@mocarz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605012114.3d85a75a@mocarz>
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

On Sun, Jun 05, 2022 at 01:21:14AM +0200, Aleksander Mazur wrote:
> Treat F71858AD like F71858FG.
> 
> Tested on Igel D220.
> 
> Signed-off-by: Aleksander Mazur <deweloper@wp.pl>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/f71882fg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 6830e029995d..19b6c643059a 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -49,6 +49,7 @@
>  #define SIO_F81768D_ID		0x1210	/* Chipset ID */
>  #define SIO_F81865_ID		0x0704	/* Chipset ID */
>  #define SIO_F81866_ID		0x1010	/* Chipset ID */
> +#define SIO_F71858AD_ID		0x0903	/* Chipset ID */
>  #define SIO_F81966_ID		0x1502	/* Chipset ID */
>  
>  #define REGION_LENGTH		8
> @@ -2638,6 +2639,7 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
>  		sio_data->type = f71808a;
>  		break;
>  	case SIO_F71858_ID:
> +	case SIO_F71858AD_ID:
>  		sio_data->type = f71858fg;
>  		break;
>  	case SIO_F71862_ID:
