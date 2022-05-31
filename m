Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B553934C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345308AbiEaOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345310AbiEaOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:47:29 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9471FCC0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:47:25 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-30c1b401711so78674497b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0/w36mR8lkluvb8r4zMg9iFSFRhtHLpPbTXMI17TU+0=;
        b=LSLyPRCEhXwgNFtzrXoohD9b0LordUSKogzPD70Sspkp+qbF4XrKc4emGZDOqFhtZq
         V9GMbd4oqskJ5yX/Onrv4xCdE2Hb19sjiQLd5lXz3isCADO36PQwBR+CqvHyIbovAct9
         2Goq8LE+bgXwOcTIUbdiMiZ2/O7Hi0EY7NhlWgT4KL5DdcHjD+VfD4cw9dbk7afIZAlR
         ajkQOPs+PJeB46bfEqAgEH6FVCR9dcpq36yDQx5eqH/udxd20DndGF/cTN1/b1XwmS1t
         23sMUF4kMLrWJYOsmDZGqCXs7TLhu2OnlFf3HEPhJMHSsLvyuN9AswgDHGEJUjJUV0Ay
         v9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0/w36mR8lkluvb8r4zMg9iFSFRhtHLpPbTXMI17TU+0=;
        b=ZT9CHWf3vxP1JvLohmScWPsFbM2WHNcON0hh1wh6cRWXwLAHRaG29ZACnYspTcJEp8
         t/aqMF2yoVwESKpJYxJn7erEGNwNOvcJKoSJ9Vw4iRjFOkgdVGEKGuJajsOnRSIJP32/
         W6HZ3MRyCzf1R5VVnQ+ncnpkz97XvqcmN/SLYYdymuDs/vyYxQY1ySziEC+7WNFmult1
         YdWCOwpais4yLJhw65qhMPiwbwR4+0KHzuOQZYVlqEBEQ1b967hi2N+f9SD8mOeSXWuI
         +FBulm29ewnFAoWoERLNiVFWEvia9WbIKxNvdTULXHlkNoo8SlR5fKtLJ3ckm2sIl7Id
         25tQ==
X-Gm-Message-State: AOAM5330DlftmQmOCrl5Wk6bjsHw6uSz+7j79+wHHEpUps253yNB0npQ
        UPo7ANULi5080mAP2qI/5+gdoF/vpIZN37nBS3UMOA==
X-Google-Smtp-Source: ABdhPJxalwaZgY7TBxR+rRUyZGByUKq8vkvMzwrupGRbsbPzVyQkfLLhgbl3SHj69aTFZUjOQDLsewD3X2l5ox/iwNk=
X-Received: by 2002:a81:92cd:0:b0:30c:33ad:377e with SMTP id
 j196-20020a8192cd000000b0030c33ad377emr14554771ywg.286.1654008444987; Tue, 31
 May 2022 07:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220530130839.120710-1-pan@semihalf.com> <20220530130839.120710-3-pan@semihalf.com>
 <f789afb2-33c5-2b28-5ade-0c76ebb7206f@linaro.org> <CAHNYxRw00QraVW0085xO-qzgGJdZ2joukuSYzBQo+yjLnkD=Tw@mail.gmail.com>
 <e4ef2056-c990-b308-a9d5-98f11ac0ba51@linaro.org>
In-Reply-To: <e4ef2056-c990-b308-a9d5-98f11ac0ba51@linaro.org>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Tue, 31 May 2022 16:47:13 +0200
Message-ID: <CAF9_jYR=sjP9wYW9wyfbrVYO4PDYTfMhjvyyh53U3a3+2Zyw=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: socfpga: Add Google Chameleon v3 devicetree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandru M Stan <amstan@chromium.org>, SoC Team <soc@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 11:11 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/05/2022 03:20, Alexandru M Stan wrote:
> > Hello Krzysztof
> >
> > On Mon, May 30, 2022 at 11:56 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 30/05/2022 15:08, Pawe=C5=82 Anikiel wrote:
> >>> Add devicetree for the Google Chameleon v3 board.
> >>>
> >>> Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> >>> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> >>
> >> Your SoB chain looks odd. Who did what here?
> >
> > Sorry about this.
> >
> > It was mainly Pawel but I did some small changes at some point before
> > it landed in our tree (particularly the GPIOs).
>
> Then usually Pawe=C5=82 should be the owner of the patch, not you.
> Alternatively it could be also co-developed.
>
> >
> >>
> >>> ---
> >>>  arch/arm/boot/dts/Makefile                    |  1 +
> >>>  .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++=
++
> >>>  2 files changed, 91 insertions(+)
> >>>  create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
> >>>
> >>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >>> index 023c8b4ba45c..9417106d3289 100644
> >>> --- a/arch/arm/boot/dts/Makefile
> >>> +++ b/arch/arm/boot/dts/Makefile
> >>> @@ -1146,6 +1146,7 @@ dtb-$(CONFIG_ARCH_S5PV210) +=3D \
> >>>       s5pv210-torbreck.dtb
> >>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) +=3D \
> >>>       socfpga_arria5_socdk.dtb \
> >>> +     socfpga_arria10_chameleonv3.dtb \
> >>>       socfpga_arria10_socdk_nand.dtb \
> >>>       socfpga_arria10_socdk_qspi.dtb \
> >>>       socfpga_arria10_socdk_sdmmc.dtb \
> >>> diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch=
/arm/boot/dts/socfpga_arria10_chameleonv3.dts
> >>> new file mode 100644
> >>> index 000000000000..988cc445438e
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
> >>> @@ -0,0 +1,90 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright 2022 Google LLC
> >>> + */
> >>> +/dts-v1/;
> >>> +#include "socfpga_arria10_mercury_aa1.dtsi"
> >>> +
> >>> +/ {
> >>> +     model =3D "Google Chameleon V3";
> >>> +     compatible =3D "google,chameleon-v3",
> >>
> >> You miss here enclustra compatible.
> >
> > Does this make sense? I don't expect this device tree to boot/work on
> > an enclustra motherboard. It's only really compatible with a
> > "chameleon-v3".
>
> You also do not expect it to boot on altr,socfpga, do you?
>
> If I understood correctly, this board has physically Mercury AA1 SoM, so
> that compatible should be there.

Yes, you understood correctly.
I looked at a similar device - the Cyclone V MCV (SoM) and the MCVEVK
(base board):
arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
And there is no denx,mcv compatible anywhere, only denx,mcvevk.
Also, devicetree bindings documentation lists denx,mcvevk under
"Cyclone 5 boards", and, unless you consider the MCV to be a board,
there isn't a good place to put denx,mcv (same story with mercury+
aa1/chameleon).

>
> It's the same for every other SoM. Neither Google nor Enclustra are
> special...
>
> >
> >>
> >>> +                  "altr,socfpga-arria10", "altr,socfpga";
> >>> +
> >>> +     aliases {
> >>> +             serial0 =3D &uart0;
> >>> +             i2c0 =3D &i2c0;
> >>> +             i2c1 =3D &i2c1;
> >>> +     };
> >>> +};
> >>> +
> >>> +&gmac0 {
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&gpio0 {
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&gpio1 {
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&gpio2 {
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&i2c0 {
> >>> +     status =3D "okay";
> >>> +
> >>> +     ssm2603: ssm2603@1a {
> >>
> >> Generic node names.
> >
> > Dumb question: what does this mean?
> >
> > Are you saying the name is too generic? As someone reading the
> > schematics this would be immediately clear what chip it's talking
> > about.
>
> Let me clarify - please use generic node names, as asked by Devicetree
> specification (2.2.1. Node Name Requirements). There is also list of
> some examples in the spec, but you can use some other generic node name.
>
> Several bindings also require it.

Do you mean something like this?
ssm2603: audio-codec@1a {
u80: gpio@21 {

Regards,
Pawe=C5=82
