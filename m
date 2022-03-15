Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC714D9D02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiCOOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiCOOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:11:23 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F056454193;
        Tue, 15 Mar 2022 07:10:10 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j5so15015281qvs.13;
        Tue, 15 Mar 2022 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HYr3pi4BMwg8XurxUPEZOXVcmILs5yF8kfiWA1uwWus=;
        b=NBpL3yZTX3rX0rCVBAuLqTfzWQY3EjPLV9UlQY32nw3JjfqwKXu2qlti4/amjtA6F8
         K+gAg/4j+JQmhirKtqCHd+EguMw3VQTAmcjRgPz7oHTJsGWRpOLCWcog3IAXYLK5tjwz
         PMXsH8ZIqwTlcn9prXj0KWS2PkPeih5i85ohY31gQpaDN84SKpUVYhj9tPtL3jgUCMI4
         DLk4Kxez315tGBQGvjXghs3PAuQWBvNtSEGhlroIgeJy/RYuzosBN3tJju40kA5yHsga
         zaPgOku5S+N8Dcjtuc6kvSnki5qIN0RarapspOmRBDUHtRlNB3bQtvU2tvhy7D2na96A
         HAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HYr3pi4BMwg8XurxUPEZOXVcmILs5yF8kfiWA1uwWus=;
        b=IooiOJMmGc46pl4KMKtRLgxnbY2a4YDspmze8ur3jnm8y+fHKQ1sbjJc7iMLuhi/w8
         E+AM4rqMoKgrJE/v6Gims1MzkH1kBNeKSMZlM1ouzvArRhzw78HUuLOD4/oJiVEM5fto
         IXTnpH4XM+TNwtOPsskd43nsTbasqTuDbkgST/ia70FfvS+IzfXtHKhRuaBwwT/Dxywz
         P0zpPftQcJS19FQVUKFpD9cZ428p+iSnuIxQj5ypNWxDRxJIoBlss+AAnyZ3pW8ciYEB
         NROdLDQx+glE8zpF7Xh/1pqgLLYPOMx3vkBOgvOBaWB6kjuhPhRzb3pCPWHMIcimej7+
         2tpg==
X-Gm-Message-State: AOAM532r9dzyTHDfNis+UHtTHJp+ZUjcAvH3ZUG5HsoOs2KZ2CIddNcx
        eisWi3jTeslUBjABlmMFQ7pIHLCezdh/OKU4M5pDtukZ
X-Google-Smtp-Source: ABdhPJwX9RjMlXP9UtTr655sw8v9+9Wy4M6MdUPRxYFoY+iCcim+TEUlnE4V1K7Av56MRgYc0uli2eoP+wCzmajoxl8=
X-Received: by 2002:a0c:e781:0:b0:42c:4e4f:a6db with SMTP id
 x1-20020a0ce781000000b0042c4e4fa6dbmr21035527qvn.107.1647353410051; Tue, 15
 Mar 2022 07:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220315132836.1062-1-arinc.unal@arinc9.com>
In-Reply-To: <20220315132836.1062-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 15 Mar 2022 15:09:58 +0100
Message-ID: <CAMhs-H-PSNHMB-AWZ7B_sFH_Fu9N4RtS9=ieuLH2-jq1A3hSmg@mail.gmail.com>
Subject: Re: [PATCH] mips: dts: ralink: add MT7621 SoC
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        NeilBrown <neil@brown.name>, DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        erkin.bozoglu@xeront.com, linux-staging@lists.linux.dev,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arinc,

On Tue, Mar 15, 2022 at 2:29 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> The MT7621 system-on-a-chip includes a 880 MHz MIPS1004Kc dual-core CPU,
> a 5-port 10/100/1000 switch/PHY and one RGMII.
>
> Add the devicetrees for GB-PC1 and GB-PC2 devices which use MT7621 SoC.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
> I'm not sure which repository/branch this patch is supposed to be applied
> to. This patch does changes on top of commit dcd520af4eac ("staging:
> mt7621-dts: fix cpuintc and fixedregulator dtc warnings, fix xhci") which
> is currently applied on gregkh/staging.git staging-next branch.
>
> Ar=C4=B1n=C3=A7
>
> ---
>  MAINTAINERS                                           |  7 +++++++
>  arch/mips/boot/dts/ralink/Makefile                    |  4 ++++
>  .../mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts     |  0
>  .../mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts     |  0
>  .../mips/boot/dts/ralink}/mt7621.dtsi                 |  0
>  arch/mips/ralink/Kconfig                              |  5 +++++
>  drivers/staging/Kconfig                               |  2 --
>  drivers/staging/Makefile                              |  1 -
>  drivers/staging/mt7621-dts/Kconfig                    | 11 -----------
>  drivers/staging/mt7621-dts/Makefile                   |  5 -----
>  drivers/staging/mt7621-dts/TODO                       |  5 -----
>  11 files changed, 16 insertions(+), 24 deletions(-)
>  rename drivers/staging/mt7621-dts/gbpc1.dts =3D> arch/mips/boot/dts/rali=
nk/mt7621-gnubee-gb-pc1.dts (100%)
>  rename drivers/staging/mt7621-dts/gbpc2.dts =3D> arch/mips/boot/dts/rali=
nk/mt7621-gnubee-gb-pc2.dts (100%)
>  rename {drivers/staging/mt7621-dts =3D> arch/mips/boot/dts/ralink}/mt762=
1.dtsi (100%)
>  delete mode 100644 drivers/staging/mt7621-dts/Kconfig
>  delete mode 100644 drivers/staging/mt7621-dts/Makefile
>  delete mode 100644 drivers/staging/mt7621-dts/TODO
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 62d6758bf8c4..92eda5adca44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16181,6 +16181,13 @@ L:     linux-mips@vger.kernel.org
>  S:     Maintained
>  F:     arch/mips/ralink
>
> +RALINK MT7621 MIPS ARCHITECTURE
> +M:     Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> +M:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +L:     linux-mips@vger.kernel.org
> +S:     Maintained
> +F:     arch/mips/boot/dts/ralink/mt7621*
> +

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
