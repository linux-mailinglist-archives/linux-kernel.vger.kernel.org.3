Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93049FCDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347192AbiA1Pba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348350AbiA1Pb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:31:29 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CAFC061747;
        Fri, 28 Jan 2022 07:31:28 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b9so12486952lfq.6;
        Fri, 28 Jan 2022 07:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KHs6ffmXoNgB7PgAET8KZkcoI47YhdLdQfWEN1wdVIY=;
        b=EGy5kBsZs7mue/dnKJkIJKYEb3NQuujucP9629Oezmt3hmr2Lda276tchLhN/H10cm
         hSTdd88xh4xET4rO+9cz4tQYS8wqjSGbq9JQp3ayfHKoHp6RllbhpLfwA9/WieAp8Tu4
         YG7RyoNJz/fdrgUu+ym8BUjRayCPZbZMT5jVMJFll74/40/smf4liERf4Owi7UpMCfmp
         v1Y4AEREiPkDhWkBoKFU2J3Gi5G2838nldCF++lrZUyftLFNQMNkyzPtUO35hnzhCOfz
         Y5+01YB4OO9SyWNPSfjTw8C1+FN/UXmCue4UiGMXKwoO3l8J/8EPp4YXhGO8Bo02eNSA
         l06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHs6ffmXoNgB7PgAET8KZkcoI47YhdLdQfWEN1wdVIY=;
        b=4IyRYXe6jAxtrM5xjlocPDt4hvCVWPOxI0ZEKYs0+OFxKWlidPhxNFOqQCE44eMOdg
         Atx4Uc3/eyKEGUU4LJEDpgj6gVjvoxVTZLdSZj8qVRIiyGbcRNQ9aNsq5qIi5VVTWK0y
         69KA9YRPlD4mMtpCjVrws78ODTAg7KF5WlY3mIT4gTasryuIb3CKuM4nvwCVExUnCFNY
         M6qp54LSOZY0rhtjvAnjMYqAaJHqhbKJfZ7KjUI7KdXmidiRkw0kNfZZ/hNlDHcNRNYu
         Y7lmSb/g/1kng+ej7sIXxeDMxAOSH+IC257J1QEw+ukPzaaONX8UJPggnpJ4y1Xn7Vay
         KWAA==
X-Gm-Message-State: AOAM5326Ed3QEvZ8UFGksjowgWH5tOOKJn8vv3zxMkpEHMYT90w4L2wN
        I0m6/V2JiGzHbXpom8gJw+cG9plyHPo=
X-Google-Smtp-Source: ABdhPJxVsONRJJAvcxhzc27gfPk/RvQsfat/2Ev+rmO3fwe+uwXQHNrZwU5ASImIhbDRO2lCZinLFQ==
X-Received: by 2002:a05:6512:12d6:: with SMTP id p22mr6686448lfg.231.1643383886725;
        Fri, 28 Jan 2022 07:31:26 -0800 (PST)
Received: from [192.168.1.103] ([31.173.86.67])
        by smtp.gmail.com with ESMTPSA id t6sm2570898lfp.128.2022.01.28.07.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 07:31:26 -0800 (PST)
Subject: Re: [PATCH] usb: usb251xb: add boost-up property support
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220121232612.7283-1-tomm.merciai@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <be1c8dcc-1136-f101-3129-4d6587b9204b@gmail.com>
Date:   Fri, 28 Jan 2022 18:31:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220121232612.7283-1-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 1/22/22 2:26 AM, Tommaso Merciai wrote:

> Add u8 property to support boost-up register of usb251xb hub.
> boost-up property control USB electrical drive strenght

  Strength.

> This register can be set:
> 
>  - Normal mode -> 0x00
>  - Low         -> 0x01
>  - Medium      -> 0x10
>  - High        -> 0x11
> 
> (Normal Default)
> 
> References:
>  - http://www.mouser.com/catalog/specsheets/2514.pdf p29
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/usb/misc/usb251xb.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 507deef1f709..74fd8ac0c303 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -543,6 +544,12 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
>  		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
>  
> +	if (!of_property_read_u8(np, "boost-up", &property_u8)){
> +		hub->boost_up = property_u8;
> +	} else {
> +		hub->boost_up = USB251XB_DEF_BOOST_UP;
> +	}

   No need for {} here at all.

[...]

MBR, Sergey
