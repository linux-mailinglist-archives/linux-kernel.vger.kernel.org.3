Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8A466E43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbhLCAIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhLCAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:08:44 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992F4C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 16:05:21 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s37so1305854pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 16:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YNq71eugKd6ZuFCZ5Q2r4IlEflH5oCQKgCO8j2VOR4k=;
        b=H6auaOZajr7ROgTJ77RMu5c9CI728HFCUDXBSzUg0dcqmGw5nZW9uLKpjaNa0gIJPh
         n4Q8vGxTFDb0rWg9sn6/sia0+4Tzvf+ngYQlt1eSdoPOUquA/VXzukgoOOL70gNlKU93
         WIf+NTJuJS73F2mvd6QPe84ARcGX056qA7mtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YNq71eugKd6ZuFCZ5Q2r4IlEflH5oCQKgCO8j2VOR4k=;
        b=3g0Tm7JMSVQQCKN2GnjqyGTA2vpm9n/8ugldBINLCkikA0WsjIK+GdSDcLr+8xsJ8/
         symDUrna0efuwwlHM6gxV/g3iOsQxITisx+pDOXo2u6QkrSguLBICecrVWrazgm64lLS
         YEjZwSP/q5T2O+Mnea7YSogBpYKAnVD6ocM8s7nCKFQBfIWcWoEH2QA8oA0NXgZnoDy8
         FE2r5LvRTmxlgCzhnfkRxT3aRDyI7V/vazD2Qs32ZV7R6gHXF4uDj3RyY7X8jc0HjmBB
         Bu18ZITXWfF0TXuJFNvch0GcxacOzjkVlD5IivLdo4crijNq8rukxRpwwU2nSCLIreG2
         FQuA==
X-Gm-Message-State: AOAM5324hFzyfv+7kZUvo442XWoQ+VVwHszTypDzOH380m69FJ/Wo6+D
        600cW9ZA1oE60g7Hf+pNI+Z7xw==
X-Google-Smtp-Source: ABdhPJwDi9J4NoMa+JuX5RZuz3GYQIOjZ6/MsFXsp/vmnNCdDwz+Gg93EPkstIEsBWo6kVDr5Mbf/A==
X-Received: by 2002:a63:2155:: with SMTP id s21mr1956291pgm.20.1638489921114;
        Thu, 02 Dec 2021 16:05:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mi18sm558085pjb.13.2021.12.02.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 16:05:20 -0800 (PST)
Date:   Thu, 2 Dec 2021 16:05:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, van.freenix@gmail.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variable
 with __ro_after_init
Message-ID: <202112021604.E65EDA8D6@keescook>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 08:50:29PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> sys_ctr_base and cmpcr will not be updated after init, so mark
> as __ro_after_init.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Always nice to get more of these. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  drivers/clocksource/timer-imx-sysctr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
> index 18b90fc56bfc..2b309af11266 100644
> --- a/drivers/clocksource/timer-imx-sysctr.c
> +++ b/drivers/clocksource/timer-imx-sysctr.c
> @@ -20,8 +20,8 @@
>  
>  #define SYS_CTR_CLK_DIV		0x3
>  
> -static void __iomem *sys_ctr_base;
> -static u32 cmpcr;
> +static void __iomem *sys_ctr_base __ro_after_init;
> +static u32 cmpcr __ro_after_init;
>  
>  static void sysctr_timer_enable(bool enable)
>  {
> -- 
> 2.25.1
> 

-- 
Kees Cook
