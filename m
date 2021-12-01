Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF33464BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348702AbhLAKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:36:32 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:35650 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbhLAKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:36:30 -0500
Received: by mail-ua1-f47.google.com with SMTP id l24so47950891uak.2;
        Wed, 01 Dec 2021 02:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qx2rFl2gGh5DjvnB5x64pIevDhVgLso6t2KGmD7a7pY=;
        b=0lsImyXKn25t3UNQpHUQwzt96IbRvCYZZgAsaDDLbKsCihkGHOITPJI3Xjoimw7toG
         BGCMY2Fu6od5pFOwJIERyt7QqwLlZNqwPj1HNIOsB0WoYtusCuPh3HLt3PYl1xfWASrK
         TtwoRVDb3MaolHO7p0Pm5MzF8oMyAtucEDYhQEebqXziJMY39tbzx8oSjGoZxafNk3vB
         +i6svcaIJ/zBaOsQ9Objk7cGX2BlIQhqPbuCm+D9UBmMUKxzKzDzjpRvuBga3EjvqXp8
         dRr71ixMfDkCExmSqme5rke2RSXZqJiAVRfyE9949Si6llnXOPhWFg0aTseOxrjGPvAr
         a4Nw==
X-Gm-Message-State: AOAM531zdKhTTRNfn5oe+AVDRj124C2d/gUG2Em4NgVNUZENY68ebnaM
        cqX8p8wOdJR++dUrWnQGN9dJtj9vpGIG8Q==
X-Google-Smtp-Source: ABdhPJzxA47Sgmg4ssYnY8KAQ5TDQn0XFiXhEAlKZOdWLYqU7Yf6SQwKxAFeNElmOvqfgXlfHh3fIw==
X-Received: by 2002:a67:e14d:: with SMTP id o13mr5710626vsl.29.1638354789538;
        Wed, 01 Dec 2021 02:33:09 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id v8sm11505624vkc.52.2021.12.01.02.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:33:09 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id r15so47884185uao.3;
        Wed, 01 Dec 2021 02:33:08 -0800 (PST)
X-Received: by 2002:a9f:248b:: with SMTP id 11mr6091545uar.14.1638354787791;
 Wed, 01 Dec 2021 02:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20210906102837.2190387-1-martin.kepplinger@puri.sm>
 <20210906102837.2190387-3-martin.kepplinger@puri.sm> <CAMuHMdVVNhLa2p-ywmpcEj-sw+NyRNp2z9jsVqsXEDrKphivCQ@mail.gmail.com>
 <d5e0fe8f8a5445c9c2d2b90fcf454829daf393e8.camel@puri.sm> <YaC0cxmXB8kDcDAI@valkosipuli.retiisi.eu>
 <CAMuHMdXaywzfzLDoWYj0vfQ=xjUc+exgwUrrfNvp0Z-eVcNNMg@mail.gmail.com> <cbf47818643901943b844fb729c9ac360d7f3bd3.camel@puri.sm>
In-Reply-To: <cbf47818643901943b844fb729c9ac360d7f3bd3.camel@puri.sm>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Dec 2021 11:32:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMvFDJ44LLZbXsCs7U=0novzLAae7tUw48HC9JG2aVGg@mail.gmail.com>
Message-ID: <CAMuHMdUMvFDJ44LLZbXsCs7U=0novzLAae7tUw48HC9JG2aVGg@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] dt-bindings: media: document SK Hynix Hi-846 MIPI
 CSI-2 8M pixel sensor
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel@puri.sm,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        shawnx.tu@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Nov 30, 2021 at 3:57 PM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
> Am Freitag, dem 26.11.2021 um 13:03 +0100 schrieb Geert Uytterhoeven:
> > This is reproducible on next-20211126.
> > Is your dt-schema up-to-date?
>
> it is now, I'm running
>
> make -j7 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- dt_binding_check
> dtbs_check
>
> but I can't reproduce that error. weird.

Interesting...

$ git checkout next-20211201
$ make -j 12 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- dt_binding_check
  [...]
  CHECK   Documentation/devicetree/bindings/media/i2c/rda,rda5807.example.dt.yaml
Documentation/devicetree/bindings/media/i2c/hynix,hi846.example.dt.yaml:
camera@20: port:endpoint: Unevaluated properties are not allowed
('link-frequencies', 'data-lanes' were unexpected)
        From schema:
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml

My userland is Ubuntu 20.04.3 LTS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
