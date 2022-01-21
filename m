Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4949617F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350944AbiAUOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:46:58 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:34660 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381244AbiAUOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:46:52 -0500
Received: by mail-ua1-f54.google.com with SMTP id y4so17319370uad.1;
        Fri, 21 Jan 2022 06:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRy1UB9/9Iwbc25L4bNSi6Y5S8XfK2Sd+ZFrIqKOmtE=;
        b=4oopF8NQ3TeEWjK8JMjXvvsy8fuwYbkZuqE+ekjLh/dKfn3jEF196iYLX+bf50dLPW
         aFdjPFpy8c0iDfh6II9CVNX1UBk7TFARnCt6rsn9dwfpShO6/N/aF999AEQLsxJkilJ3
         t1hpvOEEszMLuRefQHNMD33SkX9UljWqSORmJtkNRs1SN1qo0vY+AHC6vW8Nm2oN/EmA
         gj3nA9lt7DEYK/ytLJMsp+spx1LG6zAOaSFj9tw9YvCJNnK1TeO+nK/gnh44lBRfD4uJ
         /N0jbLObJFsCTR1F32keRT9FQA0K8X3Pzgs4Zg/27fkz/ahRY+H36VQVmMecrBro2ZVh
         x66w==
X-Gm-Message-State: AOAM531IfVc12hgEw6EVrW4iZu/9TKPIytq9thyH77qridc5b3lsZSDQ
        2QhupgRhbI7WZ9YTOBzJbgU2/SOceLvtRA==
X-Google-Smtp-Source: ABdhPJxvHyG186HFgZyxXjCOjK/9Tvso3j71149vyGxgbqHEEnzYMCCIiCU6nGKPQ5TYZ4tavN+oTg==
X-Received: by 2002:ab0:6cae:: with SMTP id j14mr1779899uaa.131.1642776411119;
        Fri, 21 Jan 2022 06:46:51 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id z10sm1548386uap.14.2022.01.21.06.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:46:50 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id x33so17204865uad.12;
        Fri, 21 Jan 2022 06:46:50 -0800 (PST)
X-Received: by 2002:a67:e905:: with SMTP id c5mr1902705vso.68.1642776410392;
 Fri, 21 Jan 2022 06:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:46:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVrJ++Tm4D6a=c-mEagK5RvgwjZSrDcPdPtoRH0NhyKkQ@mail.gmail.com>
Message-ID: <CAMuHMdVrJ++Tm4D6a=c-mEagK5RvgwjZSrDcPdPtoRH0NhyKkQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] arm64: dts: renesas: Add initial DTSI for RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
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

Hi Prabhakar, Biju,

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RZ/V2L is package- and pin-compatible with the RZ/G2L. The only
> difference being the RZ/V2L SoC has additional DRP-AI IP (AI
> accelerator).
>
> Add initial DTSI for RZ/V2L SoC with below SoC specific dtsi files for
> supporting single core and dual core devices.
>
> r9a07g054l1.dtsi => RZ/V2L R9A07G054L1 SoC specific parts
> r9a07g054l2.dtsi => RZ/V2L R9A07G054L2 SoC specific parts
>
> Both RZ/G2L and RZ/V2L SMARC EVK SoM  are identical apart from SoC's
> used hence the common dtsi files (rzg2l-smarc*.dtsi) are share between
> RZ/G2L and RZ/V2L SMARC EVK. Place holders are added in device nodes to
> avoid compilation errors for the devices which have not been enabled yet
> on RZ/V2L SoC.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> +               pinctrl: pin-controller@11030000 {

pinctrl@

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
