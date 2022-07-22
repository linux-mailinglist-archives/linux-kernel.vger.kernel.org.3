Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D220957DFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiGVKNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGVKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:13:08 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401674784;
        Fri, 22 Jul 2022 03:13:08 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31e7055a61dso42347997b3.11;
        Fri, 22 Jul 2022 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UF9LLNXxHjO50dQ1kLL/0ALZSieprElxvM0avSId9VE=;
        b=bbfST+yyd4mUoCCjb1HZRc79+4hnU1velaSMVQZXVPKuVvkUoyjf/xnssHvIdHBrPQ
         /vGP7uAMpE6nzhsqZK9YgnQvgRa/kbw44WsWhyIeclTxCEIpZMu8hthpaFs3Nwlng40B
         qn75snDacBp/Jgt2be5wl3enTdzN0jEF9/2CNygYOJIoEOGdqrlpKRsKvYGKaOHKBvr0
         g6JSNZWCfcPglPR37O/HcNQ3hsU5Ti5TId7LcpxjFu5u5w0LhUnyzppIaBlvaQYMY1dG
         omJmwPlAHYWFtuJguMFv1A6NMZmI1wCTMlfjszCybIaubBb4c0w8nEiCLDj2jHJGd2SX
         5dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UF9LLNXxHjO50dQ1kLL/0ALZSieprElxvM0avSId9VE=;
        b=JWbmdP5FLS8kSj1HXywdca2yTcoohdRK6JIjh6Vdb2f53BEk7Z6VdVJLDBDTONwvJ2
         njZ25wlJsI5jcbry/wo67nXnnDjAwrdSutBeMBiFbAszyjHmKB2ZNvHt9dnyCYDUgkCv
         tt7DHT9YAUB+93TwMl4tLTgfNjrZpoqYFkh+pm6cogwVEs6TbxOqD9eWH1babfogoSuM
         RBrbcYlWcMbexTrEzJ0ddYCF8IyKIeOcrDYLZGiFucLUxVJEjCae3os0+WEk4oImFYyQ
         5E+Jha+MWP3GoIuVAjC2ftJSpAue3gTE+cjkRlqNp/r2UIJzwFsDaJrl4XHlV+8QFshe
         v0fQ==
X-Gm-Message-State: AJIora9rbAk6wHjVhfM+r+wt+kiTp1uYvc2joc0mZNURgaO0ZMQHqgIp
        TjvAglh2eW/0DviC5orlyiBF0T/wvwXD00AtYJx2axsYX2g=
X-Google-Smtp-Source: AGRyM1sN+U64clWGsFoYQzVrnNEbSPXBFNxfr7YdxOyf28vEspCeUsve3sVFFlZ4LDVWDxgDN6VwYjWiqS5DQsMfBsU=
X-Received: by 2002:a81:5d55:0:b0:31c:dce7:96c9 with SMTP id
 r82-20020a815d55000000b0031cdce796c9mr2355897ywb.519.1658484787468; Fri, 22
 Jul 2022 03:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220721165701.17888-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922D6EC478AE231A06E94B586909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUrmseZEBpsh22U52vivA=wXYo2C8Ke6CvgWSKjwgYByQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUrmseZEBpsh22U52vivA=wXYo2C8Ke6CvgWSKjwgYByQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 22 Jul 2022 11:12:40 +0100
Message-ID: <CA+V-a8s8UGhC7hNzfhbDL817Bup6PXM+_UhEJfsEZH0GZB2BYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
 for IRQ0-7
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jul 22, 2022 at 10:01 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> CC maz
>
> On Fri, Jul 22, 2022 at 6:34 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Subject: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
> > > for IRQ0-7
> > >
> > > Add macros for IRQ0-7 which map to SPI1-8 so that it can be used in
> > > dts/i.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v1->v2
> > > * New patch
> > > ---
> > >  include/dt-bindings/pinctrl/rzg2l-pinctrl.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h b/include/dt-
> > > bindings/pinctrl/rzg2l-pinctrl.h
> > > index c78ed5e5efb7..6aae2ac206d6 100644
> > > --- a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
> > > +++ b/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
> > > @@ -20,4 +20,14 @@
> > >  /* Convert a port and pin label to its global pin index */
> > >  #define RZG2L_GPIO(port, pin)        ((port) * RZG2L_PINS_PER_PORT +
> > > (pin))
> > >
> > > +/* IRQ0-7 map to SPI1-8 */
> > > +#define RZG2L_IRQ0   1
> > > +#define RZG2L_IRQ1   2
> > > +#define RZG2L_IRQ2   3
> > > +#define RZG2L_IRQ3   4
> > > +#define RZG2L_IRQ4   5
> > > +#define RZG2L_IRQ5   6
> > > +#define RZG2L_IRQ6   7
> > > +#define RZG2L_IRQ7   8
>
> No definition for NMI?
>
Ok, I will add a macro for NMI.

Cheers,
Prabhakar
