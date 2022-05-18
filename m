Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29352B4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiERIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiERIWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:22:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140DA1059D0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:22:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k30so1557418wrd.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trjJ+b0UjHlSF876BjNjmr4z+E9qBj2MQAPe6nMnBlA=;
        b=kFQL87UQWcFbmG99QsHcYpdeBr7/o0aCWLZs4cACELBQusFJkwnRf0pnFO4BDWplkx
         cDH2SaMQtqvmmKd7YarcDr6MKTgLipa+MYrk5MqwCbBnMNf0NtADKSO1xlrn93fWfEL/
         kOPiVL45nY/gbVwf2E1xkzd1+wEqe/kxQhllGmASlFvU84YmE2Hylbv0Gk16JInDXOvT
         cqqGAdCBMYABt4E8pwn6a5vPq5uFMzhvZn8SBBEMtLTWXJxLINkJVYQgvss+bOHe0FgK
         AWYyC7JcIRMSt2qMLbJGKE/3FiNuDammjR3pelAzq11lv/7jtKbhXzmbP7fWxM5jPlte
         zRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trjJ+b0UjHlSF876BjNjmr4z+E9qBj2MQAPe6nMnBlA=;
        b=A7Sgg0N3/bPWr/bvTJWJbZvAlEMjw1cvfr7jcpqGEfIPR7KCD3igSyeCaxeiW0QhwX
         LS3+1nCaPWSZeCYEfmzyDfQVkLAACgvycInaF3wgQTFDHTMsKBi7X/ZZf/QIuFpTMJzw
         pR4myta+tSVi2IOEVwbd/l5APpvmsQdor15WAws1z1pENVbBmgpYv1F/PolR3kpD/uEL
         yzrXmMHjhn+m4dqjbBpbNI5Owf8xXfvFW76idWSseRacLXqR20k5vuFpT83Zz8HLnofg
         Xp5I7tlI2fgkwdsue/ZUvAMM2Wbj2Ywby37kz3e8kj26cuIYID3c+I2Yb/Y9fgA028o/
         2EYw==
X-Gm-Message-State: AOAM531Y53k/Z320s4qz2eM9A08G5mY2L0hVbUt8m9El5S/jptgMWTh5
        FFk8XNikHIoSbiHEhHUnYH1/JIYEFy30/Bsh25OvFg==
X-Google-Smtp-Source: ABdhPJyR3TK3AZ6vFSIVdWlbdx57iSv9BfywlkDpHw7WENtz/yeCErgNkkD7SzI8rPZAtra5UA7HzAA1/Ep30orloL4=
X-Received: by 2002:a5d:618f:0:b0:20c:ffa0:95a8 with SMTP id
 j15-20020a5d618f000000b0020cffa095a8mr15420395wru.306.1652862148610; Wed, 18
 May 2022 01:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220511214132.2281431-1-heiko@sntech.de> <20220511214132.2281431-2-heiko@sntech.de>
 <20220518002529.GA1928329-robh@kernel.org>
In-Reply-To: <20220518002529.GA1928329-robh@kernel.org>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 18 May 2022 10:22:17 +0200
Message-ID: <CAAeLtUBLpDHeJHfPtaUb_OLZb_6cUQa1Z_F+06pkdJMSHtWrfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, krzk+dt@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+David Kruckemyer (who is chairing the CMO task-group within RVI).

On Wed, 18 May 2022 at 02:25, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 11, 2022 at 11:41:30PM +0200, Heiko Stuebner wrote:
> > The Zicbom operates on a block-size defined for the cpu-core,
> > which does not necessarily match other cache-sizes used.
> >
> > So add the necessary property for the system to know the core's
> > block-size.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index d632ac76532e..b179bfd155a3 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -63,6 +63,13 @@ properties:
> >        - riscv,sv48
> >        - riscv,none
> >
> > +  riscv,cbom-block-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Any value 0-2^32 is valid?
>
> > +    description:
> > +      Blocksize in bytes for the Zicbom cache operations. The block
> > +      size is a property of the core itself and does not necessarily
> > +      match other software defined cache sizes.
>
> What about hardware defined cache sizes? I'm scratching my head as to
> what a 'software defined cache size' is.

This seems to be a misnomer, as the specification doesn't use the term
and rather talks about the "size of a cache block for [operation
name]".

There are currently two such 'operation sizes' discoverable by software:
- size of the cache block for management and prefetch instructions
- size of the cache block for zero instructions

For whatever it's worth, cache operations in RISC-V attempt to
disassociate the underlying hardware cache geometry from software.
See https://github.com/riscv/riscv-CMOs/blob/master/specifications/cmobase-v1.0.1.pdf
for the CMO specification, and the discoverable parameters are listed
in section 2.7.

Philipp.

> > +
> >    riscv,isa:
> >      description:
> >        Identifies the specific RISC-V instruction set architecture
> > --
> > 2.35.1
> >
> >
