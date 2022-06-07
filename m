Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B353F7E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiFGIH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiFGIH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:07:26 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7616BA441;
        Tue,  7 Jun 2022 01:07:21 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id y15so12091257qtx.4;
        Tue, 07 Jun 2022 01:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nGjrTIeofqRJeA4GWWs8vd7hIjiLENiB/8ryQPveu0=;
        b=DNFR9EZhTaflmlytk8SVGW6fA2NnqGMqXps0BnhcUwhC/n5/VEtkkJzeMdLt3MOJyE
         zLUHvSHYxLkwaHOe9rQlRX1vRNg9MGLx52IJSSwHszhnCC4+1JLC1w/oJvfb1Evu0Qwn
         gb6EpEDW3JbmcJ/omJ/06A4FOWkN7Jxo8c4RZmNaKawHw5eES+GF3pH15l6HKojigZGI
         /vqGO8Bbqo8OeSpBQSs+ETEjuFjKasu69E0QexkuKFWf9zCgYr6yEhIQlTX+QEd6pTY7
         CtCbVNVwp43RUfztCBpbWIkIlz3qh+8OUVzDaPA6yqW82EwuRaKmm4mPsFvuQpVDitzW
         xI2g==
X-Gm-Message-State: AOAM532FbqfMQV7cjAi+3ZX4pRMf8wwg8hIbff6MbLDMDbR/YzB/jFaT
        EE7vEp/eYbeknYnz0VNASx4Afa5D72+qlA==
X-Google-Smtp-Source: ABdhPJwTs8QYYzk92z2c+3mHSnKJgN2imVXGdT70UsjlTeykYQrug7B83FJNbMjSiT5ljpVjaVsbQw==
X-Received: by 2002:ac8:4e82:0:b0:304:efb6:6197 with SMTP id 2-20020ac84e82000000b00304efb66197mr5317481qtp.224.1654589240349;
        Tue, 07 Jun 2022 01:07:20 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id j19-20020a05620a289300b006a6ab259261sm7903280qkp.29.2022.06.07.01.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 01:07:20 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-30ec2aa3b6cso166597467b3.11;
        Tue, 07 Jun 2022 01:07:19 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr30121193ywa.47.1654589239317; Tue, 07
 Jun 2022 01:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654529011.git.mchehab@kernel.org> <39b24f99f5b71eb5ac025b438b7eb2a0df2258a1.1654529011.git.mchehab@kernel.org>
In-Reply-To: <39b24f99f5b71eb5ac025b438b7eb2a0df2258a1.1654529011.git.mchehab@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jun 2022 10:07:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPfOjVWkDgthbhxrgyfb8oEjRh61xWxL7=HX0PfCxpHA@mail.gmail.com>
Message-ID: <CAMuHMdUPfOjVWkDgthbhxrgyfb8oEjRh61xWxL7=HX0PfCxpHA@mail.gmail.com>
Subject: Re: [PATCH 23/23] arch: m68k: q40: README: drop references to IDE driver
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mauro,

Thanks for your patch!

On Mon, Jun 6, 2022 at 5:25 PM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> Since IDE support was deleted by Christoph Hellwig <hch@lst.de>,
> Jun 16 2021, drop the left-over from README file.

This is only half of the story, cfr. commit 44b1fbc0f5f30e66 ("m68k/q40:
Replace q40ide driver with pata_falcon and falconide").

> Fixes: b7fb14d3ac63 ("ide: remove the legacy ide driver")

Hence this Fixes tag should be dropped...

> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/
>
>  arch/m68k/q40/README | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
> index a4991d2d8af6..4db6db54d57a 100644
> --- a/arch/m68k/q40/README
> +++ b/arch/m68k/q40/README
> @@ -30,9 +30,7 @@ drivers used by the Q40, apart from the very obvious (console etc.):
>                      genrtc.c           # RTC
>                 char/joystick/*         # most of this should work, not
>                                         # in default config.in
> -               block/q40ide.c          # startup for ide
> -                     ide*              # see Documentation/ide/ide.rst

... and the above should be replaced by ata/pata_falcon.c.
There doesn't seem to be an ATA replacement for Documentation/ide/ide.rst?

> -                     floppy.c          # normal PC driver, DMA emu in asm/floppy.h
> +               block/floppy.c          # normal PC driver, DMA emu in asm/floppy.h
>                                         # and arch/m68k/kernel/entry.S
>                                         # see drivers/block/README.fd
>                 net/ne.c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
