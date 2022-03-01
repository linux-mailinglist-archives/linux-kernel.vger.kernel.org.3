Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400F54C8A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiCALVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiCALVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:21:02 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A192D05;
        Tue,  1 Mar 2022 03:20:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b35so26476785ybi.13;
        Tue, 01 Mar 2022 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0T0gSikPTrVECzotPCXInq3GYJxj5g1aZIYL6syoEIU=;
        b=HklaV1Cs9+rJp25ErTKhRKoE80TEBZLB7YWf7aYAqQaUQZUtYlWphcMuItZi1W44fM
         52mpLVbCYesybBkVWu3/YtWQ5wyCaD+Z59Um5GNzKDDBZaf/TMB3nxCuB30XB0gt4Utb
         a0AtcTTr9xt4wRCXmS0wkhn2UAQ7w9TwCAE1GPbn99e/gEzlg5W6SUNhg7OOs5OQ9wRg
         u3e/3EaTytfbcs9ZvXVy6h7JVDA/2zk3XQeHZKj0OQjV4v/T0EmQmvULCGUNkxBAXt/2
         y1QDvJgOc05YrCv1BojSYhhFv2h8O/jDLY3kNlJoBbA4GAi4e/h+onCOuJ1SqXBXM6Pb
         Z7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0T0gSikPTrVECzotPCXInq3GYJxj5g1aZIYL6syoEIU=;
        b=t9LL5VO2Rn91pzwRC3sp67x87iXTPXrpQAIWAtG51Ndk64cRYcTNmnWm/MTftEyy05
         h488c1knmdC/FvUu/H2dM+YoXWj+oEeb/t2E3hW/gcgQWmE5dQvS2RlU6bR8/Nhrk/0y
         qGBdFtu1XshWpkMIomAWQZVVxx2cB8tsuukXDfa5m1djshZoL9ywaPAmf1bVZCmmuor4
         lUuvkULmFlwQPsW0FXKpiMU9Vctu83TCUMkqsOd6loMzLmu1zMeLHgzepJZusxgFS3SN
         RCQXBgSdj1N5b/JDChpIcLryLX76R4J4jL9LP1bYsCNRQymFlmcYiDdWLQQYLPba16ih
         srdg==
X-Gm-Message-State: AOAM5329zfFNo8H9Ywvj9wo7F8J5jkHls6lV7NYw+CQ9UIvAmg8IS/Qt
        oiHcoZMoYjG8cE7J23SSvWETyXKP4KwL1XJhMcM=
X-Google-Smtp-Source: ABdhPJwOEvMwWhE4ZaDlTxB0TFjEYbrp4JPVed1eNLSGqlWh9vshf9+agBKo/K2Eo4i2Yh4YNJX5FWhFR6ETLa1L5SU=
X-Received: by 2002:a25:6a43:0:b0:624:45c7:f629 with SMTP id
 f64-20020a256a43000000b0062445c7f629mr22413278ybc.218.1646133621662; Tue, 01
 Mar 2022 03:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20220227225309.28098-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX1J=S+LczVXy3cmWEkRV4U_WffAuxTTReeLAJ8rpacjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX1J=S+LczVXy3cmWEkRV4U_WffAuxTTReeLAJ8rpacjQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 1 Mar 2022 11:19:55 +0000
Message-ID: <CA+V-a8t62gJLfsJZA0HiHdp0i2DB-dW=2TB=2wfbpPLkdT_wQw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/V2L SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
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

Hi Geert,

Thank you for the review.

On Mon, Feb 28, 2022 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sun, Feb 27, 2022 at 11:53 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document RZ/V2L WDT bindings. RZ/V2L WDT is identical to one found
> > on the RZ/G2L SoC. No driver changes are required as generic compatible
> > string "renesas,rzg2l-wdt" will be used as a fallback.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > DTSI changes have been posted as part of series [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
> > 20220227203744.18355-9-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > ---
> >  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> > index 91a98ccd4226..26c7a152ff98 100644
> > --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> > @@ -22,6 +22,7 @@ properties:
> >        - items:
> >            - enum:
> >                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
> > +              - renesas,r9a07g054-wdt    # RZ/V2L
> >            - const: renesas,rzg2l-wdt     # RZ/G2L
>
> Please drop the comment on the previous line.
>
OK, I will drop " # RZ/G2L" and resend the patch.

Cheers,
Prabhakar
