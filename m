Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43934484C06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiAEBQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiAEBQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:16:53 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4FFC061784;
        Tue,  4 Jan 2022 17:16:52 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y13-20020a4a624d000000b002daae38b0b5so12029482oog.9;
        Tue, 04 Jan 2022 17:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ZPWMEoxBsbpS7/9RxGjpDBMPoelUHBQgc5YD0glsEU=;
        b=now5qFIYHd6CGsKgambfC8Et8CPMkjm3CtBzmD16Rf0N9RrNixWgbGdRiUoUwBuwk8
         Hn8+8oSUvlZ3qQCO+lfricaWhegUQ7hRNJyPgzovLFYLS29cKCgdzWpO0xP1qVfBea2d
         JISluvXCq4wWD0o9/NnkPbIEp/OqzTs3dTk/cI6OxsaigvuIbae1JqkTmdk/1u3ly4K3
         /650UntA3LP+VtjVPssrdV+cIDzBsiCIjNLWEtbgcnjKSG2po0fY6KSg0bmB78Z/OWzC
         iwHELiv2y6psVKTzJkHkx3/TfPDgMb+mH//33buT5aMhM8UlcZjOuvRuPT3NkNlrFWw6
         5/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4ZPWMEoxBsbpS7/9RxGjpDBMPoelUHBQgc5YD0glsEU=;
        b=KlRWUDDpb6dV0j2ICwWx1ujfPOQNUYNVZA2cMTMvo2fVzEuMhGBqbpGyoEwYdvGg+j
         LzSSLTL96HNvOEC5flmDZp8IZmKH4H13HGwilIckWjXjAwoRcl8Yl/cpX0KgCUIjpkjF
         2oEKsOv98VlwZPy9sMP6wxZNbSMC7XiOU23Ix9VMF9geJOQycvbbwdvqb7WbzB6VLjYe
         7EE9EDFgRQg5nGFR6IQip2OjrQ9jIi7Dr2LIrCHdsCkWon7OgGZ/slVs2jYaLHdfD7hM
         iciYWv3EbalLhI76r+b7V6G3Lzjns2rjiOmZtzQv5DBotUmJ7WmPUnoFJVwWOnyt1iHZ
         VSkw==
X-Gm-Message-State: AOAM532Cn6dtut8bnXcwbxhMor4VkW+B04VxvtSZOpgB5xluKbTJhOVz
        T5Ktq6vh0UJdcwqwa5b2znT61if/kSc=
X-Google-Smtp-Source: ABdhPJwAoY7IomfnnrohqQuxg7GdZ0t40FOl2qKWMwQYdx0Hb2Cnk8m+NwEztdRayK0yAu8+asC7Lg==
X-Received: by 2002:a4a:9c92:: with SMTP id z18mr33048837ooj.83.1641345411235;
        Tue, 04 Jan 2022 17:16:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bg41sm8011859oob.42.2022.01.04.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 17:16:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 4 Jan 2022 17:16:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sander Vanheule <sander@svanheule.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove typo from REALTEK OTTO WATCHDOG
 section
Message-ID: <20220105011649.GA2671929@roeck-us.net>
References: <20220104154414.21496-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104154414.21496-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:44:14PM +0100, Lukas Bulwahn wrote:
> Commit 489119bf75e6 ("watchdog: Add Realtek Otto watchdog timer") adds the
> REALTEK OTTO WATCHDOG section in MAINTAINERS and one file entry refers to
> driver/watchdog/realtek_otto_wdt.c. The actual top-level directory name is
> drivers, not driver, though.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>     warning: no file matches	F:	driver/watchdog/realtek_otto_wdt.c
> 
> Remove this obvious typo in the file entry.
> 
> Fixes: 489119bf75e6 ("watchdog: Add Realtek Otto watchdog timer")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7bf491409cf..b4fcc2bb7c54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16307,7 +16307,7 @@ M:	Sander Vanheule <sander@svanheule.net>
>  L:	linux-watchdog@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> -F:	driver/watchdog/realtek_otto_wdt.c
> +F:	drivers/watchdog/realtek_otto_wdt.c
>  
>  REALTEK RTL83xx SMI DSA ROUTER CHIPS
>  M:	Linus Walleij <linus.walleij@linaro.org>
> -- 
> 2.17.1
> 
