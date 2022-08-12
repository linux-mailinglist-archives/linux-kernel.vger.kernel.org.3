Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC29590DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiHLIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbiHLIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:48:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C3A9249;
        Fri, 12 Aug 2022 01:48:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o15so466631yba.10;
        Fri, 12 Aug 2022 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4I92zgcv4n8w6lK9XsPEI5EU0ua+RWFqnkrokUkZU2w=;
        b=H3f2qqlsaamrBpS5t6cnxf3Eh7Iq3XUFK/xRzSB98BuNIGIq3D3nh8HXa8Uu+VjfGv
         QS17G6MWk7DP+zcm3T3Z6w04NqiBVSJE/8+n+4pu5s1linOMO1wViTis/drCBVSvLJ/e
         T89uTOpf3HBo56BhcjmLRP4Fmr+Sl9xzM95bdLL69iuVMvmNLVmuVRC7JrVWOZ3PuMCL
         jz62zPMegSjZCze0BtEV0kfA7+4VHfAdUKRt30nq8u+JivsL6SChPlnNT0nNv5HqqfsL
         SjhMN7jP4AEAotWzPMdcV87j66bOfzEGJXIcvrMuW6Ux5Ze3aad69R5F1MXdJRNygP3/
         7P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4I92zgcv4n8w6lK9XsPEI5EU0ua+RWFqnkrokUkZU2w=;
        b=hTIp0CcheGsGH/SU/ZH6Xv8GcoN8VsFuaMBQ1Ne6Tuwf13iX9YtfbL9VY5TaSn/sqW
         22bHobzmCL2a8Q0GtwchoviMLydzBVtk+OUWr3RrPReN3iLbpnwC8yRBtom02KwkSIaA
         28sc6WTjdkVOtuxPZvY2kiD+Wtf6OsljfeJDljzMF2Wsy8SAnw6o6Quan5o/yMs4QNsb
         guINUkSVRM18yufxpZWALwM4DtG8bF6i8dD7qqG6tGDecf4D+XJGQmCTkVySZQamyr3u
         rlZz657M+NlTg/IyAni2d8xfJvVTy0NN7E77+zNyKAwICweVI0MnEtKnq0WzO5/zxyK0
         Ohvw==
X-Gm-Message-State: ACgBeo2hQKutyinX4SWqVV7+VFG6qeVrAeVcyKBdT3qZcUbV3TiFUFFO
        3tGUgzbc59gfy3LNrqH8zDSEZMYV9Ptk+KWXrRY=
X-Google-Smtp-Source: AA6agR7/vJuDkmtonOa8FQfnIkjYadN9f5zG+FYERnqxpM99984CpFK8fa4djMvczhY5Z0pz+WsE7bcob0ars2CKzOc=
X-Received: by 2002:a25:4689:0:b0:671:6d4f:c974 with SMTP id
 t131-20020a254689000000b006716d4fc974mr2643125yba.354.1660294098593; Fri, 12
 Aug 2022 01:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220727153738.GA2696116-robh@kernel.org>
In-Reply-To: <20220727153738.GA2696116-robh@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 12 Aug 2022 09:47:50 +0100
Message-ID: <CA+V-a8t2LJ1qSsJWK4S-434cLfp0AuqkSKLjk7VgtwrMrNr2SA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas,rzg2l: Document RZ/Five SoC
To:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Rob,

Thank you for the review.

On Wed, Jul 27, 2022 at 4:37 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 26, 2022 at 06:45:25PM +0100, Lad Prabhakar wrote:
> > The CPG block on the RZ/Five SoC is almost identical to one found on the
> > RZ/G2UL SoC. "renesas,r9a07g043-cpg" compatible string will be used on
> > the RZ/Five SoC so to make this clear, update the comment to include
> > RZ/Five SoC.
>
> It's either the same part or it isn't. 'almost identical' doesn't sound
> like the former. Unless it's the former, it's a nak for me.
>
It's the latter.

> Litering the drivers with #ifdef CONFIG_ARM64/CONFIG_RISCV is not great
> either. That's not great for compile coverage and they have nothing to
> do with the architecture.
>
Geert any thoughts?

Cheers,
Prabhakar

> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Note the driver changes [0] have been already queued for v5.20.
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> > 20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > ---
> >  Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> > index d036675e0779..487f74cdc749 100644
> > --- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> > +++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> > @@ -24,7 +24,7 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > -      - renesas,r9a07g043-cpg # RZ/G2UL{Type-1,Type-2}
> > +      - renesas,r9a07g043-cpg # RZ/G2UL{Type-1,Type-2} and RZ/Five
> >        - renesas,r9a07g044-cpg # RZ/G2{L,LC}
> >        - renesas,r9a07g054-cpg # RZ/V2L
> >        - renesas,r9a09g011-cpg # RZ/V2M
> > --
> > 2.17.1
> >
> >
