Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC84A5B01
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiBALRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236928AbiBALRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643714258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vjw//fLkAQ84TIDAJkx8fTRjA3gXymjff0vArIKpGDA=;
        b=Fc/236WIZ8n4hanzHODpUCgwI96ge9VdO0NUAEtJmdG3CLS2nBwY/4cHlr4gA/9KEA57cB
        CCyeuwSTBKjND10Jk5iuEbxVY0MB6xCgDMnbFwbsJt0oeGhTZoazjnrlZGkPrtkkYsWy0a
        NoDOwaTzzbwvxR5IGIjV4cxNE9mnzLU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-xIN3zCs6Mde8dlwwzTLYbg-1; Tue, 01 Feb 2022 06:17:37 -0500
X-MC-Unique: xIN3zCs6Mde8dlwwzTLYbg-1
Received: by mail-wr1-f71.google.com with SMTP id t14-20020adfa2ce000000b001e1ad2deb3dso746651wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vjw//fLkAQ84TIDAJkx8fTRjA3gXymjff0vArIKpGDA=;
        b=FALtMUnyPgGONCJ0X2gWf6/d7r49JeFmrAXR3LbEkbpwQ2hiy1p8DTMspAy8n/bAlK
         VgTi/2f9Iz3GBZvz+PfSV0BqVqMGsuyI6kYwUZSEBoGCVAxeG8UeTqpuxBeQkSXe5AQh
         una3ehb5HOAoISqXKDSVGe0ua/y2saV+cScen6pg4khRb+Kll94UE49FEQ57WpXpHD5m
         zVIcWBYv2dwk6fieEmAiSj8AjuO9y/GgbF812dMj7ZWHJlafRBvEvv6tkjOINmCTkUaG
         Zs5idLZMM5Z6b4FDAzUf03doRowazIKKL8rajblQOYFEV2yBvytQb6LyBiM9g1GBdeOk
         cc9Q==
X-Gm-Message-State: AOAM531N3+2uo4Z78X8K7W3L41b+Wy7eUTqXCOi9ceLoGikUpYPBehXy
        lvwB2wIgC2DxNvRIboa9juHwVaGajRt2w2NMYrqzmpAYusqaeQ3FuGPlQampH4aV9Dkb3RIq/Tt
        F4bhbXPaL058C+daV+7ykqge2
X-Received: by 2002:adf:f045:: with SMTP id t5mr21095372wro.385.1643714256622;
        Tue, 01 Feb 2022 03:17:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbcg9U2rYIsyfcakZ9zSjonoBgrdJ/oOcSUdMbVuNhLqDn/9NnvNfRqe0QXRW90Ej8ByOWhg==
X-Received: by 2002:adf:f045:: with SMTP id t5mr21095354wro.385.1643714256365;
        Tue, 01 Feb 2022 03:17:36 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p7sm1824109wmq.20.2022.02.01.03.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:17:36 -0800 (PST)
Message-ID: <273132fb-cf11-93a6-6bfd-3cc8b19f8fa9@redhat.com>
Date:   Tue, 1 Feb 2022 12:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] MAINTAINERS: Add entry for Solomon SSD1307 OLED
 displays DRM driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220131201537.2325487-1-javierm@redhat.com>
 <Yfj+FOELlbtdhvRa@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yfj+FOELlbtdhvRa@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On 2/1/22 10:32, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 09:15:37PM +0100, Javier Martinez Canillas wrote:
>> To make sure that tools like the get_maintainer.pl script will suggest
>> to Cc me if patches are posted for this driver.
>>
>> Also include the Device Tree binding for the old ssd1307fb fbdev driver
>> since the new DRM driver was made compatible with the existing binding.
> 
> Dunno why you have patches 3 and 4 missed references (in terms of email
> thread).
>

Yeah, I use the patman tool [0] to post patches and something went wrong
after sending the first patch and I had to manually post the others with
git-send-email. I could had used --in-reply-to, but didn't feel like it.

[0]: https://gitlab.com/u-boot/u-boot/tree/master/tools/patman
 
>> +DRM DRIVER FOR SOLOMON SSD1307 OLED DISPLAYS
>> +M:	Javier Martinez Canillas <javierm@redhat.com>
>> +S:	Maintained
>> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>> +F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>> +F:	drivers/gpu/drm/tiny/ssd1307.c
> 
> I think it makes sense to add ssd1307fb as well. At least you may point out
> people patching old driver about new one until it's gone completely.
> 

That's a good idea. I also found some issues in the ssd1307fb driver when
doing the port, so I could dig more to fix them and propose myself as a
co-maintainer for the fbdev driver.

But I'll do that as a separate patch-set.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

