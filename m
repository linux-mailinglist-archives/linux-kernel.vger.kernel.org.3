Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD150D238
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiDXO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiDXOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:25:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F43240B7;
        Sun, 24 Apr 2022 07:22:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so7830854wmp.3;
        Sun, 24 Apr 2022 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pIUwr7rvSC00tEuCJUJpOI2hD07LGXvLzfGQmfn7FGE=;
        b=aQL87mJLkvI4hXvNHkgRps+S0rEFi5C3jnkx9Q6Ie+Cp0GNp7rdNJuXyBz3gFE5/9q
         UPqwWQRlnahZNJ0tZz4HKGNVUHZbtWoHdvq7qrpoKrAUBom2MMlOt3xOHThuHL3hdPsI
         v9wLeDwwb48IJOwXIXi/CWmIRL0FACrgFwdPpeLR3AkS/nsFJux8OZ1KeQNIPGKBtY24
         xJN6Vf7Eo5m3gjKj7n4C8rjrR8BgAYixb4ucWdF/eLfGiITkpo08Xa34C4pjfDCouziV
         7MDPBMnfQMJLEIJAwVVEDgk+6KhW+EXYL3XR2BkauwEUIQQ04iTxDAIkAVYnhEiaUpqc
         N39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pIUwr7rvSC00tEuCJUJpOI2hD07LGXvLzfGQmfn7FGE=;
        b=k2sU6y0ZttnMWVU1eTGJysH/giHQjNl1beH95anf7b4s9WjMg+OpWU7lxza8A3fVxM
         hcEmw4zJHeCqih/ZrOzdWnamsnv7xbVm5FaODWjgmd4OqyJWjsoTO1Nb6lUwnatBSWvb
         rXL/VLGva6/PUZjZSoK8s7xluPv6+OXhnK934m3D86ZmuaDcPd2aGSvoxiZmUtMCM8Bd
         wfaGbDbbJpYlddkauJ9erC9yMdMWcKkwl9UOwXI9QlcMmDM/VAtsjXE8xB7hVWLnmMEk
         Gvr4Ase9JEqPNSMt3WKlCvctZbNzS85eEZJVXekA9Qp9mH9OAD5BIWijLtn7+gsB6gYQ
         RPsw==
X-Gm-Message-State: AOAM533nwRXuDpw6+3jGDgu5KEWvFgC+4vCICPGM9oA+LVqCtaVNre26
        INczF7IGD8zjf12l8aFWPSnAbCM16xUC5tW3IaI=
X-Google-Smtp-Source: ABdhPJy23on36vtfmZZFtqRCktW5HHTuPmMRotc7rdlQTLUfTyIEM4TPn7oaPBRaMT5KV0/H1z7dDTvhyzrVhSVm6HI=
X-Received: by 2002:a05:600c:35c5:b0:390:9982:73ec with SMTP id
 r5-20020a05600c35c500b00390998273ecmr21880389wmq.196.1650810174850; Sun, 24
 Apr 2022 07:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220418125630.2342538-1-gengcixi@gmail.com> <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org> <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
 <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org> <CAF12kFu5KW+fw=0kP6LrEqOvKYR38mELfPjG64=n+gudRxsZUQ@mail.gmail.com>
 <baa73bda-91af-8a31-67f4-6d5615862c73@linaro.org>
In-Reply-To: <baa73bda-91af-8a31-67f4-6d5615862c73@linaro.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Sun, 24 Apr 2022 22:22:18 +0800
Message-ID: <CAF12kFsxqdYERwhjC3tq9bNqzWS3P6Sb7VPCwHmQ=StF28Q-+A@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
4=E6=9C=8824=E6=97=A5=E5=91=A8=E6=97=A5 19:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On 24/04/2022 12:47, Cixi Geng wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=
=B9=B44=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C 14:38=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On 19/04/2022 03:53, Cixi Geng wrote:
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=
=B9=B44=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C 00:28=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>>
> >>>> On 18/04/2022 14:56, Cixi Geng wrote:
> >>>>> From: Cixi Geng <cixi.geng1@unisoc.com>
> >>>>>
> >>>>> Add a new bindings to describe ums512 clock compatible string.
> >>>>>
> >>>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> >>>>> ---
> >>>>>  .../bindings/clock/sprd,ums512-clk.yaml       | 112 ++++++++++++++=
++++
> >>>>>  1 file changed, 112 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,um=
s512-clk.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-cl=
k.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..89824d7c6be4
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >>>>> @@ -0,0 +1,112 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +# Copyright 2022 Unisoc Inc.
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> >>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >>>>> +
> >>>>> +title: UMS512 Clock Control Unit Device Tree Bindings
> >>>>
> >>>> Remove "Device Tree Bindings". You could do the same also in the
> >>>> subject, because you repeat the prefix ("dt-bindings: clk: sprd: Add
> >>>> ums512 clock controller").
> >>>>
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Orson Zhai <orsonzhai@gmail.com>
> >>>>> +  - Baolin Wang <baolin.wang7@gmail.com>
> >>>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> >>>>> +
> >>>>> +properties:
> >>>>> +  "#clock-cells":
> >>>>> +    const: 1
> >>>>> +
> >>>>> +  compatible:
> >>>>
> >>>> Put the compatible first, by convention and makes finding matching
> >>>> bindings easier.
> >>>>
> >>>>> +    oneOf:
> >>>>> +      - items:
> >>>>> +          - const: sprd,ums512-glbregs
> >>>>> +          - const: syscon
> >>>>> +          - const: simple-mfd
> >>>>
> >>>> Why do you need simple-mfd for these? This looks like a regular sysc=
on,
> >>>> so usually does not come with children. What is more, why this "usua=
l
> >>>> syscon" is a separate clock controller in these bindings?
> >>> there is a warning log before add these const.  and the reason we nee=
d
> >>> the simply-mfd
> >>> is some clock is a child of syscon node,which should set these compat=
ible.
> >>> failed to match any schema with compatible: ['sprd,ums512-glbregs',
> >>> 'syscon', 'simple-mfd']
> >>
> >> Neither here nor later you did not answer the question - why do you ne=
ed
> >> such complex construction, instead of adding syscon to the clock contr=
oller?
> >>
> >> Let me paste again my concerns:
> >>
> >>   You have nodes with reg but without unit address ("rpll"). These nod=
es
> >>   are modeled as children but they are not children - it's a workaroun=
d
> >>   for exposing syscon, isn't it? The sc9863a looks like broken design,
> >>   so please do not duplicate it here.
> >>
> >> IOW, sc9863a uses similar pattern as here and the DTS is made wrong.
> >> Because of this you need to create complex ways to get the regmap for
> >> the clock controller... Why not making it simple? Clock controller wit=
h
> >> syscon?
> >
> > I find the history discuss about the sp9863 clock[1] and last
> > ums512-clk dt-bindings patch[2] which from chunyan.
> > please refer to the reasons below.
> >
> > These clocks are at the same register range with global registers.
> > the registers shared with more than one devices  which  basically
> > are multimedia devices. You may noticed that these are all gate
> > clocks which are in the global registers  ranges and are used to
> > controll the enable status of some devices or some part of devices.
> >
> > [1] https://lore.kernel.org/all/CAAfSe-s0gcehu0ZDj=3DFTe5S7CzAHC5mahXBH=
2fJm7mXS7Xys1Q@mail.gmail.com/#r
> > [2] https://lore.kernel.org/all/163425295208.1688384.110231876257931146=
62@swboyd.mtv.corp.google.com/#r
>
> Which looks like discussion about different bindings. You had there a
> clock controller and additional clock device using "sprd,syscon". Why
> the rpll is a subdevice and not a part of clock controller. The same as
> all other clocks coming from that clock-controller, right? What is so
> special about rpll that is is a separate device, not part of the clock
> controller? It's the same address space, isn't it?
The hardware spec design these clocks are not belonged to the syscon,
the phandle is only used to get virtual  map address for clocks which
have the same phsical address base with one syscon.(I don't know the
historical reason for this design) It also can wroten a clock sperated from
syscon by add the reg which same as syscon. but will lead to a duplicate
mapping--one is from the clock,and one is from syscon. which make difficult=
y
 in analyzing some panic problems.

>
> Best regards,
> Krzysztof
