Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC347D2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbhLVNUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhLVNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:20:10 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 05:20:10 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g17so6483945ybe.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j1goV5aAlMyw5R8emZiAZx447+jdj41qItWe+35D124=;
        b=jrchVVYCdWsktlqGCWjwZ1v1nkvcmwuQpyp6dw1rbAOesVS48vJ/3AMJLHLTPt8+H3
         55oFx4O2+e1JzsWICdze5pWlgOPiPVuL4aB4vDNxhLU5kx1frOqUwmwg3lMJThOl7SZN
         sRjFXF4dVzb5qE2Ae4w3uykCcKE/AwLTGdDLbMF+X52pcWRFLFSATkJockrIXweHCThX
         BMm2bAbLSeHDuLwUBRO/I9JrnGQuyqAXA1nMdzVj4aYK9X3maVeziqeVAUGIG+D/cEDz
         SzLYPjtfM0EZhf0pfdIZQJTYzg2bN7RGS9dlkFPgDtovuWc2KLYklFnHa5+jK+jMHuK+
         50oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j1goV5aAlMyw5R8emZiAZx447+jdj41qItWe+35D124=;
        b=fFnYYtMjl8fkrCrg5l87QFx9Xo/ZIEmnmt8pX3Qppfr1UJbbPO9dB6tWb+kqzt7R7I
         G+GhrqmahxGcsAfc+v8PMkQoXAgVpK93zovwjLkq9+r/790hpOXa9Vv52D+Cfz4VISku
         VPCoZWMkujrqdI/vngnqonvhu1Mq8nadpmkBAroL7BAQW0IBi6NYUsGFnJMinSERtbog
         DGuiKPkDBRnf7vTT5+8Gw9+HVjDYrut/21ZZxw/SNdLJBb4Pz5HujtoQdxatxpioTjWG
         dA/DrvwH5AhLAbtcYMnhW5NOu9LzPQIPhxrPR9wDwRJYCG0hT9+z5T0fT0kcIKXilUjh
         +ZKA==
X-Gm-Message-State: AOAM531W4PHuvQtLGKmM2VAW4KVrleNW3zCMKmw9V3yS8aSuSrbeDifn
        P1uTnxI6YrP+1ywH0jnhJWXGWcx+qEJu3eUD2UnACDo3eHYE7g==
X-Google-Smtp-Source: ABdhPJzV7Q7oVy5TFBaPsvS9bSSY0IIXErDsF3neEXO3xKp5bdC9y9YZcL2gJ2ew0gMm7WD6kGv87ChvXAlwxxaOjr8=
X-Received: by 2002:a25:9a84:: with SMTP id s4mr4116211ybo.405.1640179209684;
 Wed, 22 Dec 2021 05:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20211220144654.926112-1-pgwipeout@gmail.com> <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
 <YcGU6pQqfEPBqjrO@google.com> <4963E4A2-63B4-48A1-BDDD-5F9D07D71598@public-files.de>
 <YcMHhJTsQMLDRRsN@google.com> <trinity-4d94e8dd-1499-4d5f-84c3-85075a4085dd-1640172673779@3c-app-gmx-bs44>
 <YcMf56MvFv0ym7E5@google.com>
In-Reply-To: <YcMf56MvFv0ym7E5@google.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 22 Dec 2021 08:19:57 -0500
Message-ID: <CAMdYzYpYumXLEZYNadfHHGZN16ismT2JOMO8bGEegXP69sT3sw@mail.gmail.com>
Subject: Re: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 7:54 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 22 Dec 2021, Frank Wunderlich wrote:
>
> > > Gesendet: Mittwoch, 22. Dezember 2021 um 12:09 Uhr
> > > Von: "Lee Jones" <lee.jones@linaro.org>
> > > An: "Frank Wunderlich" <frank-w@public-files.de>
> > > > Here i have squashed the change in:
> > > >
> > > > https://github.com/frank-w/BPI-R2-4.14/commit/06430ffcb6d58d33014fb=
940256de77807ed620f
> > > >
> > > > With the change i can compile it...
> > >
> > > Not sure I understand.
> > >
> > > Please make sure all patches you send for inclusion into the Linux
> > > kernel are fully tested.  They should also be bisectable i.e. not
> > > depend on patches applied *on top*.
> > >
> > > > But in v4 (patch is tagged as v3 too) the of_property_read_bool was=
 dropped completely.
> > > > regards Frank
> >
> > only v1 was sent by me :)
> >
> > v4 is compilable and works on rk809 (Bananapi r2 pro)
>
> My comments are directed at whoever sent patches without testing.

Apologies, due to an unfortunate set of circumstances I missed the
build failed and I was using a stale kernel.

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
