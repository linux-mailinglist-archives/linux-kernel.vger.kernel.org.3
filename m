Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6635758ED45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiHJNaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiHJNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:30:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659521B7;
        Wed, 10 Aug 2022 06:30:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z19so14253760plb.1;
        Wed, 10 Aug 2022 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ohl92CQuRhESHtwQxZEMJGVLnoJq8U54PHyx1qfYRJg=;
        b=l+qPlKn1d4i+hk3n3IaUiEvwJRcpcXN6RJICZH1ImhXT4UHc5m/QYBQt11gao33vKk
         hKqewCizzqNvifDGsK4daDi17OX0Po4CRfGuFlUgzJAwXnXy5piPpig2aIDjWOoo6Npu
         lBY3nK6aWR8/jVLuNA1Y+anoXzDftLfW3dCF9X6ZUoJFeeKuNTd0sG83KIpJXQRvih8k
         npRt6TK4GtaTvhvdNyD3COiksdpAYtNTxu9fr2nFh4xO3sBAgvIAJHeMJxPxT6wgVz1Q
         S0XmWtdrzglgTdaZ08H0NtKNAjJZ02AwhDYagqqaL4JxRjUwQ127xB0vO1/MLkPyCyhM
         VF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ohl92CQuRhESHtwQxZEMJGVLnoJq8U54PHyx1qfYRJg=;
        b=qKKnL6tUbjS7FpyjGFSHyU1sAMCRMs+JjRAtHpmAiyzKZIAqBvvk1Mfm7ye7O+ch+7
         nyzdY1KUqviu3THAtpJ4y3bYJtH6lpUt35uF1m06brPg//WVFophblnSbmo0SlnldIkk
         x0MaP/tojkF8bfFhmzczZzxeMtG165sAOKv7u0db0BJPPInmqpNLkfa6vFYKvexvBkcH
         mj0AIBLDQknB282WwZhQdeTh4GKh+lSsjjrESnerXYa3L4W+Zdr1CZqBZZy76k1X/aCg
         JLv3nM95ObWOTbGMoQxAVLznGwpf4pAOmJra8HIfejMDfKXzUeZlcZsvMo2/ssOMxyPp
         FIDw==
X-Gm-Message-State: ACgBeo2wS9M91VgHJEl9eN4SazBKh3boIXFftuT97/ZP6mtK2CfB1AxP
        IrhTyEcsyKYA6XPl+wAkkyU=
X-Google-Smtp-Source: AA6agR59qnSGP6yr2A6rXmpT9oob62sPQtCj/+xfSkr36oeW3Ha2kpSCWJs5KexgQYDCNHucILTtJQ==
X-Received: by 2002:a17:90a:7005:b0:1f5:53cc:7336 with SMTP id f5-20020a17090a700500b001f553cc7336mr3791345pjk.27.1660138214224;
        Wed, 10 Aug 2022 06:30:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf8-20020a170902b90800b001709e3c750dsm7561437plb.194.2022.08.10.06.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:30:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 10 Aug 2022 06:30:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Message-ID: <20220810133012.GB274220@roeck-us.net>
References: <YvN4SbnAp3jl+Vzo@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvN4SbnAp3jl+Vzo@monster.localdomain>
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

On Wed, Aug 10, 2022 at 09:20:09AM +0000, Wilken Gottwalt wrote:
> Adds reporting via debugfs if the PSU is running in single or multi rail
> mode. Also updates the documentation accordingly.
> 

Please use imperative mode.

"Adds reporting" -> Report
"updates" -> update

See Documentation/process/submitting-patches.rst,
"Describe your changes".

> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
>  Documentation/hwmon/corsair-psu.rst |  5 +++--
>  drivers/hwmon/corsair-psu.c         | 21 ++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index e8378e7a1d8c..c3a76305c587 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -86,8 +86,9 @@ Debugfs entries
>  ---------------
>  
>  =======================	========================================================
> -uptime			Current uptime of the psu
> +ocpmode                 Single or multi rail mode of the PCIe power connectors
> +product                 Product name of the psu
> +uptime			Session uptime of the psu
>  uptime_total		Total uptime of the psu
>  vendor			Vendor name of the psu
> -product			Product name of the psu
>  =======================	========================================================
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 14389fd7afb8..9d103613db39 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -71,9 +71,10 @@
>  #define PSU_CMD_RAIL_WATTS	0x96
>  #define PSU_CMD_VEND_STR	0x99
>  #define PSU_CMD_PROD_STR	0x9A
> -#define PSU_CMD_TOTAL_WATTS	0xEE
>  #define PSU_CMD_TOTAL_UPTIME	0xD1
>  #define PSU_CMD_UPTIME		0xD2
> +#define PSU_CMD_OCPMODE		0xD8
> +#define PSU_CMD_TOTAL_WATTS	0xEE
>  #define PSU_CMD_INIT		0xFE
>  
>  #define L_IN_VOLTS		"v_in"
> @@ -268,6 +269,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  		break;
>  	case PSU_CMD_TOTAL_UPTIME:
>  	case PSU_CMD_UPTIME:
> +	case PSU_CMD_OCPMODE:
>  		*val = tmp;
>  		break;
>  	default:
> @@ -660,6 +662,22 @@ static int product_show(struct seq_file *seqf, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(product);
>  
> +static int ocpmode_show(struct seq_file *seqf, void *unused)
> +{
> +	struct corsairpsu_data *priv = seqf->private;
> +	long val;
> +	int ret;
> +
> +	ret = corsairpsu_get_value(priv, PSU_CMD_OCPMODE, 0, &val);
> +	if (ret < 0)
> +		seq_puts(seqf, "N/A\n");
> +	else
> +		seq_printf(seqf, "%s\n", (val == 0x02) ? "multi rail" : "single rail");

If this is not always available, would it be better not to create the file
in the first place ? If that is not feasible, it should at least be
documented that the value is not always available to ensure that no one
complains about it (or at least no one who read the documentation).

Also, is the value strictly 0x02 for multi-rail configurations, or
is that possibly just a bit or the number of rails ?

Thanks,
Guenter

> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ocpmode);
> +
>  static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
>  {
>  	char name[32];
> @@ -671,6 +689,7 @@ static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
>  	debugfs_create_file("uptime_total", 0444, priv->debugfs, priv, &uptime_total_fops);
>  	debugfs_create_file("vendor", 0444, priv->debugfs, priv, &vendor_fops);
>  	debugfs_create_file("product", 0444, priv->debugfs, priv, &product_fops);
> +	debugfs_create_file("ocpmode", 0444, priv->debugfs, priv, &ocpmode_fops);
>  }
>  
>  #else
> -- 
> 2.37.1
> 
