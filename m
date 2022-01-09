Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24988488CB0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiAIVut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAIVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:50:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AEEC06173F;
        Sun,  9 Jan 2022 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8A9EBuuFLCjf49rIJT7a1YTOiOCs0PjdbuyZU9+YH7s=; b=Ej2FV30VKUe0A674Wm3Bg2w5aR
        fkF1MGVG6cms6XSAw9i1X/er9Vy6Bng92VdEOvwQQ+4fcYxQc/m8aiK6QfAgZKIwugT6rV5ATww7e
        8eXDC+kgDxry1bvNqnjPc6Ho410LCvWlwknNKTCLsFIUHIV8l4VnwIOE43tO9Wp4UXizwAgU1Gmp7
        5jtZK0hiCHKOZxZvwwvswZRqW//MPCzq4sUlyhW6CIAcrm1uMz8dl3GzwRy1uSBBkcqJrowwmg24h
        IVv2HH2iNhuI3cavtXlqdd90SHxNCxIvm+n0AbZD+uwL4lUr6f/AKwf61ZeOUhyQG+2UWFHLDUwOR
        dagjdU5g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6g5E-001t01-Km; Sun, 09 Jan 2022 21:50:37 +0000
Message-ID: <56f9081a-bb0d-deb1-09cf-da34b4e9e776@infradead.org>
Date:   Sun, 9 Jan 2022 13:50:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 1/3] Documentation: admin-guide: Update i8k driver name
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220109214248.61759-1-W_Armin@gmx.de>
 <20220109214248.61759-2-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220109214248.61759-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/22 13:42, Armin Wolf wrote:
> The driver should be called dell_smm_hwmon, i8k is only
> an alias now.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  .../admin-guide/kernel-parameters.txt         | 29 ++++++++++++-------
>  1 file changed, 18 insertions(+), 11 deletions(-)
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
> --
> 2.30.2
> 

-- 
~Randy
