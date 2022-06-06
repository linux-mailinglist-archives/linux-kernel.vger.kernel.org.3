Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76553ECC6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiFFRNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiFFRMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:12:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0926543B;
        Mon,  6 Jun 2022 10:01:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v1so19471906ejg.13;
        Mon, 06 Jun 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4zYRg9QIKLuP0JwfVvjlEFPmuLeyXti8yyirKy91Q1w=;
        b=lJvGt4cT7Wc3DUsIMaQJsU+RQuEVx65ETRRSCvyxvEvxFajh86RC7k/CefpleSbE7Z
         CJHl/5Ookhpz2/i3QdX2NFv5FHsSkeZb0+1akLAgL8edxon2E7iL5TcbJbdwKmlabZm8
         dqdBfLGwCVDfd9si6nR8Pphnta9eMUHMkpsu9+TrvFqdvE/l7URNK6O5r0x4YVOKMGKm
         m+Mzn3E8wh/U5G4b1elvFdtUayEL8E+3JCbWSF8b6/kTv/38HnitXj3Kmf2YWvwTmlkj
         qpX41+bJ32sG+yCL/bnUciDsBj0HSsEI5LM0JYHD9uAxMEYFD4Mp/ax86AQ1+YAC3s3B
         yiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4zYRg9QIKLuP0JwfVvjlEFPmuLeyXti8yyirKy91Q1w=;
        b=jeqnBBjSAgOYozdonhihQAVzeG6gitdwU5t+VHBoz8ZG/hJyNHls/kqHatRZOlh262
         /YGRf7MMr2lEURW6BBfhQUPkScyPg6bcx0hy/0rUmjTXaGZ3RoD6Pr4bN7pT51JClAQd
         Sw+Rd+SIR+OBE5s6Eogmo3AvSGBk83ig8veXhZdR+JzyHhtFLiqyHWo/B3xnKcNsKveC
         phuzg65wsl2RGnE1S369ILVcXz21m4KcuCcL7vJRHBEgbMgqyPIgYXeyqfHLW2lEaDCu
         7u2Uz3kKbWQMWkWw+/M4WXed7v9Xu5wj2a7Vh3Al9SMdY8uZj+wpaVFsTvPQT3b8V93v
         9YMQ==
X-Gm-Message-State: AOAM531GbvcQp88LDvdsCNK1mDRaIcNFGXWzR724IENH2f6cEmkWvzWv
        hFLakHqTzSJlKGsPRkLa87yoCz09cuUyxUzu79ZzGjuqLww=
X-Google-Smtp-Source: ABdhPJzovU3c9OvgJvFgFzpioKQzX8EX17ry25J4mXgs9aUqi2Qyk8sPpBoEWgnTBS4jNoJCUffSCB20fcohU9dPV4M=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr4128843ejb.639.1654534911686; Mon, 06
 Jun 2022 10:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com> <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
 <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com> <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com>
In-Reply-To: <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 19:01:15 +0200
Message-ID: <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr read
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 6:54 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 6 Jun 2022, Andy Shevchenko wrote:
> > On Mon, Jun 6, 2022 at 3:55 PM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:

...

> > But more importantly I do not see the reason for the Acked-by tag when
> > SoB of the same person is present.
>
> I just repeated what Uwe gave me. Maybe he didn't notice he was already
> there as SoB.
>
> This situation is anyway a bit more complex than usual. The line I took
> was part of Uwe's much larger patch initially (which was fully reverted)
> so his SoB was carried over to preserve the authorship. As I made a
> non-trivial modification to his original patch by removing almost all of
> it, I added my SoB too. Given this situation, I kind of thought he Acked
> (approved) the post-modification version of it.

I believe you haven't preserved the authorship that way (since From
line is different), but since you have done non-trivial changes and
Uwe is okay with them, the straightforward tag chain would be (with
your authorship implied):
Co-developed-by: Uwe
SoB: Uwe
SoB: yours

--=20
With Best Regards,
Andy Shevchenko
