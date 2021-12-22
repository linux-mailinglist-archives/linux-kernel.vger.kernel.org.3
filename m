Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9303E47D5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbhLVRab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:30:31 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:45999 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLVRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:30:29 -0500
Received: by mail-qv1-f54.google.com with SMTP id a9so2912464qvd.12;
        Wed, 22 Dec 2021 09:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WxBE7Xhve5RqzvsBuOQen9R0baHuksdxA2HFZArSmo=;
        b=7h1KC/r3Ulurpymx1yjQa3mkwITuRHy87R/a73CxglPDfv4vZRXS5IElUvvU7FyPoj
         FfoMla3Crcz7eXhaylC5LKOzS5Xu5Nqi3MwUFurVtDmCCoZ6hYYvS8qK1ZL+wwXx7n8C
         1I3aKT0RuEhCf3eMVkQbTg0jX9l68pTCR9c8QDPr+3qQ//45MXQyhEmK5dMDVyFa9Mhv
         1onco/JReGYlifRA/U9qMLvwa8eHr4Rk7/i3dW69KSjddYlPI+bUoaTFw/Z3rOx+EeJR
         QVHV7WN0/O8F8RyvtD6P/sPXTvTIGeBso0w9+yzGUNAvc7DMA22v2Hq2kSX/3oJILdde
         /mWw==
X-Gm-Message-State: AOAM531FVYxfN78uszHUKiV165ulmqg8J6rq9x9CiD4d7Ddt+JJKdQ+y
        9FW/SKEvXigC/L6a60ltCqJ6hACqDSC0ZkAX59k=
X-Google-Smtp-Source: ABdhPJw8AQW0Suyyun87LFUztcMqag7Gc7sRcNLWko5oX5Wr5XorKoQ4C3ycqFrHdjBNZnNJmKYAEO+beyXclG+SSnA=
X-Received: by 2002:a05:6214:1c06:: with SMTP id u6mr3321258qvc.35.1640194229118;
 Wed, 22 Dec 2021 09:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20211221133215.8447-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211221133215.8447-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Dec 2021 18:30:18 +0100
Message-ID: <CAJZ5v0gX3RJ=evToKhFpQQTR3pAbQ=ybDFTuKSJ5Ku=SneROPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] software node: Update MAINTAINERS data base
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 2:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are two updates to the MAINTAINERS regarding to software node API:
> - add Daniel Scally to be designated reviewer
> - add Sakari Ailus to be designated reviewer
> - add rather tightly related device property files to the list
> - due to above adjust section name accordingly
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Acked-by: Daniel Scally <djrscally@gmail.com>
> ---
>
> v2: added tags (Daniel, Heikki), added Sakari to the reviewers (Sakari)
>
> Rafael, I guess it's the best if you can pick this up.

Applied as 5.17 material, thanks!

>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8912b2c1260c..e36497cb7f40 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17666,12 +17666,17 @@ F:    drivers/firmware/arm_sdei.c
>  F:     include/linux/arm_sdei.h
>  F:     include/uapi/linux/arm_sdei.h
>
> -SOFTWARE NODES
> +SOFTWARE NODES AND DEVICE PROPERTIES
>  R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +R:     Daniel Scally <djrscally@gmail.com>
>  R:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +R:     Sakari Ailus <sakari.ailus@linux.intel.com>
>  L:     linux-acpi@vger.kernel.org
>  S:     Maintained
> +F:     drivers/base/property.c
>  F:     drivers/base/swnode.c
> +F:     include/linux/fwnode.h
> +F:     include/linux/property.h
>
>  SOFTWARE RAID (Multiple Disks) SUPPORT
>  M:     Song Liu <song@kernel.org>
> --
> 2.34.1
>
