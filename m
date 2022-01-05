Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A081A4851B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiAELUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:20:00 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:44616 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiAELT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:19:58 -0500
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 06:19:58 EST
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 8A91B409E9; Wed,  5 Jan 2022 10:42:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 8A91B409E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1641375724;
        bh=9N04zDKHmWi/Ax4vZBHgaCc9+vFD2bgpCFA4bgoWL7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXtfdWRcIh9Vdq3Ttnx+/l8VRJto+CkgyA8h9OXDu1EC378Nop6A43HUJgMyJV/vR
         6hRDquX680Cvorhjv7aaFVtDVGRO3CmkjTn62x1OasryG7XOJbZ9b8BkWSa5A1dfDy
         m6ey9ak5cq0pvnbYFNi+E+Ni1n1cohOjJzk5X5E0=
Date:   Wed, 5 Jan 2022 10:42:04 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sander Vanheule <sander@svanheule.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove typo from REALTEK OTTO WATCHDOG
 section
Message-ID: <20220105094204.GA7303@www.linux-watchdog.org>
References: <20220104154414.21496-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104154414.21496-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

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

Since I had to do some other changes on the tree, I changed it directly in the original patch.

Kind regards,
Wim.

