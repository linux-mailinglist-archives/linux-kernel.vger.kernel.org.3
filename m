Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D909055D8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiF0Hko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiF0Hkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:40:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1D60E0;
        Mon, 27 Jun 2022 00:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61E8CB80F9D;
        Mon, 27 Jun 2022 07:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3166FC341CB;
        Mon, 27 Jun 2022 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656315637;
        bh=MzjeRwNuJsz8lcgalKEQ4uPa0idcPi8oD5nNWGIpJfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VaX5mrEEdE2Z9agLkU0695/N0Do+K7kF7EzotBofAEeAZi3H81+ru7iELCi7+CXud
         I7sc6MspU0l3UFZ6WiWU8Owcp0WOSW2xzI9iypARvXToBYm/vVtpIyJWtiYf2Mru+y
         FwkAxPjXWB1ui6WY2lNeo7CZ3yli2jfGTjOVhR2fZOuqt0nFgyNGNIJSQN3GQRxw1I
         ieVGf6EXs6UgX1ltdxJsmBhvXeUoNUVbQoBIRCsTBqIpxYBI8cmysEiTKfFkrUqkmi
         pVJXRRGBX2OAvkj97g2ROqu5HI59sS5ykPbmuohM1fFANHeS6HmQGfzQuqDm8gZvVu
         A6I7kl8DIplEQ==
Received: by mail-vs1-f44.google.com with SMTP id e7so8125888vsp.13;
        Mon, 27 Jun 2022 00:40:37 -0700 (PDT)
X-Gm-Message-State: AJIora8VZG/2DetFAtOv3Z8Cy95+A9cudWuxyApNewGlJi+PlBUeexk1
        9fVOUXz7bQM3T7S9bvJCsOSZARvMeyhITUi6dq0=
X-Google-Smtp-Source: AGRyM1u9UMEKzaQ6qY0F+LTaZrCPsaY5ETieZQ4tBTTwNl2TC5aylcJ0FKqZSQCmSwgkYlER6Qj74Jpb2RbFugMABwo=
X-Received: by 2002:a05:6102:366f:b0:356:352f:9de2 with SMTP id
 bg15-20020a056102366f00b00356352f9de2mr2343073vsb.2.1656315636148; Mon, 27
 Jun 2022 00:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220627051257.38543-1-samuel@sholland.org> <20220627051257.38543-2-samuel@sholland.org>
In-Reply-To: <20220627051257.38543-2-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Jun 2022 15:40:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSq1NsBWRCg+kpTbJRwSeE30P9NVB5di6vzi7m2CFRzHw@mail.gmail.com>
Message-ID: <CAJF2gTSq1NsBWRCg+kpTbJRwSeE30P9NVB5di6vzi7m2CFRzHw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: interrupt-controller: Require trigger
 type for T-HEAD PLIC
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 1:13 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The RISC-V PLIC specification unfortunately allows PLIC implementations
> to ignore edges seen while an edge-triggered interrupt is being handled:
>
>   Depending on the design of the device and the interrupt handler,
>   in between sending an interrupt request and receiving notice of its
>   handler=E2=80=99s completion, the gateway might either ignore additiona=
l
>   matching edges or increment a counter of pending interrupts.
>
> For PLICs with that misfeature, software needs to know the trigger type
> of each interrupt. This allows it to work around the issue by completing
> edge-triggered interrupts before handling them. Such a workaround is
> required to avoid missing any edges.
>
> The T-HEAD C9xx PLIC is an example of a PLIC with this behavior.
Actually, C9xx support pulse signals which configed by
pad_plic_int_cfg_x for SoC vendor:

https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/=
plic/rtl/plic_int_kid.v
104: assign int_new_pending =3D pad_plic_int_cfg_x ? int_pulse
105:
        : level_int_pending;

They could put pad_plic_int_cfg_x into the SoC software config
registers region or bind them to constant values.

>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  .../sifive,plic-1.0.0.yaml                    | 31 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 27092c6a86c4..3c589cbca851 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -26,9 +26,13 @@ description:
>    with priority below this threshold will not cause the PLIC to raise it=
s
>    interrupt line leading to the context.
>
> -  While the PLIC supports both edge-triggered and level-triggered interr=
upts,
> -  interrupt handlers are oblivious to this distinction and therefore it =
is not
> -  specified in the PLIC device-tree binding.
> +  The PLIC supports both edge-triggered and level-triggered interrupts. =
For
> +  edge-triggered interrupts, the RISC-V PLIC spec allows two responses t=
o edges
> +  seen while an interrupt handler is active; the PLIC may either queue t=
hem or
> +  ignore them. In the first case, handlers are oblivious to the trigger =
type, so
> +  it is not included in the interrupt specifier. In the second case, sof=
tware
> +  needs to know the trigger type, so it can reorder the interrupt flow t=
o avoid
> +  missing interrupts.
>
>    While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>    "sifive,plic-1.0.0" device is a concrete implementation of the PLIC th=
at
> @@ -65,7 +69,8 @@ properties:
>      const: 0
>
>    '#interrupt-cells':
> -    const: 1
> +    minimum: 1
> +    maximum: 2
>
>    interrupt-controller: true
>
> @@ -91,6 +96,24 @@ required:
>    - interrupts-extended
>    - riscv,ndev
>
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - thead,c900-plic
> +
> +    then:
> +      properties:
> +        '#interrupt-cells':
> +          const: 2
> +
> +    else:
> +      properties:
> +        '#interrupt-cells':
> +          const: 1
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.35.1
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
