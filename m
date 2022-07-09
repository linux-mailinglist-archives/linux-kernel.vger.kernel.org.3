Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10AA56C908
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGIKfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:35:02 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA265580
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 03:35:01 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id x22so660819qkf.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 03:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYYq2mWCFBLoiPh2Ay9Qcz2ku4io1G7S8HaCDNUt9gI=;
        b=kQPcxFY4lfjfImMvKPjTX9byhy5bzB7Rbp8zOVkiaCkI5jHM8lWBDixXsM8otdQGa0
         C4ict/2SN3vlG6EC4kekhqUi17+g7Jaf5XdtPP8kwYEt2tc/Tcy73IuMvfwzwDPIq3Io
         IwH+HNcga7pnl/ijhuOu+lMDoSoVgd9QwSIeox+HN6+520Q6I1I7/EnEq8kk249kMn6m
         fX+EJKBGjkJDNG1G1W3MtL7xHUMD33MNxmYOk55pxCaEMUEDI9iX0+w8YuRX+A1dGKyd
         hX6gBtHjgi7lSsu0Svu+oCrKW7xJ1sIMsx8z6iqR7elTIYIEfeRkJBmqwSSsztL1lLUr
         Y+Yw==
X-Gm-Message-State: AJIora/15HYNXM7NafzXwVeXRzbj0FJr70+WR4ecfEU2HgnqFi7abhm1
        vuLjlJHCaHtuWiTf/6cUVq2udd7Yg39JDQ==
X-Google-Smtp-Source: AGRyM1tIYfnqebDUoqxtiCXc15BSt75+gZngpmn/+fHFdlkionLvMg0IKUogM19A12Yb4Cg6EguiFQ==
X-Received: by 2002:a37:a154:0:b0:6b5:74ef:5b36 with SMTP id k81-20020a37a154000000b006b574ef5b36mr721779qke.168.1657362900376;
        Sat, 09 Jul 2022 03:35:00 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id g2-20020ac84b62000000b0031eae039188sm703271qts.90.2022.07.09.03.34.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 03:34:57 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 75so248366ybf.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 03:34:56 -0700 (PDT)
X-Received: by 2002:a05:6902:1246:b0:66e:ea31:8d05 with SMTP id
 t6-20020a056902124600b0066eea318d05mr2374600ybu.89.1657362896428; Sat, 09 Jul
 2022 03:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220531174514.1586248-1-laurent@vivier.eu> <CAMuHMdUbUZU3YA6nDC_LDAfUYQVmHTuCzrCfxDqwF=ZZyR5fqw@mail.gmail.com>
 <YseHZq/u9OkVltxW@zx2c4.com> <CAMuHMdX7JPKJbth9xw4MbPbi29fgQNSva0r394JX-etEZiUJ_A@mail.gmail.com>
 <YsjHiZeUxo7RXxAu@zx2c4.com>
In-Reply-To: <YsjHiZeUxo7RXxAu@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 9 Jul 2022 12:34:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLzAzb+GBXgU_+aGwcVd0U5ZDjoakopW62brpYmTEm3g@mail.gmail.com>
Message-ID: <CAMuHMdXLzAzb+GBXgU_+aGwcVd0U5ZDjoakopW62brpYmTEm3g@mail.gmail.com>
Subject: Re: [PATCH] m68k: virt: Kconfig minor fixes
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
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

Hi Jason,

On Sat, Jul 9, 2022 at 2:11 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Jul 08, 2022 at 09:24:59AM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jul 8, 2022 at 3:25 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > On Thu, Jun 02, 2022 at 09:13:14AM +0200, Geert Uytterhoeven wrote:
> > > > On Tue, May 31, 2022 at 7:45 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > > > > Select VIRTIO_MENU as it is needed by VIRTIO_MMIO.
> > > > >
> > > > > Add an ending period at the end the virt machine help message.
> > > > >
> > > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > i.e. will queue in the m68k for-v5.20 branch.
> > >
> > > Shouldn't this fix make it for 5.19? It causes Kconfig warnings during
> > > builds. So this seems like a ordinary mid-cycle bug that can be fixed.
> > >
> > > For example, if you ctrl+f for "unmet direct" in this log, you'll see
> > > this splat in the wireguard CI:
> > > https://build.wireguard.com/random/108f4fea7b6053dfd09039af74c0ac0c32c956be/m68k.log
> >
> > These are merely configuration warnings, there is no build or runtime
> > failure.
> > I reverted this patch, disabled CONFIG_VIRTIO_MENU (which BTW defaults
> > to y), built and booted a kernel fine, and could login on the console.
> >
> > So IMHO it can wait.
>
> Okay, no problem. I suppose 5.19 isn't likely to be an LTS anyway.

I expect this to be auto-backported to stable 5.18.x and 5.19.x anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
