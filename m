Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71FB5897DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiHDGsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiHDGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:48:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE63A485;
        Wed,  3 Aug 2022 23:47:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso4371687pjq.0;
        Wed, 03 Aug 2022 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=lJ2RcUH4YfpT8xs7Cl3kJdao+iEwbE0ETrJv8eZGZ68=;
        b=pJ66Y+HXik9WqKVgF5atP1aNTacZkeLEM1AtfQWKWaBNA6QJLpA8yjCILmasHfZe7D
         Mk2xj1+I6hLWfz84LI1ANXBKYUEIlv1Efp/jiLYPzlmV04nW1B+HgHjc089ep6D+M7Zk
         PDk3zlAtKDac4MbAfXXHjrmTUTdqlr1lDcf74H/vHOrQyBI84cg/yvWVUXhFXDd7rwbd
         h9gwh0MjsWX+p2xjvkh/KxbXzb/ETHEGGNmd5sf/LSN8Uu3hcgaYX4fnE60mGl0+SO5a
         sdaE6VNRC7J+Fh9SiU8wJYDc22Tb3md0ECoU3Upw+7ZokkZZEPLz6yqVXek5jQoL/Wk0
         RjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=lJ2RcUH4YfpT8xs7Cl3kJdao+iEwbE0ETrJv8eZGZ68=;
        b=h8cxgeEXa3thPmdDHn2/awvod+p2EXNmX8LuxrIPg+w8/3Efv/jKl8HyXrUUmK3g8k
         VHhiozZbGZE4T4hOdhX84j6xbB8MTq9y15/RrTGgpWTb9bqDv4zHIPSbPcRR6pJSmTm0
         f6j9nrNzRrHIyYuUkEzf4BzR/pBGgGXBKQzaZqXXZv/JHuEvO+vs0KKEgI/RRveVHUeC
         6vauEKJ0kPj9I23pnYGVB4m3RrzFaARtwuhB8JM3z+qKiBupg/+3J2WfQdm0EFmax/aH
         X749Tok0oL0BA7bIUwOWmLu5cszves4zzLgTzjS3NzTET6Nfyk8jpemE7byYk2fkvlve
         y2CQ==
X-Gm-Message-State: ACgBeo1hvMOY0Zhk9Oc0Ak0g6syg5uO6qEWPvJw0S//Uo7/d/LveV9qr
        8E3ZgAabNSh6s/UGXPHVBp37niHCklC+f9SD
X-Google-Smtp-Source: AA6agR5lzyXnqthclTBCvytEE7zd3YDciHYQ19JqVTciDnAc1KNZNlX65VcV2eJefP7u4brPPngVGw==
X-Received: by 2002:a17:903:247:b0:16c:5017:9ad4 with SMTP id j7-20020a170903024700b0016c50179ad4mr560350plh.115.1659595678605;
        Wed, 03 Aug 2022 23:47:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1-20020aa79a01000000b00528f9597fb3sm19808pfj.197.2022.08.03.23.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:47:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 3 Aug 2022 23:47:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jack Champagne <jackchampagne.r@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] hwmon: (ads7828) Rename regmap_config variable
Message-ID: <20220804063234.GA4122108@roeck-us.net>
References: <20220803174356.474969-1-jackchampagne.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803174356.474969-1-jackchampagne.r@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 01:43:56PM -0400, Jack Champagne wrote:
> The regmap_config variable for the ads7828 and the ads7830 are both
> misnamed to `ads2828_regmap_config` and `ads2830_regmap_config`
> respectively. These variables refer to regmap configs for the ads7828
> and the ads7830 and should be named accordingly.
> 
> This patch does not introduce functional changes as the only two usages
> of these regmap_config variables are within the changed file.
> 
> Signed-off-by: Jack Champagne <jackchampagne.r@gmail.com>

Please refrain from submitting patches with non-functional changes
like this one unless you are also submitting patches with functional
changes.

Guenter

> ---
>  drivers/hwmon/ads7828.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
> index 7246198f0901..20bdee769882 100644
> --- a/drivers/hwmon/ads7828.c
> +++ b/drivers/hwmon/ads7828.c
> @@ -89,12 +89,12 @@ static struct attribute *ads7828_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(ads7828);
>  
> -static const struct regmap_config ads2828_regmap_config = {
> +static const struct regmap_config ads7828_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  };
>  
> -static const struct regmap_config ads2830_regmap_config = {
> +static const struct regmap_config ads7830_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  };
> @@ -152,11 +152,11 @@ static int ads7828_probe(struct i2c_client *client)
>  	if (chip == ads7828) {
>  		data->lsb_resol = DIV_ROUND_CLOSEST(vref_mv * 1000, 4096);
>  		data->regmap = devm_regmap_init_i2c(client,
> -						    &ads2828_regmap_config);
> +						    &ads7828_regmap_config);
>  	} else {
>  		data->lsb_resol = DIV_ROUND_CLOSEST(vref_mv * 1000, 256);
>  		data->regmap = devm_regmap_init_i2c(client,
> -						    &ads2830_regmap_config);
> +						    &ads7830_regmap_config);
>  	}
>  
>  	if (IS_ERR(data->regmap))
> -- 
> 2.25.1
> 
