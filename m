Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389E747C8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhLUVrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUVrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:47:04 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083BC061574;
        Tue, 21 Dec 2021 13:47:04 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id y13-20020a4a624d000000b002daae38b0b5so76248oog.9;
        Tue, 21 Dec 2021 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbEZC/qpFquSdFLdQ91cxIA6QX3OHSXfVk58kDJD3mY=;
        b=aaVVXfpeTL3rBx1G0uXZui/hhVysI/7PRQh2jZuDwl5Y3SzyPh2UqBSUVsLjzbCIvs
         G20AWoQOqmV5hnH2foOtu1+fXPWGXcr8mqdpQWmiqEuHnp7i83zdy4uT6NMzfZvbuQNR
         qepWKzizKY3APu8VJ4deyOiVPWt7B7dVtaFseX+TvT5qFi4pBB6e2TDqjQLpGlJk77za
         cgUWdAom9SasDj5BtJMu0E0xnzWFYMJSB8hr4Kartp/1/ugH4GVsMWcpfvzy0HNqziVD
         jyUmYxJJVW1Z+ROpuNJR4K5cvpNYFgEXiFRxVOFDRRlZx21IGr89JkHbBmVPqcgxnfYF
         xJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbEZC/qpFquSdFLdQ91cxIA6QX3OHSXfVk58kDJD3mY=;
        b=YFiYzqcu5c6Hb0G9ovHlRIMzd5/SQVlNbUY65qWwKkBJrB0D3FKhsGWF9Li6+fjtft
         uuV17CwdyST6IqJLs8ejXp1/Iog5yar4GeT36tDhnRRsBTNF9McXbSfJ6p2WyA0xcUGo
         Mee09Fiul5LQmY8Um5Ar89yoL399O9WmW/SvPDg5q/FHovVBef2fcsb/cqYtWxbEZ5yk
         S89BOrACscy0K9EpyZ9/Or4s1wWqWPtySap9EE2II3IZZwb2hUcWUy5nVKN+rEh0Racl
         wD326Ak2LHcHfKNxfSak1hCEybEgfhQYYIPwPrXKdWYyut6WFcWMGQGXlE4a18jmPqWB
         5Pbw==
X-Gm-Message-State: AOAM533/YQVmgk86fabMVJ/JlBkYyodNVJPXWrpDh2nw7RFNGQt8o2+Z
        8uCB6fWrWo4tNNXulYsmqYf8R+0Whd0=
X-Google-Smtp-Source: ABdhPJwB74Y+t1CrzMZTffpgC80Ikyj38XIipOQyqdXoj4KURdv5CPm+Rz9zNLQN0YH1djZ0WQWL4Q==
X-Received: by 2002:a4a:a88d:: with SMTP id q13mr175832oom.5.1640123223533;
        Tue, 21 Dec 2021 13:47:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m6sm38545ooe.24.2021.12.21.13.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 13:47:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221210438.2637430-1-demonsingur@gmail.com>
 <20211221210438.2637430-2-demonsingur@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/8] hwmon: (adt7410) Pass name to core driver
Message-ID: <d7b4192f-da61-d0a5-ac72-db36e1f5708a@roeck-us.net>
Date:   Tue, 21 Dec 2021 13:47:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221210438.2637430-2-demonsingur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 1:04 PM, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> It will later be used to register hwmon device using
> hwmon_device_register_with_info.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>   drivers/hwmon/adt7410.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 973db057427b..ef4b5af865e9 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -45,7 +45,7 @@ static int adt7410_i2c_probe(struct i2c_client *client)
>   			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>   		return -ENODEV;
>   
> -	return adt7x10_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
> +	return adt7x10_probe(&client->dev, client->name, client->irq, &adt7410_i2c_ops);
>   }
>   
>   static int adt7410_i2c_remove(struct i2c_client *client)
> 

Did you test this patch on its own ? It should result in a duplicate
attribute error from sysfs if an i2c device tries to register.

Again, that is unacceptable. The patches have to apply on their own
and must not cause any problems.

On a side note, it seems that your e-mails do not have a To: address.

To:     unlisted-recipients:; (no To-header on input)

This results in an error when trying to reply to all.

Guenter
