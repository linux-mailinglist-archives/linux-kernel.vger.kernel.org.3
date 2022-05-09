Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412895205D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiEIU3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEIU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56B1F8F14;
        Mon,  9 May 2022 13:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35555616D2;
        Mon,  9 May 2022 20:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B133C385C2;
        Mon,  9 May 2022 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652127083;
        bh=KgbkuAWcAZAtlly2dGO/ru9Wcb6YFEOvc5D53ztwe1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZroXpDHV8m3uvWP15OxOZr3pOXzhtlgKfqlthkmHP5tgkQlwvIMt7OazQ89NM5Hzv
         zqS0A/1v5KDNQewtqDIwDIcy+CoLK2VxTEwTF06UsHSjmBc7moCd57WkSmxdObjaWC
         wRpQu/6Cai7Ov5ynIIr51emPMZWJ3z4xrA/nwKFOsS3m4fbSNcKJS5ka2MBZcQJ9SG
         y5j+aGdwm953bmtceFEHNJYe9KFhmknNkUNdDToHJGYzD4UrqDAggbPaw94Y3SNYcb
         mmaRzdE/ScDXoaTrUe7H5Jc7LHHJTP68yTF8ZvKVBRHVvPAk1oZuEbOm9HzQHiwipE
         3L8/sM/WIAPUw==
Received: by mail-pf1-f175.google.com with SMTP id bo5so13162187pfb.4;
        Mon, 09 May 2022 13:11:23 -0700 (PDT)
X-Gm-Message-State: AOAM530qQHmWkxqvp8nT5jS/Xjb/v5I55B72w0jNtZkeCdFO7VKho5aS
        7/yqP/ZSzWpZgDOCS9Ex/kZivd1onoEt4K/bCg==
X-Google-Smtp-Source: ABdhPJyNfsJjiheHv8YpRlfRjiAzEZNoSI2TP/1P0uIzUtueTLIZeAoOJi21y1r/+RutXA01GPq9VsMWBC5AAj8touY=
X-Received: by 2002:a63:d842:0:b0:3c6:ab6b:5f3c with SMTP id
 k2-20020a63d842000000b003c6ab6b5f3cmr6788575pgj.148.1652127082959; Mon, 09
 May 2022 13:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220217102448.27586-1-zajec5@gmail.com> <Yh/ovYMV104jc+CE@robh.at.kernel.org>
 <fb18b5e2-d273-adf6-3e14-77628abc4560@gmail.com>
In-Reply-To: <fb18b5e2-d273-adf6-3e14-77628abc4560@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 May 2022 15:11:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+KPiy4Tg3+qeMYHuSM5y2Y1X6tsAvQsWrWsoQiugtykw@mail.gmail.com>
Message-ID: <CAL_Jsq+KPiy4Tg3+qeMYHuSM5y2Y1X6tsAvQsWrWsoQiugtykw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: partitions: add UBI binding
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 2:32 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> w=
rote:
>
> On 2.03.2022 22:59, Rob Herring wrote:
> > On Thu, Feb 17, 2022 at 11:24:48AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote=
:
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> UBI is often used on embedded devices to store UBI volumes with device
> >> configuration / calibration data. Such volumes may need to be document=
ed
> >> and referenced for proper boot & setup.
> >>
> >> Some examples:
> >> 1. U-Boot environment variables
> >> 2. Device calibration data
> >> 3. Default setup (e.g. initial password)
> >>
> >> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >> ---
> >>   .../bindings/mtd/partitions/ubi.yaml          | 67 +++++++++++++++++=
++
> >>   1 file changed, 67 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/=
ubi.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml=
 b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> >> new file mode 100644
> >> index 000000000000..cd081f06d4cb
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> >> @@ -0,0 +1,67 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: UBI (Unsorted Block Images) device
> >> +
> >> +description: |
> >> +  UBI is a layer providing logical volumes (consisting of logical blo=
cks) on top
> >> +  of raw flash devices. It deals with low-level flash issues (bit-fli=
ps, bad
> >> +  physical eraseblocks, wearing) providing a reliable data storage.
> >> +
> >> +  UBI device is built and stored in a single flash partition.
> >> +
> >> +  Some (usually embedded) devices use UBI volumes of specific names o=
r indexes
> >> +  to store setup / configuration data. This binding allows describing=
 such
> >> +  volumes so they can be identified and referenced by consumers.
> >> +
> >> +maintainers:
> >> +  - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >> +
> >> +allOf:
> >> +  - $ref: partition.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: ubi
> >> +
> >> +patternProperties:
> >> +  "^volume-[0-9a-f]+$":
> >> +    type: object
> >> +    description: UBI volume
> >> +    properties:
> >> +      volume-name:
> >> +        $ref: /schemas/types.yaml#/definitions/string
> >> +      volume-id:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +    anyOf:
> >> +      - required:
> >> +          - volume-name
> >> +      - required:
> >> +          - volume-id
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    partitions {
> >> +        compatible =3D "fixed-partitions";
> >> +        #address-cells =3D <1>;
> >> +        #size-cells =3D <1>;
> >> +
> >> +        partition@0 {
> >> +            compatible =3D "ubi";
> >> +            reg =3D <0x0000000 0x1000000>;
> >> +            label =3D "filesystem";
> >> +
> >> +            env: volume-0 {
> >> +                volume-name =3D "u-boot-env";
> >
> > Why not do 'compatible =3D "u-boot,env";' to align with normal partitio=
ns?
>
> I mean to reserve "compatible" for describing UBI volume content.
>
> If I manage to get
> [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables binding
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2022022813=
1250.16943-1-zajec5@gmail.com/
> accepted, it'll allow me to later work on something like:
>
> env: volume-0 {
>      compatible =3D "u-boot,env";
>      volume-name =3D "u-boot-env";
> };
>
> (I believe) I'll need (in the final shape) two properties:
> 1. One for describing UBI volume ("compatible")
> 2. One for identifying UBI volume ("volume-name" / "volume-id")
>
> It's similar design to the "compatible" vs. "reg" in IO hw blocks.

That's what it is vs. what instance. You need a better example if
that's what you are trying to show. I guess if you were doing A/B
updates you'd have something like 'volume-name =3D "u-boot-env-b"'?

>
>
> > Or 'label'?
>
> I could replace "volume-name" with "label" but someone once told me that:
>  > 'label' is supposed to correspond to a sticker on a port or something
>  > human identifiable

Yes, it could be a human wanting to identify it. The question is
whether s/w does too.

The other aspect is there's also filesystem/partition label's. Those
are generally set by humans and opaque to the s/w. If the use is
aligned with how those labels are used, then I'd be okay with the DT
'label' here.

>
> ;) https://patchwork.ozlabs.org/comment/2812214/
>
> So I don't want to abuse "label" here.
>
>
> > We have enough ways to identify things, I don't think we need another.
> >
> >> +            };
> >> +
> >> +            calibration: volume-1 {
> >
> > Are 0 and 1 meaningful or just made up indexing?
>
> Made up indexing. I need unique nodenames but @[0-9a-f] doesn't appply he=
re.

Maybe use "volume-$volumename" or "volume-$volumeid" instead?

Rob
