Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F7558823B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiHBTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiHBTCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:02:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1F54640
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:02:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m4so5772228ejr.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5XGKPAZehpjIbBHNoqFU/QMw0NFWXHGxjALKpRQuH/Q=;
        b=3ZN8i5AIfRKO069Nl4yIu0bs6n64efLqeQGmt5KIIGfw9TyDf7YVvIirjzhVs6e5UN
         zzi56vDz4WA+E56LQsSqnbPAdaf+/kz2WSZ9HtvuzLxbKQDg7V94x8hdI/Qh1Mx75jhw
         1aV49dQ/Ad2Ex2NQSekRllBzFNJCSEAadstPN6FPzwrsbSd5ScgTcqNQlWffUe3iO3mR
         a+lRihDvuNsHOCOPGQthnm0Xub07HuqR73zVbSL5qDXkzMYOrOVqWydoS71S6MGcUpHy
         FAcQIsLprR8HM7IEhaI+AjJSPne5LTH+/tnPEI0wbaIYmWWwxvLp2HMZIu+aL9bng1ng
         CKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XGKPAZehpjIbBHNoqFU/QMw0NFWXHGxjALKpRQuH/Q=;
        b=xRG881/2hvvPf2DlmjrcXbMG8n+7ij2uEySdnSJJB8uZcbdbSSG0ieToLDxkBCGGv8
         0rHndpK1ujzs9WCmnJGyO8wIjwdGjwwhpWOV+JwyW33r6FBfsXMVikhrd44QdfJNMwtS
         mjLw9YtvBqK6v6mjFHj0deNzbyLvd7F80bT3A3BDLowZL9DC4xFqJXKjAWffkaoiecRy
         G3b6UTRef651D5yN1cuYWx0BfqAiWV3fWT0uRTF0BhRMP8GSYc1FfhVBJ+26oqSFtl2m
         iMENl1Pb68WHM8CQ1RmIqW40H0O6hpsCH0eW9qSqor5SwDnIRBNw3jTUFAaEbRKchA5m
         KivQ==
X-Gm-Message-State: AJIora+neBDXAyX0ie6vN9Ujl2CKVVEAmPwX+SFgYjnRORmJAd5sWr1G
        tHInai9f2OE1hOTVHMXCRs5i6Q==
X-Google-Smtp-Source: AGRyM1sAt6kPLLurtO4mZK2puhY0Vn2/KI2C0fcZE+l17gCGQVHMOvfaFg99haziKBp5pqXXhw64xA==
X-Received: by 2002:a17:907:9803:b0:72e:ec55:b2a5 with SMTP id ji3-20020a170907980300b0072eec55b2a5mr17483035ejc.347.1659466942030;
        Tue, 02 Aug 2022 12:02:22 -0700 (PDT)
Received: from OEMBP14.local (82-132-212-195.dab.02.net. [82.132.212.195])
        by smtp.gmail.com with ESMTPSA id i28-20020a0564020f1c00b0043d5c9281a3sm5341500eda.96.2022.08.02.12.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 12:02:21 -0700 (PDT)
Date:   Tue, 2 Aug 2022 20:02:18 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Grzegorz Szymaszek <gszymaszek@short.pl>
Cc:     Greg KH <greg@kroah.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: r8188eu: add firmware dependency
Message-ID: <Yul0urtdPUWoCuVe@OEMBP14.local>
References: <YukkBu3TNODO3or9@nx64de-df6d00>
 <YukvnVWuhUeOgRyZ@kroah.com>
 <Yukx8KEEOhKTJ7HQ@nx64de-df6d00>
 <c82114b6-1003-bfb5-0550-98dcbf1a3761@lwfinger.net>
 <YulcdKfhA8dPQ78s@nx64de-df6d00>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YulcdKfhA8dPQ78s@nx64de-df6d00>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 07:18:44PM +0200, Grzegorz Szymaszek wrote:
> The old rtl8188eu module, removed in commit 55dfa29b43d2 ("staging:
> rtl8188eu: remove rtl8188eu driver from staging dir") (Linux kernel
> v5.15-rc1), required (through a MODULE_FIRMWARE call()) the
> rtlwifi/rtl8188eufw.bin firmware file, which the new r8188eu driver no
> longer requires.
> 
> I have tested a few RTL8188EUS-based Wi-Fi cards and, while supported by
> both drivers, they do not work when using the new one and the firmware
> wasn't manually loaded. According to Larry Finger, the module
> maintainer, all such cards need the firmware and the driver should
> depend on it (see the linked mails).
> 
> Add a proper MODULE_FIRMWARE() call, like it was done in the old driver.
> 
> Thanks to Greg Kroah-Hartman and Larry Finger for quick responses to my
> questions.
> 
> Link: https://answers.launchpad.net/ubuntu/+source/linux-meta-hwe-5.15/+question/702611
> Link: https://lore.kernel.org/lkml/YukkBu3TNODO3or9@nx64de-df6d00/
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>  drivers/staging/r8188eu/os_dep/os_intfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 891c85b088ca..5bd3022e4b40 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -18,6 +18,7 @@ MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
>  MODULE_AUTHOR("Realtek Semiconductor Corp.");
>  MODULE_VERSION(DRIVERVERSION);
> +MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
>  
>  #define CONFIG_BR_EXT_BRNAME "br0"
>  #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */
> -- 
> 2.35.1

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Thanks for the patch :-)

Regards,
Phil
