Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBD5822B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiG0JGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiG0JGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4C1474ED;
        Wed, 27 Jul 2022 02:06:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z132so10371839yba.3;
        Wed, 27 Jul 2022 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVtZIwcu07JXR0+8xN/nQ/0RqGwtHXT7p6Ok3vBeYZE=;
        b=ZWqbYH4Scf7v0uPK5nBhI+Oi2aGMD3geeu+RxWWfYOXlH233jnt/MhtON9mgnkNPJ8
         6ASkPkPzx9T4XCRpBU4dfQfAwQ8QUbQgPkk4EYRT0FR3+xAI7fi8WsZqVSR/HQUjFpD+
         45rkjW8YLxnp4INk5NmrDVeL7osGrneXlYxnSb+Yz0G0q3DWwVQr77QSpWWNIRjDkdlg
         FtxTn4NGkfcH+d8cQ4VFkyrGGtlohUQwGzDu27uTyzhzk/eBetVM6Dg9boxyEcUtHkmz
         Ax9VJZbcH7ZK6WV6wWnOPnjSvPvX9iocq148gy1lgQCZIMr57pRH1usjDQ2kobJ2rbHE
         BtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVtZIwcu07JXR0+8xN/nQ/0RqGwtHXT7p6Ok3vBeYZE=;
        b=yE6zXk6zaGXWBRZG9UaxJQuk4Jpph/bqXQONq9egj41viwoRp1YXg9GCUUD07y/rRE
         FVKoqWv2rT8v6EloE9+sNQSBke6OwUt3s3V3lRXikFOjM6GXZFXDK8e7QdyyfWm8d94l
         6Webt5RrSgygrJLVNCWIWzCKZhvWPISWAjPwALrLm5H9dzwBNyz7gGnGxOPkF6xIKLfX
         WPR/SylcXJZQgogtpQWs9/eTO6t3ZNS5J5wuXRv71tDi5N6PwUJkB1jhjmnHk7JArurB
         wryRzPPSs0VC9rdQS/odDIppxQTBlriw9b13KjyTh27fKu07a3ZU0Sac1oGlpIKCP3e8
         9Q0g==
X-Gm-Message-State: AJIora+LC0QoiJjVMe46Rcgre8YMljySipqCNGumABXeMBZuSERRlE4l
        QGbcFGgUTnSF2NzTP1g9jel7yc70npb3PBDuY80=
X-Google-Smtp-Source: AGRyM1vMDtzNnEM6xTH8HaoM2lTtPMXOMKIaKhZ65B7NZ920zrB5f8/tgkkYAAYImsgLC6OF2gaBWwRSwVR8dhHF0+M=
X-Received: by 2002:a25:4689:0:b0:671:6d4f:c974 with SMTP id
 t131-20020a254689000000b006716d4fc974mr6910885yba.354.1658912769970; Wed, 27
 Jul 2022 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
In-Reply-To: <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 10:05:43 +0100
Message-ID: <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
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

Thank you for the review.

On Wed, Jul 27, 2022 at 9:54 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/07/2022 20:06, Lad Prabhakar wrote:
> > Document Renesas RZ/Five (R9A07G043) SoC and SMARC EVK based on this SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/riscv/renesas.yaml    | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/renesas.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/renesas.yaml b/Documentation/devicetree/bindings/riscv/renesas.yaml
> > new file mode 100644
> > index 000000000000..f72f8aea6a82
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/renesas.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/renesas.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/Five Platform Device Tree Bindings
> > +
> > +maintainers:
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +# We want to ignore this schema if the board is SMARC EVK based on ARM64 arch
> > +select:
> > +  not:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          items:
>
> I think you should rather ignore the RiscV SoCs, not specific board.
>
You mean to ignore ARM/64 SoCs?

Agreed just the below enum, should do the trick.

            - enum:
                - renesas,r9a07g043u11
                - renesas,r9a07g043u12
                - renesas,r9a07g044c1
                - renesas,r9a07g044c2
                - renesas,r9a07g044l1
                - renesas,r9a07g044l2
                - renesas,r9a07g054l1
                - renesas,r9a07g054l2


> > +            - const: renesas,smarc-evk
> > +            - enum:
> > +                - renesas,r9a07g043u11
> > +                - renesas,r9a07g043u12
> > +                - renesas,r9a07g044c1
> > +                - renesas,r9a07g044c2
> > +                - renesas,r9a07g044l1
> > +                - renesas,r9a07g044l2
> > +                - renesas,r9a07g054l1
> > +                - renesas,r9a07g054l2
> > +            - enum:
> > +                - renesas,r9a07g043
> > +                - renesas,r9a07g044
> > +                - renesas,r9a07g054
>
> Did you actually test that it works and properly matches?
>
Yes I have run the dtbs_check and dt_binding _check for ARM64 and
RISC-V. Do you see any cases where it can fail?

Cheers,
Prabhakar
