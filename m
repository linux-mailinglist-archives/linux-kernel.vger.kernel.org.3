Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60E547C0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhLUNfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhLUNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:35:22 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35BC061574;
        Tue, 21 Dec 2021 05:35:21 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 956B71B00228;
        Tue, 21 Dec 2021 15:35:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1640093717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4U6yBFb6S+4Mj+TP2XrOxpUbUb18nMOKdkGXhstUyc=;
        b=pQHByr+QOHYHsL7GmKznfluOaNIhFkq9lUeSJK4VakHKn8uCU5k7fS9n0Qmphy2bcRk3BJ
        oAMkyIY4ebiSu4rSogHhiaaHADD8N2ApwdcjO6WB/oeXs4LjqSLz+3LFKg7HyAlqoC8WKa
        b9QZ6WTXivzu1vsk3hPzAVef/Z/pTHVAg62VwrhAph9kkKO27rjL8iXit7DxgeQ63TS3R8
        pv0G/3JYKtvnm+7E15pbAHBqbBEc5hk1kWHQiNnFKo/OHcA+twaD4AYUdcS1FDdvoQJZfV
        1n3aAyR68Zp9dZzC2dF5P4BM275g/goZF+w8ZRt5ncRqGJ5rnhQHwd3+PmuozQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 27C45634C90;
        Tue, 21 Dec 2021 15:35:17 +0200 (EET)
Date:   Tue, 21 Dec 2021 15:35:17 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/1] software node: Update MAINTAINERS data base
Message-ID: <YcHYFTAoS5ghYWkD@valkosipuli.retiisi.eu>
References: <20211221133215.8447-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221133215.8447-1-andriy.shevchenko@linux.intel.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1640093717; a=rsa-sha256;
        cv=none;
        b=i79pLTTMFBOaqyfbgMxidGqx8Qselwf9E8ANKNt+KYr2wy7TR7g5ZzbMk9wSbWzh/gWcxn
        uROPNr3VPuEfVhdeS478u39kfBaGCjuqPOtno7psAZbTPn0vNrQtTiiJLq5p9rLysikKFJ
        rN+NjPGs2vMgqrgbgyThn2BCnXLUGUiLXYei8ydf355ImEngAiCjTHuu+TvPPuWyv0J6DI
        J4d1FPRuOziQrrpIUOqrmCTmnanlFWuwft3Sy7g6Bb9jsQtDpyiFISG+StIhucS/67M0Sd
        bzP4vhqYIJiwktq/Ycpj1ckU3YowspFjv5ZiG2iEpVG4U0uymEvC0PrvQsEr9A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1640093717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4U6yBFb6S+4Mj+TP2XrOxpUbUb18nMOKdkGXhstUyc=;
        b=Qtiy14fnKsjZ8ZwW1gGFWOqy4PCGEKPLcZBKmEWdZwalYwMjwVUABgThOYGIvkPSAaPRrp
        W7yk9RfCHAd5rj2EAyNtGHBD2b1oP87LPdJ1PcUfFHxrFu5jS/oZDCjUjtaunOqxM7kWDX
        Md0DfoiWp3dVoTvwKydehmv+C1OZWTDe9soLNgswk/ep73uZmtqWTYnlu6zVerKhlOnPyv
        h9XNSe+9dlMEZT9mx2CNnWRMABZrG7nSoh74REoOO2p1doBo5+aM/iL7kW9jpfFHmCAU7a
        MLQ3sFNIZu0+2YhI1eDOHYIkw6ikRPbDiOghKAQVyDNzTbctzl1nULWsipgyOg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:32:15PM +0200, Andy Shevchenko wrote:
> There are two updates to the MAINTAINERS regarding to software node API:
> - add Daniel Scally to be designated reviewer
> - add Sakari Ailus to be designated reviewer
> - add rather tightly related device property files to the list
> - due to above adjust section name accordingly
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Acked-by: Daniel Scally <djrscally@gmail.com>

Thanks, Andy!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
> 
> v2: added tags (Daniel, Heikki), added Sakari to the reviewers (Sakari)
> 
> Rafael, I guess it's the best if you can pick this up.
> 
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8912b2c1260c..e36497cb7f40 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17666,12 +17666,17 @@ F:	drivers/firmware/arm_sdei.c
>  F:	include/linux/arm_sdei.h
>  F:	include/uapi/linux/arm_sdei.h
>  
> -SOFTWARE NODES
> +SOFTWARE NODES AND DEVICE PROPERTIES
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +R:	Daniel Scally <djrscally@gmail.com>
>  R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +R:	Sakari Ailus <sakari.ailus@linux.intel.com>
>  L:	linux-acpi@vger.kernel.org
>  S:	Maintained
> +F:	drivers/base/property.c
>  F:	drivers/base/swnode.c
> +F:	include/linux/fwnode.h
> +F:	include/linux/property.h
>  
>  SOFTWARE RAID (Multiple Disks) SUPPORT
>  M:	Song Liu <song@kernel.org>
> -- 
> 2.34.1
> 

-- 
Sakari Ailus
