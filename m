Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE46475849
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbhLOL7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhLOL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:59:14 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD57C06173E;
        Wed, 15 Dec 2021 03:59:13 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so5837797oog.1;
        Wed, 15 Dec 2021 03:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lQwcpNrbli9VLdeHuoAEQZcD0V8NfN8ZrlDwyL/3SPg=;
        b=NXUg701i7/xygKjrqrCnOF3wUzVQW/TT/JHhNblf9fYF2jPatQRkV0gz680FHw9f3f
         B5xkzXspfmD6dEWbRcP6S/G9fRNZPORFRqlG5h20DMNcD0rGbxIr8OqBNfYLzyELwTx0
         aIJnnpnwvQVALQcXb08NhZbfFozyc/zl5Zs07VOl5gGShFmDfAGjt0FtS2W89CJQGWjr
         GUDipgN/QDnzP5GB/B3ludRHG/OAjHcIKrQ8eipvXDhd7GxxHwOSQ+JlZv8uPPb18MsP
         qTIAJuulgP1GfsNwLMn/ewNZeABFgJ9Ml2TL3GNQyfF1E5KgErPp5QIXFiZJDv9lttlv
         LLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQwcpNrbli9VLdeHuoAEQZcD0V8NfN8ZrlDwyL/3SPg=;
        b=2WmkcrgVOGWpOtTGnyWD6tjseDGV5WiRbTckwOdJAA3vyLOgoWRyck1qFYZB9mpyjF
         KelKsBDgAOCwwzfCwUXOXLHI8jlq/ZEyhXRX6RP0rqZ0RG+PF6/BXe71PGgEdnTNgIx+
         Cx9FPc4MdJm9bSS2JMpnkz6ja8fjQBRgXGc3mJjADmRsbpEIsQeYRMeyBQP9uoTk1N9A
         RvfQy4kQ8+wdMX/YZZ1yUt/yCUYQRqFsgnB1OWiqeCRYVuWUiACf7rBjgDynLwdl3KF9
         MeZwVtSTnWD0vknnN4VerV1GY1R3vzSNuB5I2oxrsNQZYW0vcFu0jlMAnOYb+PByMxFy
         tsqg==
X-Gm-Message-State: AOAM532Q+cwxjEyWLrKxsEImN0fczILuJKv/PKB5scI89mVZFm3wkl8x
        6ajZ5eeguXGm/sBLU7yN4w/nsoSslcE=
X-Google-Smtp-Source: ABdhPJz3kh6UqCvLRy64cZ4L8HIFYMkmsAOVitikMB/e8C4SDG+xnmEnY2tAfD5CidpR/9tkcNTgUw==
X-Received: by 2002:a4a:d8c7:: with SMTP id c7mr7034347oov.58.1639569552916;
        Wed, 15 Dec 2021 03:59:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11sm396991otj.24.2021.12.15.03.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 03:59:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Arseny Demidov <arsdemal@gmail.com>
Cc:     Arseny Demidov <a.demidov@yadro.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211215113023.2945-1-a.demidov@yadro.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
Message-ID: <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
Date:   Wed, 15 Dec 2021 03:59:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215113023.2945-1-a.demidov@yadro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 3:30 AM, Arseny Demidov wrote:
> In the file mr75203.c we have a macro named
> POWER_DELAY_CYCLE_256, the correct value should be 0x100
> 

How do you know that ? Do you have access to the datasheet, or
is it just an assumption based on the name of the define ?

Guenter

> Signed-off-by: Arseny Demidov <a.demidov@yadro.com>
> ---
>   drivers/hwmon/mr75203.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 868243dba1ee..1ba1e3145969 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -93,7 +93,7 @@
>   #define VM_CH_REQ	BIT(21)
>   
>   #define IP_TMR			0x05
> -#define POWER_DELAY_CYCLE_256	0x80
> +#define POWER_DELAY_CYCLE_256	0x100
>   #define POWER_DELAY_CYCLE_64	0x40
>   
>   #define PVT_POLL_DELAY_US	20
> 

