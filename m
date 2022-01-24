Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40682498875
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbiAXSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:39:09 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:41630 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiAXSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:39:07 -0500
Received: by mail-ua1-f43.google.com with SMTP id l1so30893551uap.8;
        Mon, 24 Jan 2022 10:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8r8scPQjT8uH8pXGowu/+E5c7EtaUCFQ6Gv6NPqtrM=;
        b=CYiuf8EyVTvsGjFuaR/f6AR0zk/zDLJWz90XbzEF5WnuR5YDuk4vucQxJucWLb3pDJ
         Yxu/Uu/C1seXaBhn+/cIBGB3T5jgRHwfkFyUp1Lkpwya4gLJdztkQYwPJZf0pE1AAmQn
         dba6dXRPMB43EDxKZRvYhHP6NJOwyHs/5g4V7faGHSrAlwCqdp6daFxCbXXb3JvBigv9
         M2ifRckiv3YuSsiQM85xKWTQ8Ei9ydRqLNvTkpjqP8ehAbCjxFtODvjWLpbf8uuRnv9u
         SJFXvmD1Hqwa7mOb2qM1XzUnp8J9UR/SNOHDhNH4owJdJBVq1c6pLSLvJgxbHwNh+1kc
         N5xw==
X-Gm-Message-State: AOAM533TJt6S0s8+SBDUmx2pc2bh82QNNFjQPCeaIcFyZ7kCffzi+ZKo
        IspSzcVjeYYt6LlJhzj8hs4Phzs5ai1ziw==
X-Google-Smtp-Source: ABdhPJwaSLswTK8d7GpAwtydmeDIhX+9HKkpmjVZsL17aGPTKWx7GKnJMa1/vgD5f36BT9r+dZqE9Q==
X-Received: by 2002:a67:dc03:: with SMTP id x3mr5450574vsj.37.1643049546829;
        Mon, 24 Jan 2022 10:39:06 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id q6sm1943489vkd.50.2022.01.24.10.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 10:39:06 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id b77so10741774vka.11;
        Mon, 24 Jan 2022 10:39:06 -0800 (PST)
X-Received: by 2002:a05:6122:ca1:: with SMTP id ba33mr1920131vkb.39.1643049546088;
 Mon, 24 Jan 2022 10:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
 <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com>
 <70530b62-7b3f-db88-7f1a-f89b824e5825@suse.de> <CAMuHMdW5M=zEuGEnQQc3JytDhoxCKRiq0QFw+HOPp0YMORzidw@mail.gmail.com>
 <57d276d3-aa12-fa40-6f90-dc19ef393679@gmx.de> <CAKMK7uE7jnTtetB5ovGeyPxHq4ymhbWmQXWmSVw-V1vP3iNAKQ@mail.gmail.com>
 <b32ffceb-ea90-3d26-f20e-29ae21c68fcf@gmx.de> <20220118062947.6kfuam6ah63z5mmn@sirius.home.kraxel.org>
 <CAMuHMdWXWA2h7zrZa_nnqR_qNdsOdHJS=Vf1YExhvs08KukoNg@mail.gmail.com>
 <3f96f393-e59d-34ac-c98b-46180e2225cd@suse.de> <20220120125015.sx5n7ziq3765rwyo@sirius.home.kraxel.org>
 <CAKMK7uF-V20qWTxQLvTC6GjC8Sg+Pst+UJ3pWCLQ4Q7Khgy62g@mail.gmail.com>
In-Reply-To: <CAKMK7uF-V20qWTxQLvTC6GjC8Sg+Pst+UJ3pWCLQ4Q7Khgy62g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jan 2022 19:38:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWS3rYUUB8HQcpjq0pY28cLiPMGrYEXeSPVtr-a_rrQvQ@mail.gmail.com>
Message-ID: <CAMuHMdWS3rYUUB8HQcpjq0pY28cLiPMGrYEXeSPVtr-a_rrQvQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Jan 21, 2022 at 9:55 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> Just to clarify, since we had lots of smaller and bigger
> misunderstandings in the thread thus far: DRM_FORMAT_RGB332 exists, so
> drm support that already. The fbdev emulation doesn't yet, but all
> that's needed for that is filling out the code to remap the drm
> description to the fbdev format description for this case. Plus
> testing it all works ofc with fbcon and whatelse. Note that RGB332  is
> a bit more work than e.g. C4, since atm fbdev still uses only bpp to
> identify formats, so would need to be switch over to drm_fourcc first
> before adding anything which aliases with something existing (we have
> C8 already wired up).

I doubt that RGB332 would be a bit more work than C4, as RGB332 is still
8 bpp, while C4 is less.  To support C4, all DRM code that cannot
handle format->cpp[0] < 1 or drm_format_info_block_width() > 1 has to be
fixed first.

On the plus side, I finally got my proof-of-concept Atari DRM driver
working with fbcon on ARAnyM.  Mapping /dev/fb0 from userspace doesn't
work (fbtest SEGVs while reading from the mapped frame buffer).  I don't
know yet if this is a general issue without deferred I/O in v5.17-rc1,
or a bug in the m68k MM code...

So far it supports C8 only, but I hope to tackle C4 and monochrome soon.
Whether the end result will be usable on real hardware is still to be
seen, but at least I hope to get some DRM code written...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
