Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917344692D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbhLFJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:41:52 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:45011 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbhLFJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:41:48 -0500
Received: by mail-ua1-f52.google.com with SMTP id p2so18231395uad.11;
        Mon, 06 Dec 2021 01:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3aBhkJuL60X71ytHG2A/Q8fBCQllX3/UcSSYzbfqHw=;
        b=PFpzxVuVy/yZML8NYnagsBQg6k/IARj2abNTOaCP/O7EqPzA/1TJEGa3Gr0OTYpDqh
         1RMzW6vCk0wpH8gV0Hp2guxtYfPh8Zu71ua5uyhb5UH6THFT6wQmMf5Va6s6+X1klk6a
         qJSOlfheV73NBcTVhy9pSLcmGTLcGYEKdMuIkBOIi+/aZF9im7FWlgn8IQcO1nxoNzc7
         AysWAQ5UKSk0/2MwBJcPmw6dPIO2bsI6dXmKYltctGSe0hgZRAABOZgbmNBxKdWPtnOU
         1nOInbE5XVgrwAunptDbuEjwxlU6to3yu3vDXrxOli3hOfdDKlxmrcWE5YyTGtdQ3swG
         mBkw==
X-Gm-Message-State: AOAM5318mj74Eki5GL5gZp+HrVXIiApIDkfdJV0+zTdyd0dyujz0GmvZ
        acoyBJH9lAeHR3gvm9eegQ7r3y/qLsbx8A==
X-Google-Smtp-Source: ABdhPJyomUfZBGPBVTNYctX7PE8XsPJSGOvqPmYF2T+MjDuW7kuO9tjSukB8Qpl3VEflIpV+KG/lzA==
X-Received: by 2002:a05:6102:374a:: with SMTP id u10mr35191988vst.74.1638783499362;
        Mon, 06 Dec 2021 01:38:19 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id bl34sm3547525vsb.31.2021.12.06.01.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 01:38:19 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id m19so6290917vko.12;
        Mon, 06 Dec 2021 01:38:18 -0800 (PST)
X-Received: by 2002:a05:6122:920:: with SMTP id j32mr41469902vka.20.1638783498399;
 Mon, 06 Dec 2021 01:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20211203234155.2319803-1-gsomlo@gmail.com> <20211203234155.2319803-3-gsomlo@gmail.com>
In-Reply-To: <20211203234155.2319803-3-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 10:38:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7ZVpStBeS3eqFaHmyv+KoVmddn8DNTMqOoTxe61xf6Q@mail.gmail.com>
Message-ID: <CAMuHMdU7ZVpStBeS3eqFaHmyv+KoVmddn8DNTMqOoTxe61xf6Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
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
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Sat, Dec 4, 2021 at 12:42 AM Gabriel Somlo <gsomlo@gmail.com> wrote:
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

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
