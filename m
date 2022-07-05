Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B6566438
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiGEHjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiGEHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:39:50 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9413D2C;
        Tue,  5 Jul 2022 00:39:48 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id l14so12583905qtx.2;
        Tue, 05 Jul 2022 00:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQ61tPN0yBFwiubVc1sFoEmC6InOODKRMnlSWDXBVic=;
        b=EQ7dER3a6ImAD8g35CrCjGm95+/DuRME6JcJhTkRHoCnvqFK7AER2Kr+FEt5sKztnt
         Oxql7unMdVZtwlkuLTNzL5CoXfI8IhRi8BY6DbRUcn/RZcK3eXOivABwCbpXY+/LsNBi
         HCo6MyGK4gbvvCrvbyIY2jY7wS1cwxKm5gxqRSHWX2jnPmQ0h6piQjGM13DJJh89C3Vn
         AvQUyyp0FDdxFnS5ZSBWX/3E35KE6cRg6lhNpLOYygNYyspRxzXMcoGanh/Jq5I29134
         LPxkFv+DkzORURq1ZggHO0WP9+6vVuzkxk/rHrVBX+SDP9Xp5NoCM/EwfTSGq4nVLECN
         IisA==
X-Gm-Message-State: AJIora9LHA7cgwGhkC1GrRHbu3g7Vr8oSiVo8KR+NlVmXREr3lV5tY3q
        6bLEEb+xv1Z3aUyLB6MGV6wrtKvIgmUICNZ9
X-Google-Smtp-Source: AGRyM1tfIqbzfBtd0/O5s6GDD65tiqn/H9F+DKGfHcw0heur8wXcShA2TaYctB5UcGsRT1uSWM7mAw==
X-Received: by 2002:a0c:c608:0:b0:470:2e15:ce8c with SMTP id v8-20020a0cc608000000b004702e15ce8cmr30773834qvi.99.1657006787883;
        Tue, 05 Jul 2022 00:39:47 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b006a36b0d7f27sm29346876qkp.76.2022.07.05.00.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:39:47 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id l144so7891192ybl.5;
        Tue, 05 Jul 2022 00:39:47 -0700 (PDT)
X-Received: by 2002:a25:3288:0:b0:66c:8a91:74bb with SMTP id
 y130-20020a253288000000b0066c8a9174bbmr35496230yby.89.1657006787005; Tue, 05
 Jul 2022 00:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220623134259.03af40f6@canb.auug.org.au>
In-Reply-To: <20220623134259.03af40f6@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jul 2022 09:39:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTwJDTtXYQkbkz2EgrKdrfr6Zv-DGfy-PfcOepBgj6kA@mail.gmail.com>
Message-ID: <CAMuHMdWTwJDTtXYQkbkz2EgrKdrfr6Zv-DGfy-PfcOepBgj6kA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the usb tree with the spi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 6:51 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the usb tree got a conflict in:
>
>   MAINTAINERS
>
> between commit:
>
>   f303c6b26ced ("MAINTAINERS: add spi to PolarFire SoC entry")
>
> from the spi tree and commit:
>
>   4a691b8c157a ("MAINTAINERS: add musb to PolarFire SoC entry")
>
> from the usb tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc MAINTAINERS
> index fcaa66ea848b,e73c77d479bb..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -17225,7 -17169,7 +17232,8 @@@ S:   Supporte
>   F:    arch/riscv/boot/dts/microchip/
>   F:    drivers/mailbox/mailbox-mpfs.c
>   F:    drivers/soc/microchip/
>  +F:    drivers/spi/spi-microchip-core.c
> + F:    drivers/usb/musb/mpfs.c
>   F:    include/soc/microchip/mpfs.h

Not that it would have avoided this conflict, but both commits didn't
care about sort order.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
