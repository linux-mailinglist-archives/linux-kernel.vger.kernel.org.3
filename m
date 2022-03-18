Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B778B4DDFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiCRRMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbiCRRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:12:34 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84530DC70
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:11:14 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 018341D6E57
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:11:14 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id VG6DnfLb19AGSVG6Dnh93Q; Fri, 18 Mar 2022 12:09:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JOcpyRgPLuW6EfkECyLFstXhFqED0WQf0RhR8a/5r0M=; b=VbFz4z9XWaeoZwA7hkoS3lEyeG
        0VuAi+DDHS9hjsMqSM1wYahjLaOu9qf+wBqZtYKtMCv6kVDK7xtxtMoTJCfPU0mWGSd/69Xp7ERRX
        08l9MxR88vgBigwbhzIR5E/nZPicENcBZVZCvIxPcQCab1oXUEoxqdEQhtOCjrjU7/7NiuRpQMhua
        fdKU3b6cyy6/RQiY6eiqasxqoqeox+s3g4R+aw+BiqfVQoDgfJRTOyRNJxD8/2YU2gP0vmJVESRqr
        qH2TCOHkqKX3VXkgFB1MsbJKkOd3uAfsYnwfzx4rRbbbQNTl1t3CYVCCMw13G7QUkW4cyFzfn1+4n
        Smf2wlTg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57546 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nVG6D-000g8B-1Z; Fri, 18 Mar 2022 17:09:13 +0000
Date:   Fri, 18 Mar 2022 10:09:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] platform/chrome: cros_kbd_led_backlight: sort
 headers alphabetically
Message-ID: <20220318170912.GA687608@roeck-us.net>
References: <20220314090835.3822093-1-tzungbi@kernel.org>
 <20220314090835.3822093-2-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314090835.3822093-2-tzungbi@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nVG6D-000g8B-1Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57546
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 15
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 05:08:31PM +0800, Tzung-Bi Shih wrote:

Nit: There should be some text here describing the rationale.

With that added,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v1:
> - Update email address accordingly.
> 
>  drivers/platform/chrome/cros_kbd_led_backlight.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index aa409f0201fb..f9587a562bb7 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -4,12 +4,12 @@
>  // Copyright (C) 2012 Google, Inc.
>  
>  #include <linux/acpi.h>
> -#include <linux/leds.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
