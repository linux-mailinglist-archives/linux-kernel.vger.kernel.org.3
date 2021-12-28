Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF9480BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhL1Q6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbhL1Q6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:58:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9DC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k21so42685449lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLS767KJTZfvw5/Pb90qAf4lv/UgXzjgnY65+gUmz1k=;
        b=h6kLOAeWGL2CluUxbLepQ1y9HSLKlXZKkho5A1VDDVF8paOZSSAvw1dxROD6rkd/ba
         TpGyRyKjcTEPQMbqCwjOLj8+ug9uyO6U+S3HdAMwDkbb19hMEkUmMZ0Nd0SjMJFF+6qt
         +glPqyCTX8XHD3nnyqlp35igsacDq+ZiXXeMUOl/8fNegh+cBM5tje8bm4AFKMD4t8tB
         EDefaYRtlfL8+fgied+f4uvIkkAlOStidiIJqerM9aEtUz2O17lVFf9uqy8zNsgOSgPR
         TnEMpJIaXxGzN7NQZAgt0ZA6HNd3oIY2vwbralUqxBrlpJSUqY3OTdhs7+RahR5Jz9oB
         eeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLS767KJTZfvw5/Pb90qAf4lv/UgXzjgnY65+gUmz1k=;
        b=C+U4KdN6QHvBXSlT1we9VOQ25OeFIBwkgyW4FneeHLcWyEl3fSh8vbbcar0276MxpL
         5qjyIHbCLLLLjtBIYBcKOXnFETrm93IreriHMx5OJ5XRWXH2QN7ig0WLVGF7tzsiKwTC
         UENqA8+FBugfalLiar0IoDClclLgS9oQbC2qa1RUJLn+8wMFarw82+YvluBwDanao5/1
         BVpEiTES9IyGWpxEhL5nkSkM/yoFabnRpPqX7HwNTekt7lx/uFGazuDB4TT9buJeI+Z4
         6hRks4bLwXCMMjD5aEgUWflutZxRdlV75Eu0Scjtm1Yf6UFda/cWO0mp6xzLjsTWSkuu
         Wtzg==
X-Gm-Message-State: AOAM533Ymixmcgpd2iPge5COBfMkIyUxH7mfb/0RpuDtNzOcY2rSluBE
        hQCItF8t1A8Wm5Gu+8LPFROFFWMjWdFaohesLCbKsw==
X-Google-Smtp-Source: ABdhPJwyZ9JvkIK3ExHySh5L90wxtJYKduqCDHyqNMikqWtjWEpQBb5jtvqNjjZwpSDQQ5znW/Iu2simawK1NooQXJc=
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr20014933lfv.184.1640710722641;
 Tue, 28 Dec 2021 08:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com> <20211227133558.135185-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211227133558.135185-3-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:58:06 +0100
Message-ID: <CAPDyKFqJYMkxS01dQCGhtwGtFdf98XnvEJOoeYu9=pnnRUhJhA@mail.gmail.com>
Subject: Re: [PATCH 09/19] dt-bindings: mmc: synopsys-dw-mshc: integrate
 Altera and Imagination
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 at 14:36, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The bindings for Altera and Imagination extensions are the same as for
> the original Synopsys Designware Mobile Storage Host Controller.
> Integrate them into Synopsys bindings to have dtschema coverage.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/img-dw-mshc.txt   | 28 -------------------
>  .../bindings/mmc/socfpga-dw-mshc.txt          | 23 ---------------
>  .../bindings/mmc/synopsys-dw-mshc.yaml        |  5 +++-
>  3 files changed, 4 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
>  delete mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
> deleted file mode 100644
> index c54e577eea07..000000000000
> --- a/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Imagination specific extensions to the Synopsys Designware Mobile Storage
> -  Host Controller
> -
> -The Synopsys designware mobile storage host controller is used to interface
> -a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> -differences between the core Synopsys dw mshc controller properties described
> -by synopsys-dw-mshc.txt and the properties used by the Imagination specific
> -extensions to the Synopsys Designware Mobile Storage Host Controller.
> -
> -Required Properties:
> -
> -* compatible: should be
> -       - "img,pistachio-dw-mshc": for Pistachio SoCs
> -
> -Example:
> -
> -       mmc@18142000 {
> -               compatible = "img,pistachio-dw-mshc";
> -               reg = <0x18142000 0x400>;
> -               interrupts = <GIC_SHARED 39 IRQ_TYPE_LEVEL_HIGH>;
> -
> -               clocks = <&system_clk>, <&sdhost_clk>;
> -               clock-names = "biu", "ciu";
> -
> -               fifo-depth = <0x20>;
> -               bus-width = <4>;
> -               disable-wp;
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> deleted file mode 100644
> index 4897bea7e3f8..000000000000
> --- a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -* Altera SOCFPGA specific extensions to the Synopsys Designware Mobile
> -  Storage Host Controller
> -
> -The Synopsys designware mobile storage host controller is used to interface
> -a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> -differences between the core Synopsys dw mshc controller properties described
> -by synopsys-dw-mshc.txt and the properties used by the Altera SOCFPGA specific
> -extensions to the Synopsys Designware Mobile Storage Host Controller.
> -
> -Required Properties:
> -
> -* compatible: should be
> -       - "altr,socfpga-dw-mshc": for Altera's SOCFPGA platform
> -
> -Example:
> -
> -       mmc: dwmmc0@ff704000 {
> -               compatible = "altr,socfpga-dw-mshc";
> -               reg = <0xff704000 0x1000>;
> -               interrupts = <0 129 4>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index 240abb6f102c..ae6d6fca79e2 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -15,7 +15,10 @@ maintainers:
>  # Everything else is described in the common file
>  properties:
>    compatible:
> -    const: snps,dw-mshc
> +    enum:
> +      - altr,socfpga-dw-mshc
> +      - img,pistachio-dw-mshc
> +      - snps,dw-mshc
>
>    reg:
>      maxItems: 1
> --
> 2.32.0
>
