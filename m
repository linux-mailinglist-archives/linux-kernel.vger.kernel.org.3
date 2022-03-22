Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD64E3F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiCVNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiCVNPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:15:54 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D1B7EF;
        Tue, 22 Mar 2022 06:14:26 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id 1so13913848qke.1;
        Tue, 22 Mar 2022 06:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/adiEo/XzFIdraw7is3qX+sC2P5eNMbIwRzU4EJr7s=;
        b=aYkL91Otmu5jRTqRCXIGkXR+FNRa4pWrJ5xN5BsmMHtMRHBmqBbeZ98qlg8Q9b7T80
         l2WUnE2z6DT7rPm21cv9xgrT+rv2jNk+KjY5RqFIeSL5EM7qlH3ZzexiSqAsQxdKneF4
         tJBUbOsROV1ujWy1p/+XTL2a/3WAG6V7/kM2CE1gmXxtJ8i/L4JCmq0f2G8jlTeUDT1X
         OV0cFHA5e1qm4IOxT/Sm2XSWQSiSNpJA0YqmiL2KT4q1l7JU0s/943FhWqPFIYA3J+/B
         s2BxneX5nc/6yX0yfG0zA2BfCiUZ827CoVkONyORh0cttzuElOELa7Gf/dg84OzWg/Dz
         Ua5Q==
X-Gm-Message-State: AOAM531PqY+laTLUBjPZeWX6+YbY6d52Xl/L0Od6nY1ioYigBeb1RLyG
        PDX/NMBgizeQryeHzH9jwYmKRJBANsbB9A==
X-Google-Smtp-Source: ABdhPJy5MKI3Itee0xd+7KFQZqSHPa2fEFOfkId03Xu1EgI9okxq/n+PzlDdrsEnte+581Jxzx4VNQ==
X-Received: by 2002:a05:620a:440d:b0:67b:489a:616f with SMTP id v13-20020a05620a440d00b0067b489a616fmr14983782qkp.639.1647954865268;
        Tue, 22 Mar 2022 06:14:25 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id z6-20020ae9c106000000b0067d3b9ef387sm8836885qki.28.2022.03.22.06.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 06:14:25 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2e5e9025c20so106880687b3.7;
        Tue, 22 Mar 2022 06:14:24 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr29453478ywb.132.1647954864581; Tue, 22
 Mar 2022 06:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
 <CAMRc=McbY6vK_M9fP7Hzg8LE9ANOZKN49hmBFn92YFH+2ToM8w@mail.gmail.com>
 <CACRpkdb-W10YAQff_dTUL7B-DH01Z9nn7cE71Zv5xjALtDGQ1g@mail.gmail.com> <CA+ASDXOOzECbCBoehKjmFjLTtsssk9AH1NabA=FSRvoVWp8KMQ@mail.gmail.com>
In-Reply-To: <CA+ASDXOOzECbCBoehKjmFjLTtsssk9AH1NabA=FSRvoVWp8KMQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Mar 2022 14:14:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUANNFNt6yuTEcadkdVhKHDmVAVofWOfFpW-r2wkL=vdQ@mail.gmail.com>
Message-ID: <CAMuHMdUANNFNt6yuTEcadkdVhKHDmVAVofWOfFpW-r2wkL=vdQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Brian Norris <briannorris@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Brian,

On Tue, Mar 15, 2022 at 1:19 AM Brian Norris <briannorris@chromium.org> wrote:
> On Mon, Mar 14, 2022 at 3:23 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Mar 14, 2022 at 4:00 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > I like it. It's true we don't see many of those DEBUG constructs
> > > anymore nowadays and overhead for might_sleep() and WARN_ON() is
> > > negligible.
> >
> > I agree.  I have something similar for pinctrl, maybe that needs to
> > go too.
>
> Huh, yeah, CONFIG_DEBUG_PINCTRL does look awfully similar, and I just
> didn't notice because we don't happen to have it enabled for Chromium
> kernels. We happen to have CONFIG_DEBUG_GPIO enabled though, and the
> "new" rockchip-gpio log messages triggered me :)
>
> I guess one difference is that CONFIG_DEBUG_PINCTRL is almost
> exclusively (aside from some renesas drivers?) about extra logging and
> less about interesting checks that one might want to enable in more
> general settings. So it's a clearer call to make that people generally
> want it disabled.

For the Renesas pinctrl drivers, it enables sanity checks on the pin
control tables, which you definitely do not want in your production
kernel.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
