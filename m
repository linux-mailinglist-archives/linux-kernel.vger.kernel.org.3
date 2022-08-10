Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067FE58F074
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiHJQb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiHJQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:31:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9878E792E6;
        Wed, 10 Aug 2022 09:31:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k14so12144081pfh.0;
        Wed, 10 Aug 2022 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=ldG5HBksWv2c1zj54Qdg3FSVmZNOpeO/llQQUO6k+N8=;
        b=pgVThpEPNleIvyzkpg4e80gocHudfi53vITQrqs7zln3sLYlAd9qDYRQc8uePodU7S
         3emmpure3uCu/e87z9cnqFy8oaT53Ea2jzro9nAQ4kGuVBDHolxv4xO5rpVxfuqiXHFr
         19bjPxWHFar9WkTihApC8x5kRWVB/cvU4ZoPDNBmOSh9TvlznqGKazW+MGdY6iyWcP48
         4zOSENAnTAXboXv1scTifStROmKFCKiBzd/Yzc909yvdb/ritRuNHxEJ6aiR4ZBKgQcJ
         uPwC31ysvd59PsunQiaMg8iuq+kZiok4PVl3HmWynRZ18WikuYokjmhFbcqPIP839kBI
         yd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=ldG5HBksWv2c1zj54Qdg3FSVmZNOpeO/llQQUO6k+N8=;
        b=Zdru+JP8Qh9x+WVyURvFa6ibtGP6QLexwXPTGc2J7AzTwVtR1RMjyjmgePF3k3af2p
         v75GnD9PQ4dvLgy6g4jucdVo6SXaPYfRaB+5HUdTriq42oIjA9F73alekRBHOq3VPQ0E
         9hg5d/3C40aVMFxBoiOwyvuVLDDMLm2vwWKn0/4U8fS+YAqd7ZctFOsECgfFDVXxGqwy
         2q9u4htbLOm2n6ii2BmZjyGDKW+J0XU/a0vjDhJ2TYA5ZmL8p0gmtVqdhkZo9gd/hA6a
         nH/30Qhlvsr6tkduM1Aj42I9UFSsIM0LmZ04zhMSFP7bqrBkrCTCOUgRJ70xqh62n7UW
         qfWg==
X-Gm-Message-State: ACgBeo2CErmGglL+SuPt2dY4K/wEh0/obFpJ01Axf76/3y70Ig+CqYMw
        V7R3YUKNsrzs2ZHCy2X+TVA=
X-Google-Smtp-Source: AA6agR7eJsRuLe38BbPVzWp4jcPepdPdcibX479FyAKc+luacMXBj7+RUzl0S9HPPRz4NQ0h2oDIDQ==
X-Received: by 2002:a63:d646:0:b0:41a:6c24:d829 with SMTP id d6-20020a63d646000000b0041a6c24d829mr23629956pgj.470.1660149083148;
        Wed, 10 Aug 2022 09:31:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b0016ee708350bsm13449901plg.14.2022.08.10.09.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:31:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
Date:   Wed, 10 Aug 2022 09:31:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org
References: <YvO4cfx12Q9gcmPg@monster.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YvO4cfx12Q9gcmPg@monster.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 06:53, Wilken Gottwalt wrote:
> Add reporting if the PSU is running in single or multi rail mode via
> ocpmode debugfs entry. Also update the documentation accordingly.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v2:
>    - fixed spelling issues in commit message

You did not address or even provide feedback on my second comment.

Guenter

> ---
>   Documentation/hwmon/corsair-psu.rst |  5 +++--
>   drivers/hwmon/corsair-psu.c         | 21 ++++++++++++++++++++-
>   2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index e8378e7a1d8c..c3a76305c587 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -86,8 +86,9 @@ Debugfs entries
>   ---------------
>   
>   =======================	========================================================
> -uptime			Current uptime of the psu
> +ocpmode                 Single or multi rail mode of the PCIe power connectors
> +product                 Product name of the psu
> +uptime			Session uptime of the psu
>   uptime_total		Total uptime of the psu
>   vendor			Vendor name of the psu
> -product			Product name of the psu
>   =======================	========================================================
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 14389fd7afb8..9d103613db39 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -71,9 +71,10 @@
>   #define PSU_CMD_RAIL_WATTS	0x96
>   #define PSU_CMD_VEND_STR	0x99
>   #define PSU_CMD_PROD_STR	0x9A
> -#define PSU_CMD_TOTAL_WATTS	0xEE
>   #define PSU_CMD_TOTAL_UPTIME	0xD1
>   #define PSU_CMD_UPTIME		0xD2
> +#define PSU_CMD_OCPMODE		0xD8
> +#define PSU_CMD_TOTAL_WATTS	0xEE
>   #define PSU_CMD_INIT		0xFE
>   
>   #define L_IN_VOLTS		"v_in"
> @@ -268,6 +269,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>   		break;
>   	case PSU_CMD_TOTAL_UPTIME:
>   	case PSU_CMD_UPTIME:
> +	case PSU_CMD_OCPMODE:
>   		*val = tmp;
>   		break;
>   	default:
> @@ -660,6 +662,22 @@ static int product_show(struct seq_file *seqf, void *unused)
>   }
>   DEFINE_SHOW_ATTRIBUTE(product);
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
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ocpmode);
> +
>   static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
>   {
>   	char name[32];
> @@ -671,6 +689,7 @@ static void corsairpsu_debugfs_init(struct corsairpsu_data *priv)
>   	debugfs_create_file("uptime_total", 0444, priv->debugfs, priv, &uptime_total_fops);
>   	debugfs_create_file("vendor", 0444, priv->debugfs, priv, &vendor_fops);
>   	debugfs_create_file("product", 0444, priv->debugfs, priv, &product_fops);
> +	debugfs_create_file("ocpmode", 0444, priv->debugfs, priv, &ocpmode_fops);
>   }
>   
>   #else

