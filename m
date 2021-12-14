Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BF47409D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhLNKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:41:31 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:41927 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhLNKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:41:28 -0500
Received: by mail-ua1-f50.google.com with SMTP id p37so34055135uae.8;
        Tue, 14 Dec 2021 02:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjahYurnjZXl2YAUO9JQ6AYI06sAOFdZUDV4b2nECo0=;
        b=WzASmSvyMRZCB3mNIgkpD6rSPYOgZTciAXfw15JIH0OPiocEYl8gn4Ql2BS2p0R7Kk
         o7xH/LiflwABnGXLmXnzZxbwbpj9BJbQvxJ7yuHz7WUYw+VhK4XmMf5nxPfTgtAv8lgD
         JW/fSk7VFZBgq/yurM8nK/DB9yBhAWAK7W3tIIr6McgzVDEmnxcmhcB162zdaPuOMOHK
         S1b7swpruqlHyRpbcMV7PMOu5inm2aerMKEev3MBmw+4yxl3dFgznxqRvGySTgsLtKkL
         t/jv2zIU6yRtG4PHBjbIAEi/AmTy1mXZPakV4TMC+5o164g6FU+vxhgEVCA/O7gUyyBt
         /lSQ==
X-Gm-Message-State: AOAM531hUNX3TnhSPuXxjzWPEMCh9xDjMNgik9HAkJHvWWYWWquS8gLV
        IYFMdQugYkva09Kxr+XM9dfzAyH+1w76zQ==
X-Google-Smtp-Source: ABdhPJx0jcVwbIYsV4K+HY6g84d4/ECDG93to9knUpAipKc6SJgYBZq+uTu2CfzYDQuOhyR1XEO43A==
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr3977549vsf.38.1639478487883;
        Tue, 14 Dec 2021 02:41:27 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id o7sm4503584vkl.41.2021.12.14.02.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 02:41:27 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id f7so12189553vkf.10;
        Tue, 14 Dec 2021 02:41:27 -0800 (PST)
X-Received: by 2002:a05:6122:2193:: with SMTP id j19mr4107170vkd.7.1639478487115;
 Tue, 14 Dec 2021 02:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com> <20211130164311.2909616-2-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20211130164311.2909616-2-kieran.bingham+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Dec 2021 11:41:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXT-SSqtx=_DT0J0Yus-WSPsYv2GOtehjGq2KbWQHbA5Q@mail.gmail.com>
Message-ID: <CAMuHMdXT-SSqtx=_DT0J0Yus-WSPsYv2GOtehjGq2KbWQHbA5Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: renesas: r8a779a0: Add DSI encoders
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Tue, Nov 30, 2021 at 5:43 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
> Provide the two MIPI DSI encoders on the V3U and connect them to the DU
> accordingly.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> @@ -2290,12 +2290,14 @@ ports {
>                                 port@0 {
>                                         reg = <0>;
>                                         du_out_dsi0: endpoint {
> +                                               remote-endpoint = <&dsi0_in>;
>                                         };
>                                 };
>
>                                 port@1 {
>                                         reg = <1>;
>                                         du_out_dsi1: endpoint {
> +                                               remote-endpoint = <&dsi1_in>;
>                                         };
>                                 };
>                         };
> @@ -2633,6 +2635,64 @@ isp3vin31: endpoint {
>                         };
>                 };
>
> +               dsi0: dsi-encoder@fed80000 {
> +                       compatible = "renesas,r8a779a0-dsi-csi2-tx";
> +                       reg = <0 0xfed80000 0 0x10000>;
> +                       power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
> +                       clocks = <&cpg CPG_MOD 415>,
> +                                <&cpg CPG_CORE R8A779A0_CLK_DSI>,
> +                                <&cpg CPG_CORE R8A779A0_CLK_CL16MCK>;
> +                       clock-names = "fck", "dsi", "pll";
> +
> +                       resets = <&cpg 415>;
> +                       status = "disabled";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       dsi0_in: endpoint {
> +                                               remote-endpoint = <&du_out_dsi0>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                               };
> +                       };
> +               };
> +
> +               dsi1: dsi-encoder@fed90000 {
> +                       compatible = "renesas,r8a779a0-dsi-csi2-tx";
> +                       reg = <0 0xfed90000 0 0x10000>;
> +                       power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
> +                       clocks = <&cpg CPG_MOD 415>,

416?

> +                                <&cpg CPG_CORE R8A779A0_CLK_DSI>,
> +                                <&cpg CPG_CORE R8A779A0_CLK_CL16MCK>;
> +                       clock-names = "fck", "dsi", "pll";
> +
> +                       resets = <&cpg 416>;

That one is OK.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.17 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
