Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A60479034
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhLQPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhLQPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:45:15 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD99DC061574;
        Fri, 17 Dec 2021 07:45:14 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id w64so4138896oif.10;
        Fri, 17 Dec 2021 07:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uZ8krUXCSkFJEVk+pBrz3qOWD2pHhzJx4XHVD2svN/s=;
        b=OMqAz3f9cNg5bk4GTw5gw02EeUfitXDqPiwpHk7kHtiVU9126JRhVDM/hRTwrLyZXU
         YxqWNYANU8oQkA2MkOmBFrqUDK2EvFZ/gSqGJ+90D0NKoKCxHVymT3eWu9aNbB74Wf3q
         Y7njQorol6I+KaWCpVHLnEmjvnEeZFYOL5nsKm7x+2e4XphiDXd8kq2e8zuM3zOfQCZA
         YjZTeOW8y4RA3o6f+ODYrZxQhAdWiLag7+fjT5/eo5tMC7AAnPVjLmnFWzHqLGwsCRhN
         ujF90XWG0IRmpSbzY1Bxnc2rAOwRfaX6I8jli+FKPoOOMNh20DTSSUxUp9yJkcbDVlQO
         Cj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uZ8krUXCSkFJEVk+pBrz3qOWD2pHhzJx4XHVD2svN/s=;
        b=O3EKNNMfMNjCEkOAyKHpi8jLqWDDJr5EGHMX4iEth73lud3MLQ8hy+0LRnNcoEgddl
         hwpXNHyzhHEl0ihX8Zb8xvSlzzjdu35arJnX2O925nZnAYdC8oLx8wD5rDSrHbIbelLX
         rlCb1eBelYmndz1RWWlT+fbQVWlzbsvXaK5m0UHkzlNthJHIVGTwsFWo9JNSDJnXTTc1
         ZOoxGIavJ6+yILCl8uQuYAQbqczjCXuHgQSuq/DQgC1EHxwVPNh2PwNpoAHEXuqW3wCB
         30pZTibtCcGTk3keNtNTXRBVj6TcG/QlofOKJKcOujq9sfWbEDjms8qb8eEC/eOpkNZE
         3Z8Q==
X-Gm-Message-State: AOAM5322+KX6IzyL7Z+RlpcSnEzfBaoh2OcHmR75dJ/9WP2h3aAT683b
        5xTB5MXav9Fa8uRSgLFXEXc=
X-Google-Smtp-Source: ABdhPJyloBMK1IeYm+CC5Aj5GZB5qrSRSewk71IGCTlnLOPNwI/SibCCfGbCWe92ZytS8rjd+UET+A==
X-Received: by 2002:a54:4590:: with SMTP id z16mr2413538oib.67.1639755914291;
        Fri, 17 Dec 2021 07:45:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m6sm1614536ooe.24.2021.12.17.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:45:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Dec 2021 07:45:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: prefix kernel-doc comments for structs with struct
Message-ID: <20211217154512.GA2882803@roeck-us.net>
References: <20211216154257.26758-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216154257.26758-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:42:57PM +0100, Lukas Bulwahn wrote:
> The command ./scripts/kernel-doc -none include/linux/hwmon.h warns:
> 
>   include/linux/hwmon.h:406: warning: This comment starts with '/**', but
>     isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>    * Channel information
>   include/linux/hwmon.h:425: warning: This comment starts with '/**', but
>     isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>    * Chip configuration
> 
> Address those kernel-doc warnings by prefixing kernel-doc descriptions for
> structs with the keyword 'struct'.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  include/linux/hwmon.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 1e8d6ea8992e..fad1f1df26df 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -403,7 +403,7 @@ struct hwmon_ops {
>  };
>  
>  /**
> - * Channel information
> + * struct hwmon_channel_info - Channel information
>   * @type:	Channel type.
>   * @config:	Pointer to NULL-terminated list of channel parameters.
>   *		Use for per-channel attributes.
> @@ -422,7 +422,7 @@ struct hwmon_channel_info {
>  	})
>  
>  /**
> - * Chip configuration
> + * struct hwmon_chip_info - Chip configuration
>   * @ops:	Pointer to hwmon operations.
>   * @info:	Null-terminated list of channel information.
>   */
