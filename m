Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B243549CB22
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiAZNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240960AbiAZNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643204658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HO8OojRGDxiniZjv6SrW57XV+ZtoIr3bX0tnTNyRlq8=;
        b=HmuHHy+CXzthFKRGWbNvXkNnjUhh/IW9/RmVjgk2GTj8e06LtRRJpSXXG0luChDKsNnsh1
        8e7DSU/Au1DgmzgDsYrk8FyXZQsDGYMQQUuLOkyKSXp0MfBc6rB9QOZZMJIifNjRwKeLXp
        SBb0gKx258Mud1lptCWyq7hbKR5CwX4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-qc46l_AzMpahc8Mr_gunvQ-1; Wed, 26 Jan 2022 08:44:15 -0500
X-MC-Unique: qc46l_AzMpahc8Mr_gunvQ-1
Received: by mail-wr1-f71.google.com with SMTP id q14-20020adfaa4e000000b001dd761d46c7so1382445wrd.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HO8OojRGDxiniZjv6SrW57XV+ZtoIr3bX0tnTNyRlq8=;
        b=295ygx6xI/wmgSVqVoytSXEDhSmyIjVfUwgfCdYhz9HdqSh+qzGPbVdluDJt7Odhxe
         QFN/K1hkk99QPCzr2gXfmmKvdik4Z2AdKgF3XcF6gI0O0mAYdnp9xu0Vc1I8As3bfTpN
         hII9gtjnZvMqzBoKnKRkIZI3aNN/9Uv4h87yspQQgPMzzimPfOtZUqZlrmtMeilD5/on
         bBr2p5mO0xnBbi1CZ3AGt93vTKJxIWyJ9pnY4NJ0uoN7+pVyjcGwQuBdR77Tyl6w4g1C
         DwyVoVhkIdvZg4mnSLSYXEYq3PjM4cmKfc3lNG71efln8gqDTRQq/O+VJQy0oqFijo0w
         Rz7w==
X-Gm-Message-State: AOAM532tYjld73Sn7Pn42Tspht9qjIAsecJi/kydm1CTfdt5Tqw7kuv2
        zU6hvKwkT8ROWH3XAN3hnfiIg/cNkrNV7UZmNyahXrtFQkslnEhdd1AsFFodIYPTOukNHfSmpA7
        lmUNLz58MkAGAXDpUwH7ECIP1
X-Received: by 2002:a5d:588d:: with SMTP id n13mr553776wrf.690.1643204654460;
        Wed, 26 Jan 2022 05:44:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybzQqjbMputeacc2RjhaPfXtnrHwBB3Q4bMgXV2bO3BAQz7ZnwzmTspSR3f1GLZrNkoUbXJg==
X-Received: by 2002:a5d:588d:: with SMTP id n13mr553763wrf.690.1643204654263;
        Wed, 26 Jan 2022 05:44:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 11sm902476wrb.30.2022.01.26.05.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:44:13 -0800 (PST)
Message-ID: <9b426301-bf41-0312-c34e-856938b196fd@redhat.com>
Date:   Wed, 26 Jan 2022 14:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <CAHp75Vd7oaYPKx6bxjCqNnm6fieeQFrtq5K4YYrxYbXoXFy=+Q@mail.gmail.com>
 <20220126102858.GX1951@kadam>
 <1b665bb8-7acb-519b-0a02-ef0f2dd4b524@redhat.com>
 <YfFE61IQus3SMQRZ@kroah.com> <YfFKLfSKUdo1UVfF@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfFKLfSKUdo1UVfF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 14:18, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 01:56:11PM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Jan 26, 2022 at 01:37:00PM +0100, Javier Martinez Canillas wrote:
>>> On 1/26/22 11:28, Dan Carpenter wrote:
> 
> ...
> 
>>>    fb_hx8347d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
>>>    fb_hx8357d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
>>>    fb_ili9163.c (DRM driver in drivers/gpu/drm/tiny/ili9163.c)
>>>    fb_ili9341.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)
>>>    fb_ili9486.c (DRM driver in drivers/gpu/drm/tiny/ili9486.c)
>>>    fb_st7735r.c (DRM driver in drivers/gpu/drm/tiny/st7735r.c)
>>>    fb_st7789v.c (DRM driver in drivers/gpu/drm/panel/panel-sitronix-st7789v.c)
>>
>> I'll gladly take a patch that deletes the fb_* files that are already
>> handled by a DRM driver like you list here.
> 
> None of the DRM driver supports parallel interface for these devices.
> 

Thanks for the info. Then we can't remove any of these drivers indeed.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

