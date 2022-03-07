Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906124D0101
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiCGOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCGOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:22:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DA3BBDE;
        Mon,  7 Mar 2022 06:21:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r4so803755lfr.1;
        Mon, 07 Mar 2022 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+EMKFR4Q/6JagJvPZA+Y3lne0ZDGNjl+Y24aj5XlI+g=;
        b=mNVN8TpOFToRMpQZSAfJ3Q9YDhKpwQbh7Eb000Lsa7R3ADs5pkF3XEuG5/faRw/HgL
         iZqJId505MP6qAlyykGSnWHRk5s3DSl4yVhct3y9/LuUgPQrF+S9WhEaiVxdgDkDx/Ps
         0biOIfrJYmjQTnzcNhiafnE66v9PFAyPVZZvkpOMYZmjcYA/q/Euf+ZM8OLgcxr5vahf
         VkokSjETyosJCFjfcgUonTzqrc6utwQ6Xh8nRnOTs7Oc/HySxqM5EgcmoL8l/n52VJZm
         +zV8XdSIOZ3Uf53NpJTHXp18m1wc4mNtghrWPRXCiMJaNbcy2cI7GdYpveQ00IB/Rwfr
         +Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+EMKFR4Q/6JagJvPZA+Y3lne0ZDGNjl+Y24aj5XlI+g=;
        b=XGShvBaE1zsU6nuKMCLpgaSKY0Gb70eP5tKV1ItMx3+Cw0OfOqosgQW2ja4vRBgQta
         JQbYBBFBHtTuZB2jqmJaTKdWpFLF2ROCZOcASz3+pmOmHLoK6tDd/JB4l1aRNB7Rl9W4
         T1D+KipRsKgcEmsnXLUn1MLeMLg1WP4tbzqkABHfU7uqQtpfsDxzZBRN70RZaXMmWRrH
         l89TUrXkc8O/w/HcCzwk9UwReLPBEEKbP9Cw36MPgnacafJJN7SSD3TPS4Z+lBAYAkAu
         n900o6t7NIWhcAJRLqmxKHqMe/NcqycTeNAn2ni9e/7HpWCwGZfaHJ1m5wJqcDQXAty0
         SLmQ==
X-Gm-Message-State: AOAM532rxNk5eXSM8buEIKjTSehycf7IoMrPV1HIzTGv+kMKq5XtOYi8
        LxavWL8TvPBjWIqnCzc1JckBZeXCsn7BJAPp+qk=
X-Google-Smtp-Source: ABdhPJwhYrILSZVlae/ab5TOFV1Bk9yUjAsz7MCaHYhmcLagRPPeZ+Ac5SmOgfXvHOIii+waUkHtVPewRX0rJWrG4BQ=
X-Received: by 2002:a05:6512:228a:b0:443:4cd1:1bcc with SMTP id
 f10-20020a056512228a00b004434cd11bccmr7805283lfu.133.1646662896641; Mon, 07
 Mar 2022 06:21:36 -0800 (PST)
MIME-Version: 1.0
References: <1646647704-2331-1-git-send-email-u0084500@gmail.com>
 <1646647704-2331-2-git-send-email-u0084500@gmail.com> <1e6893ca-69f4-a2ed-6ecc-23507c04002b@canonical.com>
 <CADiBU3_jC_+P4d-gjMRGpP0uBejUkCY-axNd4nh1Y_=95iav3A@mail.gmail.com> <060968dc-9460-1b75-12a7-cb0bbe9563cc@canonical.com>
In-Reply-To: <060968dc-9460-1b75-12a7-cb0bbe9563cc@canonical.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 7 Mar 2022 22:21:25 +0800
Message-ID: <CADiBU387CFZNGoxu1G_8P8a6oFE-QLMTiDDXKTc0rkOsgbi4bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5190A PMIC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Krzysztof:

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=E5=
=B9=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:27=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On 07/03/2022 14:21, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=
=E5=B9=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:14=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> On 07/03/2022 11:08, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Add bindings for Richtek RT5190A PMIC.
> >>>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>>  .../regulator/richtek,rt5190a-regulator.yaml       | 138 +++++++++++=
++++++++++
> >>>  1 file changed, 138 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/regulator/richt=
ek,rt5190a-regulator.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt51=
90a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt=
5190a-regulator.yaml
> >>> new file mode 100644
> >>> index 00000000..b9f5836
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-reg=
ulator.yaml
> >>> @@ -0,0 +1,138 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/regulator/richtek,rt5190a-regulat=
or.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Richtek RT5190A PMIC Regulator
> >>> +
> >>> +maintainers:
> >>> +  - ChiYuan Huang <cy_huang@richtek.com>
> >>> +
> >>> +description: |
> >>> +  The RT5190A integrates 1 channel buck controller, 3 channels high =
efficiency
> >>> +  synchronous buck converters, 1 LDO, I2C control interface and peri=
pherial
> >>> +  logical control.
> >>> +
> >>> +  It also supports mute AC OFF depop sound and quick setting storage=
 while
> >>> +  input power is removed.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - richtek,rt5190a
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  vin2-supply:
> >>> +    description: phandle to buck2 input voltage.
> >>> +
> >>> +  vin3-supply:
> >>> +    description: phandle to buck3 input voltage.
> >>> +
> >>> +  vin4-supply:
> >>> +    description: phandle to buck4 input voltage.
> >>> +
> >>> +  vinldo-supply:
> >>> +    description: phandle to ldo input voltage
> >>> +
> >>> +  richtek,buck1-fixed-microvolt:
> >>> +    description: buck1 fixed voltage that depends on the external re=
sistor.
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>
> >> You should use standard bindings for it.
> >>
> > Sorry, I didn't get the point for the meaning 'standard binding'.
> > Do you mean to change 'richtek,buck1-fixed-microvolt' or 'uint32' defin=
ition?
> > This voltage depends on the external resistor selection. It's 'fixed'
> > by the application.
>
> I meant that you should not have dedicated binding to set regulator
> voltage, but use regulator-min/max-microvolt instead, within one
> regulator node. Just set min/max to same level and handle it in the
> driver. See for example:
> drivers/regulator/scmi-regulator.c
>
As I know, regulator-min/max-microvolt is used as the usage constraint.

But out buck1/buck4/ldo vout is defined by
Vout =3D VFb * (1 + R1/R2) where R1/R2 is chosen by the circuit design.

It seems not similar with the scmi-regulator.

Do you really suggest to use regulator-min/max-microvolt????

>
> Best regards,
> Krzysztof
