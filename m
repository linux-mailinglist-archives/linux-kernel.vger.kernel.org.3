Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0422D4692DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhLFJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:43:19 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:36728 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbhLFJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:43:17 -0500
Received: by mail-ua1-f44.google.com with SMTP id r15so18301793uao.3;
        Mon, 06 Dec 2021 01:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAhg71GFQNwi0ZUBWJo8blwwm9Af9BasS8atD8IZ9lg=;
        b=ztnjmzbzQ3wFOqXBWZRVPeH2yRoDIV9MGxlw3tEnBB5P0675Q4zfzvG8bYW3NwcJ95
         F3+8KsbS16ZT4Y26OsSKo6OHA5pwoVjFLi+wzBoh4QhETKWk06MIOefsWoudVbleSlgt
         SgS6cGb9cCEKg/5at/YsnSP3rdUyoT1w5i6q60LLHdTNVlQA7ICHVjxO0CaOfkSqKUaC
         V0WCBL+rs0Io+Wjby9Ex4tQGe4oNKXB7LwooS9TBh7OTVJMBvBjF0ESnNKPIE5nTJzZ9
         SG52YZoWLK7H7bMsP3yfBMcfs88s1evxkqQPNq+m4ngo/5UfcGS9ovW4Q879DiS82Kok
         ViyQ==
X-Gm-Message-State: AOAM533Xh4UbZ6McACoK/xxEieeQxo5R+2GdIzxK479w88D4uqsXdmIJ
        8E+RVQp+4GFjzNTXwSyT60/+m5d/R5J7JA==
X-Google-Smtp-Source: ABdhPJyp2ClAJ/1bSPQ9EJ81ht8ba2ScHTich0tmS9EyaRx2agOKmOzLkowqF8W/Y/djRXTQ3eohEg==
X-Received: by 2002:ab0:6f14:: with SMTP id r20mr39746482uah.22.1638783588338;
        Mon, 06 Dec 2021 01:39:48 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id f132sm3847462vkf.18.2021.12.06.01.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 01:39:47 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id w23so18260894uao.5;
        Mon, 06 Dec 2021 01:39:47 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr34344674vsf.38.1638783586911;
 Mon, 06 Dec 2021 01:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-3-gsomlo@gmail.com>
In-Reply-To: <20211204204121.2367127-3-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 10:39:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUiHtjy6m5xN=ZrhZzetE1S6TWsGM+RSwXs8NXy-ovhQ@mail.gmail.com>
Message-ID: <CAMuHMdVUiHtjy6m5xN=ZrhZzetE1S6TWsGM+RSwXs8NXy-ovhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

(whoops, I did intend to reply to v2, let's duplicate)

On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> LiteSDCard is a small footprint, configurable SDCard core for FPGA
> based system on chips.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/litex,mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LiteX LiteSDCard device
> +
> +maintainers:
> +  - Gabriel Somlo <gsomlo@gmail.com>
> +
> +description: |
> +  LiteSDCard is a small footprint, configurable SDCard core for FPGA based
> +  system on chips.
> +
> +  The hardware source is Open Source and can be found on at
> +  https://github.com/enjoy-digital/litesdcard/.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: litex,mmc
> +
> +  reg:
> +    items:
> +      - description: PHY registers
> +      - description: CORE registers
> +      - description: DMA Reader buffer
> +      - description: DMA Writer buffer
> +      - description: IRQ registers
> +
> +  reg-names:
> +    items:
> +      - const: phy
> +      - const: core
> +      - const: reader
> +      - const: writer
> +      - const: irq
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

reg-names?

(and updating litex/tools/litex_json2dts_linux.py to add it)

> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mmc: mmc@12005000 {
> +        compatible = "litex,mmc";
> +        reg = <0x12005000 0x100>,
> +              <0x12003800 0x100>,
> +              <0x12003000 0x100>,
> +              <0x12004800 0x100>,
> +              <0x12004000 0x100>;
> +        reg-names = "phy", "core", "reader", "writer", "irq";
> +        interrupts = <4>;
> +    };

The rest looks good to me, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
