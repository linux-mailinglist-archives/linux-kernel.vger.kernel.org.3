Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23042496182
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351189AbiAUOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:47:06 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:41685 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351153AbiAUOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:47:01 -0500
Received: by mail-vk1-f173.google.com with SMTP id y192so2304114vkc.8;
        Fri, 21 Jan 2022 06:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMw8Yeuv31UE/VDaXo04Ok4usnmtOwsikwoUJMB8Gy8=;
        b=vkC8S1nJdcUKfrlE/7V+1w/5i9dKQdEog8aKqoExVk+L/VMZkBRtTF57oC3GwvlQXL
         198e71lqNFclnU0YkWGPr0oJ+OaML4Vt9SpzmG8z1geEylAuCcsT93btPPaM83z3r3cL
         R5K7tkmboFLNcJ4Z2DybOLeuxLK2hqGVMbmfIb34mRvcqNJbTVLT+QVisg1AExXRl1pG
         LohpT8leBmZd7aUtr0esa0wN4pZ0N97kR8PrQIhgjP0ubFFnkO2tfNE2lGoZSLE/hrx5
         nT13sGS3TMIJWkR/nH//R5MtGNi/1OcsA15MGbUmqB38s+Ii0N8buFTGNyjMdflXN8Z7
         7O4Q==
X-Gm-Message-State: AOAM532xxV2wtU8bgw3EH3krL2cHSh4r83eBfIoGVoF+k43XsVU9/1u5
        pp2XtGsQMl/6lYb2Vr7g2Mo56EF36fKOOQ==
X-Google-Smtp-Source: ABdhPJyuuZzt62z2NeZB5FKuwBG3ZJTWV3OMyoxmxiDlIGD0XNE78b8IF4HYaMFdYSjiwNGUatCnVw==
X-Received: by 2002:a05:6122:1690:: with SMTP id 16mr1673287vkl.40.1642776420963;
        Fri, 21 Jan 2022 06:47:00 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id p2sm1536971uao.1.2022.01.21.06.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:47:00 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id f24so17198583uab.11;
        Fri, 21 Jan 2022 06:47:00 -0800 (PST)
X-Received: by 2002:a67:e055:: with SMTP id n21mr1812366vsl.57.1642776420432;
 Fri, 21 Jan 2022 06:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:46:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVs3hmp2cOsux+XFvhH=ddbaZjhsQaviDdBC81zcEWpw@mail.gmail.com>
Message-ID: <CAMuHMdXVs3hmp2cOsux+XFvhH=ddbaZjhsQaviDdBC81zcEWpw@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] arm64: dts: renesas: Add initial device tree for
 RZ/V2L SMARC EVK
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

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add basic support for RZ/V2L SMARC EVK (based on R9A07G054L2):
> - memory
> - External input clock
> - CPG
> - Pin controller
> - SCIF
> - GbEthernet
> - Audio Clock
>
> It shares the same carrier board with RZ/G2L with the same pin mapping.
> Delete the gpio-hog nodes from pinctrl as this will be added later when
> the functionality has been tested.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
