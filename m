Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E774A2DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 11:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiA2Kc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 05:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiA2Kc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 05:32:27 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7EC061714;
        Sat, 29 Jan 2022 02:32:26 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q22so12524378ljh.7;
        Sat, 29 Jan 2022 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M8KppXZwkQSQWhLcBO/fg1G7bhttmzdUMDjxY3POSRc=;
        b=KYcUA2p/u0YUGwacjhosNfy6/MHCmvfyLeV7o9hkVTyZtzJe9N4W9DkjAJHmHCBpbD
         4xcRPkZhMgS8zZsVFRqMRgjSJXNI3paToeVAX5Y6l5md3kVF3gejygqPx2A2fZx04Byy
         0K28Y0EXQMvRSypEcGq780su83T2Wlkw5hvbhl2/J6dd7nyDdSvc2fhkQT+hKK0m1j37
         uKGKAKDjt3HcHeuxtVUF4bfKWvElYsXUHBzFAs57ATbc4pPTXj/PqBAMjox2t41y1Eh+
         YLDv/7FbANJF4pXnbMXEmw5hhHi1q+7ncSVFZrjRuFUOVG/mBa+YO6AUK0wKx7kf6qp2
         Tkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8KppXZwkQSQWhLcBO/fg1G7bhttmzdUMDjxY3POSRc=;
        b=MUiqOU0o31L9+yMjoATN5Z/E5WdslIjfz8ew7CsWeFNXtw0Iz5qbyIjPRniQdsZlH9
         /ETFffdnEpWMJe3bamXVzIkEM8IOtPzEYPLqNTM1/63YVxuFCGfHlCxvR0fuRA4Q6QVC
         4npFvetjfQWJfl50dtQKC7r0nXz2metnd8u1MHOl0AzXP7+4pexRfkILPyQ9KGL6IIuK
         c1/NeJi1Q3JntOyZJIvtJbKPszAZdtA4VDxPcHJbdIIFMhkMbR9jFjeno4YVcP20unlD
         C6XMVNoZEDEXwYTzAD57u61hXP2LZf2ByHC3ZTY7UWIUt8MlsJj64qq3c29hqGz9Bx2b
         Zq5A==
X-Gm-Message-State: AOAM533/J6UkAc/46WlreFDnixaec2Yfbv1qXhmslqbSma8x6XLCu7ba
        +5QgT1LQkspUFiS0I1EnB3SzzV89dk8=
X-Google-Smtp-Source: ABdhPJwHr9BlhoIOQVT34MoP/cSFcrqcUz/v8macj0lwehEYlcwRDIrSo/596bJ42uJya5xVQysz/Q==
X-Received: by 2002:a2e:9594:: with SMTP id w20mr7906708ljh.448.1643452344673;
        Sat, 29 Jan 2022 02:32:24 -0800 (PST)
Received: from [192.168.1.103] ([31.173.86.18])
        by smtp.gmail.com with ESMTPSA id s18sm1705138ljs.115.2022.01.29.02.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 02:32:23 -0800 (PST)
Subject: Re: [PATCH v2] usb: usb251xb: add boost-up property support
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220127231437.10893-1-tomm.merciai@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <978bc09c-b963-566b-8fa4-a53f1e5c569b@gmail.com>
Date:   Sat, 29 Jan 2022 13:32:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220127231437.10893-1-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again!

On 1/28/22 2:14 AM, Tommaso Merciai wrote:

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
> Changes since v1:
>  - Fix patch as suggested by RLeitner
> 
>  drivers/usb/misc/usb251xb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 507deef1f709..b60ab148e6ac 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -543,6 +543,8 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
>  		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
>  
> +	of_property_read_u8(np, "boost-up", &hub->boost_up))

   Isn't it hub->boost_up left uninitialized if an error occurs here?

[...]

MBR, Sergey
