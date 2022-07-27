Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3652B5821EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiG0ITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiG0ITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:19:47 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECF243E70;
        Wed, 27 Jul 2022 01:19:46 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31f379a0754so64616997b3.2;
        Wed, 27 Jul 2022 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtxVw1pYdcDvsQm6N6G29PT1JL73CCGF7G8sUX9Kfs4=;
        b=hdCF6Ux5sj/Ui9SA+QZZFWkaz5tpU9oPnqTZMgUl6hVM9GTYkAyiJgwUmQ7xJXqrVC
         CGZbCqmB4ZibJocXFQycUeXVNgG1DFaAbWs/GzGX+MPkm+55MRRkil1MkC1NVT/1FA0k
         5Zf8kb4Y+7E1Yx9UzwIILGRYSEFn0kSSkdVICU5GuYN/eNeIin9QlQnUl9GtcOcrxSPE
         99bveCKYmLsicmzrX5ZkgdCDNAgI0MUmQ8RNirZ6nDSYQ5klEI5rE5YDtmgraxBULcs/
         XxKpMGAaNf1VXcyVPXKR9eS8HKBWBnwbqvlxVUUPhE+msVyY7V6rWgcb+IHQesqz+H2B
         7F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtxVw1pYdcDvsQm6N6G29PT1JL73CCGF7G8sUX9Kfs4=;
        b=YCioRMA85b0kZ+Azg3MMOCE8sA+4qMPmwCll3F7kXpbhO2qxfpz8gnG6CgQMZskCKm
         nDYyKqaKF2JHMUKW4iiih+75NFnhQw9bwJ29sDRAEOxTkHMNOn2XDw+yc1w9c6AcmXgE
         IIXc2i9dFiwataYK6tMIf4ZM3oFf9KMddQZCOG9S8KcZ9CzqQR2MhQQFT2pamlv7k0CT
         YrrLw6sgwTDWuwyKWUah0PPcRkVWHUUPuQxGAl6BLjekUM2iryjS/2gqtBBNydKBjrec
         RBlJvpddHTQhjeTtp1QiqlZ/3DsKL1Td879lP7J9mhzsWMd9eoxDt9HFZgG1MZ9F0rQs
         VUCQ==
X-Gm-Message-State: AJIora9eNj8wIJ2P6rc8JYy9H49m1X1wIn+2VLfiexP5urxFGY1yKx1r
        j/Wu9WBOWZbXVcBoCt13QXNyLaOfhkkVTx5OYcI=
X-Google-Smtp-Source: AGRyM1secQcLWHxnDAk0KB/hY+50q7KhRWosdCbuNLjT5ScRK3t60youklhj3RRe3N6FfG9loM0EXWhiCzu80vbJ9/Y=
X-Received: by 2002:a0d:f0c7:0:b0:31e:e814:e7d6 with SMTP id
 z190-20020a0df0c7000000b0031ee814e7d6mr14519304ywe.340.1658909986075; Wed, 27
 Jul 2022 01:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <08083c49-68a3-6b0d-4a12-d9c9f7994281@microchip.com>
In-Reply-To: <08083c49-68a3-6b0d-4a12-d9c9f7994281@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Jul 2022 09:19:18 +0100
Message-ID: <CA+V-a8vx0XLVsZxr-HcQZVqWjQ3tW9ZgbOU0GTKtEf=VcDWRqg@mail.gmail.com>
Subject: Re: [PATCH 5/6] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC kconfig option
To:     Conor.Dooley@microchip.com
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for the review.

On Tue, Jul 26, 2022 at 7:49 PM <Conor.Dooley@microchip.com> wrote:
>
> On 26/07/2022 19:06, Lad Prabhakar wrote:
> > Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
> > (R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
> > of the Renesas drivers depend on this config option.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/riscv/Kconfig.socs | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 69774bb362d6..91b7f38b77a8 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >
> >  endif # SOC_CANAAN
> >
> > +config ARCH_RENESAS
>
> Hmm, I guess since it is very late in the day for v5.20 and there
> appear to be some issues with the SOC_ symbol breaking the dts build
> anyway, this is likely to be v5.21 content anyway...
>
I was targeting this for v5.21 ;)

> ...but I would be wary of adding ARCH_ symbols from ARM archs prior
> to figuring out what we actually want symbols in Kconfig.socs to
> actually  at LPC or w/e. Palmer?
>
> > +     bool
> > +     select GPIOLIB
> > +     select PINCTRL
> > +     select SOC_BUS
> > +
> > +config SOC_RENESAS_RZFIVE
>
> I would like to see this added to the default defconfig so that
> it has dtbs_check coverage by default.
>
Agreed, I will include it in the next version.

Cheers,
Prabhakar
