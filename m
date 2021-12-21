Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF92F47BCA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhLUJPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhLUJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:15:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E8C061574;
        Tue, 21 Dec 2021 01:15:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q16so25518744wrg.7;
        Tue, 21 Dec 2021 01:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+limH/jUrjCPWSbz4amnM+QL6aX2y+zOR0FC6q29CV4=;
        b=FCU2Sp1otauI/SYUaG0oRRMxG8vHnfPw64TxbSJUmjCD5FdczHy6GYzH4rA+hvdpu0
         Bb+Rsr29lZxbMPXSiqvMDybTDmb/m1KGrxEeOIf4wBhKia4DtytI+u/JRuOsB5Y5Bt85
         Joh08FEWyzlfvNRrxizK/ps4BKl8wiu4Rh/iUUvvFkyEJB5RQOPHLaAQOoIlcv4pfcdu
         TTh9+4VV1Pg1ZPLoBv4HM64QViA4a+De0n/tfvA0DjeSEjAkYrMgTlNm1Z4L5yAazRM9
         mwQG76shR0CcsfZS+ax89KcYcwC+1+Rqpr1rS85sIj51zVAak94NNXg3mnoHY11h+piR
         flvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+limH/jUrjCPWSbz4amnM+QL6aX2y+zOR0FC6q29CV4=;
        b=5VoXCnqq1gIdXiiCOkqM//PICdzXTlZZvaY7F468a5lH4DFuyMVavvAz82YiLR3U3A
         NN/5YCx44hVNI9csqQbZPmnH93LfSt35Uha/sEAqZGtOq4CMXN1RZ12PCBhsNf14evhv
         +f88r0M+n/6eTD3BZchVI1FHjmuZNALpKLveJe4W90tfW0K5ZuU60RRCuNghfFxu/hpy
         lqF4GCJrroJ9fwu04xu9psZdrNLaFf0f0iwil7jpY5yJPC5vBNMmGPFXymckXJAaztIO
         BMXnuEKGmqOof03Aw21dWgslhJy94QHhqtDD1xVp8xxYCTMZCq99IFiUnB8vlXkvVlf2
         ALMg==
X-Gm-Message-State: AOAM530MSDXhBcKWgDJDFTYj3XmLRz0oYGTc1NiVxsiAnB5hKi78amqR
        Y0/WC0qnPtL5UXu/CahDQsmqB1N4p6k=
X-Google-Smtp-Source: ABdhPJzsf2Dq+wB+TY+AzowkHMERAcpbTz0z51XtxHiOP+ZLsgxkuRuEneInYUXSZVTCwNhKCGF6JQ==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr1830396wrm.697.1640078132082;
        Tue, 21 Dec 2021 01:15:32 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id s1sm1686126wmh.35.2021.12.21.01.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 01:15:31 -0800 (PST)
Subject: Re: [PATCH v1 1/1] software node: Update MAINTAINERS data base
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <35944dfd-a20a-f67b-5d34-a0e0a4cb7066@gmail.com>
Date:   Tue, 21 Dec 2021 09:15:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Morning

On 21/12/2021 07:14, Andy Shevchenko wrote:
> There are two updates to the MAINTAINERS regarding to software node API:
> - add Dan Scally to be designated reviewer
> - add rather tightly related device property files to the list
> - adjust section name accordingly
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> Based on the latest Dan's involvement and amount of patches seen recently
> I went ahead and added his name to the list. Dan, please tell me if it's
> not appropriate.


This is fine by me - I don't know if you need a tag from me for this but
feel free to add whichever's appropriate

>
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8912b2c1260c..ccb4aa744540 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17666,12 +17666,16 @@ F:	drivers/firmware/arm_sdei.c
>  F:	include/linux/arm_sdei.h
>  F:	include/uapi/linux/arm_sdei.h
>  
> -SOFTWARE NODES
> +SOFTWARE NODES AND DEVICE PROPERTIES
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +R:	Daniel Scally <djrscally@gmail.com>
>  L:	linux-acpi@vger.kernel.org
>  S:	Maintained
> +F:	drivers/base/property.c
>  F:	drivers/base/swnode.c
> +F:	include/linux/fwnode.h
> +F:	include/linux/property.h
>  
>  SOFTWARE RAID (Multiple Disks) SUPPORT
>  M:	Song Liu <song@kernel.org>
