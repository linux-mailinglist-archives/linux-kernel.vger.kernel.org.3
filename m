Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF649615F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381344AbiAUOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:45:19 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:42949 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381286AbiAUOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:44:52 -0500
Received: by mail-ua1-f52.google.com with SMTP id p1so17218176uap.9;
        Fri, 21 Jan 2022 06:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cld9dHpqx69KSu6lj47UFuHz9JzDz3so342nqfbgTNw=;
        b=Mi/L6U0nbM3s+ZZGcCnL6Sr9Wmfvk3bzUSH7/kzloW60zawIWZiJE2D+54zkhtJUfp
         YGwqBUU1LU9dt9WW3aQupiZ5VtCZaPz6hCsyXNWckivV19Dtfu9nZ8EBi1MCM+YpZNQT
         YZCiwcOsQFQCGX77aKeNePU8Q7MKONRUol68BBnTVrtH/D33kNKRfk8gpC0xzCON6fdo
         pB6lkA6O9EwZrGxK6Z+x5bTkEOFzJBRlTULz56SqP6a/VoVrWULpITK4D6lZyiTeZvoS
         kEg8zM4QMK8XLXhGB0isT0nFpez/9uit+YyrMV74yepeRcz8gnYg/orYd7Rmp7tL20nH
         9TwA==
X-Gm-Message-State: AOAM530B/+PePTN1awEBg8yz9Qpq84+mtiPUmMG3W3Pm6tiAliSuCbpa
        TKlNSE92oSKgoUBFjx3u17N5oSr8qEnwCQ==
X-Google-Smtp-Source: ABdhPJx4W5ZXCpIcAV8yD2JIC0Rmc7FCxIQXpZ7WgjMnLS5OLAPZZwbb9S31GgufoXRFYSin+YKzcQ==
X-Received: by 2002:ab0:6213:: with SMTP id m19mr1941573uao.92.1642776290950;
        Fri, 21 Jan 2022 06:44:50 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 187sm119045vsi.12.2022.01.21.06.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:44:50 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id b77so5672806vka.11;
        Fri, 21 Jan 2022 06:44:50 -0800 (PST)
X-Received: by 2002:a1f:a2d3:: with SMTP id l202mr1663344vke.7.1642776290471;
 Fri, 21 Jan 2022 06:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:44:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWp_Fv+KQ6LXJrsymVeHbC5BVv0ZaKZ5ppbtd0rmUHw_Q@mail.gmail.com>
Message-ID: <CAMuHMdWp_Fv+KQ6LXJrsymVeHbC5BVv0ZaKZ5ppbtd0rmUHw_Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] dt-bindings: power: renesas,rzg2l-sysc: Document
 RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add DT binding documentation for SYSC controller found on RZ/V2L SoC.
> SYSC controller found on the RZ/V2L SoC is almost identical to one found
> on the RZ/G2L SoC's only difference being that the RZ/V2L has an
> additional register to control the DRP-AI.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
