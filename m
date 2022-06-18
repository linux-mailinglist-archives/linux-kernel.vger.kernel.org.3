Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F25550657
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiFRRZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiFRRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF915FCF;
        Sat, 18 Jun 2022 10:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E72B60B55;
        Sat, 18 Jun 2022 17:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDFDC3411A;
        Sat, 18 Jun 2022 17:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655573123;
        bh=Q6g5uQ1LQChmHpAdw8ycq1g5nOknwEdMg8uvJ98h72Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZvzyXwrvKPXWSQe+/ZLoXnYYLU/AiMwKuFeit6PR33u7BeJ6L13LeNnhgryWe6FiT
         pUMsFNXUUkjUFQvYCOHX+12uRfI8zD56F7t4W+Kq6kpq2fEctqGxnKuZF6sYnje5X5
         Ngi/Ima8tTCiQ71eGWhUTybULz4xxFWh0p5Bd9nKA84oRc787Av4G+hc3BjgQ54Wq9
         FPJHA6xJB3KLs+Y3kVMmo3lq6UViP+1NXs1NsnGqwyDhBd2OfiwCYONiCV/sLbVR8u
         3TxOLHarcLim4y7mS8XHpb3Nmy/STL4WMeLgwR3Eg26QBb9jrTxlmfX8Kmq/dFWs4I
         lnOVFJvEM6JEQ==
Date:   Sat, 18 Jun 2022 18:34:40 +0100
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
Message-ID: <20220618183440.121365d7@jic23-huawei>
In-Reply-To: <279cf4ef-8b41-5e92-73c3-416730038c56@linaro.org>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
        <1655458375-30478-2-git-send-email-u0084500@gmail.com>
        <7a9d3354-164b-e5e5-936b-95de4c4338f9@linaro.org>
        <CADiBU3_wyFLpoy3PU0a-EbGAKoQ9LZMprH5DWnzwo05-Gwa2=Q@mail.gmail.com>
        <279cf4ef-8b41-5e92-73c3-416730038c56@linaro.org>
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

On Sat, 18 Jun 2022 19:00:19 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 18/06/2022 08:50, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=
=B9=B46=E6=9C=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:45=E5=AF=
=AB=E9=81=93=EF=BC=9A =20
> >>
> >> On 17/06/2022 02:32, cy_huang wrote: =20
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Add the documentation for Richtek RTQ6056.
> >>>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>>  .../bindings/iio/adc/richtek,rtq6056-adc.yaml      | 57 ++++++++++++=
++++++++++
> >>>  1 file changed, 57 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek=
,rtq6056-adc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq605=
6-adc.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.=
yaml
> >>> new file mode 100644
> >>> index 00000000..6b4e0e0
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.y=
aml
> >>> @@ -0,0 +1,57 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056-adc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit =
ADC
> >>> +
> >>> +maintainers:
> >>> +  - ChiYuan Huang <cy_huang@richtek.com>
> >>> +
> >>> +description: |
> >>> +  The RTQ6056 is a high accuracy current-sense monitor with I2C and =
SMBus
> >>> +  interface, and the device provides full information for system by =
reading
> >>> +  out the loading current and power.
> >>> +
> >>> +  The device monitors both of the drops across sense resistor and th=
e BUS
> >>> +  voltage, converts into the current in amperes, and power in watts =
through
> >>> +  internal analog-to-digital converter ADC. The programmable calibra=
tion,
> >>> +  adjustable conversion time, and averaging function are also built =
in for
> >>> +  more design flexibility.
> >>> +
> >>> +  Datasheet is available at
> >>> +  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: richtek,rtq6056
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  "#io-channel-cells":
> >>> +    const: 1
> >>> +
> >>> +  richtek,shunt-resistor-uohm: =20
> >>
> >> Use standard properties, so "-micro-ohms". Drop the unit from
> >> description and drop the ref.
> >> =20
> > Use richtek.shunt-resistor-micro-ohms? =20
>=20
> Yes.
>=20
> > Or the prefix 'richtek,' can be removed? =20
>=20
> No, the vendor prefix must stay.

It's a standard generic binding used in a bunch of IIO and hwmon
drivers without vendor prefix.  Mind you I can't find a definition
in any of the top level binding files.  Probably wants to be in
adc.yaml for IIO.

Jonathan

=20
>=20
> Best regards,
> Krzysztof

