Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182B34635FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbhK3OFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:05:45 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:33761 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbhK3OFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:05:42 -0500
Received: by mail-ua1-f50.google.com with SMTP id a14so41647426uak.0;
        Tue, 30 Nov 2021 06:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YELocWE3VFiRMQlYvTN83nPr/FHXo//o82fezKUForE=;
        b=UfWY023/n8H0HZ16tdeOt3X2RE0aNjVWWOOqVjNBxYsN98xgO7q5FHCrBfqFtwvW0/
         deKg+IJA5Oe8YX9MufdRlV+zwilW8e8wbg2JBlSx4dcXu29mLSsA+Tkq9smBbYjIONKZ
         0+2LDY2kwDfMhHukOy1JevwwvLVfFlVzk8vhf6zLaAOxeh310x312msBCeQtVnwjiCwL
         g9o8oLWw9yb2OeQdy4QgghdaRR8h0wQMDHSLIJq6Uvgvq9xdnNlLpPn8qezOoAgB65qT
         uGOCfEpjc7R9bDMlwKx+xXQ+vUl/vZxBb/2Smc/UcU4v+ppsa+ylDIYVjgaJ00qGzADI
         JReA==
X-Gm-Message-State: AOAM5327EnXbwb9wDY3vSwa1mVCtMHApy+R5i0uEz3+7u7UaMGVlAJK4
        Csb+opPJkviFnZdrM9psBvdJTJGzRpzwIQ==
X-Google-Smtp-Source: ABdhPJwYHnbS5LSEmkNcXcoRZ+3UkInyd4SG56VbyOEe6cjdOCC0GdafmNzTTwDSPsnl44j16KZxjQ==
X-Received: by 2002:a05:6102:cd3:: with SMTP id g19mr40537614vst.14.1638280943133;
        Tue, 30 Nov 2021 06:02:23 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id r20sm9969015vkq.15.2021.11.30.06.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 06:02:22 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id o1so41578188uap.4;
        Tue, 30 Nov 2021 06:02:22 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr18445880vsg.57.1638280941859;
 Tue, 30 Nov 2021 06:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com> <20211116100818.1615762-2-horatiu.vultur@microchip.com>
In-Reply-To: <20211116100818.1615762-2-horatiu.vultur@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 15:02:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkr3n-m8dadyzb=s7F9ns6PXMLgOkZaG=XTYNKnaaORg@mail.gmail.com>
Message-ID: <CAMuHMdUkr3n-m8dadyzb=s7F9ns6PXMLgOkZaG=XTYNKnaaORg@mail.gmail.com>
Subject: Re: [PATCH resend v4 1/3] dt-bindings: phy: Add lan966x-serdes binding
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, Vinod <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-phy@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatio,

On Tue, Nov 16, 2021 at 11:16 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
> Document the lan966x ethernet serdes phy driver bindings.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Thanks for your patch, which is now commit fd66e57e46a3d1b7
("dt-bindings: phy: Add lan966x-serdes binding") in phy/next.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml

> +examples:
> +  - |
> +    serdes: serdes@e2004010 {
> +      compatible = "microchip,lan966x-serdes";
> +      reg = <0xe202c000 0x9c>, <0xe2004010 0x4>;
> +      #phy-cells = <2>;
> +    };

So this overlaps with the switch registers, cfr.
Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
in net-next/master?

    switch: switch@e0000000 {
      compatible = "microchip,lan966x-switch";
      reg =  <0xe0000000 0x0100000>,
             <0xe2000000 0x0800000>;
      ...
    };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
