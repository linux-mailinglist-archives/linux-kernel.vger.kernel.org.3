Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4098A49F5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbiA1JG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiA1JGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:06:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1149AC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:06:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so5076186wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6wIAYdGWZvgUsjPei+YbgKLlhX+BWcT4ZFFreUIf/o=;
        b=e73sSH1LXzCPedGG67Np0Stuh7FrNuD36SgjCIgJXn6tMAZP2RLyxpZ5numftYWMkn
         uUzxnPg8OT4ngevlyyJYj2XknPGqVKMYKBEtLa5Zc1qziBiUF3qPs7+sEiljmCKDxlvX
         v3D2EBhTMdw2JLJ1bdrtvFib+Cykh4rvp5b1zCbQzjgz4z2MjEzlUNP8MyHhkc64rC5O
         fj2p1owTF9KfsHFMViYbftU7c5/Ztvu0X0PHXW03QxyysfL3PaFxlGTQbx//YBCzdJux
         aCjfVRw5TADT5hyTzV2vsieM9Bm2AiKFR7EI33AWwGTHDQ6nRNwsEQ9LP5xc/F/B1972
         sUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6wIAYdGWZvgUsjPei+YbgKLlhX+BWcT4ZFFreUIf/o=;
        b=oukL+rgcj1b+eykuaYgMVuYjylEDcDIal+LGDFl4Mf+hYaTQEsHxK52oAJFNt0ouh7
         jj+l5M5EviqHhQAFEeOJuAZr8o+LUT9T5jshKYt25RIx+cUDRmlnjT7SpJcEmGns8e+L
         NPhamtF8K2LscW8Ky61IAJXA0dPYCklTPW3mK8y8uR4TJuNR4eDXa1hAWLTgdBYLywIa
         Z1ABw+vvEIkKpycu80Vlc+rvwswwo95BAF9Q5KBoRPvSKBjU7rCzdaqnwBzwtQCeUxyH
         /iQds3Bbur9LpgxFebcRTikpHSJwJN0HekumhfJrqxzJWhta5xxPR4DcZZATpCyDo4mF
         UPFQ==
X-Gm-Message-State: AOAM532IdLpKVJx6MIxMKZC1eEoE6aq8s95pDQCqB1CiZolawv6d4TAL
        9z63C3X5LFCEeDi70s7+yG4XRUJjsVHLfphi28MH5Q==
X-Google-Smtp-Source: ABdhPJwPIrr2gE94yvvHvP7GvT3Wa+RsEPzFUqQsChCTORUdOrGaMkrRfg9l3aIgiVlBuFYisnhQExd2es0kZuE0U8M=
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr6622486wmj.59.1643360809397;
 Fri, 28 Jan 2022 01:06:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643360419.git.geert@linux-m68k.org> <211705e74a2ce77de43d036c5dea032484119bf7.1643360419.git.geert@linux-m68k.org>
In-Reply-To: <211705e74a2ce77de43d036c5dea032484119bf7.1643360419.git.geert@linux-m68k.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 28 Jan 2022 14:36:38 +0530
Message-ID: <CAAhSdy1VfWaSxPb0kLFtxz4acX6fBOuZ=7y7QRiGp0SydqD6ZA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: interrupt-controller: sifive,plic:
 Group interrupt tuples
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:34 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> To improve human readability and enable automatic validation, the tuples
> in "interrupts-extended" properties should be grouped using angle
> brackets.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> v4:
>   - No changes,
>
> v3:
>   - Add Reviewed-by,
>
> v2:
>   - Split in two patches.
> ---
>  .../interrupt-controller/sifive,plic-1.0.0.yaml       | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 57c06126c99502fa..0dfa6b26e09910a8 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -91,12 +91,11 @@ examples:
>        #interrupt-cells = <1>;
>        compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
>        interrupt-controller;
> -      interrupts-extended = <
> -        &cpu0_intc 11
> -        &cpu1_intc 11 &cpu1_intc 9
> -        &cpu2_intc 11 &cpu2_intc 9
> -        &cpu3_intc 11 &cpu3_intc 9
> -        &cpu4_intc 11 &cpu4_intc 9>;
> +      interrupts-extended = <&cpu0_intc 11>,
> +                            <&cpu1_intc 11>, <&cpu1_intc 9>,
> +                            <&cpu2_intc 11>, <&cpu2_intc 9>,
> +                            <&cpu3_intc 11>, <&cpu3_intc 9>,
> +                            <&cpu4_intc 11>, <&cpu4_intc 9>;
>        reg = <0xc000000 0x4000000>;
>        riscv,ndev = <10>;
>      };
> --
> 2.25.1
>
