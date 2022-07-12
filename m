Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81037571E58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiGLPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiGLPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:07:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AFFC5946;
        Tue, 12 Jul 2022 08:01:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so8283746pjl.4;
        Tue, 12 Jul 2022 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j10ZK7k9+wF3AscGA6+W1rhOqE5GdVtkwRkExfLXfZ4=;
        b=WeoWE9V9PYJdymyMogplFBkFW4R+6l9/9KvDaMhkpHhFUAdCLABYlaekMAM+pRaEF9
         Xe3A+kOfie5snVOrc4wi9nG4QufoAoiD822nU75R8rMmqX73bFMzPOaFKp82PK9clU8M
         ITpMWG+vYJwCiY2Gq+xdrL6QavZuiudT2XvqU+Go0LHfqyW7kKJiHBMnv3XVdoqi+bVf
         O2BJuoC1iCcLSpE5mMk/8Wc2Sl7Wbq9QvpevZBmRZf8CYASUpHS7X02jmO9qixqgUMmt
         Mm5fXRENwfVpXROW9rsKDQcm65DhUFHb3H7z8CnSWqODy6T2SJMqRgVi1TMFmonZxHvh
         ymDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j10ZK7k9+wF3AscGA6+W1rhOqE5GdVtkwRkExfLXfZ4=;
        b=QvWTGSIR3Ths+NLsxrMLqjx9Jcs6wqc3MyOfaSrAZjOE7X/GtF0rNiq4Lhw1ADFZ/B
         S6O8FZWmPJA8VMt8tGpGuiq/G3OUIoNpH78Ys4wHpJG3JRe8OpxZf8A6jEoWxoq4PBD5
         Rd9SESXCTwleuleneH58UvaJVsjmvNtHt74nicBIp2IKQO+e5TROhFEES4yAX3z48LcY
         5Lr8rMNuHWiNR3m+UVoJR/K3qBTqIto34v+0eOjFLFKuBh6WgtHBJgQ8qQquO0bX1/SE
         d/wqogGd7MB16QRLpkVhE9U+OfwwNCIxdbQSXpihIkMWDhzib7kMrWtQqr6HxiBCNlSJ
         HrRw==
X-Gm-Message-State: AJIora+ArsWNf+7EEEzmfT//H+9NHqr1d0N7HVFMFEyTfh6a11aTNU47
        vRvyzDjCuKws5LuZoVYEhsjUgmLWM6rWlcoGK18=
X-Google-Smtp-Source: AGRyM1tN7SRJdAb69G47W1dJ+dAaV/v0vDfzIyKkOIwse6mSLgMHdIi43XV7cMpjHY2T0qz2ZkWd72NcfPHzal4/3lA=
X-Received: by 2002:a17:902:cecb:b0:16c:40a8:88ff with SMTP id
 d11-20020a170902cecb00b0016c40a888ffmr13155485plg.33.1657638077402; Tue, 12
 Jul 2022 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220712142040.12021-1-v.v.mitrofanov@yadro.com>
In-Reply-To: <20220712142040.12021-1-v.v.mitrofanov@yadro.com>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Tue, 12 Jul 2022 17:01:06 +0200
Message-ID: <CANBLGcwXLNpbmCaqvBWbZLZ2-n4B+dJkStTKcrxsyvjHO756QA@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: fu740: Add PDMA node
To:     Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Cc:     linux@yadro.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>, Zong Li <zong.li@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viacheslav,

Thanks for your patch! I have a comment below.

On Tue, 12 Jul 2022 at 16:22, Viacheslav Mitrofanov
<v.v.mitrofanov@yadro.com> wrote:
>
> HiFive unmatched supports PDMA but is not implemented in DT.
>
> Add the PDMA node in SiFive FU740 soc-specific DT file.
>
> Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
> ---
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> index 7b77c13496d8..4bd670d8632f 100644
> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -161,6 +161,14 @@ prci: clock-controller@10000000 {
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
>                 };
> +               dma: dma-controller@3000000 {
> +                       compatible = "sifive,pdma0";

I think this should be

compatible = "sifive,fu740-c000-pdma", "sifive,pdma0";

..but before adding that you'll also need a separate patch to

Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

..adding the new compatible string. Otherwise this will complain

make ARCH=riscv
DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
dtbs_check

/Emil
> +                       reg = <0x0 0x3000000 0x0 0x8000>;
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <11 12 13 14 15 16 17 18>;
> +                       dma-channels = <4>;
> +                       #dma-cells = <1>;
> +               };
>                 uart0: serial@10010000 {
>                         compatible = "sifive,fu740-c000-uart", "sifive,uart0";
>                         reg = <0x0 0x10010000 0x0 0x1000>;
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
