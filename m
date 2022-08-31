Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890D35A7D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiHaMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiHaMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:36:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE0A267C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:34:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w2so2692527edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=1pA1H8nkYb5VElz85NWjhyXpasCqMV5nI67TZjXNSBs=;
        b=jMl2QH8f6UYJlVJB6tq5fekl5jcKwDZVIJufD1/gy2sIJ1tR2+vn61JhG9wcSmh46+
         zsYRylN/alXd8zhE6PhL+TirnNwaf8QaeoubcbnKmyQy8+Y/dIX6MnvIala6xCIh0bkw
         x9Y6HvL9Zz2GSN+liPwtWkbrH9D/b84rZYkWpsE7T1DVxX/PjnnNi/60I1WbjwV6Jr1l
         dsPNNBvd68maKAlvPuyxLgj/ZGgn88rcdy2vuLghU2/GuT2MJMKoTzoSDdcBiSp+fVku
         45Puejd004Seh0w2BpS28xXYKJkUpkTOwDaWkx82tqNktG02ywdG8HS4ccY7DRmAE7Hl
         xgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=1pA1H8nkYb5VElz85NWjhyXpasCqMV5nI67TZjXNSBs=;
        b=q2fx4aKBGR0+ML+Sda+B8S0yExbINUymnhED5I5vZLKJLvvDiz84qPKCtMvJYLNtw4
         zdiIwRc0X+exxcupNla1F9C72As4eR1P0E/sVMCqSv8ZUF+5RmNAupgovm1Lpl3N+tWP
         KO5RIvOfFVlFPPCwV9qzfxAxzZ9+0PNqxRZSxdUmRtEl6+TMHBKn+QglbzuZY8sS/ItG
         aEIqTBepMD8WbruzmUQVUyk3gBle2K+jc4c4DHAuKK9X6efFObV/PqpmuC0eooIyqjem
         ORyRWnw0nRBYNQK+9sYknMuvTsr7/kuwf4VuMN7F1Lh09QmIojL15wR/ui78zvYtf+Z9
         RZMg==
X-Gm-Message-State: ACgBeo1ohUhesAqJ70GwT9shE7lLPbVe3fgVh13wMYBIkQ6Ke1dkE3Ib
        6NMMWU12Hm2m9LOTYUqNwvOaeui8TD8qbE+t8b+nFg==
X-Google-Smtp-Source: AA6agR4KkfGmMPIYFXYFom4e3356aaJKaOYY6tyoWaRwEw9whLNitUblBCGffj1850PsXFYXhF6tcSBJBi+QUWC71YE=
X-Received: by 2002:aa7:c84f:0:b0:446:2bfb:5a63 with SMTP id
 g15-20020aa7c84f000000b004462bfb5a63mr24615226edt.172.1661949288382; Wed, 31
 Aug 2022 05:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220113144305.1074389-1-narmstrong@baylibre.com>
 <25976b46-21b4-6e3f-0182-85dd4ca2b654@gmail.com> <a4a36360-3f77-17a0-9239-08cb8c08de74@baylibre.com>
 <13bd6440-9a61-d444-518c-f4e8cba0b825@baylibre.com> <5a1df5ce-a497-760b-8e2c-130a0e659c0b@gmail.com>
 <3725619d-72c5-5c9d-513b-80bbc727dd07@baylibre.com> <CACRpkdbucRqf80UB+AikYQGsHPiDJffP9dqkqx+RX8Nkdg3eaw@mail.gmail.com>
 <d115ad6e-1c23-e7d9-dc9f-a12903782850@baylibre.com>
In-Reply-To: <d115ad6e-1c23-e7d9-dc9f-a12903782850@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 14:34:36 +0200
Message-ID: <CACRpkdZu-WuOp-K9tUptHh_k=p+dOXG1WoQG_=bfJBFn0EuiTw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: sii902x: add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Rob Herring <robh+dt@kernel.org>,
        jernej.skrabec@gmail.com, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent.pinchart@ideasonboard.com,
        Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 3:36 PM Neil Armstrong <narmstrong@baylibre.com> wr=
ote:
> On 25/08/2022 14:48, Linus Walleij wrote:
> > On Wed, Aug 17, 2022 at 3:31 PM Neil Armstrong <narmstrong@baylibre.com=
> wrote:
> >> On 15/08/2022 02:15, Dmitry Osipenko wrote:
> >>> 08.08.2022 12:51, Neil Armstrong =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> On 08/08/2022 11:15, Neil Armstrong wrote:
> >
> >>>>>> This patch broke ARM/QEMU vexpress display because of_drm_find_bri=
dge()
> >>>>>> always fail with -EPROBE_DEFER. Reverting this patch returns displ=
ay
> >>>>>> back. Please fix or revert, thanks in advance.
> >>>>>
> >>>>> Can you share a QEMU cmdline to reproduce ?
> >>>>
> >>>> Actually the vexpress DT has multiple input ports instead of a singl=
e
> >>>> input port at @0
> >>>> and an output port at @1 like documented in the bindings:
> >>>>
> >>>> vexpress-v2m.dtsi#L303-L307:
> >>>> ports {
> >>>>       #address-cells =3D <1>;
> >>>>       #size-cells =3D <0>;
> >>>>
> >>>>       /*
> >>>>        * Both the core tile and the motherboard routes their output
> >>>>        * pads to this transmitter. The motherboard system controller
> >>>>        * can select one of them as input using a mux register in
> >>>>        * "arm,vexpress-muxfpga". The Vexpress with the CA9 core tile=
 is
> >>>>        * the only platform with this specific set-up.
> >>>>        */
> >>>>       port@0 {
> >>>>           reg =3D <0>;
> >>>>           dvi_bridge_in_ct: endpoint {
> >>>>               remote-endpoint =3D <&clcd_pads_ct>;
> >>>>           };
> >>>>       };
> >>>>       port@1 {
> >>>>           reg =3D <1>;
> >>>>           dvi_bridge_in_mb: endpoint {
> >>>>               remote-endpoint =3D <&clcd_pads_mb>;
> >>>>           };
> >>>>       };
> >>>> };
> >>>>
> >>>> bindings:
> >>>>     ports:
> >>>>       $ref: /schemas/graph.yaml#/properties/ports
> >>>>
> >>>>       properties:
> >>>>         port@0:
> >>>>           $ref: /schemas/graph.yaml#/properties/port
> >>>>           description: Parallel RGB input port
> >>>>
> >>>>         port@1:
> >>>>           $ref: /schemas/graph.yaml#/properties/port
> >>>>           description: HDMI output port
> >>>>
> >>>>         port@3:
> >>>>           $ref: /schemas/graph.yaml#/properties/port
> >>>>           description: Sound input port
> >>>>
> >>>> The patch is conform to the bindings, the DT was working but is actu=
ally
> >>>> not valid.
> >>>
> >>> I haven't looked closely at how to fix this properly, but if we can f=
ix
> >>> it using of_machine_is_compatible("arm,vexpress") workaround in the
> >>> driver, then it will be good enough at least as a temporal fix, IMO.
> >>
> >> If other maintainers are ok with that, it can be temporary fix until t=
he DT gets fixed.
> >
> > That's fine with me, will you send a patch?
>
> Who, me ?

Whoever you were referring to with the "temporary fix" :D

> > I don't know how you expect the DT to get "fixed" though.
> >
> > The hardware looks like this, it's maybe not the most elegant
> > electronics design but it exists, so... I wrote this DT with two
> > inputs, see commit f1fe12c8bf332, the code handling this
> > awkward mux is part of the DRM driver, see
> > drivers/gpu/drm/pl111/pl111_versatile.c function
> > pl111_vexpress_clcd_init() for an idea of how it works.
>
> The proper fix would be the other way around, adding a mux bridge before =
the sii902x
> returning the next bridge or nothing to the right controller.

Hm you mean the vexpress PLD should be a bridge and not just
some magic registers poked by the DRM driver?

OK fair point. But it will need proper representing in the DT then,
I guess that is what you mean by "DT gets fixed". It's not just
the DT that needs fixing then but also the driver(s).

Yours,
Linus Walleij
