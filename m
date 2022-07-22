Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630157E003
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiGVKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVKb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:31:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD7B5041;
        Fri, 22 Jul 2022 03:31:27 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i14so7343096yba.1;
        Fri, 22 Jul 2022 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lhb42uZBI4TkrNrzYCwheilBu8AsVpQh5Q/c+JEO0E=;
        b=qtHokHQGmqaO6Xq3ZREy2um0Z1aLQprQxEK3pIiup0QckVHGrUwkYy3t2Tsqs+lgrP
         TJVa2xn4V3AdVyJ7GJ7ydMXVZtd8f5QK7IjuzG5tbGuIh1J9e9QBVTKgZrU+TIYgfqbZ
         XvWHpD3zFJdVMsCY9z/t2WV61AG6VavJzP78p7mY5mWrI8QAXCmfEGk8DI57fPMdQNJv
         a//9zBPnWesxxoqthE8mczZS2OL6EgU0GukHfhgJcyXv3zhz4OWaaGDV99jCVoGFSXK4
         R5kxw5g/4dTqtyz0N484VvDEOx0MDpt4MEzfrQqkFldCtTbbY0M13kdt8FUfPZQHBhks
         ZMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lhb42uZBI4TkrNrzYCwheilBu8AsVpQh5Q/c+JEO0E=;
        b=meoLa/zW2OpqolpZT63ledLvZQk50JvoByFv2faiZa4JxEdIrV37LSdvSuBTzIFmQv
         eDebHVi91gaubSYxF6tN0z1zr/1qQze2k0xh7F7HhfupsJGpEMKn3XhXo/Xis71XbNhR
         4eLijnbdYxe2KOLnz4htQoiOX7FbOMHtntzbKctzWOql60fnpnM83txlQJl1npFw+XxY
         b4o71Hzn/YIGYaRjXEnXnurBNkETadjE98aeZvwwWtKrGnBMkgtAhb7U39OW5KNy+Rgp
         jiOnTXtdsvhf1jfljp23kiGr5EwlytMkioHGai87YCelnQ1SD/aSQoekPT744+12BxWC
         yuNg==
X-Gm-Message-State: AJIora8DDJE4t333+r6/mYoPdgGjx+Y6dmY+aAfJKdKro7yjbk1tGGoL
        UDyX1qT++zZJZgeL25c6tLgRxm6WD6NiVWc9sns=
X-Google-Smtp-Source: AGRyM1t86Ef2OkpcCNfQcn6wapSKkyxLA9etJGNbszm3Cynf6R9BXTPXXmGUjUhEfs1JLyMr3Wa+4fWeZz1rc6LrXIw=
X-Received: by 2002:a25:d406:0:b0:66e:c6b3:f11e with SMTP id
 m6-20020a25d406000000b0066ec6b3f11emr2440559ybf.354.1658485886284; Fri, 22
 Jul 2022 03:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220721221212.18491-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWDZVoxW5RUb0HjR7ZABo2Hj0waX+soqTDsxtxQa2N1MA@mail.gmail.com>
In-Reply-To: <CAMuHMdWDZVoxW5RUb0HjR7ZABo2Hj0waX+soqTDsxtxQa2N1MA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 22 Jul 2022 11:30:59 +0100
Message-ID: <CA+V-a8vE5PBhsmEcKYFrwV4wdF73rpqR3j8kQyKvRGbOA+Dahg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: renesas: Identify RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Fri, Jul 22, 2022 at 10:37 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Jul 22, 2022 at 12:12 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add support for identifying the (R9A07G043) RZ/Five SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -333,6 +333,16 @@ config ARCH_R9A09G011
> >
> >  endif # ARM64
> >
> > +if RISCV
> > +
> > +config ARCH_R9A07G043
> > +       bool "RISCV Platform support for RZ/Five"
>
> RISC-V
>
Agreed.

> > +       select ARCH_RZG2L
> > +       help
> > +         This enables support for the Renesas RZ/Five SoC.
> > +
> > +endif # RISCV
> > +
> >  config RST_RCAR
> >         bool "Reset Controller support for R-Car" if COMPILE_TEST
> >
>
> > @@ -102,6 +106,11 @@ static const struct renesas_soc soc_rmobile_a1 __i=
nitconst __maybe_unused =3D {
> >         .id     =3D 0x40,
> >  };
> >
> > +static const struct renesas_soc soc_rz_five __initconst __maybe_unused=
 =3D {
> > +       .family =3D &fam_rzfive,
> > +       .id     =3D 0x847c447,
>
> The Hardware User's Manual Rev.1.00 says H=E2=80=99x841_C447?
>
You caught a typo in theHW manual, H=E2=80=99x841_C447 is the value for
RZ/G2L, for RZ/Five the value is H=E2=80=99x847_C447 (and can be verified o=
n
page 146 SYS_DEVID register).

Below is the log from RZ/Five SMARC EVK:
U-Boot SPL 2020.10-ge84e786a34-dirty (Feb 25 2022 - 17:10:04 +0000)
Trying to boot from NOR


U-Boot 2020.10-ge84e786a34-dirty (Feb 25 2022 - 17:10:04 +0000)

CPU:   rv64imafdc
Model: smarc-rzf
DRAM:  896 MiB
MMC:   sh-sdhi: 0, sh-sdhi: 1
Loading Environment from MMC... OK
In:    serial@1004b800
Out:   serial@1004b800
Err:   serial@1004b800
Net:   eth0: ethernet@11c30000
Hit any key to stop autoboot:  0
=3D> md 0x11020a04 1
11020a04: 0847c447                               G.G.
=3D>


> > @@ -398,6 +411,7 @@ static const struct renesas_id id_prr __initconst =
=3D {
> >
> >  static const struct of_device_id renesas_ids[] __initconst =3D {
> >         { .compatible =3D "renesas,bsid",                 .data =3D &id=
_bsid },
> > +       { .compatible =3D "renesas,r9a07g043-rzfive-sysc", .data =3D &i=
d_rzg2l },
> >         { .compatible =3D "renesas,r9a07g043-sysc",       .data =3D &id=
_rzg2l },
> >         { .compatible =3D "renesas,r9a07g044-sysc",       .data =3D &id=
_rzg2l },
> >         { .compatible =3D "renesas,r9a07g054-sysc",       .data =3D &id=
_rzg2l },
>
> This change might not be needed (cfr. my comments on patch 1/2).
>
Ok.

Cheers,
Prabhakar
