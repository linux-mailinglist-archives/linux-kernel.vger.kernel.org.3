Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB23594827
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344580AbiHOXFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345590AbiHOXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:03:35 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002FB140383;
        Mon, 15 Aug 2022 12:58:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32a09b909f6so99762267b3.0;
        Mon, 15 Aug 2022 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SaKpW6zKf3J+BDdw7lydmtNN4p2oq5j0Q5VFDNof+pM=;
        b=mClJbEgUZn7mid1IMN6JVxp3CUtP2f+GgqIus6vTR3wa/69syGLtTNMNumUfGQzXCp
         uRDUujND1uBLSov9tLJdTrhBNK4B/ta9oo+peGB6mwcb8/kM4OmseN8nDM9YLPfiHgSu
         RrtJxBtdwb6OC6Eu1qdUXMMnROTgoZ2W2e+6A3ATXr99NvzmM59FmVMYNT9KmeXOLaRD
         C2C/byWulXxqj0E4VMlC2YXPNO9aDoJf4mHM1cueQC2FLe14+lm/ePG6cQFQPmcSWlOY
         UKsBZAfBlelS45l7Cx7P5f2skan3K6PWshyYKKfIFbFtHx6ntkMKbYnO/pXNhZDRqzoe
         HI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SaKpW6zKf3J+BDdw7lydmtNN4p2oq5j0Q5VFDNof+pM=;
        b=EWkA1Y6h3hKyYblxQFVtr9CXuhHcLEAkGQs807hTsonqJPaNRBUOSdVN6XPS0WWCCE
         p2Z7vI3sZgZk4lfdE40HiPJrXJgqt/UCqVTvg8V5R6LMSGQTShgh0cWXue3Hu7XkRdaE
         vFyn3ycPS+wzwj8FrtOenZKs5htFWiSBjLirbSGyv9ySWz7O9gfRvJc2/13bEW6eOGlr
         deDmFxD7jah2z/YP5jZSSY95ypKIBXxVVPnUg+NC6gDp4zTAxAIsOCV0HECuxB+piGpa
         BLKzTdQatY3HzrF3ttC9E2YCnW/wr5XilJ/cfBTPd71LNmJNZsmlVA+dpO3jMHS5/m2N
         +NWw==
X-Gm-Message-State: ACgBeo2brk+cjwCUSeJJiCJfMdkEDlpUeLH9BmvgqKBMzhlm1wBhKzP2
        qJ/tIT5p8tOsLxS8JFvGa5MhT08PN/QEKguw/ETF3AGFtkY=
X-Google-Smtp-Source: AA6agR7YZhetSRriR3fxyVoEb45vvhBzsBWV2fXqw33tgHSOBo2R5O1+udwaFBShKA5Xahd/ARVynHtaGCyY7Ch4dU8=
X-Received: by 2002:a25:2245:0:b0:67b:7758:808b with SMTP id
 i66-20020a252245000000b0067b7758808bmr13450908ybi.279.1660593505118; Mon, 15
 Aug 2022 12:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <d9d0deef-92e1-05b4-a195-d2ca03801129@microchip.com>
In-Reply-To: <d9d0deef-92e1-05b4-a195-d2ca03801129@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 15 Aug 2022 20:57:57 +0100
Message-ID: <CA+V-a8utT6UE=rc62LPE=UoU0DTJ2dDt7KO9UJ1vAG9r80E2pg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
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

Thank you for the review.

On Mon, Aug 15, 2022 at 8:10 PM <Conor.Dooley@microchip.com> wrote:
>
> On 15/08/2022 16:14, Lad Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
> > (R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
> > of the Renesas drivers depend on this config option.
>
> Hey Lad,
>
> I think I said something similar on v1, but I said it again
> to Samuel today so I may as well repost here too:
> "I think this and patch 12/12 with the defconfig changes should be
patch 8/8.


> deferred until post LPC (which still leaves plenty of time for
> making the 6.1 merge window). We already have like 4 different
> approaches between the existing SOC_FOO symbols & two more when
> D1 stuff and the Renesas stuff is considered.
>
> Plan is to decide at LPC on one approach for what to do with
> Kconfig.socs & to me it seems like a good idea to do what's being
> done here - it's likely that further arm vendors will move and
> keeping the common symbols makes a lot of sense to me..."
>
Sure not a problem. But delaying patch 4 and 8 will make RZ/Five SoC
not buildable. Is that OK?

> Also, for the sake of my OCD could you pick either riscv or
> RISC-V and use it for the whole series? Pedantic I guess, but
> /shrug
>
Sorry did you mean I add riscv/RISC-V in the subject?

Cheers,
Prabhakar


> Thanks,
> Conor.
>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * No Change
> > ---
> >  arch/riscv/Kconfig.socs | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 69774bb362d6..91b7f38b77a8 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif # SOC_CANAAN
> >
> > +config ARCH_RENESAS
> > +       bool
> > +       select GPIOLIB
> > +       select PINCTRL
> > +       select SOC_BUS
> > +
> > +config SOC_RENESAS_RZFIVE
> > +       bool "Renesas RZ/Five SoC"
> > +       select ARCH_R9A07G043
> > +       select ARCH_RENESAS
> > +       select RESET_CONTROLLER
> > +       help
> > +         This enables support for Renesas RZ/Five SoC.
> > +
> >  endmenu # "SoC selection"
> > --
> > 2.25.1
> >
>
