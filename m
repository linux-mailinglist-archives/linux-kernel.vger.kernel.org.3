Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2734A5DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiBAOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238944AbiBAOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643724109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0xhLey8NZwZfvq1aWQDBdLCgJjMsiCxuS9yKl0tV4E=;
        b=htPBBToLdzW2ECHBe8RKXN7vCK24k9NMaaQHwfYi1iYzpYljKlKUYjreA0TB6ZUTDMUPXj
        VlRiqxEs8N/rKetWB4kcOuNlbjWMFn3THF2DK25PpMr6SVC7xRmfg7ILSssIk7bIYymUjL
        CetMVlWoKsuiCyUwT7YHt6/b6pyJ2iA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-pqGdKLyIMcSky05r0D0XUQ-1; Tue, 01 Feb 2022 09:01:46 -0500
X-MC-Unique: pqGdKLyIMcSky05r0D0XUQ-1
Received: by mail-wm1-f71.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso666036wmz.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t0xhLey8NZwZfvq1aWQDBdLCgJjMsiCxuS9yKl0tV4E=;
        b=jisfhyU0SaFv0SZhg6+QijLvp3H0XH8rpqSwS15ph+kjx6ameTvi93xnG4e6ssktud
         qcF2n7N0uhf1/83u8x45S75IJGxnTZ4L94PaULDJAw2v2o4tSNRUFd/Jo3S6ZnyW/7HE
         B0IRVTl7G9/XSCrednrI9K6s7hZi/z3vYvYwUKOIZG/9VOg2FBMCiemvfohY5N8eV023
         YE+NFkgRWGXvlJiG0SiCczmV6sx+koz9Z03UfBqw+p3C99LuwJN7DGrn5QmKw4Zjup30
         Ayocw/PCbajfRagDYIXa7Hpo7qAqZny8a6u3zBeqg5Hhm+HA0kfgtm/r5FGxxc4NdLBS
         /SDA==
X-Gm-Message-State: AOAM532yCPs9poAqLi2esR/sel/EvwQwMuuQnw1MpnDxvxkxBW381/X9
        AZbViq7VHABrZ/juEpn/+ncLuj3vBIw0iL+cWXzww3cMZFakfy5o1o0AwWk0xaVUylHwdRXAEq6
        vhV1VEyd+C4RxoAIZDeOvagvr
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1907013wmc.177.1643724105443;
        Tue, 01 Feb 2022 06:01:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiXh7XT/y9EhbXaaYFMW+Z8FLorkbaMP6N2gEv45FSVWMJcQUX+XJyy9OHO0UQo8Hz5UgkJg==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1906977wmc.177.1643724105240;
        Tue, 01 Feb 2022 06:01:45 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v5sm2032210wmh.19.2022.02.01.06.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:01:44 -0800 (PST)
Message-ID: <3ebc8a81-a27f-9ab7-d247-5203f286eeb2@redhat.com>
Date:   Tue, 1 Feb 2022 15:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 22:05, Daniel Vetter wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
> 
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
> 
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
> 
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.
> 
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: DRI Development <dri-devel@lists.freedesktop.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

