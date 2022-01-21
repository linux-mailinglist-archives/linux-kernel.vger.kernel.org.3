Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9039C495809
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378379AbiAUB6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbiAUB6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:58:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C85C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:58:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m3so28759241lfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UldeKnr9PGsHDm84/QvQaIofT9QuBopddvadaSRieY=;
        b=SJG97pub7A4eya4kCKHOmmqrelrMniQ/VP8wnpQf7tPxCcgyptuQO+LEhUDNd5ccRJ
         Vw4hs5mU3pQBXq5kLDfsV7lUA0n2XRt67LaihqJy19vYW0NXn3pd9u6F6Td+FFo3MoVp
         tpF9t43jtpsS0yoXIpDM9HODwYAs6YC8JEOATJyeJT6D6jYmUu96AjGlix7AGfnY6d1K
         k2wFRbCjLRIwhfNbjD2TBCvdDdFWqGyeFJMtYET7KwpI7zVCTwojm2VxKTinw/jRtYht
         PAVqpmMTtVk+8BDmbdX5y7NXjMSLIaC4tDQMTDPewWqF7yVTF9QtIjRnZMp4ZITiJbHy
         UzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UldeKnr9PGsHDm84/QvQaIofT9QuBopddvadaSRieY=;
        b=P9bbxnpLohhR07PogOnKeP9xfxWZfE3aDQbcPhQ4/qZtSW8h+RMzi96+xdgMus3KDa
         0tjL+es8gxH1HnhL4ZP3mIqTbBGlkx4lN4VRYbiG9OkZPB8AjkqDdQAEepSRDWPPrXVn
         VP4o6I9SNuMovt7TUcS43UyUUBqc6nyJxo9kTb35ahVqCu8TNyXJHw0QdgcGAkY01KEv
         XZJJDhgi1uVLs7LYK4DYXZQCp0BfteNeLzowDmQfKtJ7n5iclKkuFJFsJzzt3td4wT/f
         CbDSAYM/YQwGpJ1ktdwfGwvguh2YqQUrN0nRYWYdRPVHw0fXFl2VlpUCfrRna5NpQ21N
         NOXg==
X-Gm-Message-State: AOAM5320nAZthbV/9XvUTHuxDrj5SmRjTo/F2y2VuIHOb89S/hYHycLL
        BrZXjy4uDCoPVFZBmdPReEKoE90CEavubuaEq46odA==
X-Google-Smtp-Source: ABdhPJxSDXdkiBVnafLq8QOd3wg3RcHUJ9cAed5T94EdWRYG+0qGg5gqguJOGXbjy+s9xjqMZmi40VDbu7CUgLuii/Y=
X-Received: by 2002:a2e:a90c:: with SMTP id j12mr1559970ljq.71.1642730286659;
 Thu, 20 Jan 2022 17:58:06 -0800 (PST)
MIME-Version: 1.0
References: <5db314b798cd9cfcb5cb61bc56515220b7d50315.1642383007.git.zong.li@sifive.com>
 <mhng-e5e649a2-96bf-4244-a29a-a75c913111a2@palmer-ri-x1c9>
In-Reply-To: <mhng-e5e649a2-96bf-4244-a29a-a75c913111a2@palmer-ri-x1c9>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 21 Jan 2022 09:57:55 +0800
Message-ID: <CANXhq0o_d58cx7L_cUQMUYALwBbY7DKm3agT9+LM8Lt8KYaMnQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: Add dma-channels for pdma device node
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 2:51 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sun, 16 Jan 2022 17:35:27 PST (-0800), zong.li@sifive.com wrote:
> > Add dma-channels property, then we can determine how many channels there
> > by device tree, rather than statically defines it in PDMA driver
>
> Maybe "statically defining it" is better here?
>

Thanks for the correction, I would modify it in the next version.

> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml    | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > index d32a71b975fe..3dbb8caefc17 100644
> > --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > @@ -34,6 +34,12 @@ properties:
> >      minItems: 1
> >      maxItems: 8
> >
> > +  dma-channels:
> > +    description: For backwards-compatible, the default value is 4
>
> Maybe "backwards-compatibility" is better here?

Thanks, let me change it in the next version together.

>
> > +    minimum: 1
> > +    maximum: 4
> > +    default: 4
> > +
> >    '#dma-cells':
> >      const: 1
> >
> > @@ -50,6 +56,7 @@ examples:
> >      dma@3000000 {
> >        compatible = "sifive,fu540-c000-pdma";
>
> IMO we should have a "sifive,pdma-1.0.0" (or whatever the versioning
> scheme ended up being) here, in addition to the SOC-specific DT entry.
> It's kind of odd to start extending the SOC-specific DT entry, as the
> whole idea there is to let us have an out in case we find future
> compatibility issues.

yes, I notice that we usually have a entry with the version in other
device nodes, such as "sifive,xxx0", I guess we should have a
"sifive,pdma0" there, thanks for your advice, let me add it and use it
in match table of pdma driver in the next version.

>
> >        reg = <0x3000000 0x8000>;
> > +      dma-channels = <4>;
> >        interrupts = <23 24 25 26 27 28 29 30>;
> >        #dma-cells = <1>;
> >      };
