Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3775946212E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379918AbhK2UBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbhK2T67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:58:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8BDC07CA30;
        Mon, 29 Nov 2021 08:30:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 905CB615A2;
        Mon, 29 Nov 2021 16:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E6C53FCD;
        Mon, 29 Nov 2021 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638203408;
        bh=0nM9Zmi/0tmh4ZVUo4rPDNni8qv7d4dpBNcM+KHsuro=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CZ0zEE9TX/82bzK6mWwweNQckfEOej/XhUxQ8k0cme0RRBnP0QrDFWmFGE6+tsSTj
         hCu7cflNmo5g95cbOp+ysjmY8Zh8RYIiQysAkja0ps2EvT5+F0dtYcCM6CxKfKf5aO
         VNE+niu+eEgcGdSVmQEV5z6vk2m5EWUxAogMuL+JZL0jGsO7mIPkroJ0rFVGvkyZPt
         +3UhVh2TRG83DQBqMxZPhvwFqW8qJwf8YNB3LXbeUZFTgqqHGaPGAj3MOUhvyHo+Sp
         Zsmudql/15T/ywV0IqW/tLd1o4WDlqqfbUQtBPSGETCMZ4oWePo8Z9Pofqyxl7tEeS
         SYfKJPFf25T+A==
Received: by mail-ed1-f46.google.com with SMTP id z5so9184529edd.3;
        Mon, 29 Nov 2021 08:30:07 -0800 (PST)
X-Gm-Message-State: AOAM533oVq4uKMgd0GZEv/PYeCMsp0F0/MXnvicoWby6WrPpZFwF+fsZ
        6K+MLnqgCDDOkLzZidPXCHvlF7mmzO4MHNfkIg==
X-Google-Smtp-Source: ABdhPJwdi2obd94NfZySI0D4j9hUUyc1bSXXDIqrRsdfdsaKo0dvxFRXe6oTS5gvFLyxMSrK1FPA3wGf7etLHoFZGRM=
X-Received: by 2002:a17:906:fcbb:: with SMTP id qw27mr60632167ejb.320.1638203406208;
 Mon, 29 Nov 2021 08:30:06 -0800 (PST)
MIME-Version: 1.0
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1636444705-17883-1-git-send-email-lh.kuo@sunplus.com> <1636444705-17883-3-git-send-email-lh.kuo@sunplus.com>
 <YaQu3dCQD4FG7ete@robh.at.kernel.org> <f5607fa7ad9c49a7bfcce02eac834838@sphcmbx02.sunplus.com.tw>
In-Reply-To: <f5607fa7ad9c49a7bfcce02eac834838@sphcmbx02.sunplus.com.tw>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Nov 2021 10:29:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK=7ma_LwMMoW7yfVoBfPN0hBJsPbp4ojtk0kt3k=+O1w@mail.gmail.com>
Message-ID: <CAL_JsqK=7ma_LwMMoW7yfVoBfPN0hBJsPbp4ojtk0kt3k=+O1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] devicetree bindings mmc Add bindings doc for
 Sunplus SP7021
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 11:30 PM Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=AA <lh.Kuo=
@sunplus.com> wrote:
>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sunplus,sp7021-card1
> > > +      - sunplus,sp7021-sdio
> >
> > What's the difference between these 2 blocks?
> >
>
> One for SD card One for SDIO

If the programming model is the same, then it should be the same
compatible string. We have various properties to handle differences
like bus width, card detect or not, etc.

> > > +  reg:
> > > +    items:
> > > +      - description: Base address and length of the SD/SDIO register=
s
> >
> > Just 'maxItems: 1' is sufficient.
> >
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  pinctrl-names:
> > > +    description:
> > > +      A pinctrl state named "default" must be defined.
> > > +    const: default
> > > +
> > > +  pinctrl-0:
> > > +    description:
> > > +      A phandle to the default pinctrl state.
> > > +
> > > +  max-frequency: true
> > > +
> > > +allOf:
> > > +  - $ref: "mmc-controller.yaml"
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - resets
> > > +  - pinctrl-names
> > > +  - pinctrl-0
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/sp-sp7021.h>
> > > +    #include <dt-bindings/reset/sp-sp7021.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    mmc1: mmc@9C003e80 {
> >
> > Use lower case hex.
>
> Do you mean as follows? ?
>
> mmc1: mmc@3e80 {

No, 'mmc@9c003e80 {'

You also don't need 'mmc1'.

> > > +       compatible =3D "sunplus,sp7021-card1";
> > > +       reg =3D <0x9c003e80 0x280>;
> > > +       interrupts =3D <21 IRQ_TYPE_LEVEL_HIGH>;
> > > +       clocks =3D <&clkc CARD_CTL1>;
> > > +       resets =3D <&rstc RST_CARD_CTL1>;
> > > +       pinctrl-names =3D "default";
> > > +       pinctrl-0 =3D <&mmc1_mux &mmc1_mux_cd>;
> > > +       max-frequency =3D <52000000>;
> > > +    };
> > > +    sdio: mmc@9C008400 {
> >
>
> Do you mean as follows? ?
>
> mmc1: mmc@8400 {
>
>
> > Use lower case hex.
> >
> > > +       compatible =3D "sunplus,sp7021-sdio";
>
