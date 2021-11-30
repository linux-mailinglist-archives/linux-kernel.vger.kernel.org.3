Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B3463DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245473AbhK3SXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbhK3SXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:23:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6F3C061574;
        Tue, 30 Nov 2021 10:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79993B81BBE;
        Tue, 30 Nov 2021 18:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EB6C53FC7;
        Tue, 30 Nov 2021 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638296395;
        bh=Rg3X5WgEx/fu1vO7MTLJTKOCZa6PxvqcsrwTHphDJDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i9FRLvgj2xYrkiwZdLPpY85Fjd6ZvT5+FmwmpPxuUtFK4QNsRJhQU8B+M80/mMbEJ
         eVLQQqRbZgJBtxNq5289CGCrLodfzfGEXyrOUGSgyiLPJJuoVUsEkqNkH3JwAFgRvm
         GGV6Z7P5+HN77l28Bpsk1fIQQNyumFBWcvDubcX8gxv7Fyq6mZYv7qsguxqC2kFozs
         htzdXGmYz1azXmkFiMYJ+M00zXnJyTOT47NERz3vDatUbikeS0R8tiilXVV06eXOGp
         93/ftkaxSSgw7FlwZjxF+gj/UTRQtTNl6ANpL36vjQ1G1oiKviDRmYoNj6V30VMIl6
         TrMILntbTqsVw==
Received: by mail-ed1-f42.google.com with SMTP id y12so90512342eda.12;
        Tue, 30 Nov 2021 10:19:55 -0800 (PST)
X-Gm-Message-State: AOAM533UqO3GNaR2ADrYMcpgDBqTshAvtqah8VN+fic8gmim3Gwoho+h
        UV7HprmqxvD9m8o9ZXixHDVPPu6whCPluXK1jA==
X-Google-Smtp-Source: ABdhPJzlzmKd9f1PSVWhZws80WIcbDQrGSGIeTyLxWwF+f3fDK1WoMt3xMdzMHMCPFI2ghaCJdwDEwf+RBBhN7lbrhs=
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr867105ejc.84.1638296393423;
 Tue, 30 Nov 2021 10:19:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637789354.git.hns@goldelico.com> <d678e785d95487202ac0660eb66796e9fb5beb50.1637789354.git.hns@goldelico.com>
 <1637875562.255498.2858308.nullmailer@robh.at.kernel.org> <A72D034E-EDBC-44F5-82DF-9EEBC5EC7E0B@goldelico.com>
In-Reply-To: <A72D034E-EDBC-44F5-82DF-9EEBC5EC7E0B@goldelico.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Nov 2021 12:19:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_E_USDuK3kEDKm9TsNsRdpcGNEjz==sKFS-Tv5KYCkA@mail.gmail.com>
Message-ID: <CAL_JsqJ_E_USDuK3kEDKm9TsNsRdpcGNEjz==sKFS-Tv5KYCkA@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] dt-bindings: display: Add ingenic,jz4780-dw-hdmi
 DT Schema
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Kees Cook <keescook@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Boddie <paul@boddie.org.uk>,
        David Airlie <airlied@linux.ie>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:03 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Rob,
>
> > Am 25.11.2021 um 22:26 schrieb Rob Herring <robh@kernel.org>:
> >
> > On Wed, 24 Nov 2021 22:29:09 +0100, H. Nikolaus Schaller wrote:
> >> From: Sam Ravnborg <sam@ravnborg.org>
> >>
> >> Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.
> >> Based on .txt binding from Zubair Lutfullah Kakakhel
> >>
> >> We also add generic ddc-i2c-bus to synopsys,dw-hdmi.yaml
> >>
> >> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: devicetree@vger.kernel.org
> >> ---
> >> .../display/bridge/ingenic,jz4780-hdmi.yaml   | 76 +++++++++++++++++++
> >> .../display/bridge/synopsys,dw-hdmi.yaml      |  3 +
> >> 2 files changed, 79 insertions(+)
> >> create mode 100644 Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/bridge/bridge/synopsys,dw-hdmi.yaml'
>
> I wasn't able to fix that.
>
> If I change
>
>  allOf:
> -  - $ref: bridge/synopsys,dw-hdmi.yaml#
> +  - $ref: synopsys,dw-hdmi.yaml#

That is correct.

>
> then make dt_binding_check still reports:
>
> Unknown file referenced: [Errno 2] No such file or directory: '/Users/hns/Library/Python/3.7/lib/python/site-packages/dtschema/schemas/bridge/synopsys,dw-hdmi.yaml'

The $id is wrong:

$id: http://devicetree.org/schemas/bridge/ingenic,jz4780-hdmi.yaml#

The path should be:
http://devicetree.org/schemas/display/bridge/ingenic,jz4780-hdmi.yaml#

Rob
