Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F5496164
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381336AbiAUOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:45:57 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:38812 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381325AbiAUOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:45:10 -0500
Received: by mail-vk1-f176.google.com with SMTP id l196so2790041vki.5;
        Fri, 21 Jan 2022 06:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24WM0Tul0f5zyq1RTlVgJTDmq0d7AJt4lDUplEqd86s=;
        b=AbP1MUUGW8NHGenq7LiR6miCz9TpnfpZUXstR22nhjR9v9BLJV4aHeB1MBBx/Dy+3X
         0VzWkO79oaFxh+tk42QukdSx22sB1m7pPPjZTam+uulkl3d3LwQzq0c0db2y1ZKSQWCU
         fyYDTarqIwZ2m0S+6INnoWq1Mc0JmD6OXd2rWW0Kxn6Oumbhh1LZ2tVfuJn+2BZK9eMw
         WeLJamVYn/A7Agk6b+qD7gAEztQm3GVWXvduPx4q8xEL+iOQB3PSihFAg207FsVs8IeJ
         AMs+VuF/rytZ/3ACiOYcI0ogcrvdJYXGaHiXrrRsKWbCF70QQTV+PNoS5LdgGXAe2NRs
         dUSA==
X-Gm-Message-State: AOAM533QxUcGiNY9HlInlFTepPD7oSCYcFXdbYnC/T3M8y2bdAyujWrm
        PRffSyvs6gIeloD2YQYBTDFvgzyhpd/kdQ==
X-Google-Smtp-Source: ABdhPJwJFPUzvvuvmhWwa5CcUGrztXLbI+TLwiYy55PnaKLpLKYbopzST82JlKGW9wEAi+4b6/gknw==
X-Received: by 2002:a1f:9112:: with SMTP id t18mr1666892vkd.29.1642776309462;
        Fri, 21 Jan 2022 06:45:09 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 63sm1390422vkz.19.2022.01.21.06.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:45:09 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id d189so5705030vkg.3;
        Fri, 21 Jan 2022 06:45:09 -0800 (PST)
X-Received: by 2002:ac5:c967:: with SMTP id t7mr1695715vkm.20.1642776308864;
 Fri, 21 Jan 2022 06:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:44:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUbK4BoYo1+L9DF9f12HSuAjR-wfE5GAi2EfftPnCEknA@mail.gmail.com>
Message-ID: <CAMuHMdUbK4BoYo1+L9DF9f12HSuAjR-wfE5GAi2EfftPnCEknA@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: clock: Add R9A07G054 CPG Clock and
 Reset Definitions
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
> Define RZ/V2L (R9A07G054) Clock Pulse Generator Core Clock and module
> clock outputs, as listed in Table 7.1.4.2 ("Clock List r1.0") and also
> add Reset definitions referring to registers CPG_RST_* in Section 7.2.3
> ("Register configuration") of the RZ/V2L Hardware User's Manual (Rev.1.00,
> Nov.2021).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Before I queue this in renesas-clk-for-v5.18, I'm wondering if you
want to add the DRP_M, DRP_D, and DRP_A core clocks, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
