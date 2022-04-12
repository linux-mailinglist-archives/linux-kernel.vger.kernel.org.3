Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1034A4FDA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383554AbiDLJCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357193AbiDLHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:51 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06214027;
        Tue, 12 Apr 2022 00:13:36 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id kl29so15487664qvb.2;
        Tue, 12 Apr 2022 00:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b40J74AZXHQx3F3Kvksxnsm3IoWKYudmg3ktvmskBdg=;
        b=vtRsdCbyShHPW1r/c0C6OSnkbkYgKws2dk0YIuJ2uJdeJHhuhheIRlabc3kzgejLJ1
         4lbXwJJX4hrPPJIUnEDhXOzJv7F68g3wfZYDPdRlXPAhm5COX4YRHZVy3h9GDwIL3ieK
         TqaLrInRLjUIK9U6eCX0SMozsIfepheIaVlx88atEcI2vs6etuIIsVrfBrJuU/u1PDHx
         4OH3ucwfh/DCCOIs1i9Xl/ONCtboy47ER6QV7Hugkjqx5uKrdxEY1bcXCnEW5lhEwYMg
         efQGRg65IROV1BKEt6TMK42e0nIpUfh+/CvyuJ3dQKxXOkPoL18/9CY51d/GesQXVKy+
         vw4A==
X-Gm-Message-State: AOAM532Q1UP8SW3/YKCBtQbbMbadf11PzDTPOMzr2KGM28Jdglgk38/r
        FJWZjfSj9YNPbUnWRxZa9y2js9IWLJ6y9uHX
X-Google-Smtp-Source: ABdhPJzCYVy117bkQj/DB7M6GTJOgziXwfQaUZNvnpGntUlMNL4oQyNKpLyC6dmfrLvTaoCpJKCavg==
X-Received: by 2002:a05:6214:202a:b0:441:6a41:f710 with SMTP id 10-20020a056214202a00b004416a41f710mr30439607qvf.84.1649747615328;
        Tue, 12 Apr 2022 00:13:35 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id i7-20020ac85e47000000b002e22bad4717sm27207165qtx.1.2022.04.12.00.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:13:35 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id e71so17006804ybf.8;
        Tue, 12 Apr 2022 00:13:34 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr24883011ybq.342.1649747614630; Tue, 12
 Apr 2022 00:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220411211243.11121-1-javierm@redhat.com> <20220411211243.11121-2-javierm@redhat.com>
In-Reply-To: <20220411211243.11121-2-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:13:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+ieUSv1sjOX-fks3o+J3Eicg-prCK2+roTq-MFKTHBg@mail.gmail.com>
Message-ID: <CAMuHMdU+ieUSv1sjOX-fks3o+J3Eicg-prCK2+roTq-MFKTHBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The current compatible strings for SSD130x I2C controllers contain both an
> "fb" and "-i2c" suffixes. It seems to indicate that are for a fbdev driver
> and also that are for devices that can be accessed over an I2C bus.
>
> But a DT is supposed to describe the hardware and not Linux implementation
> details. So let's deprecate those compatible strings and add new ones that
> only contain the vendor and device name, without any of these suffixes.
>
> These will just describe the device and can be matched by both I2C and SPI
> DRM drivers.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
