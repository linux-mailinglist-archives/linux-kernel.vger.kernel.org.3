Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05748EEA3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbiANQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiANQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:45:45 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEDEC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:45:45 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id r15so17966314uao.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBnfwH/s1nckEtFwwtwXrNqBglJnciIYNyoP3vBmMcA=;
        b=pzwJuFX+HKtuEM3O2uSUMWy3ssg3sY0XvaR5uq8tD+I1oYR+tqD1NZEVjA6w21HiUv
         zAJqF6r8tL8KUoxOQ+7aRb8AkFixLGrwTyJWNbC8IFlFzn+Ghq8AymP91Wn3F17zLD5V
         3zG+0tuiZkYHIExXJvYdqvjuWCYMIjA3WhUsG7nFa+Ah1V1ZBnoiFautvzLKfriFOmYq
         3a3Ik2PVPlGSzadMumWRpA6We5mOqtUYlGEfGsN5aMz405ClWxNDF4z3m8O7HbHtihA1
         3FG7rGWYfY8ESkAvrEmyU/9tuijbF6jpOBzzCMeCYco7/DuEi0H3tKGBWAmagmTcLsvf
         RiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBnfwH/s1nckEtFwwtwXrNqBglJnciIYNyoP3vBmMcA=;
        b=y77AscqdHmovuL4UF+UNIXYm6A75Bu7vq89OOJSCHDvTL0UjaFg1hBj0YxvO8lF7a8
         kc93exf/5rmrlSgzDUYKmzfvGKk0AB7WalvYvk8FXBWK7tk/8wAx8iQqOI/G3y+HLIF/
         Ox/0GGLtubT7WxMqEKV+SePK/F/i+BENNhnVIP9shIRZfWwOaDgBaBAaeSJRDQK0OWuc
         YVLMRxWP7boscnILzCAo1d3nl5iI5F/u+uFMHdee1zkHpNfV4rXDDeDNv13/Pm3sfK2o
         mKUMiCM70NAfVDbnntYEqODuNWe0ZFTWC9C8hDMxhk0ieNF8RWBlKTuOaiRyIEmw2456
         waxg==
X-Gm-Message-State: AOAM531v/0CB8ohMyJbVIpQfDceByNy33OJXOFh2paGlMwlUkzRyF9rJ
        t9mHTZ8tuAKBtIJ1Yz5nWDHSI1qTWsavkgiKx3Rxyw==
X-Google-Smtp-Source: ABdhPJxzbfwYXhLllqrfdBNTSZmo9/053hCIb0yZepZ92/AN16+ukkFuVGElSNY083XDNxtnOPe+ngaILZ18SxEfGUE=
X-Received: by 2002:a67:dd90:: with SMTP id i16mr4444764vsk.86.1642178744464;
 Fri, 14 Jan 2022 08:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com> <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 18:45:32 +0200
Message-ID: <CAPLW+4m5+BXD0vDi6YxvE7XYWZ5ej+QdL3OzzSCWG=mqX_sTqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] spi: dt-bindings: samsung: allow controller-data
 to be optional
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 12:13, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The Samsung SoC SPI bindings requires to provide controller-data node
> for each of SPI peripheral device nodes.  Make this controller-data node
> optional, so DTS could be simpler.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml  | 1 +
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml         | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> index aa5a1f48494b..cadc8a5f061f 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> @@ -28,6 +28,7 @@ properties:
>             - 3: 270 degree phase shift sampling.
>          $ref: /schemas/types.yaml#/definitions/uint32
>          enum: [0, 1, 2, 3]
> +        default: 0
>
>      required:
>        - samsung,spi-feedback-delay
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> index da4533feb946..322558818a43 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -75,9 +75,6 @@ patternProperties:
>      allOf:
>        - $ref: spi-peripheral-props.yaml
>
> -    required:
> -      - controller-data
> -
>      unevaluatedProperties: false
>
>  required:
> --
> 2.32.0
>
