Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9644695CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbhLFMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243141AbhLFMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:39:02 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C00C061746;
        Mon,  6 Dec 2021 04:35:34 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v22so10549473qtx.8;
        Mon, 06 Dec 2021 04:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bHMT8E9fImkfAoYBjXVpAXPBP4Ehi0VCPzqml/KFYCg=;
        b=gnVJ3p0EsdLu5f/hdHhrL9pYCb0eu5/3p+2GCU2aRgcwUcYr7t3eowfYbSL9pO6tXS
         MHHunaoGBMbfJT+YAHiC2EuN2OFc1IxqBNsYetLy3GbSM/qcLfemodCXhLO6PVy2kCiB
         nmtD7+X/7vGen29BCyNWcyhhVO94d5W8/t5Wcft8IJOddH1KImXZRpKfxk6sNF4KsDwT
         /RrbIPllTSH6909E6E+3TED1zi4xeWa2OG7Xldv2FBxqkg4j27wk1EmT9v6P0PYIeRK9
         NbqqrE6zDsWVLxSjrbwQdtWbkoOyrbrsHSUHcFuXKptgnInQmNbvt0W4zhf3aktKnVzI
         8o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bHMT8E9fImkfAoYBjXVpAXPBP4Ehi0VCPzqml/KFYCg=;
        b=tU/mWGs5JVT4kSY4XCWQmsQ/MYW+SaKHJoM9VWSLU+RI+oKq3fW/zGaIQrFik1jlWE
         8iYKZW52N8jnJGOsl9j9nf5FdzxYrQVgvqwH9eoWnDfrJ5m2CgU2hjIyITuBWDsmSpBV
         sEtNXrT1pSnLBoEFfy5peF6puBkvmwMY7/GHPfdYkp6JWehbGTWwWpnqcuPEdYKQ50/M
         SzbEFXG3vhgK76omuqlqs2bahmE2J7vfGnWda4+9ViVU7kXDuYrnOUmdtN016Xebm0DT
         IAuD5aP39U0+MM7EZ9MnZvnx6rGyUJ8DlkFPYzE/8TAfTHxDXZlORbC52Ynpu4bJw0V2
         OFWA==
X-Gm-Message-State: AOAM533N3mgAX0FW5UpWCf2y9S3CBlUUIYNNhVuEHDEB0O5OOMu/og07
        RmIonCP0BdkpPQ2EVukzlRk=
X-Google-Smtp-Source: ABdhPJzjUBq4Z5Lq71j4c0mIlippjySRf4t5Whw5GG4up3YjB9xND+C9kuKz0sK7AUXSG3VByXQ16g==
X-Received: by 2002:ac8:5742:: with SMTP id 2mr38986321qtx.554.1638794133143;
        Mon, 06 Dec 2021 04:35:33 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id y73sm6213811qkb.113.2021.12.06.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 04:35:32 -0800 (PST)
Date:   Mon, 6 Dec 2021 07:35:30 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: Re: [PATCH v1 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Message-ID: <Ya4DkhOafBOxZbz4@errol.ini.cmu.edu>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-3-gsomlo@gmail.com>
 <CAMuHMdU7ZVpStBeS3eqFaHmyv+KoVmddn8DNTMqOoTxe61xf6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU7ZVpStBeS3eqFaHmyv+KoVmddn8DNTMqOoTxe61xf6Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:38:07AM +0100, Geert Uytterhoeven wrote:
> Hi Gabriel,
> 
> On Sat, Dec 4, 2021 at 12:42 AM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > LiteSDCard is a small footprint, configurable SDCard core for FPGA
> > based system on chips.
> >
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/litex,mmc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LiteX LiteSDCard device
> > +
> > +maintainers:
> > +  - Gabriel Somlo <gsomlo@gmail.com>
> > +
> > +description: |
> > +  LiteSDCard is a small footprint, configurable SDCard core for FPGA based
> > +  system on chips.
> > +
> > +  The hardware source is Open Source and can be found on at
> > +  https://github.com/enjoy-digital/litesdcard/.
> > +
> > +allOf:
> > +  - $ref: mmc-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: litex,mmc
> > +
> > +  reg:
> > +    items:
> > +      - description: PHY registers
> > +      - description: CORE registers
> > +      - description: DMA Reader buffer
> > +      - description: DMA Writer buffer
> > +      - description: IRQ registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: phy
> > +      - const: core
> > +      - const: reader
> > +      - const: writer
> > +      - const: irq
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> reg-names?
> 
> (and updating litex/tools/litex_json2dts_linux.py to add it)

Thanks, I missed `reg-names` originally, and have added it to the
list. And yes, once we agree on all this, I'll submit a matching
update to litex_json2dts_linux.py 

Thanks,
--Gabriel
 
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    mmc: mmc@12005000 {
> > +        compatible = "litex,mmc";
> > +        reg = <0x12005000 0x100>,
> > +              <0x12003800 0x100>,
> > +              <0x12003000 0x100>,
> > +              <0x12004800 0x100>,
> > +              <0x12004000 0x100>;
> > +        reg-names = "phy", "core", "reader", "writer", "irq";
> > +        interrupts = <4>;
> > +    };
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
