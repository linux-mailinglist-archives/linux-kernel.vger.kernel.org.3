Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6658AA12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiHELZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHELZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:25:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F02CFC;
        Fri,  5 Aug 2022 04:25:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso8042900pjq.0;
        Fri, 05 Aug 2022 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=9OJnFc6j+jMFQ3VJlVTxz1Y6ZBCsslvkqoRh7YSY+gc=;
        b=NgZgWOdAtXeKOQKR48La1eH46crY4i8/ow31RZQp6+Vqodt89XNigD0iM4xQXi9Lgd
         3sg7nWjmS+thDrsbxfSyiiobssFWWMH4AR3trZNxzz3+z51gVqCQ0XKSNfJV5OFgUgLl
         Hy15Y9+vzRjtEaZy33mhrhEbkXQ+P449YbcK+k8NANYlxKb141Fwsg5yrxliW9rapgPM
         TaIiDh+6+k8K345aO5mMGrvvOGudfslhNDFlIxh4XGOqi8ip+NHSU8X4yJDuI8KBlDHv
         MWJP6QvGBBRz78r7KVZQC6LO223eflcflCQcOWwNQkgzOdhcnkLClmcir/MzfCv6hAGd
         8dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=9OJnFc6j+jMFQ3VJlVTxz1Y6ZBCsslvkqoRh7YSY+gc=;
        b=0QdF6fNbbm3aD9tGptYAONeYEGfgS3dcGSAU1qFxxvYIKpfDVCxG8mV0pDFIbb+FG7
         vfLCM9i5iQmqCiW69Hhex21gSi1Os3nzH1spo/MCXRWn6hWdNqeIsNZ9cLECCe58ENvq
         yVbHuAUv60cnazSFrpTveiIFQyCP1ltf1BqhH9HEO67ggxi92egMGVxC6WunlKfxJ6G8
         BmfSQs58uqtvft0pAj4teTrrw222kq3TlgZtL0QXvEnPTnk7XmbPnpHvH1D+iqVVJaH1
         EbLgYafPApKfso41JVpdTtzoMjXdVgaDR5S3gh984O7FsHPoErrMyeouLY4HchXVHY2h
         jJmA==
X-Gm-Message-State: ACgBeo0PeDu2hHbKwvX9EUrmRaclexXsvK8VUHYWzlUruBygQXKXgtZb
        R2r+mLmoCehrxEUeYgpxpp4=
X-Google-Smtp-Source: AA6agR5TmqEQvyHu/cEfipyBWoLfEWMf2SOIgibHXRy5ODPvSyeas9tXWj8Md5PK5//HXxJhunYN4w==
X-Received: by 2002:a17:90a:7b89:b0:1f3:26f3:d7c0 with SMTP id z9-20020a17090a7b8900b001f326f3d7c0mr15723072pjc.43.1659698713945;
        Fri, 05 Aug 2022 04:25:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d123-20020a623681000000b0052ce4074fddsm2807114pfa.145.2022.08.05.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:24:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Aug 2022 04:24:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: Re: [PATCH v4 2/7] usb: typec: tcpci_rt1711h: Fix vendor setting
 when set vconn
Message-ID: <20220805112441.GA1011279@roeck-us.net>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
 <20220805071714.150882-3-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071714.150882-3-gene.chen.richtek@gmail.com>
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

On Fri, Aug 05, 2022 at 03:17:08PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> replace overwrite whole register with update bits
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 3291ca4..f2f1fb0 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -5,6 +5,7 @@
>   * Richtek RT1711H Type-C Chip Driver
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -23,6 +24,7 @@
>  #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>  			    (((ck300) << 7) | ((ship_off) << 5) | \
>  			    ((auto_idle) << 3) | ((tout) & 0x07))
> +#define RT1711H_AUTOIDLEEN	BIT(3)
>  
>  #define RT1711H_RTCTRL11	0x9E
>  
> @@ -109,8 +111,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
>  {
>  	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
>  
> -	return rt1711h_write8(chip, RT1711H_RTCTRL8,
> -			      RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
> +	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
> +				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);
>  }
>  
>  static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
> -- 
> 2.7.4
> 
