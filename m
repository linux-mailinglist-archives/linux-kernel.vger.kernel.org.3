Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1155F57F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiF2FH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiF2FHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:07:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A141DA67;
        Tue, 28 Jun 2022 22:07:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so14884589pjz.1;
        Tue, 28 Jun 2022 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UrMud0sgHuqJQj7Tp8uYSP5xAJTnCFW+UpEcZGFswwA=;
        b=iBXJy4ZQJ+rL1gxQwVEvZdEgTEy0a4lVl/SWrxEweqakl3x7Qjteh2QRwg+0Pdy8R4
         Okgg1MTHwgvbLB2Fi9uHTii5P7zw5tGR4xUKUxGAbzwwSt1NWVlMYRdD4JhRl/G8+luQ
         kdvsmWAXcgr8w18uiDZBcCFwrO2+a7doF+XsxNIcT6ulTodinyohMHa5ehyFW3u/yXp0
         yfTUnZBH1ghe87N+xrJI56gAQyDnrgQ2fkXsF5V43lgxo17rCf3lGZniVeKsV+v9peZH
         OJW0q1lhdyWcNAYunMGnJrG9U0krSv7osEfRP+jQxXIz0kGoKVAjPFWUQtTm0m8hO+qm
         lHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UrMud0sgHuqJQj7Tp8uYSP5xAJTnCFW+UpEcZGFswwA=;
        b=3sKdNVvQT0xeowgpFXKci2+lfFCfTPn4vktu5W4xCICEP6ZaAnk5LgeNoqrg/iM5D9
         /Z7s2r/XU/EBgPUzO6r0OC+8vBd/4OR4dsgKIbvdy47ZZayZQmVXQvLyu4hx93vXNfck
         ZpPb+Ej07ewrahh4Oxx32FwOGQCxBk0teCRiCV3Ez5kcfYPN3sjEKeUjOLrjbjbD2fLi
         BD+DYxB5jP5ClOy+Poty+SYbYJu92G7C0s6Mh2L1Pj+bV6oY2xJ5H0aHy33vxVDzUEmo
         UUF2Iqp1ZGVupLovOcvusSir6EeyBnJOPXS0aknAjnMxz2fLk50EtXsjrDOjL61IpXkz
         W5yg==
X-Gm-Message-State: AJIora+8joO5zBHsQc+U02oPd4J27jucAM0sOVBCilRgTSmfyz2fSVpx
        OPW6Tv9+Lf0Gz5Fcmzm0LU0=
X-Google-Smtp-Source: AGRyM1vipTDfnS5quAyH9/zQOsasulwAtziunRqFyr8+3D7qaqWzqZZYlD08iUi9p5OPFbNDtxtRMw==
X-Received: by 2002:a17:90a:f684:b0:1ec:b252:4cd2 with SMTP id cl4-20020a17090af68400b001ecb2524cd2mr1779900pjb.196.1656479241285;
        Tue, 28 Jun 2022 22:07:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ff79:92cc:7905:3272])
        by smtp.gmail.com with ESMTPSA id a8-20020a656408000000b003fd1111d73csm10323410pgv.4.2022.06.28.22.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:07:20 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:07:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-input@vger.kernel.org
Subject: Re: [RESEND PATCH v4 4/6] Input: edt-ft5x06 - show model name by
 sysfs
Message-ID: <YrveBobh0tQAGD6i@google.com>
References: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
 <20220621123937.1330389-5-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621123937.1330389-5-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

On Tue, Jun 21, 2022 at 02:39:35PM +0200, Dario Binacchi wrote:
> The model name was printed only if debug mode was enabled. Now you can
> always get it from sysfs.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 843e8b0522f7..89157deebfcb 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -529,6 +529,17 @@ static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
>  static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
>  		M12_REGISTER_REPORT_RATE, NO_REGISTER, 0, 255);
>  
> +static ssize_t model_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", tsdata->name);

There is sysfs_emit() that is preferred to be used in sysfs handlers.
Same comment applies to the patches following this one.

I made the change and applied.

Thanks.

-- 
Dmitry
