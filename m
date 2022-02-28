Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513674C6F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiB1Og3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiB1OgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:36:25 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B55C355;
        Mon, 28 Feb 2022 06:35:47 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id w4so13190374vsq.1;
        Mon, 28 Feb 2022 06:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4W2KAZr0aee0ddqrQkvXwCKjH8/N/IF9E6sKuTx6QWo=;
        b=WZ0Srq2yjm6TWI53WpOX2kL98AV3P+95MEqgZatTTDa1qpnvbJ+Iks5OEF9kgiJYuy
         quomm+1gkOsTgu18UOg81fdD7Yp6gcFQlBgdnK41vGmhVwr6ruaaT+DnpUCI/FZuTznZ
         jIGyd/M+x2f9hb3WM2CWp88exurWAqNw4q2MWRyOPj0W3rgTTMiP9jB7fqEohtt0xV2E
         lMpV6D9rE+h7nh5Ppg3VXJyaAQNRGW3mTJlGj63qdEqipvcGPF/bI8L3eY4utiLSs0lQ
         p1uK4CdlDPR+x+lv/POyMpb0DqE4UnVlCMyRbVHoVvsjnwsipFzuGOlaE1ktoX22Uf7/
         Nsvw==
X-Gm-Message-State: AOAM533sMFCB7UpMPLsII6kFT9Cbpi5YuHzVV4LiZVGuA+91rV3ChJjO
        U/X7prGuClyHes6+vp9aB+EiuNmnQCtx1A==
X-Google-Smtp-Source: ABdhPJz44Q0aWzgG+Gli1HDq4Z+MRgEVa88GKww0p0I/iJpGa2R8u8VgP79WWQixv0qLtfWPuyJ9IQ==
X-Received: by 2002:a67:ca9d:0:b0:30f:88c9:df83 with SMTP id a29-20020a67ca9d000000b0030f88c9df83mr7368744vsl.23.1646058946110;
        Mon, 28 Feb 2022 06:35:46 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id g7-20020a67ee47000000b0031ac5122f3dsm1326757vsp.10.2022.02.28.06.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:35:45 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id x62so5255232vkg.6;
        Mon, 28 Feb 2022 06:35:45 -0800 (PST)
X-Received: by 2002:a05:6122:130d:b0:333:33a4:52a9 with SMTP id
 e13-20020a056122130d00b0033333a452a9mr2122971vkp.33.1646058945038; Mon, 28
 Feb 2022 06:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20220227230817.31094-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <TYBPR01MB5341A5DC3BBB4AA59668AF87D8019@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341A5DC3BBB4AA59668AF87D8019@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Feb 2022 15:35:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX5yW3_3ydFXZBsOd+s-23-3dCfcgCxi8g_VEg0XPYnDA@mail.gmail.com>
Message-ID: <CAMuHMdX5yW3_3ydFXZBsOd+s-23-3dCfcgCxi8g_VEg0XPYnDA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L phy bindings
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
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

On Mon, Feb 28, 2022 at 3:18 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Lad Prabhakar, Sent: Monday, February 28, 2022 8:08 AM
> >
> > Document USB phy bindings for RZ/V2L SoC. RZ/V2L USB phy is identical to
> > one found on the RZ/G2L SoC. No driver changes are required as generic
> > compatible string "renesas,rzg2l-usb2-phy" will be used as a fallback.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > index 3a6e1165419c..4c475be413ef 100644
> > --- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > @@ -33,6 +33,7 @@ properties:
> >        - items:
> >            - enum:
> >                - renesas,usb2-phy-r9a07g044 # RZ/G2{L,LC}
> > +              - renesas,usb2-phy-r9a07g054 # RZ/V2L
> >            - const: renesas,rzg2l-usb2-phy  # RZ/G2L family
>
> The "# RZ/G2L family" is not suitable now. I think removing
> the comment is better like "renesas,rcar-gen3-usb2-phy".

Indeed.

> I don't have the RZ/V2L- documentation. So, I cannot check
> whether the RZ/V2L is the same specification with RZ/G2{L,LC}.
> But I trust you. So, after the comment was removed,

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
