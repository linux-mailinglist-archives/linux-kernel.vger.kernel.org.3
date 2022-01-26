Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6149CA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiAZNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234798AbiAZNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643203184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYqBTg039yG6KmQki1vnfW07McLgJNXZp1LNPPbwRyU=;
        b=Bx1w4kZR+iKJNWETIqCDa8Mp9Ggy0TyD7B+zKtMf5Pke19ZXATBhxA76fCpF+Y43c14kPK
        VodSzDG3BgKswEFRGjZg1g2+OA7Q9HMgfMj8ph+rZrhsOCNlDSJa4hdaH8IAyavv5BdjkY
        qDICc8GIP0xpEBS1MGNEt4MgtfBIZ8o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-zli9mA92MAOwM22u1pdsfg-1; Wed, 26 Jan 2022 08:19:40 -0500
X-MC-Unique: zli9mA92MAOwM22u1pdsfg-1
Received: by mail-wr1-f69.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so4297864wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kYqBTg039yG6KmQki1vnfW07McLgJNXZp1LNPPbwRyU=;
        b=fv3PWF+qYVVAfrewu94+vrK7y5VTqjZ1EFx/3AjJg1sI7bOO0/YI15U4koAGQ91D1P
         xnVR0yFYBerkjZTUP6NFkMzdL5gfXfufG8bABAFTWzwR6oyQ0EW4oH/VtqwotD0FuqHn
         kq3OsGBc2svJoTcns7A6BUDwZBELu6vehr4amr74w/sG99r2a5S/7+Xdti4/4vbSI8b5
         1gQLF8QTuKhI22SeuFTf2fF4bL3xiuTULAnETlLPbi14Q2XWWA2VmfqCEAwkr3jkvRT/
         6tSUTeeknijWde1ibb0JiRu1kjBgmKIXVuMIKB0Upp5FV2G5BfGDg2MuRtoG1JhtpUOZ
         +bpQ==
X-Gm-Message-State: AOAM530D9C5XjXtrSnffcffMe6jBgD1V01Gk3zMobWf4zyPLI3n7z1Lk
        73r0SoXs1bfJIg5MWiSJv1uMRnBl/8LUHFk3qX39NbC4/A/kpj2Nw6+kxvu5ivlg7rf7jLNsTo3
        iYNTu6k5tnNg5/OFXJTRWafU6
X-Received: by 2002:a05:600c:2906:: with SMTP id i6mr7383999wmd.14.1643203179716;
        Wed, 26 Jan 2022 05:19:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhzLOqHtQwaIpauLzMMgIbq+NXnLWl8IbD9oWCl1awOJ7DEu7sTaSS8Umh6aandrR9my5u6A==
X-Received: by 2002:a05:600c:2906:: with SMTP id i6mr7383980wmd.14.1643203179526;
        Wed, 26 Jan 2022 05:19:39 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n8sm3264381wmk.18.2022.01.26.05.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:19:39 -0800 (PST)
Message-ID: <afb68b5c-8d1a-17c4-a62b-be985c5bc613@redhat.com>
Date:   Wed, 26 Jan 2022 14:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <CAHp75Vd7oaYPKx6bxjCqNnm6fieeQFrtq5K4YYrxYbXoXFy=+Q@mail.gmail.com>
 <20220126102858.GX1951@kadam>
 <1b665bb8-7acb-519b-0a02-ef0f2dd4b524@redhat.com>
 <YfFE61IQus3SMQRZ@kroah.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfFE61IQus3SMQRZ@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 13:56, Greg Kroah-Hartman wrote:

[snip]

>>    fb_ili9341.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)

This was a copy and paste error. It should had been:

                   (DRM driver in drivers/gpu/drm/tiny/ili9341.c)

>>    fb_ili9481.c
>>    fb_ili9486.c (DRM driver in drivers/gpu/drm/tiny/ili9486.c)
>>    fb_pcd8544.c
>>    fb_ra8875.c
>>    fb_s6d02a1.c
>>    fb_s6d1121.c
>>    fb_seps525.c
>>    fb_sh1106.c
>>    fb_ssd1289.c
>>    fb_ssd1305.c
>>    fb_ssd1306.c
>>    fb_ssd1325.c
>>    fb_ssd1331.c
>>    fb_ssd1351.c
>>    fb_st7735r.c (DRM driver in drivers/gpu/drm/tiny/st7735r.c)
>>    fb_st7789v.c (DRM driver in drivers/gpu/drm/panel/panel-sitronix-st7789v.c)
> 
> I'll gladly take a patch that deletes the fb_* files that are already
> handled by a DRM driver like you list here.
>

Sure, I'll post a patch later today. If there's something missing in
the DRM driver, anyone can get the needed bits from the git history.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

