Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E119249D8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiA0DGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiA0DGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:06:30 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA2C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:06:30 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q75so1063114pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xYVfPUL0HT1HfQJFKeNSl4bObGkqhbPgG9tLiL2+h0I=;
        b=SevtvM6HXv4iELfguL2woPmkXMhHim46mAMmEMP0q6swAdgF3maZrrxh7ag/mAqgtQ
         fs0kaH8z4VsggKzgszjxuUkMbKcs4jS0Or+6m8POYqNVdFGvDiSQv7INQEh8MxDaxFgG
         ceM0M/Q6a7lvHOtxEkys7RebrKO+MbZww0SG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xYVfPUL0HT1HfQJFKeNSl4bObGkqhbPgG9tLiL2+h0I=;
        b=k40pXQse9ky8cjL6FZT9Lz0OR1PLZeh3JAiAdX706Mc1eGsxQ2qKIIL02PjXfgUxFN
         SwS3jF2f4Yd/OjjODjp8ZvNCZmxRnb2Px5MACgZavGOeepm+r1SznpVSxUr6IeoYCe6/
         C9K36BEtLAnL0y4CMm3S33CgoerIbGm20UZuNnMix5+npRmVNMDsIoROnOEO4hg6YC2E
         ZedoBZulsfi5dw8iuu6G5fcPcFe655Sx7Kz6Lnlc1xc/icCbXbBNll9CGGoyzKrqE3Ed
         0KbmYlcwUK9lebQI4VlPJqP61GJu4ZgQAzzF1KbkzXERG+FtqVsHNPtulbrwxAI2K3/1
         QBfg==
X-Gm-Message-State: AOAM533F2/uQZipikSDf9KizyepY4hAXtMiKPQibA22DOL+n+7ArZQrL
        Yrse1e+HaxH0SAN0jDyOLRNE/uftbP0DeQ==
X-Google-Smtp-Source: ABdhPJxNgTkHGV0XJmVs+u0EOP88+mW/sUh/5JAiRbI/CRrRnDtWpSf/IZyBLhy76fCDUJwpYVNiKA==
X-Received: by 2002:a63:c51:: with SMTP id 17mr1307984pgm.491.1643252790168;
        Wed, 26 Jan 2022 19:06:30 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v13sm3316200pfi.201.2022.01.26.19.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 19:06:29 -0800 (PST)
Date:   Thu, 27 Jan 2022 03:06:28 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        bleung@google.com
Subject: Re: [PATCH] MAINTAINERS: platform-chrome: Add new
 chrome-platform@lists.linux.dev list
Message-ID: <YfIMNC2zE2kyhSuP@chromium.org>
References: <20220126222233.2852280-1-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126222233.2852280-1-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On Jan 26 14:22, Benson Leung wrote:
> Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..cad7b0fff9f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4537,6 +4537,7 @@ F:	drivers/input/touchscreen/chipone_icn8505.c
>  
>  CHROME HARDWARE PLATFORM SUPPORT
>  M:	Benson Leung <bleung@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
>  F:	drivers/platform/chrome/
> @@ -4544,6 +4545,7 @@ F:	drivers/platform/chrome/
>  CHROMEOS EC CODEC DRIVER
>  M:	Cheng-Yi Chiang <cychiang@chromium.org>
>  R:	Guenter Roeck <groeck@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
>  F:	sound/soc/codecs/cros_ec_codec.*
> @@ -4551,6 +4553,7 @@ F:	sound/soc/codecs/cros_ec_codec.*
>  CHROMEOS EC SUBDRIVERS
>  M:	Benson Leung <bleung@chromium.org>
>  R:	Guenter Roeck <groeck@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	drivers/power/supply/cros_usbpd-charger.c
>  N:	cros_ec
> @@ -4558,11 +4561,13 @@ N:	cros-ec
>  
>  CHROMEOS EC USB TYPE-C DRIVER
>  M:	Prashant Malani <pmalani@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	drivers/platform/chrome/cros_ec_typec.c
>  
>  CHROMEOS EC USB PD NOTIFY DRIVER
>  M:	Prashant Malani <pmalani@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	drivers/platform/chrome/cros_usbpd_notify.c
>  F:	include/linux/platform_data/cros_usbpd_notify.h
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
