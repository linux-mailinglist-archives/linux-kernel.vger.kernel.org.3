Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAA496160
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350983AbiAUOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:45:30 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:45603 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381244AbiAUOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:44:59 -0500
Received: by mail-ua1-f46.google.com with SMTP id x33so17195305uad.12;
        Fri, 21 Jan 2022 06:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ek291EdLzSzjT6UYBAct8ileqftHZanUd/HSlY26Gg=;
        b=cUNZVILcA8RzBZoujkUMc1BlI+hIgTXRPUunZA15g9FGF/nGsMKAI8my5o0/vp4PJ+
         NYvbZ+6TaxIiRzW9XM5U1HNC9FJ2del+pl5qnSB16HseIDxP4XVHzvchMVRY9rXDky1u
         jSV3CV7qObWbIUnteBXrajl8WO1XRrJ5iZhVy0w0JCIu59XCuDjoN2A0Yv3Yi9BUrQHi
         J1+46p64//XIhvcjlepHs2QYzzbZbGQAr+0lyLZfhMOOPJ9D2QtKfPS4uka52FTGqxOu
         NGqZ8kR/0Ia7q17HUrMYmk8+DEO2rwMD+GsR1gryWIaok+mZat2WATsLhWYlXWtvZaXH
         Wd0g==
X-Gm-Message-State: AOAM530m+mQ5zsncHOvd8LDBRg7FQxZ52XuFmOuY38LguL22Y0UAs6Xg
        lyrYKFebx4lis11/PeM6dJfo6u9dzVSKZQ==
X-Google-Smtp-Source: ABdhPJyPYV4bg2cUCRArEGJOOFPXanzwH/ce88MWgfTu5imMFseYVE0lxWLomQ6LHmcTeoJ+T3R8nQ==
X-Received: by 2002:a67:c005:: with SMTP id v5mr1788537vsi.71.1642776297975;
        Fri, 21 Jan 2022 06:44:57 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id m25sm61194uaq.3.2022.01.21.06.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:44:57 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id l1so15402929uap.8;
        Fri, 21 Jan 2022 06:44:57 -0800 (PST)
X-Received: by 2002:a67:e055:: with SMTP id n21mr1808484vsl.57.1642776297488;
 Fri, 21 Jan 2022 06:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:44:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQ5h8J=ir+3pi2inm8n5AVMNVC1SbAGWSOQhVfijbXtQ@mail.gmail.com>
Message-ID: <CAMuHMdVQ5h8J=ir+3pi2inm8n5AVMNVC1SbAGWSOQhVfijbXtQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] soc: renesas: Identify RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add support for identifying the RZ/V2L (R9A07G054) SoC.
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
