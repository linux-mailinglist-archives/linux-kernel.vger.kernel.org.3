Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC04983D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbiAXPu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:50:56 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:33570 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbiAXPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:50:52 -0500
Received: by mail-ua1-f48.google.com with SMTP id u6so31876750uaq.0;
        Mon, 24 Jan 2022 07:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CbVkEbxTIR+WGNzjkBEYilBK2bcgVTSN3u2lPmmlm40=;
        b=i1bfkVg+Qi6fXnQrPGksEVEFeZwB8+mNVwlfgYBMiMw4JNFQFtM8qeEVlwGT5kUsJa
         1RnTy3c0bz7ubRz01WmphR775g1BNyvZrOu0wcgCAIFCdlP+0OLmBH/Z35Sv69fgRdT2
         zp8k26B2qJ4XBBiSjiCfLJrCBixRYJHt8xrPztZcYVx7WPPT6wllt6JlGDhCIdclGYnU
         jTOKfVPoYtYMUGkZeYMhGmk2L/4D3J6jYsf1PfGlawRDfS92T2X2SfCsgalsPBoz54Sb
         23BoAPa29yGvVR9+kvkNnGr1w57Zi37FN3q8X56AmB0g2Yv+gqs6m9q54jQnJceOL3sE
         i76A==
X-Gm-Message-State: AOAM533LehkXbyHecU01Qc/hNRS24cPkMGmgFTkiFle+rcWNZznmWT6u
        obtk+kenJxI3AZ3ryoDBGvO8yHWkdnFofw==
X-Google-Smtp-Source: ABdhPJzpp7sOBzRgDjOYTiWE4YAOj3jxrSZxCYmo7f1KT/K/BrY3KtHueSaUMr3Vkob8adzEWldK+g==
X-Received: by 2002:ab0:48d1:: with SMTP id y17mr5906246uac.12.1643039451951;
        Mon, 24 Jan 2022 07:50:51 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id g25sm131201vsj.6.2022.01.24.07.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 07:50:51 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id w17so6330486vko.9;
        Mon, 24 Jan 2022 07:50:50 -0800 (PST)
X-Received: by 2002:a1f:1b46:: with SMTP id b67mr2965993vkb.20.1643039450695;
 Mon, 24 Jan 2022 07:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de> <20220119110839.33187-3-deller@gmx.de>
 <YelyGDNDTn1Aq/hm@phenom.ffwll.local> <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org> <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
 <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de>
In-Reply-To: <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jan 2022 16:50:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXu_paBcNhevgxXzr1pEes7qWtD=RHXTrqP=hxNBkupnw@mail.gmail.com>
Message-ID: <CAMuHMdXu_paBcNhevgxXzr1pEes7qWtD=RHXTrqP=hxNBkupnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Helge Deller <deller@gmx.de>, Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:33 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> With fbdev emulation, every DRM driver is an fbdev driver too. So

Some are even without?

drivers/gpu/drm/vmwgfx/vmwgfx_fb.c:     ret = register_framebuffer(info);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
