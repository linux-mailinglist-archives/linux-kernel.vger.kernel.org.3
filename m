Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1165564AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiGCXum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiGCXuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:50:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2345F79
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:50:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so11117974wrc.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRq/e/4c333beIFv9gNYaIdxDIpAmsD9/ZlSeuiZFzY=;
        b=xZ2sS7h3kN01lP5WAc6i9d0ekvpe8SzRjHWfh7G4ZP+QuV4A+Q8UM8gOCvwip8ugvm
         1e/zqx1uABp5ft9chPXoGat+L0w7axrrlDwHmhVs0wZ4RrP2LoPIbBXIy+4si2Y2LRvK
         PztxPVetl2AUI8OunpRgQPZxQFJn/6f1XNQz920RvSuDfW5WoPyC3OOHslT5cxvssIPp
         91bNVem4Z0gYZTFJmgFmRlTmqvFAXyWfWyeCFVONyOWwXlOKHq+dgyL1m09So+vlwtNr
         J+rEwjzC4ycC7FkPV5N7HYTDtCv5haXexhVsa4xDbtIiaUcyzJhh+3874zqPDSM+gcV1
         t+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRq/e/4c333beIFv9gNYaIdxDIpAmsD9/ZlSeuiZFzY=;
        b=Pg3taU7Phn0GNIlBJ2ik6Ub1RnzwyKl46lxW+W+A6vNCrZQY8N+d/00CLIyxNopQZq
         BfFksIy2XFRTYZjMKWfbF+VhCnyLv7iRdPmMyfwY6+vodm4KVAXTwX7sTSFFDo5GxXNk
         csUhAx961KzlHGQwCo3GnbFOcXb9eU/I4Cqz7jKbKxk6paiZwSWg6skhNuJppY25JdAM
         TPdQsV4lJaZ9Ue8UKRrkZtQSANcfND/sw3PfzA+ZFuAizgiEjNi/Ea9INDJksMBhn7x1
         VyManWLKaf/PpQcdC01aPQhV7dur5DGWfYpyF7EDPDfFOuEFQBeCF5efW8R6dVLnhiT3
         C7vw==
X-Gm-Message-State: AJIora8DgtpmtND5uJMv4H5dxIprNOAdiv6o2r5eub9+Wy4P47OLE13k
        /OdPSkSTBMMOyle+FDHlj1Lh1OCJJxHn++ipCk9jbZgU7Id5pg==
X-Google-Smtp-Source: AGRyM1t6qMqQOkgpSTAQjUaSv3J6ZyxsLzoJ/MEWwCcPmDPYKAG11Z6w8LtxzlSFzumNlum/bsK2f37ENWE0pAIAsjw=
X-Received: by 2002:a5d:5a15:0:b0:21d:630c:a609 with SMTP id
 bq21-20020a5d5a15000000b0021d630ca609mr7314612wrb.468.1656892237654; Sun, 03
 Jul 2022 16:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-8-brad@pensando.io>
 <eac223c5-a3d4-65e5-3753-1bd4033513f2@linaro.org>
In-Reply-To: <eac223c5-a3d4-65e5-3753-1bd4033513f2@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:50:26 -0700
Message-ID: <CAK9rFnyRgj26MaurS_u83wnzgmq+18=UdZT_FLLZc3jnWD4uFQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset:
 Add AMD Pensando SR Reset Controller bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Jun 20, 2022 at 6:00 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/06/2022 21:56, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > Document bindings for AMD Pensando Elba SR Reset Controller
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  .../reset/amd,pensando-elbasr-reset.yaml      | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> > new file mode 100644
> > index 000000000000..03bb86ebcfd3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD Pensando Elba SoC Reset Controller Device Tree Bindings
>
> Here and in all other patches:
> s/Device Tree Bindings//

Removed, must be implicit now, currently 366 files use it
$ find . -name \*.yaml|xargs grep title|grep 'Device Tree Bindings'|wc
    366

> > +
> > +maintainers:
> > +  - Brad Larson <blarson@amd.com>
> > +
> > +description: |
> > +  AMD Pensando Elba SoC reset controller driver which supports a resource
> > +  controller connected to the Elba SoC over a SPI bus.  The Elba reset
> > +  controller must be defined as a child node of the Elba SPI bus
> > +  chip-select 0 node.
> > +
> > +  See also:
> > +  - dt-bindings/reset/amd,pensando-elba-reset.h
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^reset-controller@[0-9a-f]+$"
>
> Skip the pattern. No particular need for it and unit address part is not
> correct (const: 0).

Deleted these lines
  $nodename:
    pattern: "^reset-controller@[0-9a-f]+$"

>
> > +
> > +  compatible:
> > +    const: amd,pensando-elbasr-reset
> > +
> > +  reg:
> > +    const: 0
> > +
> > +  '#reset-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#reset-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
>
> Missing file:
> ls: cannot access 'include/dt-bindings/reset/amd,pensando-elba-reset.h':
> No such file or directory
>
>
> Send complete bindings, not parts of it. Did you test it? I am pretty
> sure that this did not happen. :(

Its in patch v5-0015 with the driver.  I'll check this, the correct
approach should be put all binding changes as individual patches up
front or there are exceptions for new driver.

$ cat v5-0015-reset-elbasr-Add-AMD-Pensando-Elba-SR-Reset-Contr.patch
| grep diff
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
diff --git a/drivers/reset/reset-elbasr.c b/drivers/reset/reset-elbasr.c
diff --git a/include/dt-bindings/reset/amd,pensando-elba-reset.h
b/include/dt-bindings/reset/amd,pensando-elba-reset.h

Yes, tested it with the following and no warnings or errors
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/amd,pensando.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml

make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/amd,pensando.yaml
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/vendor-prefixes.yaml
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml

> > +    spi0 {
>
> spi

Changed to spi

Regards,
Brad
