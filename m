Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D840849DFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiA0Kuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233448AbiA0Kuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643280635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Fc2g7RRS/5veLFVlWFZ0JAd/TstB7ATk2nJ8PQ8WRQ=;
        b=hibh44FlHxvPYLwhkYSmKuzq5XbNzBCIzv8bCPRQcm4fG6tI/+k5wseMY6RIfkDrQJs36k
        lgWihIP6UgJ0mq10NfYSPOw9EKpBi63BPhYX8ILZBrSgMnfa+/suut/7GKU/yc8YkOmnh9
        OJFemdttd8p0RjqGx57LcBjhiopSAtg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-OiFU6uWwP4eSMP607JZobw-1; Thu, 27 Jan 2022 05:50:33 -0500
X-MC-Unique: OiFU6uWwP4eSMP607JZobw-1
Received: by mail-wm1-f72.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so1251986wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Fc2g7RRS/5veLFVlWFZ0JAd/TstB7ATk2nJ8PQ8WRQ=;
        b=0HzGOENG/aHMriUQ+Zzky64XFKQq1mdF2xOTQ4PE8U1LASD4KnEvAsEndP79JHOvRW
         unyZDYbu8tp/9/SDJkzJgw9Jzm2UUm0EpZ3NmFe/6y0so0TyWLoXEQ6E/V+qbFOiJ0KS
         cjM6Vccgq5lOT1+/RfKseMso10OVbNOkimaNKq8jQybMY7KtI4C6JVuIRHZLc3H0i6Q2
         7S4UI1im400L/yjNjXbLChlhhWAKLv8ik0h7gW9DGysa4RAMqarTR4J5KIuOcwskG9fx
         0Q20TAmLka+rKbF76JTw0BJJfLDJVCUD+697dRqAOdmoUGoLuGr7a4rsSLSmCbZYf+eo
         cwgQ==
X-Gm-Message-State: AOAM532/WD/zywsq0/7WG86hbItXBVur7YgoyUWSWHh92K+kOv4HRnq5
        CE+OkO8ze/lSsT6oILWhE8ENkUsb8Eqw4pRfKKGLm9GE8cxeRk7GBZUruosL+AZRHXGqF2kG5W2
        d0w1Q+aXduZA87lIi4Ivy4J8a
X-Received: by 2002:a05:6000:1acc:: with SMTP id i12mr2636061wry.492.1643280632297;
        Thu, 27 Jan 2022 02:50:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNH0Darpnr4Jl3HYou3CgHI6hafBenm/U34TNRMyZ82WXc0eLk9f+p/4dPBzISBOZBPFknQw==
X-Received: by 2002:a05:6000:1acc:: with SMTP id i12mr2636048wry.492.1643280632126;
        Thu, 27 Jan 2022 02:50:32 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b11sm5331007wmq.46.2022.01.27.02.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:50:31 -0800 (PST)
Message-ID: <b305cb36-1a09-c990-a3e6-98d420c62e3a@redhat.com>
Date:   Thu, 27 Jan 2022 11:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/doc: Add section in the introduction page about
 learning material
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pekka Paalanen <pekka.paalanen@collabora.co.uk>
References: <20220127082058.434421-1-javierm@redhat.com>
 <c99a7784-7ac4-e305-1a06-dfb514a409ff@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c99a7784-7ac4-e305-1a06-dfb514a409ff@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 1/27/22 10:18, Thomas Zimmermann wrote:
> Hi Javier,
> 
> thanks for this patch.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks!
 
> Find some ideas for consideration below.
> 

[snip]

>> +
>> +Learning material
>> +=================
> 
> Maybe 'External References'.
>

Agreed, I'll change it.

>> +
>> +Since the Linux DRM layer supports complex graphics devices, it can be quite
>> +overwhelming for newcomers to get familiar with all the needed concepts and
>> +learn the subsystem's internals.
> 
> It sounds a bit intimdating to me. Can we give it a positive spin?
>

Pekka also had reservations about this paragraph, so I think that will just
drop it. The goal of having this section was to ease the learning curve but
the way I worded it may reinforce the perception that DRM is hard to learn.

> IMHO we could add a separate section that talks about complexity and 
> provides guidelines about how to deal with it:  trivial HW? use simple 
> pipe;  dedicated VRAM? try TTM;  awkward color formats?  see 
> drm_format_helper.c
>

Indeed. And we can add such section as a follow-up. Maybe referring to some
of the drivers in drivers/gpu/drm/tiny.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

