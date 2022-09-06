Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8A5AE68A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiIFLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiIFLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:24:17 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C571BFB;
        Tue,  6 Sep 2022 04:24:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a67so4625614ybb.3;
        Tue, 06 Sep 2022 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=5JSwL2Nl/QbXtnQEsfoWIEd7UkyZ22GYris54Ibm6bw=;
        b=SYekG2KcDIseinOxSiMnO0m/HZIT4wwSvDuh6GU+jYSKKutBbrAdF3V0Xa/nuN4xPk
         FtTzy6+bC1AQVolJ7mmqi0vF6I9oICS+l46+fTIVBpg76+eRlU7MffXYve7+4Km5Bv0U
         /2GKhOnC/aI9U7YOSL8yrxLfVoUYjl168TVnhGdL1B1S/qpxfHDO06a0trrHFCJPTeUy
         7i6Q8T+hr55izVFY9iWW6YuPEt4P46SjR3Qkwna0VykqwJdBM4OhL+Y/A77XGzbx+fAW
         8Rg5YzXXz3dCZyfZLHFtAyOeY2rhikdWqxzMey15ZYfqSnglME7D5XBekEruOHdWLfHX
         /kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5JSwL2Nl/QbXtnQEsfoWIEd7UkyZ22GYris54Ibm6bw=;
        b=yjjmKbyP6+h8o8gDujDsBt9kR8T/fFt0BZnSxAnrn1/+6b77tS72OVW6ZbRBg7fD+E
         MKNHXLXhYLW/fnGjy4LeG+u357Fpl4pNHfuWH6g/yfU51CxhG0dvZ/8KzBXULhD/vMM2
         PnBuubAE072ftfBHbSyHI6UsZRYNNw440ssAkJ7qsbRm+GRLGMQjGqweMpuIreH1+9Sa
         O1kIe0YA9NcO77R+fWngfjv3sLHryNMMecHjekDwO4mChhT4yYdXKnHDtlrc6JG1JOkq
         VOZgRJvh7WL3xa8vea2ax5mLRpdNhR+I9ir81AHqMC4oKUlviLirRODMp/W67i6u/aPy
         PCog==
X-Gm-Message-State: ACgBeo2fSqWiPDLYcyd7hBwq7CAPT5QEXXBEYuTTB1cO5DXbL8/oLBpI
        77SeV/e7+80XB5yOVGxddcxLdHBGjZ9YZogwZc8=
X-Google-Smtp-Source: AA6agR4z2iFehGd8W6rUIWt6hj7Kye1wZrCP7PzbK7xgVbz/0ZAyX3m53ll0X2dNbN0gcYPcCzdzSyW/8zp6eCbd0xg=
X-Received: by 2002:a25:6c09:0:b0:6a6:5b85:1e53 with SMTP id
 h9-20020a256c09000000b006a65b851e53mr14579153ybc.299.1662463454003; Tue, 06
 Sep 2022 04:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
In-Reply-To: <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 6 Sep 2022 12:23:47 +0100
Message-ID: <CA+V-a8tyeufNqbLqPuKGgedXXJPxMRc2N6MjO9nCh=zvswu9NQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, atishp@rivosinc.com,
        apatel@ventanamicro.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Conor,

Thanks for the quick glance!

On Tue, Sep 6, 2022 at 11:39 AM <Conor.Dooley@microchip.com> wrote:
>
> On 06/09/2022 11:21, Lad Prabhakar wrote:
>
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 2a0ef738695e..10a7c855d125 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -37,6 +37,7 @@ enum sbi_ext_id {
> >
> >          /* Vendor extensions must lie within this range */
> >          SBI_EXT_VENDOR_START =3D 0x09000000,
> > +       SBI_EXT_ANDES =3D 0x0900031E,
> >          SBI_EXT_VENDOR_END =3D 0x09FFFFFF,
> >   };
>
> Everything else aside, I am very interested in what's happening
> here. I'll take a proper look through things later, but for now:
>
> For PolarFire SoC we have an InterHart Communication SBI EXT that
> would would like to upstream support for. We are not aiming to put
> the driver itself in arch/riscv - it's just a mailbox driver, but
> I would like to use sbi.h for defining the vendor id etc.
>
sbi.h seems appropriate for now, unless the maintainers have other ideas.

> I am not sure how this all aligns with:
> > We=E2=80=99ll only accept patches for new modules or extensions if the
> > specifications for those modules or extensions are listed as being
> > =E2=80=9CFrozen=E2=80=9D or =E2=80=9CRatified=E2=80=9D by the RISC-V Fo=
undation. (Developers may, of
> > course, maintain their own Linux kernel trees that contain code for
> > any draft extensions that they wish.)
> >
> > Additionally, the RISC-V specification allows implementors to create
> > their own custom extensions. These custom extensions aren=E2=80=99t req=
uired
> > to go through any review or ratification process by the RISC-V
> > Foundation. To avoid the maintenance complexity and potential
> > performance impact of adding kernel code for implementor-specific
> > RISC-V extensions, we=E2=80=99ll only to accept patches for extensions =
that
> > have been officially frozen or ratified by the RISC-V Foundation.
> > (Implementors, may, of course, maintain their own Linux kernel trees
> > containing code for any custom extensions that they wish.)
>
> Which is in: https://docs.kernel.org/riscv/patch-acceptance.html
>
I had completely missed this, thanks for pointing it out.

> It is unclear to me whether that is just for ISA extensions or if that
> covers SBI extensions too. At least for us, since we don't touch arch
> code there is relatively little friction & there's no concerns about
> reducing the portability of a kernel since it is just a regular old
> driver.
>
> I was planning on cornering some people *cough* Palmer *cough* at
> LPC and asking him what his thoughts were there.
>
I too will be attending the LPC (virtually though) and would like to
attend/chat on this topic. Please keep me posted.

> FWIW this is what we have been doing:
> https://github.com/linux4microchip/linux/blob/linux-5.15-mchp/drivers/mai=
lbox/mailbox-miv-ihc.c#L27
>
From the looks of it it's on similar lines ;)

> The IP itself has not stabilised yet, so we have not sent any patches
> yet, but we do intend doing so...
>
I see..

> But yea, I'll take a properly look at what you're doing here soonTM,
> although at this point it may be the other side of LPC.
>
Thanks.

> btw, where can I get my hands on your hardware?
>
I shall share the link as soon as it's available.

Cheers,
Prabhakar
