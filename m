Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFF48562E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbiAEPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbiAEPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:48:44 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67A5C061245;
        Wed,  5 Jan 2022 07:48:43 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x10so60190513oix.6;
        Wed, 05 Jan 2022 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jN6QXRXvjbB9fJXMjslApUdMWCdVO0HwiYItXDJQSmg=;
        b=pMl4T4z+3xS3buMzkFNXxdPjxMHbbykxJIWie/FzIEwhqt28zsrHJePFnwaHL3I+4b
         14lcm+GWybT/Iv2FwA1NnKVVdFhBK/yeC2bMKRXqW6WRuVjAVMxCWkVUKIi+4NJIDgkI
         6WRRLujmSPHepzfXQqwvS7brBG4PLSgOwdd8lqdmu/pqgN4ijdMUK9l1AOidIA/yodZ2
         3dmX0oNjyVu1S9Oy+wMneIFqORLCzpTM+SNOL3wiipB1Hk+hcBbdqmycfC29FqEJuloq
         vsd3xatzabNWpUTQyF5F8Rmt55AVw72xtIEjjXDtDZRtXnGYIFUEOmMlITOPExoroGTW
         at3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jN6QXRXvjbB9fJXMjslApUdMWCdVO0HwiYItXDJQSmg=;
        b=C+9UWjDpwOKDshOzjXhEYmxY+OjTkDL45va58Egut2dLexBRsY7qIzfsCiZMsnOwYI
         FrzsfnbOM3B4lEIrLp+BMA62JyM2ssjPpq1nc1x4ALWxvUQYSSTm83kQj75JqZpdpXZ3
         4WtfBc2aEeahexPMBNYNQCnY/XaGKEzVugkC4xuot1JQVF/XCbrp7FlrNGboW+vJwKMQ
         6O/P8SFnExh5OckMiJufuWwitj024cR3t2ggpD7tdImT6PLMshqjUb434M1CWLguPmnI
         EcMrKt/avKsAYtRZ3iNPPu799iZRmiZXPrMoFkdhSxCZy56tt1uLwDyHIUM8J19KUBft
         zZ/w==
X-Gm-Message-State: AOAM530nxrPbLfBDbMRdfTACiV8k6hbX+iu2uBwqWzWyMNBimwDEYM71
        wIB1HOcLH8OpjLpz38av1mw=
X-Google-Smtp-Source: ABdhPJxFdyxWQWNQVfM4aXPPN8FYlz1QqwVNTXlQwxlfe4cfpeJQQ8Zbly9wFBWZvGDG7xjwbYMTWA==
X-Received: by 2002:a05:6808:1a2a:: with SMTP id bk42mr3046715oib.118.1641397723151;
        Wed, 05 Jan 2022 07:48:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13sm10454724oil.42.2022.01.05.07.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 07:48:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] drivers/hwmon: remove redundant res variable
To:     cgel.zte@gmail.com, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220104112818.602025-1-chi.minghao@zte.com.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cd043f81-8605-be9e-4ddd-09711e060c61@roeck-us.net>
Date:   Wed, 5 Jan 2022 07:48:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104112818.602025-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 3:28 AM, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from inb_p() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Please do not send me such patches. The subject starts with the wrong tag
(it should have been "hwmon: (nct6683)", it is misleading (the variable is
not redundant; if anything it is unnecessary), and the patch itself adds
zero value. The submitter may have had a reason for using a variable,
may it be personal style or ease of adding a debug statement when testing.
There is no valid reason for changing such code.

Guenter

> ---
>   drivers/hwmon/nct6683.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index 6a9f420e7d32..ab02e967f73d 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -495,13 +495,10 @@ static inline long in_from_reg(u16 reg, u8 src)
>   
>   static u16 nct6683_read(struct nct6683_data *data, u16 reg)
>   {
> -	int res;
> -
>   	outb_p(0xff, data->addr + EC_PAGE_REG);		/* unlock */
>   	outb_p(reg >> 8, data->addr + EC_PAGE_REG);
>   	outb_p(reg & 0xff, data->addr + EC_INDEX_REG);
> -	res = inb_p(data->addr + EC_DATA_REG);
> -	return res;
> +	return inb_p(data->addr + EC_DATA_REG);
>   }
>   
>   static u16 nct6683_read16(struct nct6683_data *data, u16 reg)
> 

