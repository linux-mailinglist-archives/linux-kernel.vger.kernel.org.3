Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238184C8BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiCAMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCAMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:38:24 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70C30F60;
        Tue,  1 Mar 2022 04:37:37 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g26so1314876ybj.10;
        Tue, 01 Mar 2022 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDhnSrogQYYZ/PDz/FJ1mmPBu5LlPYyHGz4zly3ela0=;
        b=nix2l333nSPrpKfbmKrEr8yuHirrIsI6H6Q4h1MjwAIfVBJN0KOmGeEUIlLlZmr9h3
         zuSDaWKW249d9KHqXfxd9d4amX99aiDg66S6ahNJ3RgHgf33clravY6Ra94MxSus5yi5
         X2qeNaVppLL7BCcHmJqXAwQagR+VjFPlCcJjZJ6GU6AvDC0rRu63L8lQlIBAudcmOxwn
         0E9MANioUadr4BD7f+PAvQYO4zULO2vGEhfzFsUGYlLq/prNWHZaJxENrbdf3RXSy8BB
         pC0B+8tcMBX8rAteUBi5tfRkJpdFu3FVHLreGXL5idYUKFtWyfJHXu5WUD6wgFxhO8Z3
         tFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDhnSrogQYYZ/PDz/FJ1mmPBu5LlPYyHGz4zly3ela0=;
        b=64+c4cGL4yF8AVz3twvA21SohpoV9WHVSXywTvOWX05xlZhooM2qQRHK/c9J+8d19h
         0lHMFqNUPmnOjGrKaJavTiRpV/JxqLqIvObt8K+Yf1SQS4/HHlYlnObE3mfonf7nHRUU
         5n21MbdgEMUf/nP0xvR7yMrZtTFpIhgwmJIzJFMaUT8mPVYZp+PZiL/laOFrM+/AE7+2
         unmexLw4S2uu8SEYxRy6LyDwyrYU4dsGGkzFR19/8CJcK6vSQ2r14qmtKZu78g44UzpR
         9s5Z4eUUwnS0jdqnd+Y98amFluHRXWfPEYzEJ4WMZLZ9w404u+4l7D7YLwqyyRwI0EYN
         M9tw==
X-Gm-Message-State: AOAM532ANbpggjHUft5ajkCJ415v55RIeixMiLDFyLo8h5MATU6jXi6Z
        J1O9skugEoSp3jTWNrptzZkS6DAvg3yiY6vhrZo=
X-Google-Smtp-Source: ABdhPJyPGQ1BAYl5MPLZJ0Ym3NE3dFAFBwfJXZm/Vv7mnJozErV8YETJjcrqQ6OZgFYgN+/FDxDgQ2+UfyhwuiDV52k=
X-Received: by 2002:a05:6902:4e2:b0:611:19fc:a30 with SMTP id
 w2-20020a05690204e200b0061119fc0a30mr22644183ybs.431.1646138256813; Tue, 01
 Mar 2022 04:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20220227230817.31094-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYBPR01MB5341A5DC3BBB4AA59668AF87D8019@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAMuHMdX5yW3_3ydFXZBsOd+s-23-3dCfcgCxi8g_VEg0XPYnDA@mail.gmail.com>
In-Reply-To: <CAMuHMdX5yW3_3ydFXZBsOd+s-23-3dCfcgCxi8g_VEg0XPYnDA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 1 Mar 2022 12:37:11 +0000
Message-ID: <CA+V-a8uuuQiij4iZvRvTKsqYmdTgEFcKZAMTJJMQv0Er=xRG2g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L phy bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
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

Hi Geert and Shimoda-san,

Thank you for the review.

On Mon, Feb 28, 2022 at 2:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, Feb 28, 2022 at 3:18 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > From: Lad Prabhakar, Sent: Monday, February 28, 2022 8:08 AM
> > >
> > > Document USB phy bindings for RZ/V2L SoC. RZ/V2L USB phy is identical to
> > > one found on the RZ/G2L SoC. No driver changes are required as generic
> > > compatible string "renesas,rzg2l-usb2-phy" will be used as a fallback.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > > b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > > index 3a6e1165419c..4c475be413ef 100644
> > > --- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > > @@ -33,6 +33,7 @@ properties:
> > >        - items:
> > >            - enum:
> > >                - renesas,usb2-phy-r9a07g044 # RZ/G2{L,LC}
> > > +              - renesas,usb2-phy-r9a07g054 # RZ/V2L
> > >            - const: renesas,rzg2l-usb2-phy  # RZ/G2L family
> >
> > The "# RZ/G2L family" is not suitable now. I think removing
> > the comment is better like "renesas,rcar-gen3-usb2-phy".
>
> Indeed.
>
Agreed, I will drop it and resend a v2.

Cheers,
Prabhakar

> > I don't have the RZ/V2L- documentation. So, I cannot check
> > whether the RZ/V2L is the same specification with RZ/G2{L,LC}.
> > But I trust you. So, after the comment was removed,
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
