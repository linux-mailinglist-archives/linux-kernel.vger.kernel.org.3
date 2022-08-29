Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74C55A4E45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiH2Ngb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiH2NgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:36:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224757E33E;
        Mon, 29 Aug 2022 06:35:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 69so6064996pgb.13;
        Mon, 29 Aug 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=UVKTlnEIoldY+2ikvWrlNXqFFlr5euSvQ86GnWaZaho=;
        b=YwxHVBDf26Yi73o5+r444WKY7QqwFOzTEnFjSo8Bow1lqIga+JCUW7EEEpDsZ6iPSK
         Z04YZvt1Pt6J6R1j5ZWOXINdtvMh1pKvRTW8x5OhmpXBkvTcaZo99jG0R4UChrIVPpD/
         GN3nf064cXJje0jWsQM+sFauz1vZ72PjZOG8m93aXj5VevRQMfTGagenqg8i79vq41t+
         4EtR5LLe8uItIbwb9EYJ4VyQOrkBmI8ENvppF9JhEyUMFcTV0/F7ZyXRpsAeOX6AVX3f
         CfKEhMu3GIXMTbOOXnQ5LfMsYV0Xsrua1peWIMOdlhxqLg+MBpyOigdEcuY+NT3ev+xs
         cJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=UVKTlnEIoldY+2ikvWrlNXqFFlr5euSvQ86GnWaZaho=;
        b=r6XP28DAGdnVxZ1mFxBVXmqSpjnNAUPijebHWBFQGgZ+dwZt2Pcu4VT0TrZS4Yhw3s
         VsyN5wfzxsQyCe8XuQgvQJ4OHOL4feq9UD+SzvzReI4EoQmTDCTiiUhsWSr4G9E5bZxk
         5yNciwzEZ5bK73u/PdDeDzBAUaSKHjtX480SIZVoMHkh1dgV+vPxRfF9Ow8tlpbW6M2J
         atLn9A3WpoGrg91vErzunusNwAE60HtaVlVeHHs/exqOBd7rNV8GE6BCroJlmCxXjGPE
         68bIIF61OddUdjrWKZpkU+JdJMb9VmvJ6Fa9pLXGw5f55ZbQ7AurXzPB0BF4vkGwz6It
         g/hQ==
X-Gm-Message-State: ACgBeo2iHFwllIFAyUeeLn4M7QJh7tq2wS5/WSMuEJjj/tuUUMZ9vj/4
        ykV+R2P2xB2po7UL0NuQAjY=
X-Google-Smtp-Source: AA6agR4Cq2eaFxLjb3w99Ke4qD7S6eU85utxglvjTiCUilxN+MxnvuBKvF7gr8nmE7JBAiM3RRhaPA==
X-Received: by 2002:a63:6cc1:0:b0:42b:d2c5:74a2 with SMTP id h184-20020a636cc1000000b0042bd2c574a2mr6952942pgc.420.1661780158463;
        Mon, 29 Aug 2022 06:35:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 35-20020a630c63000000b0041c35462316sm6409401pgm.26.2022.08.29.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:35:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:35:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        markgross@kernel.org
Subject: Re: [PATCH] asus-wmi: Increase FAN_CURVE_BUF_LEN to 32
Message-ID: <20220829133556.GA3766826@roeck-us.net>
References: <20220828074638.5473-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828074638.5473-1-luke@ljones.dev>
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

On Sun, Aug 28, 2022 at 07:46:38PM +1200, Luke D. Jones wrote:
> Fix for TUF laptops returning with an -ENOSPC on calling
> asus_wmi_evaluate_method_buf() when fetching default curves. The TUF method
> requires at least 32 bytes space.
> 
> This also moves and changes the pr_debug() in fan_curve_check_present() to
> pr_warn() in fan_curve_get_factory_default() so that there is at least some
> indication in logs of why it fails.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3d9fd58573f9..11203213e00d 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -108,7 +108,7 @@ module_param(fnlock_default, bool, 0444);
>  #define WMI_EVENT_MASK			0xFFFF
>  
>  #define FAN_CURVE_POINTS		8
> -#define FAN_CURVE_BUF_LEN		(FAN_CURVE_POINTS * 2)
> +#define FAN_CURVE_BUF_LEN		32
>  #define FAN_CURVE_DEV_CPU		0x00
>  #define FAN_CURVE_DEV_GPU		0x01
>  /* Mask to determine if setting temperature or percentage */
> @@ -2383,8 +2383,10 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>  	curves = &asus->custom_fan_curves[fan_idx];
>  	err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
>  					   FAN_CURVE_BUF_LEN);
> -	if (err)
> +	if (err) {
> +		pr_warn("%s (0x%08x) failed: %d\n", __func__, fan_dev, err);
>  		return err;
> +	}
>  
>  	fan_curve_copy_from_buf(curves, buf);
>  	curves->device_id = fan_dev;
> @@ -2402,9 +2404,6 @@ static int fan_curve_check_present(struct asus_wmi *asus, bool *available,
>  
>  	err = fan_curve_get_factory_default(asus, fan_dev);
>  	if (err) {
> -		pr_debug("fan_curve_get_factory_default(0x%08x) failed: %d\n",
> -			 fan_dev, err);
> -		/* Don't cause probe to fail on devices without fan-curves */

The pr_warn() should be here. If you want to have a message from the call
in fan_curve_enable_store(), add dev_err() there.

Guenter

>  		return 0;
>  	}
>  
