Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A737464E73
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbhLANIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:08:30 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:39659 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhLANI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:08:26 -0500
Received: by mail-vk1-f177.google.com with SMTP id 84so16032419vkc.6;
        Wed, 01 Dec 2021 05:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSCANc5akMVyARPAGU2DAriDgbQMxgmWTdFVSgsUOA4=;
        b=TiDmxyrjuuJUZ6U815+QoUFbOixl8UJt/4YlSu0alkhZ8CbaS9FPZjMvIJF29CRqA/
         u3UtRVxxDOMAu4zeWMEqI5lmsl8JLln2Q6Mjv0FbvqsZiqFYd4O3elIlDXYTRwjzvfHN
         51nlrValFNAHsnHY9tngyE97II3hhg4qiQbuYcX5zWlaDDVZnpAW6GSunf3jxxXPKm4l
         13lpEaPNbpXrUDcp8X/y3lAuDmi7LkwRCLiCmmZFzVWHTIr9eU9zitKTt/VYJxx8iDd/
         R/KlFSovnNSi0dIIMcAPO/8tjotBP+1RiWDHIHS5IH7+Ccl0uKx2tLNdMjg/57URuEpr
         22eA==
X-Gm-Message-State: AOAM531oESAG0RbRgWbsfa59hgsAfh/gNU0M7gQxJGubIZ2zlHJsW3Yh
        A+j6MNrP60cRLE33esnlrgdN7lwDvzvl1Q==
X-Google-Smtp-Source: ABdhPJzPxPmlSSLGPOF1dc/lppCsx+DKKnHvZO4roiWaVzoXO60uk3/UVUpfzekAdXeKV7ems1E1Fw==
X-Received: by 2002:a1f:c9c2:: with SMTP id z185mr7880917vkf.26.1638363904846;
        Wed, 01 Dec 2021 05:05:04 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id g16sm11970987vsp.18.2021.12.01.05.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 05:05:04 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id p2so48691436uad.11;
        Wed, 01 Dec 2021 05:05:04 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr6795674vst.5.1638363904281;
 Wed, 01 Dec 2021 05:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20211130164558.85584-1-tsbogend@alpha.franken.de> <20211130164558.85584-2-tsbogend@alpha.franken.de>
In-Reply-To: <20211130164558.85584-2-tsbogend@alpha.franken.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Dec 2021 14:04:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUO-99bQPdLoLSPzDZ1KzT1_rS6eXEejEH4tf+XAtCgvw@mail.gmail.com>
Message-ID: <CAMuHMdUO-99bQPdLoLSPzDZ1KzT1_rS6eXEejEH4tf+XAtCgvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: TXX9: Remove rbtx4939 board support
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 5:46 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> No active MIPS user own this board, so let's remove it.
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

My rbtx4927 still works fine afterwards, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
