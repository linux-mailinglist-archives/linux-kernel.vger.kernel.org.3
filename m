Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4EA5825BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiG0LjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiG0LjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:39:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B744AD51;
        Wed, 27 Jul 2022 04:38:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j195so10385222ybj.11;
        Wed, 27 Jul 2022 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUe3ZPHnv3mne953AtKNlkKN9ecK/p0RKLrloPpqCts=;
        b=K1YSA94w7f1jm0mGfMBGTj4RDOeDsH5BdZYnKdj+ltvE01uB52qrkFVPQswgNq/6/f
         MNUEbKdU6xkDgPDPLA81boaWlH4bnwjhdQQ5xAIt2g1/tuenHsM8TSSKYjjun4bFEeys
         XldrNCP4c32arY7cDQFRNmTu0CL9PAkzjLHXcaUVoSNXh6lk7T0oUdfMrRpRaEIWe8Rj
         WhzFHunzCcgQ8+v2QYKyYHHqFT0NNAG1FqCP5SWKOm+M9MHFGaTkT7MKSBibE1Gnzawi
         BihjbXPoXNMA4vNyb6g3RyotpVNoT6lQJivBdjz1E+oDJQpAEHkRfddQNSPyQIb5Tf8z
         3CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUe3ZPHnv3mne953AtKNlkKN9ecK/p0RKLrloPpqCts=;
        b=fmUtoePimh6ifQwB5LGjGVUms0BDs2Ei0tXDf6xKeTkDC4OKxu4D40a6ptM/SSAPrh
         mTqgMpnZMCWqVM7gRtw5OR6Brc28N4vGQYvRg9O9ixZ+EZ77w9SlKC9ukhvCfhLGHhar
         zT8adWZUkqN2uo3DtE4l4QfeeX+jgY/JEMD01OfSWOEmFqon3Qoamf3aB/mvlPkxIKD9
         J53M2uNwisUffrYdrDIGscsehM9CEiPsSEDzCqubq0J25cx0V93buQRC71F3AC8dcB/u
         xpXKN7mXFx11v44+Gxv2EYpLE5d7WX2wm2KSfzz7NFeL3BVtT6ofi5aJREAnyqh3Dcss
         FfGA==
X-Gm-Message-State: AJIora94uCcuxOjkfctWuyu4f8hY4jO525TYZnyXVXgEexJWwuGL/XGU
        g68XQXBbjIwOc8xsN9lauT/JCuC+9QzY+iz8d3s=
X-Google-Smtp-Source: AGRyM1vbDxpZI15cnPe+RYbwuyh4ob36FZL9kr7Whb06GU0opVS/mtU/X897buqVar2JA+fAkDH7xA5y7j2o5CywCXU=
X-Received: by 2002:a25:bd83:0:b0:670:fc70:67f3 with SMTP id
 f3-20020a25bd83000000b00670fc7067f3mr16485485ybh.244.1658921897467; Wed, 27
 Jul 2022 04:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org> <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org> <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org>
In-Reply-To: <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 12:37:50 +0100
Message-ID: <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
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

On Wed, Jul 27, 2022 at 11:09 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/07/2022 12:06, Lad, Prabhakar wrote:
> > Hi Krzysztof,
> >
> > On Wed, Jul 27, 2022 at 10:54 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 27/07/2022 11:05, Lad, Prabhakar wrote:
> >>> Hi Krzysztof,
> >>>
> >>> Thank you for the review.
> >>>
> >>> On Wed, Jul 27, 2022 at 9:54 AM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 26/07/2022 20:06, Lad Prabhakar wrote:
> >>>>> Document Renesas RZ/Five (R9A07G043) SoC and SMARC EVK based on this SoC.
> >>>>>
> >>>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>>> ---
> >>>>>  .../devicetree/bindings/riscv/renesas.yaml    | 49 +++++++++++++++++++
> >>>>>  1 file changed, 49 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/riscv/renesas.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/riscv/renesas.yaml b/Documentation/devicetree/bindings/riscv/renesas.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..f72f8aea6a82
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/riscv/renesas.yaml
> >>>>> @@ -0,0 +1,49 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/riscv/renesas.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: Renesas RZ/Five Platform Device Tree Bindings
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> >>>>> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>>> +
> >>>>> +# We want to ignore this schema if the board is SMARC EVK based on ARM64 arch
> >>>>> +select:
> >>>>> +  not:
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        contains:
> >>>>> +          items:
> >>>>
> >>>> I think you should rather ignore the RiscV SoCs, not specific board.
> >>>>
> >>> You mean to ignore ARM/64 SoCs?
> >>>
> >>> Agreed just the below enum, should do the trick.
> >>>
> >>>             - enum:
> >>>                 - renesas,r9a07g043u11
> >>>                 - renesas,r9a07g043u12
> >>>                 - renesas,r9a07g044c1
> >>>                 - renesas,r9a07g044c2
> >>>                 - renesas,r9a07g044l1
> >>>                 - renesas,r9a07g044l2
> >>>                 - renesas,r9a07g054l1
> >>>                 - renesas,r9a07g054l2
> >>>
> >>>
> >>>>> +            - const: renesas,smarc-evk
> >>>>> +            - enum:
> >>>>> +                - renesas,r9a07g043u11
> >>>>> +                - renesas,r9a07g043u12
> >>>>> +                - renesas,r9a07g044c1
> >>>>> +                - renesas,r9a07g044c2
> >>>>> +                - renesas,r9a07g044l1
> >>>>> +                - renesas,r9a07g044l2
> >>>>> +                - renesas,r9a07g054l1
> >>>>> +                - renesas,r9a07g054l2
> >>>>> +            - enum:
> >>>>> +                - renesas,r9a07g043
> >>>>> +                - renesas,r9a07g044
> >>>>> +                - renesas,r9a07g054
> >>>>
> >>>> Did you actually test that it works and properly matches?
> >>>>
> >>> Yes I have run the dtbs_check and dt_binding _check for ARM64 and
> >>> RISC-V. Do you see any cases where it can fail?
> >>
> >>
> >> Just remove the renesas,smarc-evk2 from
> >> arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts. Do you see the
> >> error? Not from this schema. The only error you will see is that no
> >> matching schema was found.
> >>
> > I did run the dtbs_check test as per your suggestion (below is the
> > log) and didn't see "no matching schema error"
> >
>
> So you do not see any errors at all. Then it does not work, does it?
>
Right I reverted my changes I can see it complaining, dtb_check seems
to have returned false positive in my case.

What approach would you suggest to ignore the schema here?

Cheers,
Prabhakar
