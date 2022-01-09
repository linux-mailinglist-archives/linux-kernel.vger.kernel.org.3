Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD0488C35
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiAIUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiAIUMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:12:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1FC06173F;
        Sun,  9 Jan 2022 12:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NBZl4c1tCrOUmT1h/EIDHqn5PYk7y4ypjEsGNtaVc0s=; b=CRylDlkhrWPCTO7uvXCGBm8Xiv
        MvRnJ/2Pd+4R+DJ7x5p+QOKyeI9vrBvVAImNeh3GtV6Ynpe2jqKH3wYDHpqLsm5IwfDcVoY78Yko7
        n7TkzqBS8R9LlPPIr/0Uy1oV/IK1944vxpJYKe4CRO1/9qQAQ58Fz2CDl4OTm91l4hMZgdfFTJPcT
        WG1m32p5bK/G+5VzdIeSkuAYtV6wO2vqtxwYU/D1wLNy/OMdh6sy8aDiBJLVVyPuhs99+2Aqirw0S
        lvr2hFdtNhZ0hYeX6tXSMC3WJnKFzHyoO+rHrbQkzctdpUj1ZGlIhJy0sSZJI7bv32u3LWAEL6UY3
        M9/Y3vMw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6eYH-001qH8-Nx; Sun, 09 Jan 2022 20:12:30 +0000
Message-ID: <2b65f1f5-5270-a118-5099-b4c4a4fd73f6@infradead.org>
Date:   Sun, 9 Jan 2022 12:12:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH RESEND v2 1/3] Documentation: admin-guide: Update i8k
 driver name
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220109194400.58725-1-W_Armin@gmx.de>
 <20220109194400.58725-2-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220109194400.58725-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/9/22 11:43, Armin Wolf wrote:
> The driver should be called dell_smm_hwmon, i8k is only
> an alias now.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  .../admin-guide/kernel-parameters.txt         | 29 ++++++++++++-------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2fba82431efb..cb1331f85444 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -935,6 +935,24 @@
>  			dump out devices still on the deferred probe list after
>  			retrying.
> 
> +	dell_smm_hwmon.ignore_dmi=
> +			[HW] Continue probing hardware even if DMI data
> +                        indicates that the driver is running on unsupported
> +                        hardware.
> +
> +        dell_smm_hwmon.force=
> +			[HW] Activate driver even if SMM BIOS signature does
> +			not match list of supported models and enable otherwise
> +			blacklisted features.
> +
> +        dell_smm_hwmon.power_status=
> +                        [HW] Report power status in /proc/i8k
> +                        (disabled by default).
> +
> +        dell_smm_hwmon.restricted=
> +			[HW] Allow controlling fans only if SYS_ADMIN
> +                        capability is set.

Please indent all of these with tabs instead of spaces.
It's mixed in this patch.

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
> --
> 2.30.2
> 

thanks.
-- 
~Randy
