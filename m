Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5412E461FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhK2TG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:06:56 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:45943 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhK2TEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:04:52 -0500
Received: by mail-ua1-f54.google.com with SMTP id ay21so36201738uab.12;
        Mon, 29 Nov 2021 11:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DL5dHDq+6bog8OFr5QHKjlV1I5gK3strUsZva+R3K6w=;
        b=8F0sNFZjtUIa0P0KhmoaQNQDywkJiFbcS/k0w6r+K5zWfrDDLYnG3ud4u7RU8FMTN9
         pOT7Jor4zE83j7c1mcAaw3uiEICFMLF3didj3ABHFN7dcBUIKSv+x7Il2yUHXwrkVIIl
         T1+l4Kn27zcrUUw5mXBX2DEwk38Se7rJmgMAZr71j3HEY5j1qgBad9BkJQaOKRFZIiZ4
         xpbr9V1ObhJy8kACZUcFMhp8/Yq/xZeAIBQlJ5UsZo0dRCKSLDRIk7HRXFmI1TLjMyY9
         gYu5o+UpGJZfuprZSO5WAbcLUH3fNDBRsNKCLxw4dicfh26MUC2giga6RC0To9JexqRw
         qveQ==
X-Gm-Message-State: AOAM531qvTZ7jpfgfUJKor4sbh+xTyB6KdnSliMObazPbnoV1gkoZGXo
        smw5a6t+9Y8CDuJXluw1Cke2Wxb/0biunQ==
X-Google-Smtp-Source: ABdhPJy4MLnyGTwTUqQPCikXF5cDPiLm3oOBwujCki9DlxUqb2r+ctP5pOO4HWAS6BbS1DX/e2XGtQ==
X-Received: by 2002:a67:6187:: with SMTP id v129mr35003172vsb.68.1638212493960;
        Mon, 29 Nov 2021 11:01:33 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id u145sm9480402vsu.25.2021.11.29.11.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 11:01:33 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id w23so36235130uao.5;
        Mon, 29 Nov 2021 11:01:33 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr52068214uai.89.1638212493421;
 Mon, 29 Nov 2021 11:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
 <20211129122052.GA7921@alpha.franken.de> <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
 <20211129130535.GA8644@alpha.franken.de>
In-Reply-To: <20211129130535.GA8644@alpha.franken.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Nov 2021 20:01:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU94tk5pcTK4Fa-g9vm56oooCeWXkkL8nOgofk5aKbwig@mail.gmail.com>
Message-ID: <CAMuHMdU94tk5pcTK4Fa-g9vm56oooCeWXkkL8nOgofk5aKbwig@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software nodes
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Nov 29, 2021 at 2:33 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> On Mon, Nov 29, 2021 at 01:30:17PM +0100, Geert Uytterhoeven wrote:
> > BTW, I'm using it in 32-bit mode, as the VxWorks bootloader cannot boot
> > 64-bit images. Are there other boards with such a limitation? Perhaps
> > there's even shim support for booting 64-bit kernels on such boards,
> > so I can test both 32-bit and 64-bit kernels?
>
> maybe BOOT_ELF32 could help here.

Yes it does, thanks a lot for the suggestion! Patch sent.

Took me a bit to test proper operation, as contemporary cross-toolchains
create userland binaries that can no longer run on MIPS-II/III CPUs,
and native development is slow and memory-constrained (dpkg OOM)...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
