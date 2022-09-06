Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A65AF463
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiIFT0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIFT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:26:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EC3C178;
        Tue,  6 Sep 2022 12:26:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lx1so25489600ejb.12;
        Tue, 06 Sep 2022 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=3oOVdi/bQtPCfcN+ik9XE1mlmO3wSv0j3YsV+Rxg9iA=;
        b=oi+lsbgrsow9eDnffOWYdWZn4LHOIOGIOUe13rTHqTRCoiuHIMKfqZu2hMrnBmEDZf
         sdpLszwKJF4wcItH10Gu5dYZH85MdPRVCwbugwAhEuAFcgxy6hkXnUaszaH8TcTxKbBT
         dRfDl0qCbcEA/yByUASgFx/EuLvYr/BJYr27xx8NkZ4VRhKy4YkRwlDKzBJjFB8y9DO0
         hwVyxz0Z6dgjavxRhDvcb3YBNnUROMbRikIG6tqHMf6AWhGvg0homiIxi7iyiu4FlMTY
         bHfRzthhlW3dusDlm/x94JHGS5coTG5jDaStTJBO5aknisKj/UugmTQ/UcIi8Fa+gJMa
         uUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3oOVdi/bQtPCfcN+ik9XE1mlmO3wSv0j3YsV+Rxg9iA=;
        b=xiQ2ldu3aFg6+ZJMvwGzKn2rn+oHetW6ZvE7wAD3Z7KJw2uESxJ+HcPHa+Glbx93De
         pKnmjQQKlrJxEtqsHFmmBooC925YxFM4zLzG7kEYw3AGP+9ub01yQzkvFuI4+3rVEd/L
         T7wexssm59/v15yIQGBJRaSWNA+TNUeLY9GWrb+e83HENRJP2urSdf/VdgQG3VaQg9QZ
         LE5+X0HrlnWVlZQQKonmq8uvxkayvOhxJGQ7UUM7ZejRqu2MiVD7ChcwFCuOyqN+HZSU
         C+7zUEMZQrp84eff5orghnWXzmJI61MGK3Uuu0SwsZemgNMvzmXQ/DnelhlI0gcqx71E
         IjdA==
X-Gm-Message-State: ACgBeo3CkvfbhZ+MpN99RvByVX/jhPImknydv3I95bIclEyIgZCAHNsu
        Arf7DanknnbigZq9tvPDBrvKXvjFmeVhcEE1vMQ=
X-Google-Smtp-Source: AA6agR70GthhctG+XzaKnAyD3X1E8+YQzb/0n4Tcz5GSF++oD42tAArTNShHfOuNh/UxP2ah4WQAFSc4TdMmm+SuxC4=
X-Received: by 2002:a17:906:9fc1:b0:761:9192:504f with SMTP id
 hj1-20020a1709069fc100b007619192504fmr23306ejc.116.1662492406523; Tue, 06 Sep
 2022 12:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220906153034.153321-1-peron.clem@gmail.com> <20220906153034.153321-4-peron.clem@gmail.com>
 <12048299.O9o76ZdvQC@kista>
In-Reply-To: <12048299.O9o76ZdvQC@kista>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 6 Sep 2022 21:26:34 +0200
Message-ID: <CAJiuCceZg_6p4yo89e0X3fD9aXFs9Xik8b8KUM+Psdy_4paKPw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: allwinner: h6: Add GPU OPP table
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

Hi Jernej,

On Tue, 6 Sept 2022 at 21:10, Jernej =C5=A0krabec <jernej.skrabec@gmail.com=
> wrote:
>
> Dne torek, 06. september 2022 ob 17:30:32 CEST je Cl=C3=A9ment P=C3=A9ron=
 napisal(a):
> > Add an Operating Performance Points table for the GPU to
> > enable Dynamic Voltage & Frequency Scaling on the H6.
> >
> > The voltage range is set with minimal voltage set to the target
> > and the maximal voltage set to 1.2V. This allow DVFS framework to
> > work properly on board with fixed regulator.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dts=
i
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi new file mode 10=
0644
> > index 000000000000..b48049c4fc85
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +// Copyright (C) 2022 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > +
> > +/ {
> > +     gpu_opp_table: opp-table-gpu {
> > +             compatible =3D "operating-points-v2";
> > +
> > +             opp-216000000 {
> > +                     opp-hz =3D /bits/ 64 <216000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
> > +
> > +             opp-264000000 {
> > +                     opp-hz =3D /bits/ 64 <264000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
>
> As mentioned in clock patch review, rates below 288 MHz are deemed unstab=
le on
> GPU PLL by vendor GPU kernel driver. At least in the BSP version that I h=
ave.
> Did you test these points? If not, better to drop them.

I changed the governor to userspace and set the freq to 216MHz / 264MHz
Run glmark2 and didn't observe any glitch nor issue.

I'm not sure if it's enough to say it's stable but I didn't observe
any strange behavior.

Regards,
Clement

>
> Best regards,
> Jernej
>
> > +
> > +             opp-312000000 {
> > +                     opp-hz =3D /bits/ 64 <312000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
> > +
> > +             opp-336000000 {
> > +                     opp-hz =3D /bits/ 64 <336000000>;
> > +                     opp-microvolt =3D <810000 810000 1200000>;
> > +             };
> > +
> > +             opp-360000000 {
> > +                     opp-hz =3D /bits/ 64 <360000000>;
> > +                     opp-microvolt =3D <820000 820000 1200000>;
> > +             };
> > +
> > +             opp-384000000 {
> > +                     opp-hz =3D /bits/ 64 <384000000>;
> > +                     opp-microvolt =3D <830000 830000 1200000>;
> > +             };
> > +
> > +             opp-408000000 {
> > +                     opp-hz =3D /bits/ 64 <408000000>;
> > +                     opp-microvolt =3D <840000 840000 1200000>;
> > +             };
> > +
> > +             opp-420000000 {
> > +                     opp-hz =3D /bits/ 64 <420000000>;
> > +                     opp-microvolt =3D <850000 850000 1200000>;
> > +             };
> > +
> > +             opp-432000000 {
> > +                     opp-hz =3D /bits/ 64 <432000000>;
> > +                     opp-microvolt =3D <860000 860000 1200000>;
> > +             };
> > +
> > +             opp-456000000 {
> > +                     opp-hz =3D /bits/ 64 <456000000>;
> > +                     opp-microvolt =3D <870000 870000 1200000>;
> > +             };
> > +
> > +             opp-504000000 {
> > +                     opp-hz =3D /bits/ 64 <504000000>;
> > +                     opp-microvolt =3D <890000 890000 1200000>;
> > +             };
> > +
> > +             opp-540000000 {
> > +                     opp-hz =3D /bits/ 64 <540000000>;
> > +                     opp-microvolt =3D <910000 910000 1200000>;
> > +             };
> > +
> > +             opp-576000000 {
> > +                     opp-hz =3D /bits/ 64 <576000000>;
> > +                     opp-microvolt =3D <930000 930000 1200000>;
> > +             };
> > +
> > +             opp-624000000 {
> > +                     opp-hz =3D /bits/ 64 <624000000>;
> > +                     opp-microvolt =3D <950000 950000 1200000>;
> > +             };
> > +
> > +             opp-756000000 {
> > +                     opp-hz =3D /bits/ 64 <756000000>;
> > +                     opp-microvolt =3D <1040000 1040000 1200000>;
> > +             };
> > +     };
> > +};
> > +
> > +&gpu {
> > +     operating-points-v2 =3D <&gpu_opp_table>;
> > +};
> > --
> > 2.34.1
>
>
