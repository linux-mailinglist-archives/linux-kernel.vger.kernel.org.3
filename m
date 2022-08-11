Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3723658F868
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiHKHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiHKHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:32:31 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE28E0DE;
        Thu, 11 Aug 2022 00:32:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-32868f43dd6so164864497b3.8;
        Thu, 11 Aug 2022 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6u3hj+Y//vHpQbWemLUBU1B8OjMJneU5QhJwoYuwFe4=;
        b=iAGICYiTai5WT5ADZ4g/9P8h9qzyXwh/Kivi5/pDrj+yO5M8JbFTZFn/S5TDKTEzAC
         EZPffeybriTAjUbIe/ch30xzcmjPrfW0VPQGSXc4876uF94MYQNFNXsFOsbMBHCzLwQm
         Xn3KV2S3w1eqrk+/V2cxPDfSKg3k2mooVwV8sl87bwKqmC5us5e+9YVPuZAvRQkSiPmP
         izKGxlTbTQUM5c/w+JoBQ6IMZcM1jiuQLCdALal3saSNLL/vUUzO2PuTOQjKKkjbfeP1
         BGF3U5qEYnOEAJDYgxhSQxu6tByZ/H6dbraRX6kikmtlh4UiHlQlT+7McAs/HXBuUaRS
         +03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6u3hj+Y//vHpQbWemLUBU1B8OjMJneU5QhJwoYuwFe4=;
        b=TL82tdOYJqsV72CdcipDQ6X//ydN00vbKcUbySj04UXv4aJ7NKVf9iJTpzSACDXdA4
         b63YZhZpjCn7WOJPeQfWt/TvoZWkJjz4kFyj6TSnj26JFXpXeDY8uf5TyQ5gQQ/sNpFp
         EZTT6zF84Aa4x6slOjPDtoJOMx8cwoecDh9RIfuC03Wj+c2Ks83VUyZ5g9T2HmZvatQU
         Q8s5YwRLbZNYMzJF1kQrVo2DwnbKP8T/VoMuzMlrweRplpV9AJ2cUSwJfeG6DrDYH2X8
         A+cYAATot36x/NcEGbWIyxOUGR9aNj+wpXZvWzzMaKonlthflCY0dDHhJvA+OPEj14CK
         7FCA==
X-Gm-Message-State: ACgBeo3rSA+/8BSzGpZ0UsyV18LIQ2zh6M1PnFq3CN/M4o52ybk2BfKN
        iiCo7zYYfgSEADTO6ZmE46XvszfwDFi4ir+YQOk=
X-Google-Smtp-Source: AA6agR5TGJLwSsVW06H2UxMeXJYwBpsk1ZgGTLbVxkvQWThby/NO+cLwCc/kVjK14zW+I3WZaeWWW1LqnkiCjwGjFr0=
X-Received: by 2002:a81:8345:0:b0:323:9a15:7fd6 with SMTP id
 t66-20020a818345000000b003239a157fd6mr28544907ywf.104.1660203149471; Thu, 11
 Aug 2022 00:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220811070506.12252-1-lukas.bulwahn@gmail.com> <47742925-2d0d-7313-f811-aa17e35ce81a@microchip.com>
In-Reply-To: <47742925-2d0d-7313-f811-aa17e35ce81a@microchip.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 11 Aug 2022 09:32:18 +0200
Message-ID: <CAKXUXMzaR_503UMXmoRe4CvUuek50VJb+33R6xYf3Op4tw78ZQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for RISC-V/MICROCHIP POLARFIRE
 SOC SUPPORT
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Daire.McNamara@microchip.com, linux-riscv@lists.infradead.org,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 9:14 AM <Conor.Dooley@microchip.com> wrote:
>
> On 11/08/2022 08:05, Lukas Bulwahn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Commit 3cbd67384677 ("MAINTAINERS: add the Polarfire SoC's i2c driver")
> > adds the file entry for drivers/i2c/busses/i2c-microchip-core.c, but the
> > file is actually named drivers/i2c/busses/i2c-microchip-corei2c.c.
> >
> > Repair this file reference in RISC-V/MICROCHIP POLARFIRE SOC SUPPORT.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Conor, please ack.
>
> FFS... Silly mistake from me there, keep getting caught out by
> the maintainers entries when I do an inter-version rename.
> Is there something I can add to my build scripts, other than the
> get_maintainer selftest to catch these?
> Thanks Lukas.
>

I am not aware of another script. Why do you see the need for another one?

I acknowledge that ./scripts/get_maintainer.pl --self-test=patterns
does take a few seconds (roughly 30 or so) and it checks the whole
MAINTAINERS file. Is that just not performant enough?

I usually have a set of patches in a local branch (all those patches
were sent out, but are pending somewhere) to get to zero warnings from
this script. In the last few years, I did get to some points in time
that ./scripts/get_maintainer.pl --self-test=patterns reported zero
warnings on linux-next, but then new issues were introduced and the
hunt continued. When we are back at that point of zero warnings, I
will ask the intel 0-day testing team to include the '
./scripts/get_maintainer.pl --self-test=patterns' check into their
patch testing efforts, and hopefully that reduces the chance of
picking a patch with such an issue and we can keep it almost always at
zero warnings (wishful thinking on my side).

Lukas

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> >
> > Arnd, please pick this minor non-urgent clean-up patch.
> >
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9203efedea1e..797fde7e1821 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17544,7 +17544,7 @@ F:      Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
> >   F:     arch/riscv/boot/dts/microchip/
> >   F:     drivers/char/hw_random/mpfs-rng.c
> >   F:     drivers/clk/microchip/clk-mpfs.c
> > -F:     drivers/i2c/busses/i2c-microchip-core.c
> > +F:     drivers/i2c/busses/i2c-microchip-corei2c.c
> >   F:     drivers/mailbox/mailbox-mpfs.c
> >   F:     drivers/pci/controller/pcie-microchip-host.c
> >   F:     drivers/rtc/rtc-mpfs.c
> > --
> > 2.17.1
> >
>
