Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52686539E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346803AbiFAHlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347748AbiFAHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:41:06 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE46941A8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:41:05 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-306b5b452b1so9407977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9rheSKGCTBtpKVSuVWbfcC85G3s1vKpAYLbNOEGXq2w=;
        b=E9sAJi+xs2Mm03yGA6s/AoSrSPevJMqIGT2BQTUevPEAEGTCsIxg0a/Iuc+b0bBBwY
         2vlAWzqS5LyF/jTeTR1Uq2qqIhOt/UX8kSVWTx7ZwHWH+f4CClYERQzkOilRpQWjco8S
         /sPjedyjBxMLf79M6ixkpwryNB/ul+E7heP3Mgrqe0t3QcOQNywRp644FUBDU0stO3no
         ex63/anNFl6HSZkzeOQXZPPjvBhXCupe/xz/vZOrKFEE8ZSjwb/+odbCYE0LJu73dJVm
         dzP1Pd9gSGm9sf8HqAyyoaoNrhxN6NuexXeYCYx376Z1oNH2LQhLOGNAK9HXVs5FTOlt
         9siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9rheSKGCTBtpKVSuVWbfcC85G3s1vKpAYLbNOEGXq2w=;
        b=PFAQJBfnZ2KdaUj51LzYFJvFiGPViioBgysWJ1ZXG08X03JYc/BVhkmgkSJMNQWYQw
         z7BLCAwgMvp/7wqcUUeas9b9Ff6l0XpW+TTMq81OMxyDCBNySWkcK7mAhttSasGgesuu
         bBYRPpy9T/9whBXVNSiV4gsRcauFdQSLRvFmbRK6aIrc1SdylWJKzH7APtTNiDMbIfnb
         KczcqRVFnd5F5PzXDk2a7er47kTozt3/a9a7jfhSKxM8VJad0nXVvJvyb8i8mZc+o9Dd
         gKxm1wlp5UAek5Lf45NYhpXuimB/e7cQO7OIyhfdF7itoJf6eloZ5+z6y2QWpVDCIULb
         xkUA==
X-Gm-Message-State: AOAM533JjuMPFjnONq5GPflT72qgY14z6F/T+EBfQ4fYsbth+AiSV+MJ
        fTXADf4bSnT4OuVD7unIvNsnwzqzXa+cG7ftfUnJCg==
X-Google-Smtp-Source: ABdhPJywjnPzsFmV/WK0FsafZUCcTQrgNC9tqpaPDxQlkXD7h5p3xgdDtJADfFFI/ozFpTRFKWaAlbcq4ep/jBhN7yg=
X-Received: by 2002:a0d:cd04:0:b0:300:4784:caa3 with SMTP id
 p4-20020a0dcd04000000b003004784caa3mr39945959ywd.231.1654069264520; Wed, 01
 Jun 2022 00:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220530130839.120710-1-pan@semihalf.com> <20220530130839.120710-3-pan@semihalf.com>
 <f789afb2-33c5-2b28-5ade-0c76ebb7206f@linaro.org> <CAHNYxRw00QraVW0085xO-qzgGJdZ2joukuSYzBQo+yjLnkD=Tw@mail.gmail.com>
 <e4ef2056-c990-b308-a9d5-98f11ac0ba51@linaro.org> <CAF9_jYR=sjP9wYW9wyfbrVYO4PDYTfMhjvyyh53U3a3+2Zyw=g@mail.gmail.com>
 <b8a770fc-d72d-efd2-a7a0-8bfd44308576@linaro.org>
In-Reply-To: <b8a770fc-d72d-efd2-a7a0-8bfd44308576@linaro.org>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Wed, 1 Jun 2022 09:40:53 +0200
Message-ID: <CAF9_jYTdDuaCFcD33wL5m7AXU+xOgwP14himAqiJoxemd1ESyA@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 5:36 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/05/2022 16:47, Pawe=C5=82 Anikiel wrote:
> > On Tue, May 31, 2022 at 11:11 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 31/05/2022 03:20, Alexandru M Stan wrote:
> >>> Hello Krzysztof
> >>>
> >>> On Mon, May 30, 2022 at 11:56 AM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 30/05/2022 15:08, Pawe=C5=82 Anikiel wrote:
> >>>>> Add devicetree for the Google Chameleon v3 board.
> >>>>>
> >>>>> Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> >>>>> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> >>>>
> >>>> Your SoB chain looks odd. Who did what here?
> >>>
> >>> Sorry about this.
> >>>
> >>> It was mainly Pawel but I did some small changes at some point before
> >>> it landed in our tree (particularly the GPIOs).
> >>
> >> Then usually Pawe=C5=82 should be the owner of the patch, not you.
> >> Alternatively it could be also co-developed.
> >>
> >>>
> >>>>
> >>>>> ---
> >>>>>  arch/arm/boot/dts/Makefile                    |  1 +
> >>>>>  .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++=
++++
> >>>>>  2 files changed, 91 insertions(+)
> >>>>>  create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.d=
ts
> >>>>>
> >>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefil=
e
> >>>>> index 023c8b4ba45c..9417106d3289 100644
> >>>>> --- a/arch/arm/boot/dts/Makefile
> >>>>> +++ b/arch/arm/boot/dts/Makefile
> >>>>> @@ -1146,6 +1146,7 @@ dtb-$(CONFIG_ARCH_S5PV210) +=3D \
> >>>>>       s5pv210-torbreck.dtb
> >>>>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) +=3D \
> >>>>>       socfpga_arria5_socdk.dtb \
> >>>>> +     socfpga_arria10_chameleonv3.dtb \
> >>>>>       socfpga_arria10_socdk_nand.dtb \
> >>>>>       socfpga_arria10_socdk_qspi.dtb \
> >>>>>       socfpga_arria10_socdk_sdmmc.dtb \
> >>>>> diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/ar=
ch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
> >>>>> new file mode 100644
> >>>>> index 000000000000..988cc445438e
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
> >>>>> @@ -0,0 +1,90 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +/*
> >>>>> + * Copyright 2022 Google LLC
> >>>>> + */
> >>>>> +/dts-v1/;
> >>>>> +#include "socfpga_arria10_mercury_aa1.dtsi"
> >>>>> +
> >>>>> +/ {
> >>>>> +     model =3D "Google Chameleon V3";
> >>>>> +     compatible =3D "google,chameleon-v3",
> >>>>
> >>>> You miss here enclustra compatible.
> >>>
> >>> Does this make sense? I don't expect this device tree to boot/work on
> >>> an enclustra motherboard. It's only really compatible with a
> >>> "chameleon-v3".
> >>
> >> You also do not expect it to boot on altr,socfpga, do you?
> >>
> >> If I understood correctly, this board has physically Mercury AA1 SoM, =
so
> >> that compatible should be there.
> >
> > Yes, you understood correctly.
> > I looked at a similar device - the Cyclone V MCV (SoM) and the MCVEVK
> > (base board):
> > arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
>
> This one is clearly incorrect, so using it as example is wrong.
>
> > arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
>
> Since it is based on wrong MCV, then no wonder it's the same.
>
> > And there is no denx,mcv compatible anywhere, only denx,mcvevk.
> > Also, devicetree bindings documentation lists denx,mcvevk under
> > "Cyclone 5 boards", and, unless you consider the MCV to be a board,
> > there isn't a good place to put denx,mcv (same story with mercury+
> > aa1/chameleon).
>
> socfpga are not the best example... upstreaming looks incomplete or even
> incorrect, like this case of Enclustra SOM. Much better examples are
> FSL-based SoMs. Although some of them are also not in the best shape.
>
> Still someone might prefer to skip SoM compatible arguing that it cannot
> be a separate final product. Sure, but also SoC cannot be a separate
> product. Having SoM compatible allows to match against it and find
> common hardware parts.

Ok, I understand. Thanks for the explanation, I will add the SoM compatible=
.

>
> In any case you want to remove here parts of bindings (so affect ABI),
> to which I do not agree.
>
> >> Let me clarify - please use generic node names, as asked by Devicetree
> >> specification (2.2.1. Node Name Requirements). There is also list of
> >> some examples in the spec, but you can use some other generic node nam=
e.
> >>
> >> Several bindings also require it.
> >
> > Do you mean something like this?
> > ssm2603: audio-codec@1a {
> > u80: gpio@21 {
>
> Yes.
>
>
> Best regards,
> Krzysztof
