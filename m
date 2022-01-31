Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60E4A4A91
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379570AbiAaPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:31:00 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:34763 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiAaPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:30:54 -0500
Received: by mail-vk1-f171.google.com with SMTP id j185so8526244vkc.1;
        Mon, 31 Jan 2022 07:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAWG/l3ekRgpKht+VfFNmypV20iM/aAG8gzSJ21Vw4g=;
        b=G6sLuoGthRvKa5jPYi9lGih9Sj0+PPFQ7Si8qda8P0gQH1JIYx4YCUj+NtZ18NObJP
         8ERp1L4Jxal1r+AURswN6sq0w8wNjKZmw4JUrDjoKaI1N2/WRDlpNk1bu5AdtiMQszIF
         PgFrcrBJZt6I95N3WWEHCLfVk5jPz0PoCIap3xmHNJR/VUrPW+GrQ2SlmA5Gf+co48MO
         LsNHhB8QJuAjFRJcwDbewqK+QzLeEpbXQos0sd8yfztxxpuUkeM8AftRVx3zl7TIbT7R
         rQkQh+dCwwMgO7DJYQ3GJobFl1UgpIpygJGRQWaRphz8FtTuVJx02m3KPuTChImB2dgH
         vwng==
X-Gm-Message-State: AOAM530mq5PGXQ+8vXT3gZRHRzmrKMXQko4qzVdMm941iumFhXeFaXd6
        DAFF7QESlZxtn9R8vUs5nhsF4RXoFSnDEQ==
X-Google-Smtp-Source: ABdhPJzHWcZgI0Ah+frrpZ7H207ng1zEDGjQFkBkSF1l3NMSHg0ExDLzXDLJ0dPlWYalkxARHyoRRg==
X-Received: by 2002:a1f:3049:: with SMTP id w70mr8204182vkw.41.1643643053408;
        Mon, 31 Jan 2022 07:30:53 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id d19sm3299217vsh.18.2022.01.31.07.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 07:30:52 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id a19so12257952vsi.2;
        Mon, 31 Jan 2022 07:30:52 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr7571030vse.38.1643643052446;
 Mon, 31 Jan 2022 07:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20220126211003.6675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220126211003.6675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 Jan 2022 16:30:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRHvcLj-EwRUb3v2ZC8yWCmhbbAwknCyHf3j8AJUJE+w@mail.gmail.com>
Message-ID: <CAMuHMdWRHvcLj-EwRUb3v2ZC8yWCmhbbAwknCyHf3j8AJUJE+w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: clock: Add R9A07G054 CPG Clock and Reset Definitions
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:10 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Define RZ/V2L (R9A07G054) Clock Pulse Generator Core Clock and module
> clock outputs, as listed in Table 7.1.4.2 ("Clock List r1.0") and also
> add Reset definitions referring to registers CPG_RST_* in Section 7.2.3
> ("Register configuration") of the RZ/V2L Hardware User's Manual (Rev.1.00,
> Nov.2021).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Hi All,
>
> This patch is from series [0]. Just re-sending this patch as
> rest are queued.
>
> v2->v3:
> * Added DRP core clocks
> * Included RB and ACK

Thanks for the update!
Will queue in a branch shared by DT and clock driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
