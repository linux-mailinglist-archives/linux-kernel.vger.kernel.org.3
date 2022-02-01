Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5F4A5B34
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiBALbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237251AbiBALbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643715108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGRcgirIP4zYqgSlhOvvY2QNMhMYpFLin8cREeYj74w=;
        b=d2B9ItjQsMP7Kln2iapAxILEP/4/XmqojpX/mIKKlfxPz1drqkLv+wfMXz6L4OlhAYsKki
        uBrQdoVWCC1gp0baKxMmrqe7kPT3s/nsGUtNNkhUE2D03EoRW6J03KAVMgMIizGEfeYMAv
        knaHGD3cs/lTxy6BSiFXHJ13oXElDic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-uE4j7TEEOj2GzFgNF0JHvA-1; Tue, 01 Feb 2022 06:31:47 -0500
X-MC-Unique: uE4j7TEEOj2GzFgNF0JHvA-1
Received: by mail-wm1-f71.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so1420284wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XGRcgirIP4zYqgSlhOvvY2QNMhMYpFLin8cREeYj74w=;
        b=5C+Th7P1sXWAEERb39foravmRwwLKbF+NODm6EaIBahouW00HN+E0mmkjh2jY+aVts
         YcXo+MQZGPOhuG8aAiYupuMmPw67EfcutmKFRLbSFYWTBcmyfjttoqrCSLTuiar4LNM8
         VP8oGtbVHhKcp8VQ0bYbR6xqCsXTF8lNgSAbYn7ixgEXnImEoo+UGbnamnK0/wMvU7/N
         bPzkP0TZb0apBPDylIUjQ3W46j6V0GHkizxw8OvB6rRvsarCaB56o2wuXQYz2LB6TZOW
         EypTvFG6mQ9TBDYr8iRWELNb87hCnHvDzqkSXPkk16VVfnlV3OSfAPxc5X5TzQ2Jix4d
         eQlQ==
X-Gm-Message-State: AOAM532/eqHZkGuh0GldzaS4/xOwWdk9HnmAHVdRQOAsrbqSH/sTwy/a
        G0bnquJD6QgtSfG36ysroHMazL2BmGRuSOUDCWDwuqDQPcCjUyag5rxh0HARXXAmGy+xrx4WVQS
        1En2Dmip30mh6kmawYvAOUYLX
X-Received: by 2002:a05:600c:4618:: with SMTP id m24mr1382120wmo.16.1643715106049;
        Tue, 01 Feb 2022 03:31:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9dtgfmrio2wkiWGZX/AXacBC0IvydqtGX9/B6UswdRdmI3taa4PHdBSJzQZpcsZ/B5jNs5A==
X-Received: by 2002:a05:600c:4618:: with SMTP id m24mr1382099wmo.16.1643715105832;
        Tue, 01 Feb 2022 03:31:45 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n13sm1866913wms.8.2022.02.01.03.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:31:45 -0800 (PST)
Message-ID: <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
Date:   Tue, 1 Feb 2022 12:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 10:37, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 09:56:23PM +0100, Sam Ravnborg wrote:
>> On Mon, Jan 31, 2022 at 09:12:20PM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> Patch #3 adds the driver. The name ssd1307 was used instead of ssd130x
>>> (which would be more accurate) to avoid confusion for users who want to
>>> migrate from the existing ssd1307fb fbdev driver.
>> Looking forward the name ssd130x would make more sense. There is only so
>> many existing users and a potential of much more new users.
>> So in my color of the world the naming that benefits the most users
>> wins.
> 
> It depends if the binding is going to be preserved. Also this series doesn't
> answer to the question what to do with the old driver.
>

I don't plan to remove the old driver (yet). My goal here is to have an answer
for Fedora users that might complain that we disabled all the fbdev drivers.

So I wanted to understand the effort involved in porting a fbdev driver to DRM.

> If you leave it, I would expect the backward compatibility, otherwise the
> series misses removal of the old driver.
> 

I don't see how those two are correlated. You just need different compatible
strings to match the new and old drivers. That what was usually done for DRM
drivers that were ported. To give an example, the "omapfb" vs "omapdrm".

Since the current binding has a compatible "ssd1305fb-i2c", we could make the
new one "ssd1305drm-i2c" or better, just "ssd1305-i2c".

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

