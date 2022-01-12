Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49948C77A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354739AbiALPov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiALPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:44:47 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606B1C06173F;
        Wed, 12 Jan 2022 07:44:47 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id q16-20020a4a3010000000b002dde2463e66so644390oof.9;
        Wed, 12 Jan 2022 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQ1EKtddb8r/SYqNKOBZVPGJIWMdXlHw1bfiu0iSTxc=;
        b=SULidpysawx03RrXYnyJTkCZW0ZnAolf8xxJCfpJr09TaNFgO5pzhzcoCdw9rtDZFK
         B/omUYy6JgxxgqWteLqhm1+eH2vy0CTFcg0XwN5LMF6GBqBMXA6SBqVbiBSAPYQVJIJK
         FdEtD/O07zQZd5K8v/h3HhVrVc92RNZMBOP5oLl9zTqaLrfLeH2goElA+9BmeILoODqv
         DKEkWV4GZh3IPTRNzMcgIjt1p6Te4X3CM40lbWtDB7FMBCfnX83Bl2YBqftMupkokSmi
         bmb4Q1MPkSM4wBKBhD+CxwbhfxVIzs3l7j14CMBHbwXBck/puMSEGXP9d+AbkpbpAL84
         CJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eQ1EKtddb8r/SYqNKOBZVPGJIWMdXlHw1bfiu0iSTxc=;
        b=AO3FefDu8ylX6/1A7yE6dBgFApeHxmjTbKbm8QqjJ0E1dmexb4fWOEzTg+krDoCrEn
         wwtGnMp+CxFsuuHusIJP6jODpv2LtdBE5w0FPgqi355P4e/iAhy4U2XPbiu64RatfFiB
         YOinAfaTceA/CeTTlL2dx+1hnaNT+jwaa4NhTsV6jivDG1rWOKUOnDLjH8Lamn/EkQsU
         kqIU7PtQPkjcVD6ubUYRhDXSkUIGfe9hQ/qk7+QBh0ngBG6gpN+eDLQ1RRrtxhfwiOKu
         hjCdOy1T3TgUHsjftpCgcIBzyX1aVgOeaS6wlUWy8et+xlfWPMDU1bVRwKgH4gFO/siy
         tVhg==
X-Gm-Message-State: AOAM5313J1Ayhcu9Ey0CTWi7YwZqdQKWeaFCOcSHKaukmt28ypAD894b
        ZC/NOXt0mekKmxffiM4yD7bv/Sihnk0=
X-Google-Smtp-Source: ABdhPJw5iNgofLS58LWcsj30EhP9t4lWzTVA/lC7IVXLjIp8AIgJitaY0xmTD3G3rcNnaLsAFU12ag==
X-Received: by 2002:a4a:da08:: with SMTP id e8mr93059oou.68.1642002286353;
        Wed, 12 Jan 2022 07:44:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j23sm28915oii.0.2022.01.12.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 07:44:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Jan 2022 07:44:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     cgel.zte@gmail.com
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers/hwmon: remove redundant freq variable
Message-ID: <20220112154444.GA386615@roeck-us.net>
References: <20220112082602.667614-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112082602.667614-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:26:02AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value directly instead of taking this in another redundant
> variable.
> 

Again, please stop sending me such patches. And, again, the variable
is not "redundant" even though there is a partial match in meaning.
A better term would be "unnecessary". However, as mentioned before,
that is POV because we don't know if the original submitter kept
the variable to simplify adding debug code.

Guenter

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/hwmon/w83627hf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> index 9be277156ed2..0feb581975cf 100644
> --- a/drivers/hwmon/w83627hf.c
> +++ b/drivers/hwmon/w83627hf.c
> @@ -283,9 +283,7 @@ static int TEMP_FROM_REG(u8 reg)
>  
>  static inline unsigned long pwm_freq_from_reg_627hf(u8 reg)
>  {
> -	unsigned long freq;
> -	freq = W83627HF_BASE_PWM_FREQ >> reg;
> -	return freq;
> +	return W83627HF_BASE_PWM_FREQ >> reg;
>  }
>  static inline u8 pwm_freq_to_reg_627hf(unsigned long val)
>  {
> -- 
> 2.25.1
> 
