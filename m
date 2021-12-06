Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E1469348
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhLFKWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:22:00 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:45916 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhLFKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:21:59 -0500
Received: by mail-ua1-f52.google.com with SMTP id ay21so18389258uab.12;
        Mon, 06 Dec 2021 02:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwAgXDu/myPtDCkFFbm/cuoauOx3eqHkpUmLfJ+J7Jc=;
        b=McK2eajd1be2FIkzQ/kGImT1SZMIVRTCew6sPKeF/GBHrB0JVLHh+usUaa+WU3rO0P
         x2olZfvueyczy3aspo05HvsX0GKOZJkne77v/uJAOf6iv4wuocO6nfmMkxdFSdkZDQKq
         P8dCTPw2BBSr2j3MjCjB/6oIHVl7Gikzy+azqQoZfFLYapLc5dyChE4oo1LDC2RC3/jR
         NdspxP9QoI7/0T2tiS9oQcSa8VMmPpeMkWWzREOaEMgdEWIFVYTJqHRd+i3xntaB4FpO
         q1UPksrpOilRQt8J4WYf6j/nK8CrmLwkb90L05rOMHyEQ/vAKPWndnmi4TIWsgsfjU0v
         zW5g==
X-Gm-Message-State: AOAM531hOu9nQfo+GqHfdbZNsyj/aAVyZaDiIf51oB7dvmV4boYqwToo
        cxvrnEL+lFF9ryZltnFUwRR3ymgxTZ1/yQ==
X-Google-Smtp-Source: ABdhPJysQ0gJLLeyQpz9gEF3R/n6I/O5rrXlsDDc7gVoAUjhAbCnCClESWxNO/ZwyUvPXrx0XazCcg==
X-Received: by 2002:ab0:70ce:: with SMTP id r14mr38517726ual.76.1638785910382;
        Mon, 06 Dec 2021 02:18:30 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id b13sm3913524vkn.38.2021.12.06.02.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 02:18:30 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id l24so18510231uak.2;
        Mon, 06 Dec 2021 02:18:29 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr33884840vst.5.1638785909754;
 Mon, 06 Dec 2021 02:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-3-gsomlo@gmail.com>
In-Reply-To: <20211204204121.2367127-3-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 11:18:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJZp+YuaDnXabOgeTajNo0JA9nwCmkiTg2=69L9-6-ew@mail.gmail.com>
Message-ID: <CAMuHMdVJZp+YuaDnXabOgeTajNo0JA9nwCmkiTg2=69L9-6-ew@mail.gmail.com>
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

On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> LiteSDCard is a small footprint, configurable SDCard core for FPGA
> based system on chips.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

And after reviewing the driver...

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

The last one is optional...

> +
> +  reg-names:
> +    items:
> +      - const: phy
> +      - const: core
> +      - const: reader
> +      - const: writer
> +      - const: irq

Likewise.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

reg-names, as the driver needs it (and it's good practice anyway).

> +  - interrupts

Interrupts is optional.

I tried to link it to reg{,-names}:

    if:
      not:
        required:
          - interrupts
    then:
      properties:
        reg:
          maxItems: 4
        reg-names:
          maxItems: 4

but that doesn't seem to work. Anyone with a clue?

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
> --
> 2.31.1
>


-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
