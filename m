Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5515063F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348656AbiDSFou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiDSFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:44:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEEC21E1D;
        Mon, 18 Apr 2022 22:42:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j6so12727843qkp.9;
        Mon, 18 Apr 2022 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y4WqiyPBrPuq3t0GzG/KyMaIv9tuXpL8sDYJ09oaLlc=;
        b=b3g0keK+mJDMBV75bc1md4gO+XLUzYDcKtwNdefPSiZa1uEPauzb7UUpnC5UOrRAgU
         yj4s4c6cB/PnbUD5k8trcbR99/91u3tmwfL1LsrfvoRQGAmerDe1uZV9JSZXy0xjacpZ
         nMSgEEZOgtzh6udr1hAZrKthALYqZmXW7wPyEnD8IumG+B0XGNNjYRE8xeIlBXX+1nFc
         LRCNVEKccJhj0fW3wGkeyCPUMUFOv/wnrpQA1oI/AHUNVgtCbYH61hHYzRbUQeV2HLPy
         zgtJ1jAXvt1T8rCZ6K1VBGtTr/bx9Eifo/OUTjeFkgNAyfn5AR8H47zEdlTj+2jj1hVq
         TCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y4WqiyPBrPuq3t0GzG/KyMaIv9tuXpL8sDYJ09oaLlc=;
        b=x76NW+sUWIfVoypT6QKcPn+miZwcu81MB2RdbNm5kPnCum4kWhzplMmLwC7rAbpPx7
         qDUwU07RGTwEaWvdHbkKk8SVjLOQROJk/h9wWPpk5xhPp8q11PuYtI7YALw6M5ri62Ef
         BkqkoJYsooWVKH26uQGaqZJ1QnD9kCkcI7WQIrmV3OvyHDByfyXtQS7nr7PBk8M43KE6
         ATviTq+BSQhxMH6gakMfce+W++crhBfxj3GbQX68w5Dio0uTEZoSsGWX5UW0qxVRxuIR
         okqSHKCOGH1NoR2GYXtl7e4z80fuqJhUDrKe2WT44uDb1vGizbR1To5jh4dOLzM8o1at
         6DZQ==
X-Gm-Message-State: AOAM532eltR/1QzegKBq+1h8mRJQdNBHviEprE3gJ49KGFlp09uYCJO0
        /ys2cy7C/cQUaS4JZEzmShhTl0S7q0Bv04dM6PI+ssm0
X-Google-Smtp-Source: ABdhPJzDm6c7z7Z8nfJx8bLY6Q65M8wsTvC2SNRYrmONjssNXsMgNlxplno3NUOkHvtNiBmyKAF1Rv/3nxQYp13A5Uo=
X-Received: by 2002:a05:620a:4308:b0:67b:487e:e02a with SMTP id
 u8-20020a05620a430800b0067b487ee02amr8723387qko.696.1650346925402; Mon, 18
 Apr 2022 22:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 19 Apr 2022 07:41:54 +0200
Message-ID: <CAMhs-H9sdyEEmauW=Wx__+ydj46HTftjjzmJ8D3SwBkvWi_YMg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Refactor Ralink Pinctrl and Add Documentation
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>, erkin.bozoglu@xeront.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
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

Hi Arin=C3=A7,

On Thu, Apr 14, 2022 at 7:40 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> Hey everyone.
>
> This patch series brings complete refactoring to the Ralink pinctrl drive=
r
> and its subdrivers.
>
> The mt7620 pinctrl subdriver supports MT7628 and MT7688 SoCs along with
> MT7620. These two share the same pin layout. The code used for MT7628 and
> MT7688 is renamed from MT7628/mt7628an to MT76X8.
>
> Ralink pinctrl driver is called rt2880 which is the name of the Ralink
> RT2880 SoC. A subdriver for the Ralink RT2880 SoC is called rt288x. Renam=
e
> rt2880 to ralink.
>
> Rename code from pinmux to pinctrl for where the operation is not about t=
he
> muxing of pins.
>
> Rename rt288x pinctrl subdriver for the RT2880 SoC to rt2880.
>
> Variables for functions include "grp" on the Ralink MT7620 and MT7621
> subdrivers. Rename them to "func" instead as they define the functions fo=
r
> the pin groups. This is already the case for the other 3 subdrivers;
> RT2880, RT305x, RT3883.
>
> Fix Kconfig to call the subdrivers, well, subdrivers.
>
> Add new compatible strings for each subdriver and update DT binding
> accordingly.
>
> Add Ralink pinctrl driver to MAINTAINERS and add me and Sergio as the
> maintainers.
>
> Finally, fix the current rt2880 documentation and add binding for all of
> the subdrivers.
>
> I have the patches here should anyone prefer to read them there:
> https://github.com/arinc9/linux/commits/ralink-pinctrl-refactor
>
> Ralink pinctrl driver and the subdrivers were compile tested.
> MT7621 pinctrl subdriver was tested on a private mt7621 board.
> YAML bindings checked with:
> ARCH=3Dmips CROSS_COMPILE=3Dmips-linux-gnu- make dt_binding_check DT_SCHE=
MA_FILES=3DDocumentation/devicetree/bindings/pinctrl/ -j$(nproc)
>
> v2:
> - Add Sergio=E2=80=99s Reviewed-by: tag to where it's given.
> - Properly explain the addition of the new compatible strings.
> - Remove asterisk on MAINTAINERS commit.
> - Properly explain the compatible string change for the rt2880 binding.
> - Mention adding myself as a maintainer to rt2880 binding.
> - Fix typo "indiviual" on YAML bindings. Limit lines to 80 characters.
>
> Ar=C4=B1n=C3=A7 =C3=9CNAL (14):
>   pinctrl: ralink: rename MT7628(an) functions to MT76X8
>   pinctrl: ralink: rename pinctrl-rt2880 to pinctrl-ralink
>   pinctrl: ralink: rename pinmux functions to pinctrl
>   pinctrl: ralink: rename pinctrl-rt288x to pinctrl-rt2880
>   pinctrl: ralink: rename variable names for functions on MT7620 and MT76=
21
>   pinctrl: ralink: rename driver names to subdrivers
>   pinctrl: ralink: add new compatible strings for each pinctrl subdriver
>   MAINTAINERS: add Ralink pinctrl driver
>   mips: dts: ralink: mt7621: use the new compatible string for MT7621 pin=
ctrl
>   dt-bindings: pinctrl: rt2880: fix binding name, pin groups and function=
s
>   dt-bindings: pinctrl: add binding for Ralink MT7620 pinctrl
>   dt-bindings: pinctrl: add binding for Ralink MT7621 pinctrl
>   dt-bindings: pinctrl: add binding for Ralink RT305X pinctrl
>   dt-bindings: pinctrl: add binding for Ralink RT3883 pinctrl

I am ok with having different bindings for each single SoC if finally
is the correct way to go. I am also ok in being listed as a maintainer
in all of them. So, for the whole series:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
