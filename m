Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC9B590DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiHLJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiHLJIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:08:21 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D766EA723D;
        Fri, 12 Aug 2022 02:08:20 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id h4so320322qtj.11;
        Fri, 12 Aug 2022 02:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ESERLkLG3l6qeYhdj3kGjg5yZs+39sPAfuNqaDJii3o=;
        b=y7Gsc1ZAtT6g09ReXTrPkPL9YjjsSLBAaPQcHWR4L+zaRnvU3S3Bs/xvpYLBsPc7la
         AkW92CIL2URuIK/pZ8XBQeHnxNXlU0Hiidk6UhD2MCvihWRsHR34KfD8KODSjfACRn9D
         iVzEOJkI06F4SITC8CXaGoCXfx7GOe3g+r8glozX7JFFjxuNRNhpv34SlBJuoQ5q/+WJ
         jl02QEDyrygBUUaezxdU951RMT54EUVDbK9Zpt9oNpqXb7jkBqoWil+8m16LPygcQf04
         h5gZF2GwRf7h3fLPiylVShzt9KJeV3P9/pLk0VcQdazTHVbmlmb4X0q8uolS0AMP77rI
         uJNQ==
X-Gm-Message-State: ACgBeo24Ouldul2q6hLij/5YAgSrCnypdtIJ3BgmfsVP3pJaoqCBZiSd
        6AkdAeEx98Oo9aO96eLj2J5m3HM8Zo6FTw==
X-Google-Smtp-Source: AA6agR6LoVrmrzg0XIwzkFerXt0mANGUHbterUUfp/R5IqCJx77WEJjAv2JNJ1zCi/S4jH6Q9cLD5w==
X-Received: by 2002:a05:622a:8e:b0:31f:371f:e6a1 with SMTP id o14-20020a05622a008e00b0031f371fe6a1mr2658605qtw.565.1660295299921;
        Fri, 12 Aug 2022 02:08:19 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id o2-20020ac86982000000b0033a5048464fsm1329513qtq.11.2022.08.12.02.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 02:08:19 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 204so574967yba.1;
        Fri, 12 Aug 2022 02:08:19 -0700 (PDT)
X-Received: by 2002:a25:880f:0:b0:67c:2727:7e3c with SMTP id
 c15-20020a25880f000000b0067c27277e3cmr2679433ybl.36.1660295299180; Fri, 12
 Aug 2022 02:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220726175315.1147-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 11:08:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOL75DNP9NWfFpe4FkT56=p1e5qh7tfOy+hn=u9xeg=w@mail.gmail.com>
Message-ID: <CAMuHMdWOL75DNP9NWfFpe4FkT56=p1e5qh7tfOy+hn=u9xeg=w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas: Document RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 7:53 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> RZ/Five SoC is pin compatible with RZ/G2UL (Type 1) SoC. This patch
> updates the comment to include RZ/Five SoC so that we make it clear
> "renesas,r9a07g043-pinctrl" compatible string will be used for RZ/Five
> SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.1.

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -23,7 +23,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2}
> +              - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
>                - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
>
>        - items:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
