Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAA567AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiGEX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGEX5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107CE11441;
        Tue,  5 Jul 2022 16:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D5E61055;
        Tue,  5 Jul 2022 23:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F087CC385A5;
        Tue,  5 Jul 2022 23:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657065423;
        bh=2nvroOFqUI72BiyhYxzigV+e1n+0dHSA4SSKeZA4Ue4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uhP6hz2DX02FVZM3f7gAl+vSkcG8c8M3AeCVoM/k23KrVC4/xYv0ZTr5gVN8/T+It
         GLmgfad33KDW1V/ljYrTPSDw368H7b1ty1gnNQoaEk6WS8E6xYwDFSAAMlEi9QvlQl
         4xUQ6WywQn99YzKL0x94cQjTXXjuLf2oIbHRtsBW7PZL/UjKX/RCSJNuBlnh//amnQ
         K9VZWoQ2JPLV7hz5RDrqqPaMSYH0F9vt3AyUfdQtYsiWAb2XeejQyFqLzcPubnAFTo
         MluflRQbkmFLOEUgS5vcC31Ov6MWFQqojGYv8kDuvVM+ujLf+YtFjixdYdz38wSJWT
         ylKGwgNOl2uXw==
Received: by mail-vs1-f54.google.com with SMTP id 185so2423938vse.6;
        Tue, 05 Jul 2022 16:57:02 -0700 (PDT)
X-Gm-Message-State: AJIora/MGbacm0SUMpVBcwv8LDU+bMX0QeCUc3Ab2P75jHpfH84dVSk8
        ScUQwD050oZzl9Wv01hdkV7caEiKIx0bLifWr0o=
X-Google-Smtp-Source: AGRyM1sgnQezK54Hl4ttPtngEG3sziMk9S3QLvNkuhuBCXTRmmT/LuQI/QIb6P7xsrpH3r4NvNK3Dw+Uv3O75LV+f48=
X-Received: by 2002:a05:6102:149c:b0:356:c65d:218c with SMTP id
 d28-20020a056102149c00b00356c65d218cmr6956876vsv.51.1657065421944; Tue, 05
 Jul 2022 16:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220705224703.1571895-1-heiko@sntech.de> <20220705224703.1571895-3-heiko@sntech.de>
In-Reply-To: <20220705224703.1571895-3-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 6 Jul 2022 07:56:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSCpixjAqPROP-vUuTwaiacjPsSQxiiLPi4y=XhXqELxQ@mail.gmail.com>
Message-ID: <CAJF2gTSCpixjAqPROP-vUuTwaiacjPsSQxiiLPi4y=XhXqELxQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: riscv: document cbom-block-size
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Jul 6, 2022 at 6:47 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The Zicbom operates on a block-size defined for the cpu-core,
> which does not necessarily match other cache-sizes used.
>
> So add the necessary property for the system to know the core's
> block-size.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index d632ac76532e..873dd12f6e89 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -63,6 +63,11 @@ properties:
>        - riscv,sv48
>        - riscv,none
>
> +  riscv,cbom-block-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The blocksize in bytes for the Zicbom cache operations.
> +
>    riscv,isa:
>      description:
>        Identifies the specific RISC-V instruction set architecture
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren
