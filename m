Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655904FEFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiDMGip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiDMGim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:38:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418AF3A73E;
        Tue, 12 Apr 2022 23:36:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j6so689337qkp.9;
        Tue, 12 Apr 2022 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lVlNuAo9+0LRFp48WRzrOf1tdSb0zAURerrByRaHWQ4=;
        b=RWm0KbOUQ8Kubcw7iCvGa7dVVMQnn8DHJxM8rtgcot3Nef+WP3ZwU1lw2U7COdgDid
         G+kl/vGL1ZCSpKyycigFMRZiLQBc0A5xXI7QJFybMLtfXHBPL7H0CW09PSI5FKLGMIBj
         sZzgTw6eVx4AgBYyA9Aaxegl0QQcg4l4uGQ2GN2YynTKhKYa0c1L4vqw1U+a4OdameKX
         NJX5YHKKKyXTNGstljKTZGBDY+fIOnj87/jamYoW1CZVdUdweDfdHj32UyaJ5RDTyN9B
         xHvfj+MB7PLHPuWmGhjYLQe4K8FoqsYUPXpDxvA9K07Wf+zm330XLVA0z3hjrS50cIPa
         EGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lVlNuAo9+0LRFp48WRzrOf1tdSb0zAURerrByRaHWQ4=;
        b=jVjbAwxw6cQWfzOBatL8PDJzyJabE5x9caTACEpfwZzET3v271cyA/1sYghQwX318N
         4D9FQ7nEBIN5TU0e5mQETMFP/rLhOkoILyRcB8wkFOj9D+adtZ1SCWI4vo17rDC95X/c
         xvE0lA46MLeB3OuhRnH5AmFtqPXUOKNToEYqptz7NxmBfAjYvtVJR1Ao5NTsKKZF2eJ0
         JQbuHY9V+8TPU1xNkX1LMhCI8u8jnxp7AVtveTEIrVPJVa0DhQxVvTuC0rwkLhdA6l9W
         xjk4gJLtzG1w3rtbhc5j3rNO3hEQ116yK6PiVsGvj2f+1BhoDUQKbM2cLyFmYl7ZrpQ2
         6ESg==
X-Gm-Message-State: AOAM530dSw+2GDkZR3ahJU756sw98MpC7cEqitQJMd2wtNQlGZQ5frOz
        f2DczF4/R4t5kk9CSFVEbJJjv38b6KX+xl5QYWs=
X-Google-Smtp-Source: ABdhPJy3AaKsu44Yp4UCtsi1PArOwoGqRvhviTP5hjJuZ9/J2xvjSNLZDqzHNMxdw18SPpRJjGR6tsX20Muox56KDQo=
X-Received: by 2002:a05:620a:4308:b0:67b:487e:e02a with SMTP id
 u8-20020a05620a430800b0067b487ee02amr5722093qko.696.1649831780406; Tue, 12
 Apr 2022 23:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
In-Reply-To: <20220413060729.27639-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 13 Apr 2022 08:36:09 +0200
Message-ID: <CAMhs-H_oRzpeqJY8Oe+7Su5v-4B1WPwzOfhrvBC08FVi-O6fVA@mail.gmail.com>
Subject: Re: [PATCH 0/14] Refactor Ralink Pinctrl and Add Documentation
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com,
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

On Wed, Apr 13, 2022 at 8:08 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
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
> Ar=C4=B1n=C3=A7 =C3=9CNAL (14):
>   pinctrl: ralink: rename MT7628(an) functions to MT76X8
>   pinctrl: ralink: rename pinctrl-rt2880 to pinctrl-ralink
>   pinctrl: ralink: rename pinmux functions to pinctrl
>   pinctrl: ralink: rename pinctrl-rt288x to pinctrl-rt2880
>   pinctrl: ralink: rename variable names for functions on MT7620 and MT76=
21
>   pinctrl: ralink: rename driver names to subdrivers
>   MAINTAINERS: add Ralink pinctrl driver

For all these rename stuff and MAINTAINERS change:

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

>   pinctrl: ralink: add new compatible strings for each pinctrl subdriver
>   mips: dts: ralink: mt7621: use the new compatible string for MT7621 pin=
ctrl
>   dt-bindings: pinctrl: rt2880: fix binding name, pin groups and function=
s
>   dt-bindings: pinctrl: add binding for Ralink MT7620 pinctrl
>   dt-bindings: pinctrl: add binding for Ralink MT7621 pinctrl
>   dt-bindings: pinctrl: add binding for Ralink RT305X pinctrl
>   dt-bindings: pinctrl: add binding for Ralink RT3883 pinctrl

I think you cannot change compatible strings because you have to be
compatible with previous stuff. That is the reason why when I
refactored all of this stuff from 'arch/mips/ralink' into
'drivers/pinctrl' I maintained the same for all of them and only
created one binding for all. I know that these SoCs are mostly used in
openWRT and the way of doing things there is that when a new version
is released a new dtb is also compiled so I understand the motivation
of the change itself. In any case, Rob has the last word here, not me
:).

Thanks for doing this.

Best regards,
    Sergio Paracuellos
