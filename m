Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C474548EEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbiANQwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiANQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:52:23 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D54C061574;
        Fri, 14 Jan 2022 08:52:23 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso10700824otj.8;
        Fri, 14 Jan 2022 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3wh3cC6yyoQMZRxCMqS3JvTbsWp7oWzeYAy/77DLWA=;
        b=fy61NF0QGqGVf782Gq5KAJHCOmTpFoek9VOckXt7zUVnDbJItl+LtzZ3b7JS4UmUc0
         /FF2rrLc00+CKlqvDzAsKVK9PkUt7gPKuU55/5ejk8M0SrejS37BbP9VK+5Dz+IxM3VF
         irgyLUlNNoMOWKammNT0yag1kPIJLjmmFX9WuDkakvK44XoM3uzWQQ+Q1M3pTGuKav5i
         iyDPSDUBQHrfUQLrHNgiQXKi/97H3OzqLgdX9vNW8D9713GYMN/a1tvAEh/BsGCvzzV+
         AxGtOxB4/bWRzyQSSSgKqt8N54jf48vCE+SuVPJoudEb8Xz+EQ7mHz2zgVAP1aVE/Uyl
         Z0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=s3wh3cC6yyoQMZRxCMqS3JvTbsWp7oWzeYAy/77DLWA=;
        b=5au/Yiep8U264tS//TKRO/LPTeLtZzuLxzBw550sQNjG6Z0WhZCvnkTPdVn9iVQfaF
         peX/JvUVmUu/gHg2X8BtptvDUS02oTK9XBHtrdlprAiE1Eyj+9KHlXC6SemUzDS77dkw
         ZnMYF6+mN5yGnINx+AImYHas2PtfWFLsQnMoVPrNMZbm/+lC5b2SzfUhSfP5bflbKQde
         7qlCsUPdf8LSV9G4/04pinFWxFvK9QlKA16vZOPBTs9bMGNZ4JLLUrgwxDHlBCAXKrpw
         PKD7UIK5qVz4Lsk6nkyfQPPkPU+0CKXK3Uw+7D4Z0dfKI9OCQuxMOXf40P/PI7IOpHGH
         dtFA==
X-Gm-Message-State: AOAM530MGiepO4SOPbECUXkMtBKDIwiZLbS7f16eZtqu6Vvim77HSXCc
        dsh1+KbWxNA6rFGulT89Wtk=
X-Google-Smtp-Source: ABdhPJwgk/8tfnaow1CaDn/VYB4ACfm0iTYufaTIJT7XNgK3j6QmmfUoGbwRuqPb0dUQFzL3f/hm+Q==
X-Received: by 2002:a9d:60f:: with SMTP id 15mr7014877otn.266.1642179142681;
        Fri, 14 Jan 2022 08:52:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j15sm1892691otp.57.2022.01.14.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:52:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Jan 2022 08:52:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, corbet@lwn.net,
        rdunlap@infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Documentation: admin-guide: Update i8k driver name
Message-ID: <20220114165220.GA1602432@roeck-us.net>
References: <20220109214248.61759-1-W_Armin@gmx.de>
 <20220109214248.61759-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109214248.61759-2-W_Armin@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 10:42:46PM +0100, Armin Wolf wrote:
> The driver should be called dell_smm_hwmon, i8k is only
> an alias now.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Series applied to hwmon-next.

Thanks,
Guenter

> ---
>  .../admin-guide/kernel-parameters.txt         | 29 ++++++++++++-------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2fba82431efb..52de7cd06858 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -935,6 +935,24 @@
>  			dump out devices still on the deferred probe list after
>  			retrying.
> 
> +	dell_smm_hwmon.ignore_dmi=
> +			[HW] Continue probing hardware even if DMI data
> +			indicates that the driver is running on unsupported
> +			hardware.
> +
> +	dell_smm_hwmon.force=
> +			[HW] Activate driver even if SMM BIOS signature does
> +			not match list of supported models and enable otherwise
> +			blacklisted features.
> +
> +	dell_smm_hwmon.power_status=
> +			[HW] Report power status in /proc/i8k
> +			(disabled by default).
> +
> +	dell_smm_hwmon.restricted=
> +			[HW] Allow controlling fans only if SYS_ADMIN
> +			capability is set.
> +
>  	dfltcc=		[HW,S390]
>  			Format: { on | off | def_only | inf_only | always }
>  			on:       s390 zlib hardware support for compression on
> @@ -1694,17 +1712,6 @@
> 
>  	i810=		[HW,DRM]
> 
> -	i8k.ignore_dmi	[HW] Continue probing hardware even if DMI data
> -			indicates that the driver is running on unsupported
> -			hardware.
> -	i8k.force	[HW] Activate i8k driver even if SMM BIOS signature
> -			does not match list of supported models.
> -	i8k.power_status
> -			[HW] Report power status in /proc/i8k
> -			(disabled by default)
> -	i8k.restricted	[HW] Allow controlling fans only if SYS_ADMIN
> -			capability is set.
> -
>  	i915.invert_brightness=
>  			[DRM] Invert the sense of the variable that is used to
>  			set the brightness of the panel backlight. Normally a
