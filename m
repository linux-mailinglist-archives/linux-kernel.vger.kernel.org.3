Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB81526005
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiEMK3K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 06:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379399AbiEMK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:28:51 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FF5DA56;
        Fri, 13 May 2022 03:28:26 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id z144so7886235vsz.13;
        Fri, 13 May 2022 03:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TCFzo+ZD7qnkAFD88dWZtIU33M2yQsfHtS7BKLVGmW0=;
        b=UuBotEAs2UWVU1/qrzd7rqTjYzvvfPbicqppfTYr8dOwrmtbznxGarlLtHX9ZmKGh/
         55oI+9MIJMqOjGrcUxkwqMSRToZQJu8r2Mzlta1jx88W29u2Cj7g4+Hjg7eqCULuHROO
         XazhDMXdn75J8EobM+hxhZBPtPTtzuVRVL8JAQqG7LvYZ6zW4TdZ06FA7Dyq5e/7BoTN
         QChL6WKjdnbFHe4awhv2FIxysK+wz3qBxWIoXDkMaovFTV5WFmoJJa93JztAGLyLyKI4
         Nh4E4936eQgqEqLX8qsZOLm2/4ZZTNg1vIw8eIqrN6VFE/mDfCa11aD6kC9IAuFiOn/K
         Xevg==
X-Gm-Message-State: AOAM530Xt8EXZCVsbP+Fykxvxf821d5jm6DC7cCnXq0Xbspz9aA3HfYW
        yFROjji+9WgzPDjfIbi8JmuZbaQxcATh+5kP
X-Google-Smtp-Source: ABdhPJz4bthGf3rUgg3o7DBLZz3fkspLI9X2QuHnQgVdXjMDUUNhIsBAHdm/y6SpeBzRUmdfqCuaWg==
X-Received: by 2002:a67:b304:0:b0:32c:fb41:9f43 with SMTP id a4-20020a67b304000000b0032cfb419f43mr1969929vsm.83.1652437705237;
        Fri, 13 May 2022 03:28:25 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id u99-20020ab045ec000000b00364e6da2ea5sm300728uau.18.2022.05.13.03.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 03:28:24 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id x5so3029040uap.8;
        Fri, 13 May 2022 03:28:24 -0700 (PDT)
X-Received: by 2002:ab0:6f8f:0:b0:35d:5045:46c4 with SMTP id
 f15-20020ab06f8f000000b0035d504546c4mr1886627uav.116.1652437703966; Fri, 13
 May 2022 03:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220511214132.2281431-1-heiko@sntech.de> <20220511214132.2281431-2-heiko@sntech.de>
 <CAAhSdy2PN8knGzyLadq-aoXVZqN3YASVVu7HxiO3YEb6XyqRxA@mail.gmail.com>
In-Reply-To: <CAAhSdy2PN8knGzyLadq-aoXVZqN3YASVVu7HxiO3YEb6XyqRxA@mail.gmail.com>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <cmuellner@linux.com>
Date:   Fri, 13 May 2022 12:28:12 +0200
X-Gmail-Original-Message-ID: <CAHB2gtTLF7GHsAf=vY6zcGgFzAi7igO0XRRDM0f_Hy7Ubs8piQ@mail.gmail.com>
Message-ID: <CAHB2gtTLF7GHsAf=vY6zcGgFzAi7igO0XRRDM0f_Hy7Ubs8piQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
To:     Anup Patel <anup@brainfault.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup and Heiko,

The CBO specification says:
"""
2.7. Software Discovery
The initial set of CMO extensions requires the following information
to be discovered by software:
• The size of the cache block for management and prefetch instructions
• The size of the cache block for zero instructions
"""

Therefore we should add riscv,cboz-block-size as well, or?
Additionally, should we add riscv,cbop-block-size as well or rename
riscv,cbom-block-size into
riscv,cbom-cbop-block-size to reflect that this size is also used for
prefetch instructions?

BR
Christoph

On Thu, May 12, 2022 at 6:18 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, May 12, 2022 at 3:11 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > The Zicbom operates on a block-size defined for the cpu-core,
> > which does not necessarily match other cache-sizes used.
> >
> > So add the necessary property for the system to know the core's
> > block-size.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> Looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup
>
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
> > +    description:
> > +      Blocksize in bytes for the Zicbom cache operations. The block
> > +      size is a property of the core itself and does not necessarily
> > +      match other software defined cache sizes.
> > +
> >    riscv,isa:
> >      description:
> >        Identifies the specific RISC-V instruction set architecture
> > --
> > 2.35.1
> >
