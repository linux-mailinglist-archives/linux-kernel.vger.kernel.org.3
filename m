Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6621489C37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiAJPaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:30:52 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:33507 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiAJPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:30:51 -0500
Received: by mail-ua1-f42.google.com with SMTP id u6so24181046uaq.0;
        Mon, 10 Jan 2022 07:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2UqV1D5oAGp9ACrvhOukzVBgKhEaSpPUYgqC3435js=;
        b=fgX2thlCBq7dBd8lluRAQj/Kfql9FAhpM7vhMDXmHh8ECvpu4bdzIQwpPhi6543gsW
         FbH6twHr3IM7+l2G3wghKmdatgTVSxa0d8sLgBltcOWO3wFlNd6bwfdUlYqpNy9JzgvP
         Be3iLnSd6Z6cwKqvY+FY4ThR4bjstJjNRUUNW13ytogRDjpi922uAOCUN7Bi1v2bTe7q
         Vtox1xFTeFROK08pTB/mVv4ZE+WroteXI+hXGNKK1hB2yMtfgsJeunQJqBLL5IJMauxV
         aIBv2fF3Zgb1XLA35jBRH3A4NzG2lLvxXa/ichvOBEC537GkjoM/4WFVIBuzlfxsnD4z
         wK2w==
X-Gm-Message-State: AOAM530PL2s1plX/ey37AYs9AP3+/E8aUQ4SkG4MIFpQpXdw5hMZ2JOb
        9NfJJfYbAGr+MOjFvcyt/GDxiydN2MTxPQ==
X-Google-Smtp-Source: ABdhPJxDklepNRYeDC8HsIUbdGj9Nctd7Av7OSoR93UuXHQlZqLqpeRdh0tCDzCFMt145SL0zbS5Dg==
X-Received: by 2002:a67:d207:: with SMTP id y7mr168910vsi.28.1641828649990;
        Mon, 10 Jan 2022 07:30:49 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id k23sm4525405vsm.1.2022.01.10.07.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:30:49 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id y4so24131693uad.1;
        Mon, 10 Jan 2022 07:30:49 -0800 (PST)
X-Received: by 2002:a9f:3e09:: with SMTP id o9mr104524uai.114.1641828648923;
 Mon, 10 Jan 2022 07:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20211222145901.23661-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211222145901.23661-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 16:30:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW6wZLYGttKaSiX_ZknfGrqo5Z6mFBA6ZhqxURtzbaHCw@mail.gmail.com>
Message-ID: <CAMuHMdW6wZLYGttKaSiX_ZknfGrqo5Z6mFBA6ZhqxURtzbaHCw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add
 description for power-source property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 3:59 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add description for "power-source" property mentioning the values in enum
> are in millivolts.
>
> Suggested-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
