Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4D4F1376
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355773AbiDDK4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358571AbiDDK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:56:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A27340F5;
        Mon,  4 Apr 2022 03:54:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 125so10680845iov.10;
        Mon, 04 Apr 2022 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rE17aokLscUeZldWdcl+4+hAX8YeB4QD9pUd4GrjIM=;
        b=TtY+/cMcXBcL8IdYOINrQltPY2JNCPfd2Awm3ZptGepcymCrJ3HbII3+X/9Ys3fHuv
         4iCZx4zOnwwrvLnGrZ3sSBV5UeUQRXeGFGiaYmn9YqpxCGlzhG1eRkzW0TxfS5Jm/hM4
         zINrPwRZM7x3FcLUgaHacw3Oz4YJWellZsVpIAyIq8BUnJbGlyraFuEymXpU7UfYdD7r
         +ZDMMIurR+tpkRsVxx2Vac/rQeWxgpYJJTomab6ShmerwgPvcH57JqOw+IjympgRYdgr
         eUsU/pdzW9runBz+psuMNZO6RCjSu8ygZaeOOqn/wggHyW8mamGNKvJKczPXMDuKt85v
         5+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rE17aokLscUeZldWdcl+4+hAX8YeB4QD9pUd4GrjIM=;
        b=T+juA9+3w+B/+jy0r6FLVis5Ix5XPDD1XZMfH1EHRJ8j6JovhLZgflObaL4vRhplpj
         72lVKLMaqfRNNOGyH1vRYwTBTOamoAMKBJE3yki89UHzTAF3v510tJ5Joh3KDE1R0nTG
         QcvOom7m/DNjzv7OOynJw8FTV22bUwPTHfOKA8JCS4aoYyrRnB4JbR42287jxGkPDtOj
         JyqBnb4FZe11S/mwtInGgPyBD+cwBJyGP8KPXbE9h2zeSKeWhesOMpyqXXOOdKY7DPWX
         wmCNfJ5YOwvumomyTADnPgAyp6HfPyhN54giL2LfmulaZLXmraGeG63uS4+qofv/7GsN
         tW+A==
X-Gm-Message-State: AOAM530HjYKChTfOyvEA2qkxO878hy8ab6Kujs+5aacIByEyzl61mxdw
        7F2DVvXd2Lhtkp1fAQIq//ga0fWaZWsvaXJCdm4=
X-Google-Smtp-Source: ABdhPJy6dWkX7SvStDXsR6rYoheGmMRXvU/7VnD9jCFC5zDIQw6Mmc9tyZgib54eWMjb5UYf/h7INW0fl0bt4WedkxE=
X-Received: by 2002:a05:6638:d16:b0:323:63cd:c144 with SMTP id
 q22-20020a0566380d1600b0032363cdc144mr11635735jaj.76.1649069668361; Mon, 04
 Apr 2022 03:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220404040153.1509966-1-gch981213@gmail.com> <20220404040153.1509966-3-gch981213@gmail.com>
 <20220404095937.20089db7@xps13> <CAJsYDVK6ya7FR90CtAjbpbF-_+c0GVnsKsN=1wYaoBFx=ysUtQ@mail.gmail.com>
 <20220404122824.63a1c857@xps13>
In-Reply-To: <20220404122824.63a1c857@xps13>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 4 Apr 2022 18:54:17 +0800
Message-ID: <CAJsYDVJXH0MUB2wPydzqFgF8Y82HsUY7FLu1duCOCyVO-oXZqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] spi: add driver for MTK SPI NAND Flash Interface
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Apr 4, 2022 at 6:28 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> [...]
> > > > +
> > > > +     // This driver ignores any ECC capability configured by user or
> > > > +     // requested by the nand chip because the BootROM and MTK bootloader
> > > > +     // expects the page format to be the exact one as calculated in
> > > > +     // setup_pagefmt.
> > >
> > > I don't like this :)
> > >
> > > I understand that the boot partition might have specific constraints,
> > > but other partitions (or if we don't use the NAND to boot?) should
> > > probably be usable with other ECC schemes.
> >
> > In this controller, the ECC step size is fixed and it can only change
> > ECC strength.
>
> That's fine.
>
> > The calculated ECC correction capability is the max
> > possible one supported by the controller.
> > I still want the default behavior to match the boot partition
> > requirement,
>
> That is okay, but that does not mean you can only support this one.
>
> > because we can't just tell end-users to customize
> > their dts by taking apart their device and figure out which flash
> > is used.
>
> They don't have to do so. In theory they should not request anything,
> the core would take care of all of that. But they can request specific
> values by using the DT and you must follow them in the driver.
>
> On his side the core is responsible of telling you which strength
> should be used otherwise and the driver is expected to use it.

The core provided ecc strength may be smaller than the
calculated one. e.g. A nand chip may only have a requirement
of 8/512bits ECC. But if it has a 2k+128 pagesize, this
controller can do 12/512bits ECC and the bootrom expects the
latter.

> You should take the user requirements first. If there are no
> user inputs, you should in theory look at the device's requirements.

I'll take the user requirements if there is one. If there isn't, I'll
follow the calculated strength instead of the device requirement
so that user doesn't have to specify a custom strength in dt.

> [...]
> > > > +static struct nand_ecc_engine_ops mtk_snfi_ecc_engine_ops = {
> > > > +     .init_ctx = mtk_snand_ecc_init_ctx,
> > > > +     .prepare_io_req = mtk_snand_ecc_prepare_io_req,
> > > > +     .finish_io_req = mtk_snand_ecc_finish_io_req,
> > >
> > > I believe you need to take care of the bounce buffer in the exit path?
> >
> > No. The buffer should be left there for non-ecc spi-mem operations.
>
> AFAIR you initialize the buffer in the ECC part, so if it must be used
> without ECC you should probably allocate it for the SPI controller.

I did. the setup_pagefmt is called once with the minimal page+oob size
in probe.

> In
> any way, you need to free that memory at some point (when removing the
> driver).

I was using the devm api for this allocation so kernel should take
care of that.

I'll change the DMA to use streamed API in the next version to avoid
an extra memory copy in reading, and the allocated buffer will be
freed in remove().

-- 
Regards,
Chuanhong Guo
