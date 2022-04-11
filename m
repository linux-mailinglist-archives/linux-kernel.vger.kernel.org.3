Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9B4FBF65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347355AbiDKOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347485AbiDKOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:42:48 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DA5588;
        Mon, 11 Apr 2022 07:40:33 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id d71so2628447qkg.12;
        Mon, 11 Apr 2022 07:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oI4f3biPLIocOopBgIpORD0bGlZYgZJ7egsxwhidPpw=;
        b=ElKlL9nThTW7x3K4DUYqzKJrRK2cUKdFWdUai/CyPGYbMFq+gbsvXRYz52BYha2PVF
         pze4i19liwYlcgzZGipJ0qP6ZIV9PZFIjQQNcUmpUYuFniq+kw0/1Kiu/+nR8YKyL+DF
         3GR4MnH37a/UjP0itvogyJMJFez2vSgYB2WXeNqUn0FBxz32b4pRiV4+NliVUIxe4Uhd
         Mug/SrFUGfZ228Q0FpqrFzzkKZibO/yUgDORlLn4cu0tiaRLwOzOMwPTtQO2ucyE/bpy
         Br3BzSrHbxKqGPHR/NnmozpU29T7TTDZRS1U1a5YOzO8t25ukz5W+cStTX6YnucJXD0j
         pBOg==
X-Gm-Message-State: AOAM533MOZs+I2rXg2hx8MWYeI/n8Zs4Kh5jnAOk9mqNQNQqgCipeJyz
        QeMwKhe/4hSUG3Z8bHRHLKBw7mO4nd+ZEA==
X-Google-Smtp-Source: ABdhPJztOfoP6S3BOGOeO0CGa+EnwPjPs7Ri0ODxeS1MvR2L+F19meBuDNsPSc/YqMcVqQUlzIKqiw==
X-Received: by 2002:a05:620a:424e:b0:67e:4c1b:c214 with SMTP id w14-20020a05620a424e00b0067e4c1bc214mr22103728qko.651.1649688032617;
        Mon, 11 Apr 2022 07:40:32 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm26020905qta.76.2022.04.11.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:40:32 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ebd70a4cf5so109101827b3.3;
        Mon, 11 Apr 2022 07:40:32 -0700 (PDT)
X-Received: by 2002:a81:4f0d:0:b0:2ec:1556:815 with SMTP id
 d13-20020a814f0d000000b002ec15560815mr5028816ywb.256.1649688032028; Mon, 11
 Apr 2022 07:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220406070315.13862-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220410174713.1a4e013f@jic23-huawei>
In-Reply-To: <20220410174713.1a4e013f@jic23-huawei>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 16:40:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdViXg2ZpKG+fJJyMjA_uY-7Tu2E1WwWed97OX5LOMq4tQ@mail.gmail.com>
Message-ID: <CAMuHMdViXg2ZpKG+fJJyMjA_uY-7Tu2E1WwWed97OX5LOMq4tQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Jonathan,

On Sun, Apr 10, 2022 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed,  6 Apr 2022 08:03:15 +0100
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > ADC block is common on Renesas RZ/G2L and RZ/V2L SoC's, so instead of
> > adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> > ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> > ARCH_R9A07G054.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Sounds like a fix?
>
> If so, please supply a Fixes tag.
> no need to resend, just reply with one to this email.

This is not really a fix, as the original dependency was correct at
that time.
This is a change to add support for the RZ/V2L (r9a07g054) SoC, and
avoiding the need to update the dependencies when support is added
for more SoCs of the RZ/G2L family later.

> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -910,7 +910,7 @@ config ROCKCHIP_SARADC
> >
> >  config RZG2L_ADC
> >       tristate "Renesas RZ/G2L ADC driver"
> > -     depends on ARCH_R9A07G044 || COMPILE_TEST
> > +     depends on ARCH_RZG2L || COMPILE_TEST
> >       help
> >         Say yes here to build support for the ADC found in Renesas
> >         RZ/G2L family.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
