Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720F9571567
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiGLJK7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGLJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:10:57 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F99CE1C;
        Tue, 12 Jul 2022 02:10:56 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id ck6so8903898qtb.7;
        Tue, 12 Jul 2022 02:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ogZIuR/DNUWYAnvjSDu9n0AhaTeKYHQRl89eLWPlDEo=;
        b=LuOleYcdeHnvbeF4+x6flEaNrBNwKMUHbUSbpcs/5g9PEwrySYPAnXFdEo7HEWbztp
         Bfxqv+GALPjapKa0Q2A5x1iN3FJAfhgixuuU9j+IxMgiiHCHMuGzSSq83OCk6SS1aCJy
         jTe4XjnRz//eVrWyeofe+EUP3Q1OMS1k7AoomtwSPP8nU+PMp9h3p2vIRbWal0Pdc4ld
         dFcQHK6BY87mLcLte9DdCbvhw8SZY4n5L0+Fr/ER5hfQR93+04g50SOXXXKrxIfaK8c2
         bZyxHtJwxUrohZ85VoXcKZqXNtsN05JQQ7rKfbUZLpSOaIuHn3oTv1YKRzMhcLrqMAQr
         gOUA==
X-Gm-Message-State: AJIora/rdgB/36xYDKlvw4UEtdFHwVyAuwGAGZchdR7JuititvGEE+Tm
        bg+7Waavy35R+FQh6J1ix8UWoGyoWYGsNQ==
X-Google-Smtp-Source: AGRyM1vK8rlLBJMjSaehJAPkF1WdlWuzbUVpQZAsxgJKYrBqBxRy98haDwT6SmP4butduEfh/TCx1g==
X-Received: by 2002:a05:622a:60f:b0:31c:c5da:eb49 with SMTP id z15-20020a05622a060f00b0031cc5daeb49mr16659451qta.443.1657617055390;
        Tue, 12 Jul 2022 02:10:55 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id u20-20020a05622a011400b0031ea53f4c5esm7264192qtw.83.2022.07.12.02.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:10:54 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id g4so12882139ybg.9;
        Tue, 12 Jul 2022 02:10:54 -0700 (PDT)
X-Received: by 2002:a05:6902:701:b0:66e:a06d:53d7 with SMTP id
 k1-20020a056902070100b0066ea06d53d7mr20639488ybt.604.1657617053347; Tue, 12
 Jul 2022 02:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657300532.git.geert@linux-m68k.org> <0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org>
 <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org> <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
 <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org> <CAMuHMdVrf7fgzumcSnZJ3OMGqA34YExXcF3O15YXYpA1ykgKyQ@mail.gmail.com>
 <20220712083907.3ic7bltstaskz72n@sirius.home.kraxel.org> <CAMuHMdVhxE9aayG8qRMwUuBryiR_ng08m63_+GY8htFCSmUiWg@mail.gmail.com>
 <20220712090305.44jq3olwhwypisoc@sirius.home.kraxel.org> <69a6aac7-0d48-7361-9750-8f242d374d60@mailbox.org>
In-Reply-To: <69a6aac7-0d48-7361-9750-8f242d374d60@mailbox.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jul 2022 11:10:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxbF6OsP0+c5hqxDTfHu+Wetcitk1yFiOPECoLtD6zyg@mail.gmail.com>
Message-ID: <CAMuHMdWxbF6OsP0+c5hqxDTfHu+Wetcitk1yFiOPECoLtD6zyg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Tue, Jul 12, 2022 at 11:09 AM Michel Dänzer
<michel.daenzer@mailbox.org> wrote:
> On 2022-07-12 11:03, Gerd Hoffmann wrote:
> >>> As described above DRM_FORMAT_HOST_RGB565 means bigendian on bigendian
> >>> hosts and little endian on little endian hosts.  Which is not correct
> >>> when your hardware does big endian no matter what.
> >>
> >> But (a) drm_driver_legacy_fb_format() uses DRM_FORMAT_HOST_RGB565
> >> if quirk_addfb_prefer_host_byte_order is set,
> >
> > Ah, right.  Missed that in 'git grep' output.  Given that traditional
> > fbdev behavior is to expect native byte order using
> > DRM_FORMAT_HOST_RGB565 there makes sense indeed.
> >
> > Scratch my comment about it being unused then ;)
>
> DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN is still what the driver should use conceptually, and should match DRM_FORMAT_HOST_RGB565 in drm_driver_legacy_fb_format on a big endian host (which is presumably always the case for the atari driver).

Sure, I'll update the patch accordingly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
