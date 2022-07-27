Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007625823CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiG0KGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiG0KGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:06:45 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F7B1C2;
        Wed, 27 Jul 2022 03:06:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id d124so12006569ybb.5;
        Wed, 27 Jul 2022 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BPThQ8r+ZT9oR0uD4pwUUo7cjt+VO1rD6YsDH+nlihk=;
        b=qbWR7gUpU7e9J+PPmxUdtB5/GmZf5wlrRNm0DOOaKF5DXy89Dr/unc9YC5mc8A1esU
         XFX1MYNO7zaRatC2WSmQfw5Dq+pud9H5xu+XOlqt4DIdpSqcKhdTIdu//7IeLzE09Ccj
         XKb/5o5PNXYfTeog/pJmB4e4yThWzGJN4zH/CSpp/XT5AyJX8oCf5MCIxUgChjt0VT3A
         WSgLFqpYmdqVG6b7hxPnAfECJjDh9a1BNHw1WZ7hCBBUiE0+t7AyazrXL3QHmyp4h5o+
         9QW3R/qYLdVkEdcjKjVtM61T+4WTbamQz6hooXUr0s/TSMkMAPWd0EoOD9leKB5PBS0Y
         33cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BPThQ8r+ZT9oR0uD4pwUUo7cjt+VO1rD6YsDH+nlihk=;
        b=eZcReC608knPm70d9tGbMcuhAowjTkXfFHnwQySKsi7gbgoR2eO/H+3ky8xXN7GdUI
         sZmxpqZAle3Cjy3NEH23Z+Y8lWyXOP9muDVuVQxuWwvQad2AbRsjdE9U4hMnkSvzEOfZ
         rS5GkOA7q67nVJ0YV8PH8pYhglRZgvzRP0/GIu+d3SuQ1+tH/41XyGpZDEeRKp/jZWZt
         WEpGd1I7ZtUcl42jEI5hBXsGTR/vYXYrD8qdG6y8QWuT6j50XgcJ4vPI+o2nF2v0/g40
         Yjo73J/k3rEAt09N0ipEZ8GAci6QQ1u2FvFdPzlbobMLm10+GrY4yFifnlZ7IQjGL4jW
         /P5A==
X-Gm-Message-State: AJIora/JUAaqwSfNH5CmNudM5COUGh/f6SqOd3xg6BaLL6jw81t2ej1n
        mpDJgUnDOubmnqxHbhlIBTC+L9BOGcYxBd+nXLk=
X-Google-Smtp-Source: AGRyM1uLyoISGXm0Dw4G+wD70j1DWooC7FmOm76jqB8f5BUN1E/7u6keGf4JjYqcGFuYXQUnjqRSppYhLPKBQ2LLuiM=
X-Received: by 2002:a25:4689:0:b0:671:6d4f:c974 with SMTP id
 t131-20020a254689000000b006716d4fc974mr7048181yba.354.1658916403819; Wed, 27
 Jul 2022 03:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org> <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
In-Reply-To: <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 11:06:16 +0100
Message-ID: <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 27, 2022 at 10:54 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/07/2022 11:05, Lad, Prabhakar wrote:
> > Hi Krzysztof,
> >
> > Thank you for the review.
> >
> > On Wed, Jul 27, 2022 at 9:54 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 26/07/2022 20:06, Lad Prabhakar wrote:
> >>> Document Renesas RZ/Five (R9A07G043) SoC and SMARC EVK based on this =
SoC.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >>> ---
> >>>  .../devicetree/bindings/riscv/renesas.yaml    | 49 +++++++++++++++++=
++
> >>>  1 file changed, 49 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/riscv/renesas.y=
aml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/riscv/renesas.yaml b/D=
ocumentation/devicetree/bindings/riscv/renesas.yaml
> >>> new file mode 100644
> >>> index 000000000000..f72f8aea6a82
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/riscv/renesas.yaml
> >>> @@ -0,0 +1,49 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/riscv/renesas.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Renesas RZ/Five Platform Device Tree Bindings
> >>> +
> >>> +maintainers:
> >>> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> >>> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> +
> >>> +# We want to ignore this schema if the board is SMARC EVK based on A=
RM64 arch
> >>> +select:
> >>> +  not:
> >>> +    properties:
> >>> +      compatible:
> >>> +        contains:
> >>> +          items:
> >>
> >> I think you should rather ignore the RiscV SoCs, not specific board.
> >>
> > You mean to ignore ARM/64 SoCs?
> >
> > Agreed just the below enum, should do the trick.
> >
> >             - enum:
> >                 - renesas,r9a07g043u11
> >                 - renesas,r9a07g043u12
> >                 - renesas,r9a07g044c1
> >                 - renesas,r9a07g044c2
> >                 - renesas,r9a07g044l1
> >                 - renesas,r9a07g044l2
> >                 - renesas,r9a07g054l1
> >                 - renesas,r9a07g054l2
> >
> >
> >>> +            - const: renesas,smarc-evk
> >>> +            - enum:
> >>> +                - renesas,r9a07g043u11
> >>> +                - renesas,r9a07g043u12
> >>> +                - renesas,r9a07g044c1
> >>> +                - renesas,r9a07g044c2
> >>> +                - renesas,r9a07g044l1
> >>> +                - renesas,r9a07g044l2
> >>> +                - renesas,r9a07g054l1
> >>> +                - renesas,r9a07g054l2
> >>> +            - enum:
> >>> +                - renesas,r9a07g043
> >>> +                - renesas,r9a07g044
> >>> +                - renesas,r9a07g054
> >>
> >> Did you actually test that it works and properly matches?
> >>
> > Yes I have run the dtbs_check and dt_binding _check for ARM64 and
> > RISC-V. Do you see any cases where it can fail?
>
>
> Just remove the renesas,smarc-evk2 from
> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts. Do you see the
> error? Not from this schema. The only error you will see is that no
> matching schema was found.
>
I did run the dtbs_check test as per your suggestion (below is the
log) and didn't see "no matching schema error"

prasmi@prasmi:~/work/linux$ git diff
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 121e55282d18..b8129d85515f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -11,5 +11,5 @@

 / {
        model =3D "Renesas SMARC EVK based on r9a07g043u11";
-       compatible =3D "renesas,smarc-evk", "renesas,r9a07g043u11",
"renesas,r9a07g043";
+       compatible =3D "renesas,r9a07g043u11", "renesas,r9a07g043";
 };
prasmi@prasmi:~/work/linux$ rm
Documentation/devicetree/bindings/processed-schema.json
arch/arm64/boot/dts/renesas/*.dtb
prasmi@prasmi:~/work/linux$ make ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- dtbs_check -j6
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC     arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dtb
  DTC     arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb
  DTC     arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb
  DTC     arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb
  DTC     arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dtb
  CHECK   arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dtb
  CHECK   arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb
  CHECK   arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dtb
  CHECK   arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb
  CHECK   arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb:
flash@0: compatible: 'oneOf' conditional failed, one must be fixed:
    ['micron,mt25qu512a', 'jedec,spi-nor'] is too long
    'micron,mt25qu512a' does not match
'^((((micron|spansion|st),)?(m25p(40|80|16|32|64|128)|n25q(32b|064|128a11|1=
28a13|256a|512a|164k)))|atmel,at25df(321a|641|081a)|everspin,mr25h(10|40|12=
8|256)|(mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|(mxicy|=
macronix),mx25u(4033|4035)|(spansion,)?s25fl(128s|256s1|512s|008k|064k|164k=
)|(sst|microchip),sst25vf(016b|032b|040b)|(sst,)?sst26wf016b|(sst,)?sst25wf=
(040b|080)|winbond,w25x(80|32)|(winbond,)?w25q(16|32(w|dw)?|64(dw)?|80bl|12=
8(fw)?|256))$'
    'micron,mt25qu512a' is not one of ['issi,is25lp016d',
'micron,mt25qu02g', 'mxicy,mx25r1635f', 'mxicy,mx25u6435f',
'mxicy,mx25v8035f', 'spansion,s25sl12801', 'spansion,s25fs512s']
    'jedec,spi-nor' was expected
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/mtd/jedec,spi-nor=
.yaml
arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb:0:0:
/soc/spi@10060000/flash@0: failed to match any schema with compatible:
['micron,mt25qu512a', 'jedec,spi-nor']
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dtb:
pinctrl@11030000: 'interrupt-controller' is a required property
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/pinctrl/renesas,r=
zg2l-pinctrl.yaml
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dtb:
pinctrl@11030000: '#interrupt-cells' is a required property
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/pinctrl/renesas,r=
zg2l-pinctrl.yaml
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb:
pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must
be fixed:
    [[2]] is not of type 'object'
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/pinctrl/renesas,r=
zg2l-pinctrl.yaml
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb:
flash@0: compatible: 'oneOf' conditional failed, one must be fixed:
    ['micron,mt25qu512a', 'jedec,spi-nor'] is too long
    'micron,mt25qu512a' does not match
'^((((micron|spansion|st),)?(m25p(40|80|16|32|64|128)|n25q(32b|064|128a11|1=
28a13|256a|512a|164k)))|atmel,at25df(321a|641|081a)|everspin,mr25h(10|40|12=
8|256)|(mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|(mxicy|=
macronix),mx25u(4033|4035)|(spansion,)?s25fl(128s|256s1|512s|008k|064k|164k=
)|(sst|microchip),sst25vf(016b|032b|040b)|(sst,)?sst26wf016b|(sst,)?sst25wf=
(040b|080)|winbond,w25x(80|32)|(winbond,)?w25q(16|32(w|dw)?|64(dw)?|80bl|12=
8(fw)?|256))$'
    'micron,mt25qu512a' is not one of ['issi,is25lp016d',
'micron,mt25qu02g', 'mxicy,mx25r1635f', 'mxicy,mx25u6435f',
'mxicy,mx25v8035f', 'spansion,s25sl12801', 'spansion,s25fs512s']
    'jedec,spi-nor' was expected
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/mtd/jedec,spi-nor=
.yaml
arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb:0:0:
/soc/spi@10060000/flash@0: failed to match any schema with compatible:
['micron,mt25qu512a', 'jedec,spi-nor']
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb:
pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must
be fixed:
    [[2]] is not of type 'object'
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/pinctrl/renesas,r=
zg2l-pinctrl.yaml
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb:
flash@0: compatible: 'oneOf' conditional failed, one must be fixed:
    ['micron,mt25qu512a', 'jedec,spi-nor'] is too long
    'micron,mt25qu512a' does not match
'^((((micron|spansion|st),)?(m25p(40|80|16|32|64|128)|n25q(32b|064|128a11|1=
28a13|256a|512a|164k)))|atmel,at25df(321a|641|081a)|everspin,mr25h(10|40|12=
8|256)|(mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|(mxicy|=
macronix),mx25u(4033|4035)|(spansion,)?s25fl(128s|256s1|512s|008k|064k|164k=
)|(sst|microchip),sst25vf(016b|032b|040b)|(sst,)?sst26wf016b|(sst,)?sst25wf=
(040b|080)|winbond,w25x(80|32)|(winbond,)?w25q(16|32(w|dw)?|64(dw)?|80bl|12=
8(fw)?|256))$'
    'micron,mt25qu512a' is not one of ['issi,is25lp016d',
'micron,mt25qu02g', 'mxicy,mx25r1635f', 'mxicy,mx25u6435f',
'mxicy,mx25v8035f', 'spansion,s25sl12801', 'spansion,s25fs512s']
    'jedec,spi-nor' was expected
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/mtd/jedec,spi-nor=
.yaml
arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb:0:0:
/soc/spi@10060000/flash@0: failed to match any schema with compatible:
['micron,mt25qu512a', 'jedec,spi-nor']
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dtb:
usbphy-ctrl@11c40000: compatible:0: 'renesas,r9a07g043-usbphy-ctrl' is
not one of ['renesas,r9a07g044-usbphy-ctrl',
'renesas,r9a07g054-usbphy-ctrl']
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/reset/renesas,rzg=
2l-usbphy-ctrl.yaml
arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dtb:0:0:
/soc/usbphy-ctrl@11c40000: failed to match any schema with compatible:
['renesas,r9a07g043-usbphy-ctrl', 'renesas,rzg2l-usbphy-ctrl']
/home/prasmi/work/linux/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb:
pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must
be fixed:
    [[2]] is not of type 'object'
    From schema:
/home/prasmi/work/linux/Documentation/devicetree/bindings/pinctrl/renesas,r=
zg2l-pinctrl.yaml
prasmi@prasmi:~/work/linux$
prasmi@prasmi:~/work/linux$


Note: I am using dtschema version 2022.7.

> I don't think you can use such selects...
>
> Best regards,
> Krzysztof

Cheers,
Prabhakar
