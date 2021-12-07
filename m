Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2646C2AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhLGS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbhLGS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:27:14 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA29C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:23:44 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id i6so87228uae.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WFFnGguuAfJNNlyzWzYsEDjqWn3Es8o9KH8UkSEiIJg=;
        b=QXZdsesh40yspp/vuC5Vm4kMeddsWnQpKc0BAPZaKnCnpIg7QL+i3AYQbm/r10ITsH
         kCH+skGM9Kvqr0wsMAM4D0rE5+zGBHo33hoCIH6hI3VPck20O82PjYLJWHBJn6TrUoD5
         fge5j2BSWbIn2Gi8Lxu55GIILQB7foQ2bwRNfILJZYG9WhX11A/tjE0Ns06xbKV8Sdho
         Ftpv2zumMtcyoz8/eGZGylQK3VBRYyXJYXuM3NSXp2IQu143V1XWo/80J/YCte/zlfXs
         tnugYlYug+jWNblRHSs5zDksVV3Xh7DvY4QYxU727mRn4P22JNaLfq+VdlhBlo+Rg3FB
         71nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WFFnGguuAfJNNlyzWzYsEDjqWn3Es8o9KH8UkSEiIJg=;
        b=bpz4Hy77dH4yb16bF12cVn/OiMnJfZrglK6y0EzS5gpNn0EfD/dgNKUiIzaRaPk8gl
         8MvECA8q454vM75Hu/H1e7mQoX/8mFaQPtB/ZkB/MAUgrSpW5hWEKH+2W6xKZA0yxFSg
         HAnAs1BZUJGD0+OituekSOjEmeH2t27pp+AqOqYJVYBsXXdBHu5o4p1jwShOzQ2FP5hd
         qxpRjb1xDQ6vkDhrJ6Dr9CFmTzgROOO6gHajzcQUmzksSm7GeOLsvVdIxOWp1P8OCkbE
         g5RrrmrjTc1iC/hJlp/gaNUcfmZEBR8ebEAOD7FgZDSDbnboriqy1lMTV5xqEMPoD2PE
         g5uw==
X-Gm-Message-State: AOAM530ncyl+g2Jw5+Hg6WAXTJwrr0M5hMwe0ce4uMfu8K1E3w1i9JIo
        5SC7TPCfdup4rImAR6Gn8m0UoRth+LE5AbQdYiO39w==
X-Google-Smtp-Source: ABdhPJzhaNDn+hR8Qy06/GBXd2FkzRqewGIyrqT1j1J8CgqqD8P0mc41IH5Pb0jPdTIcD/UIQ3uJiyVReoJxL8RZWu4=
X-Received: by 2002:ab0:6f4f:: with SMTP id r15mr962993uat.17.1638901423133;
 Tue, 07 Dec 2021 10:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20211206153124.427102-1-virag.david003@gmail.com> <20211206153124.427102-3-virag.david003@gmail.com>
In-Reply-To: <20211206153124.427102-3-virag.david003@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 7 Dec 2021 20:23:31 +0200
Message-ID: <CAPLW+4ndzvks6os2W1o+_7dyi_DZKjgqpoFfsS90pzXWVTpkGg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: clock: Document Exynos7885 CMU bindings
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 17:32, David Virag <virag.david003@gmail.com> wrote:
>
> Provide dt-schema documentation for Exynos7885 SoC clock controller.
> Description is modified from Exynos850 clock controller documentation as
> I couldn't describe it any better, that was written by Sam Protsenko.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Changes in v2:
>   - Fixed double : in description
>   - Added R-b tag by Krzysztof Kozlowski
>
> Changes in v3:
>   - Nothing
>
> Changes in v4:
>   - Fix leading 0x in example.
>
>  .../clock/samsung,exynos7885-clock.yaml       | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exyno=
s7885-clock.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos7885-c=
lock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos7885-cloc=
k.yaml
> new file mode 100644
> index 000000000000..7e5a9cac2fd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.ya=
ml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/samsung,exynos7885-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos7885 SoC clock controller
> +
> +maintainers:
> +  - D=C3=A1vid Vir=C3=A1g <virag.david003@gmail.com>
> +  - Chanwoo Choi <cw00.choi@samsung.com>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +  - Tomasz Figa <tomasz.figa@gmail.com>
> +
> +description: |
> +  Exynos7885 clock controller is comprised of several CMU units, generat=
ing
> +  clocks for different domains. Those CMU units are modeled as separate =
device
> +  tree nodes, and might depend on each other. The root clock in that roo=
t tree
> +  is an external clock: OSCCLK (26 MHz). This external clock must be def=
ined
> +  as a fixed-rate clock in dts.
> +
> +  CMU_TOP is a top-level CMU, where all base clocks are prepared using P=
LLs and
> +  dividers; all other leaf clocks (other CMUs) are usually derived from =
CMU_TOP.
> +
> +  Each clock is assigned an identifier and client nodes can use this ide=
ntifier
> +  to specify the clock which they consume. All clocks available for usag=
e
> +  in clock consumer nodes are defined as preprocessor macros in
> +  'dt-bindings/clock/exynos7885.h' header.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos7885-cmu-top
> +      - samsung,exynos7885-cmu-core
> +      - samsung,exynos7885-cmu-peri
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 10
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 10
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos7885-cmu-top
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: External reference clock (26 MHz)
> +
> +        clock-names:
> +          items:
> +            - const: oscclk
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos7885-cmu-core
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: External reference clock (26 MHz)
> +            - description: CMU_CORE bus clock (from CMU_TOP)
> +            - description: CCI clock (from CMU_TOP)
> +            - description: G3D clock (from CMU_TOP)
> +
> +        clock-names:
> +          items:
> +            - const: oscclk
> +            - const: dout_core_bus
> +            - const: dout_core_cci
> +            - const: dout_core_g3d
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos7885-cmu-peri
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: External reference clock (26 MHz)
> +            - description: CMU_PERI bus clock (from CMU_TOP)
> +            - description: SPI0 clock (from CMU_TOP)
> +            - description: SPI1 clock (from CMU_TOP)
> +            - description: UART0 clock (from CMU_TOP)
> +            - description: UART1 clock (from CMU_TOP)
> +            - description: UART2 clock (from CMU_TOP)
> +            - description: USI0 clock (from CMU_TOP)
> +            - description: USI1 clock (from CMU_TOP)
> +            - description: USI2 clock (from CMU_TOP)
> +
> +        clock-names:
> +          items:
> +            - const: oscclk
> +            - const: dout_peri_bus
> +            - const: dout_peri_spi0
> +            - const: dout_peri_spi1
> +            - const: dout_peri_uart0
> +            - const: dout_peri_uart1
> +            - const: dout_peri_uart2
> +            - const: dout_peri_usi0
> +            - const: dout_peri_usi1
> +            - const: dout_peri_usi2
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock controller node for CMU_PERI
> +  - |
> +    #include <dt-bindings/clock/exynos7885.h>
> +
> +    cmu_peri: clock-controller@10010000 {
> +        compatible =3D "samsung,exynos7885-cmu-peri";
> +        reg =3D <0x10010000 0x8000>;
> +        #clock-cells =3D <1>;
> +
> +        clocks =3D <&oscclk>,
> +                 <&cmu_top CLK_DOUT_PERI_BUS>,
> +                 <&cmu_top CLK_DOUT_PERI_SPI0>,
> +                 <&cmu_top CLK_DOUT_PERI_SPI1>,
> +                 <&cmu_top CLK_DOUT_PERI_UART0>,
> +                 <&cmu_top CLK_DOUT_PERI_UART1>,
> +                 <&cmu_top CLK_DOUT_PERI_UART2>,
> +                 <&cmu_top CLK_DOUT_PERI_USI0>,
> +                 <&cmu_top CLK_DOUT_PERI_USI1>,
> +                 <&cmu_top CLK_DOUT_PERI_USI2>;
> +        clock-names =3D "oscclk",
> +                      "dout_peri_bus",
> +                      "dout_peri_spi0",
> +                      "dout_peri_spi1",
> +                      "dout_peri_uart0",
> +                      "dout_peri_uart1",
> +                      "dout_peri_uart2",
> +                      "dout_peri_usi0",
> +                      "dout_peri_usi1",
> +                      "dout_peri_usi2";
> +    };
> +
> +...
> --
> 2.34.1
>
