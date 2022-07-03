Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F5564A71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiGCXJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGCXJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:09:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3104A2AE4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:09:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e28so11069042wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYkFjGhU57DIzMeerOpUZbWcAqQ0kLDWHxaSYSuF4tU=;
        b=K/YblOz7W4sldc4jTWM2nFjvromJ2JaPqsNCavhFMaaAnBR530NedeLhKQXy3p/LKW
         8flQiM8s5IRTXHq3gs71kAsL1Ta/IyxWqgf7nylGAD8aXNeXIkieU0Meou9vCkfWLqK8
         t3OhoEwNPvc2UerI0r2h0fAOXqUQRh7Vn3XH1mjTJuuzUHvfRwsa7qXg0GeKepdJdA/t
         IJnlIPhJQ5OQ3YNxMe+XuG+h9mrW1ApKKI6KG76xptbByA2+SIZunwcbS4rskbiuSYO0
         1tdLrCYfJ+rJZypOKTnf3djTjGvkw/11FObzDC6olUVkYCh5sns3iuGcON/NAy8XQmjb
         e3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYkFjGhU57DIzMeerOpUZbWcAqQ0kLDWHxaSYSuF4tU=;
        b=B2Cby3LFJFfUWW0GP3x8b/NZeFulLtrfeVKqVy2+fH8aVhgDvPTVxD/AKdqkth7RIe
         tgNzAH9A8S4N/tf7sab93+FLi+k0DfIXtpQQKtF2JDtgYy3RNOFdubqrmlR4WS2RG505
         eC7W2lVR2mVpvFBEo+2382cGy2/ec/4GMmwqJ5ybwAnuSvbmf9lHnJaZ7X3EOJ9B7VcG
         SQWscT74MfZj8c3q3Bj0LXAbWzI0IlQwYEkGUZ4kPrbi0/eIpXAPH+5NPlQ+wJuXeesh
         76Q6EF0onZL6Cplfu7ywZ6QfDztiAERuP2D/GVD41FKTSuVE75Tq8CzHmHkBWQ4wID4F
         EKVg==
X-Gm-Message-State: AJIora9NUvEV+Xi2QA7BNcV6nl+Xe4HjlJSKX5uBLK1F5UgfX4NcudHF
        3hq2o2ZYYlUSd/8HKx8lSrEPbjozjpMryWghZxzRxw==
X-Google-Smtp-Source: AGRyM1v3yDcM9EqrgyJfntIxPlZpqlSO0dzROF5IVr32eY016O3FEzWA0ZNwodqlYylmilwgKijofUYXzrI3Psdt5J8=
X-Received: by 2002:a05:6000:192:b0:21a:3c91:df05 with SMTP id
 p18-20020a056000019200b0021a3c91df05mr25268858wrx.655.1656889744572; Sun, 03
 Jul 2022 16:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-3-brad@pensando.io>
 <20220614212215.GA2627610-robh@kernel.org>
In-Reply-To: <20220614212215.GA2627610-robh@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:08:53 -0700
Message-ID: <CAK9rFnyH1aNSnSRZkRt_F1sh8Wy+3c-VLgB=z3Zjdpweq0FoSw@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC binding
To:     Rob Herring <robh@kernel.org>
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
        Randy Dunlap <rdunlap@infradead.org>, samuel@sholland.org,
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

Hi Rob,

On Tue, Jun 14, 2022 at 2:22 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:45PM -0700, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> > explicitly controls byte-lane enables.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index 4207fed62dfe..35bc4cf6f214 100644
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -13,10 +13,24 @@ maintainers:
> >  allOf:
> >    - $ref: mmc-controller.yaml
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - amd,pensando-elba-sd4hc
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Cadence host controller registers
> > +            - description: Byte-lane control register
> > +          minItems: 2
>
> This doesn't work. The if/then is additional constraints on the main
> section which says there is only 1 register region. The main section
> needs the above, but with 'minItems: 1'. Then the if/then should be:
>
> if:
>   properties:
>     compatible:
>       const: amd,pensando-elba-sd4hc
> then:
>   properties:
>     reg:
>       minItems: 2
> else:
>   properties:
>     reg:
>       maxItems: 1
> ...

The proposed change to current version throws dtbs_check error below:

--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -13,19 +13,6 @@ maintainers:
 allOf:
   - $ref: mmc-controller.yaml

-  - if:
-      properties:
-        compatible:
-          enum:
-            - amd,pensando-elba-sd4hc
-    then:
-      properties:
-        reg:
-          items:
-            - description: Cadence host controller registers
-            - description: Byte-lane control register
-          minItems: 2
-
 properties:
   compatible:
     items:
@@ -36,7 +23,7 @@ properties:
       - const: cdns,sd4hc

   reg:
-    maxItems: 1
+    minItems: 1

   interrupts:
     maxItems: 1
@@ -132,6 +119,19 @@ required:
   - interrupts
   - clocks

+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 unevaluatedProperties: false

results in

$ make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/brad/linux-next/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml:
ignoring, error in schema:
/home/brad/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml:
ignoring, error in schema:
  DTC     arch/arm64/boot/dts/amd/elba-asic.dtb
  CHECK   arch/arm64/boot/dts/amd/elba-asic.dtb
/home/brad/linux-next/arch/arm64/boot/dts/amd/elba-asic.dtb:
mmc@30440000: reg: [[0, 809762816, 0, 65536], [0, 810025028, 0, 4]] is
too long
        From schema:
/home/brad/linux-next/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
/home/brad/linux-next/arch/arm64/boot/dts/amd/elba-asic.dtb:
mmc@30440000: reg: [[0, 809762816, 0, 65536], [0, 810025028, 0, 4]] is
too long
        From schema:
/home/brad/linux-next/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml

Below modification to proposed change passes dtbs_check:

--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -13,19 +13,6 @@ maintainers:
 allOf:
   - $ref: mmc-controller.yaml

-  - if:
-      properties:
-        compatible:
-          enum:
-            - amd,pensando-elba-sd4hc
-    then:
-      properties:
-        reg:
-          items:
-            - description: Cadence host controller registers
-            - description: Byte-lane control register
-          minItems: 2
-
 properties:
   compatible:
     items:
@@ -36,7 +23,8 @@ properties:
       - const: cdns,sd4hc

   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2

   interrupts:
     maxItems: 1
@@ -132,6 +120,15 @@ required:
   - interrupts
   - clocks

+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+
 unevaluatedProperties: false

Regards,
Brad
