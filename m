Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8A47AB38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhLTOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:21:28 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:33378 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhLTOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:21:28 -0500
Received: by mail-ua1-f46.google.com with SMTP id a14so18051194uak.0;
        Mon, 20 Dec 2021 06:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBIOg+699OF2vWA/PGRG8mcPD9eo4a27l9bsWnwdKZk=;
        b=j+BO694ortjTH2+dXjQsgM5YPqNawZzco84DFK6FG/QVWHfoJaE9HkzWFJNbXEDiXC
         YAwhe4kUG9t8p6KXkMeDE8KUQuC+etpDMtZV1kxxWM/xTYE01WlaKVmFcXDzzNxaD8M3
         pDxyI0WXiex0GO/JjMt0ID8EMwVpw587PVuvU+bhRoq9WnqWVl9drSOwFD/X2faV9bu/
         4JurrDyCW5azYCQQP5jlFqwVW7kRGlC9yKJjtZu2dWXjbZFx8yXR4utQdKGKsRpDUzM6
         D7/lr/TtHvr1jU3Y4KM8URZ2VB/URHU3AzFondvx7mtOIxz8zPssOMRlY3Cvzn+AzlpY
         AJ4g==
X-Gm-Message-State: AOAM532aEvyHG2xTNY69QCIHgwhLJACmKLce9FqlBmrlo/qWfsNnhJkT
        reDiKVmDHIefB+cdsfAg5wn/f3sagIMtWQ==
X-Google-Smtp-Source: ABdhPJxwshOqTIxSXjSZNa/PpWXH4C6eDiVXNWtoURsi8/M9fTHyuQC5MiUSE9z1DZSXZBIWr8Jnyw==
X-Received: by 2002:a67:fb8a:: with SMTP id n10mr5124548vsr.6.1640010086997;
        Mon, 20 Dec 2021 06:21:26 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id d124sm112449vkb.9.2021.12.20.06.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:21:26 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id p2so17893452uad.11;
        Mon, 20 Dec 2021 06:21:26 -0800 (PST)
X-Received: by 2002:a67:c81c:: with SMTP id u28mr4281638vsk.38.1640010086188;
 Mon, 20 Dec 2021 06:21:26 -0800 (PST)
MIME-Version: 1.0
References: <d4a00def-7765-e0e4-c5c7-8d648eeb8cf2@omp.ru> <20211214140607.1147976-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211214140607.1147976-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 15:21:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=MytCOsghcH9p1GXOPCO3=1mSF8PKj_UAjYEqAq4-1Q@mail.gmail.com>
Message-ID: <CAMuHMdW=MytCOsghcH9p1GXOPCO3=1mSF8PKj_UAjYEqAq4-1Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Tue, Dec 14, 2021 at 3:06 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> Add the missing lvds0 node for the R-Car M3-W+ SoC.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> @@ -2718,6 +2718,33 @@ du_out_hdmi0: endpoint {
>                                 port@2 {
>                                         reg = <2>;
>                                         du_out_lvds0: endpoint {
> +                                               remote-endpoint = <&lvds0_in>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               lvds0: lvds@feb90000 {
> +                       compatible = "renesas,r8a7796-lvds";

This should be "renesas,r8a77961-lvds".
To handle that, both the DT bindings[1] and the driver[2] should
be updated.

[1] Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
[2] drivers/gpu/drm/rcar-du/rcar_lvds.c

> +                       reg = <0 0xfeb90000 0 0x14>;
> +                       clocks = <&cpg CPG_MOD 727>;
> +                       power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
> +                       resets = <&cpg 727>;
> +                       status = "disabled";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       lvds0_in: endpoint {
> +                                               remote-endpoint = <&du_out_lvds0>;
> +                                       };
> +                               };
> +                               port@1 {
> +                                       reg = <1>;
> +                                       lvds0_out: endpoint {
>                                         };
>                                 };
>                         };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
