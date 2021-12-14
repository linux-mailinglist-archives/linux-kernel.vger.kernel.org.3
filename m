Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94A8474177
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhLNL2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:28:24 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:37474 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhLNL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:28:23 -0500
Received: by mail-ua1-f47.google.com with SMTP id o1so34282939uap.4;
        Tue, 14 Dec 2021 03:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mr8TdcizhXCsrGRXbJsQKCpFm0UTd4VasVtZDIN7EkE=;
        b=iV2qP4ka6Dr6AoRWR8ZoJhVnaIo0TfhPsdpOtditLXLcpkjehOidFWUMkxuAYVNqg5
         pQ6qwE5x2UYTMM8Pew6COcjiZdbqbSqhh06r1RAbjYlViGaiUlkKYsH0bwZ/t/289qHa
         fvEQFyiXHxteKgvN14fqwcj5/i3dJaaT6WluOQudV7cYwN0shumD7s9n1XtE+eBsOez/
         PTxXUDJAfLVPOK0Hw+m9Ft9WZtLhUHMEha7ZOWNPFiPegxLXuJVEritWfIY17m6NObaL
         GaxtYugdFaMll7RmU5UprpYw8zb8jVdVqOzE+L3Iz+zr39bq+1RWbEm0F0yH5rYN5qmA
         Fx+A==
X-Gm-Message-State: AOAM531hZWxw8S79i0vZKXe7ZlUu6yqCxCH1YTQuqemgzFhTbEKNFO7D
        KpELlNAR9GtuYoeBJJrZNLiDKfNbY2pIsw==
X-Google-Smtp-Source: ABdhPJwLp9r5PKsWUIC3l5xYzgNft47bVfR9qaG+JZ4u+4O4DbnPGN1eMIlbaE0WYSdzWxqKRIjDIw==
X-Received: by 2002:a05:6102:3754:: with SMTP id u20mr4147103vst.60.1639481302371;
        Tue, 14 Dec 2021 03:28:22 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id bi35sm4535167vkb.3.2021.12.14.03.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 03:28:22 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a14so34379813uak.0;
        Tue, 14 Dec 2021 03:28:21 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr4066780vsj.77.1639481301659;
 Tue, 14 Dec 2021 03:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20211130164311.2909616-1-kieran.bingham+renesas@ideasonboard.com>
 <20211130164311.2909616-3-kieran.bingham+renesas@ideasonboard.com> <CAMuHMdW81VE=J+ChT5jVMhHmVnMi_eQix7aXjLQPJk+qKp-EdQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW81VE=J+ChT5jVMhHmVnMi_eQix7aXjLQPJk+qKp-EdQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Dec 2021 12:28:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgYybjZDwbVZcfJO5U347H78CQbCz5PvPysR-ZYm=P8g@mail.gmail.com>
Message-ID: <CAMuHMdXgYybjZDwbVZcfJO5U347H78CQbCz5PvPysR-ZYm=P8g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: renesas: r8a779a0: falcon-cpu: Add DSI
 display output
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

On Tue, Dec 14, 2021 at 11:49 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Nov 30, 2021 at 5:43 PM Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com> wrote:
> > Provide the display output using the sn65dsi86 MIPI DSI bridge
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.17.

... using "bridge@2c".

> > --- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
>
> > @@ -146,6 +190,41 @@ &i2c1 {
> >
> >         status = "okay";
> >         clock-frequency = <400000>;
> > +
> > +       sn65dsi86@2c {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
