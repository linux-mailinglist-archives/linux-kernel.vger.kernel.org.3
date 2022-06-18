Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A255065A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbiFRR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:26:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A915FD3;
        Sat, 18 Jun 2022 10:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57D85B80B2E;
        Sat, 18 Jun 2022 17:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DFCC3411A;
        Sat, 18 Jun 2022 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655573178;
        bh=39UnWn6/BLP0wfoTZHT7v2eNKaEICuTAxT3fZ9m190s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iO2tqrxnt4KpaHax6i/wrpdA0yUl51BQfyFFDXdlXie//UgyKsVSCJjCaqC8x0HgZ
         sr2Ur5peM9Wm3C03A0OlYpiKofzqd7I45exkV2OvIeVDyy01W4XwSOnmgkRmn9bRII
         AwgTJKMztbMPb3BatWny0rxA7rY5gkc+d9eZnlN77+uvUXkCEUqsGbHlna/Kn/6Bas
         RgUrjW3P3UYIPEAX9aOP2FzM0UiHrDGV4eu/fCMXf1R9AnU/j7PVnhgolSbE4TuLzU
         j6Fez52xdS3ZphVn02Jl8Q3Uv14kNvGhN1nS32inVVzbcITZIQDDY8JgMtKnE0r2+x
         +x9xCE1KYEEBA==
Date:   Sat, 18 Jun 2022 18:35:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Message-ID: <20220618183534.576a2277@jic23-huawei>
In-Reply-To: <20220618183440.121365d7@jic23-huawei>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
        <1655458375-30478-2-git-send-email-u0084500@gmail.com>
        <7a9d3354-164b-e5e5-936b-95de4c4338f9@linaro.org>
        <CADiBU3_wyFLpoy3PU0a-EbGAKoQ9LZMprH5DWnzwo05-Gwa2=Q@mail.gmail.com>
        <279cf4ef-8b41-5e92-73c3-416730038c56@linaro.org>
        <20220618183440.121365d7@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 18 Jun 2022 18:34:40 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 18 Jun 2022 19:00:19 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>=20
> > On 18/06/2022 08:50, ChiYuan Huang wrote: =20
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=
=E5=B9=B46=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:45=E5=
=AF=AB=E9=81=93=EF=BC=9A   =20
> > >>
> > >> On 17/06/2022 02:32, cy_huang wrote:   =20
> > >>> From: ChiYuan Huang <cy_huang@richtek.com>
> > >>>
> > >>> Add the documentation for Richtek RTQ6056.
> > >>>
> > >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > >>> ---
> > >>>  .../bindings/iio/adc/richtek,rtq6056-adc.yaml      | 57 ++++++++++=
++++++++++++
> > >>>  1 file changed, 57 insertions(+)
> > >>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/richt=
ek,rtq6056-adc.yaml
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6=
056-adc.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-ad=
c.yaml
> > >>> new file mode 100644
> > >>> index 00000000..6b4e0e0
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc=
.yaml
> > >>> @@ -0,0 +1,57 @@
> > >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >>> +%YAML 1.2
> > >>> +---
> > >>> +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056-adc.yam=
l#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>> +
> > >>> +title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bi=
t ADC
> > >>> +
> > >>> +maintainers:
> > >>> +  - ChiYuan Huang <cy_huang@richtek.com>
> > >>> +
> > >>> +description: |
> > >>> +  The RTQ6056 is a high accuracy current-sense monitor with I2C an=
d SMBus
> > >>> +  interface, and the device provides full information for system b=
y reading
> > >>> +  out the loading current and power.
> > >>> +
> > >>> +  The device monitors both of the drops across sense resistor and =
the BUS
> > >>> +  voltage, converts into the current in amperes, and power in watt=
s through
> > >>> +  internal analog-to-digital converter ADC. The programmable calib=
ration,
> > >>> +  adjustable conversion time, and averaging function are also buil=
t in for
> > >>> +  more design flexibility.
> > >>> +
> > >>> +  Datasheet is available at
> > >>> +  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.p=
df
> > >>> +
> > >>> +properties:
> > >>> +  compatible:
> > >>> +    const: richtek,rtq6056
> > >>> +
> > >>> +  reg:
> > >>> +    maxItems: 1
> > >>> +
> > >>> +  "#io-channel-cells":
> > >>> +    const: 1
> > >>> +
> > >>> +  richtek,shunt-resistor-uohm:   =20
> > >>
> > >> Use standard properties, so "-micro-ohms". Drop the unit from
> > >> description and drop the ref.
> > >>   =20
> > > Use richtek.shunt-resistor-micro-ohms?   =20
> >=20
> > Yes.
> >  =20
> > > Or the prefix 'richtek,' can be removed?   =20
> >=20
> > No, the vendor prefix must stay. =20
>=20
> It's a standard generic binding used in a bunch of IIO and hwmon
> drivers without vendor prefix.  Mind you I can't find a definition

by which I meant to say "bindings" not drivers :)

> in any of the top level binding files.  Probably wants to be in
> adc.yaml for IIO.
>=20
> Jonathan
>=20
> =20
> >=20
> > Best regards,
> > Krzysztof =20
>=20

