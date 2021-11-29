Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF9461FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349744AbhK2TNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhK2TLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:11:41 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC94BC052925;
        Mon, 29 Nov 2021 07:32:36 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id m6so35334023oim.2;
        Mon, 29 Nov 2021 07:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xn0HWQDqGoSI5N5BzKsI9k86k0ZFmdy7lZiWdeS54vs=;
        b=HWZpuBpzAWtgOoDnqsVg6oglNAy+4ld48MGugS4I/Td1xYLRZJE9i6cjsfRb4rIFU9
         PNRKArUz2Ze/L2exNv/p8zD8zpbZV3FetIZajlhczdh9kJEiTbLE6e/r7cJex9icFzm+
         p914BUBXDHjCLH5c1F6brY3VZQYEcXX4hMNoZAtwMmYXz+RKB0VNXA5QHkx01Sgvdpp+
         msZVr6PA4+cy5OonS1fiqsfvur8Pd4hJw7Ht4T0+xrq/4iKe3uondgJwFJscBLuHK5v8
         zfyEpzXFITc4N0aM/SIVGvmC16SnGqxKeljNbnRdVQSnSIPcn0tvJimKxXLsOs06RX4H
         2xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=xn0HWQDqGoSI5N5BzKsI9k86k0ZFmdy7lZiWdeS54vs=;
        b=lSEfD16FzYcrovX8m3oZvybpEgexhF3r7Z36geCG4fYQP/5Xlkq61Z8HB5zYIykz7z
         yWyxHUrUWXwBuWAt3BvKUC5IN8NL10q/Oy+57v/ZcpxK8Gpfvjong6wqQc4KSJCCXrLk
         6iA3VwKzJ3ErQC6t3syO4018YpAZMAsSIXE5GoJz9NoZagWZEa7jriZNZS5NHrHO499R
         pqZvgw4t4CWhQYe/6vsL2CIzqma3Ged5OuB66OtgpszZR0NlEmIAHTKRhXKwU95WSfEh
         Xj/LboWT9+/dMtMvZD8LG/az3mySi+pyDKBs6kl8i+4lIuY9rGobYQoY0cAM8J93a1G+
         JHbw==
X-Gm-Message-State: AOAM532FYdK5nfPkqCYVpwptXD5ntgGQW3Vza06wLEsrA1vVSUyAE0vQ
        fh/zXeMUataqc8aukLBqLBo=
X-Google-Smtp-Source: ABdhPJxy16yU9FQY4WxueZw8hkgLl864I/mAKQfE9n8/rrWWTh2LZQI01zlQTpGQAqXjDk+mVK8zjg==
X-Received: by 2002:aca:ab84:: with SMTP id u126mr40568449oie.41.1638199956401;
        Mon, 29 Nov 2021 07:32:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4sm1003909ook.16.2021.11.29.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:32:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Nov 2021 07:32:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        y.bas@phytec.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: da9063: Add hard dependency on I2C
Message-ID: <20211129153234.GA2627247@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 02:49:38PM +0100, Andrej Picej wrote:
> Commit 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in
> reset handler") implements atomic save i2c transfer which uses i2c
> functions directly. Add I2C hard dependency which overrides COMPILE_TEST.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in reset handler")
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9d222ba17ec6..3207085f799f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -207,6 +207,7 @@ config DA9055_WATCHDOG
>  config DA9063_WATCHDOG
>  	tristate "Dialog DA9063 Watchdog"
>  	depends on MFD_DA9063 || COMPILE_TEST
> +	depends on I2C
>  	select WATCHDOG_CORE
>  	help
>  	  Support for the watchdog in the DA9063 PMIC.
> -- 
> 2.25.1
> 
