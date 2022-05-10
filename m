Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA0520F79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbiEJINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiEJINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:13:05 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166C259FB3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:09:09 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id y3so13003329qtn.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lihJuC/UeLrmK8Xl/R7H/fOSa5ycCvpBE1UByHbPLM=;
        b=NYVaVp6PtghedAXHoI7PqZOPAwTxpJDOAGUNAGpZx2IZugC5ashkf1hR9H766wva6o
         bmzJX65ClnoRgK/KG2tqKrGZZDhk+MgVNebYbOAjv+QAMr9WIsEbiO8Fe7RR1eDP93Yx
         Uf0uzDWQVsmxeXBTvQ+6LoU/Uah24PUISYFrQmRaDKgP2XAngiG7wsmk/+Ml0N6BPHM1
         TbdcnV9O0p0MJgFlJKtnQcCEqqg1qf7h26W58cNZqAa5ZyV0OuCCCaWhZY7Rj2XQ35G8
         QTEnzvIZwbu5z83fSRUyemIYogqMCjuP0dmxi6RAc6z0XkRbeS7RM6DOkK25slFTR20V
         THKA==
X-Gm-Message-State: AOAM531MdABgAdLqZ3t307mNfZnA2dbzpCE5wAMDoiwpKUVFXOatM0Rq
        FEbFz72Hpedeei+bvoaam4QwHwvnXoSRgw==
X-Google-Smtp-Source: ABdhPJx0z8P12pr0wLDiYlVyjqO4rJlXtNHlSnQgLJTqvgmO9+wigfj0VDUUrm5bPQNlltvHhHEmvw==
X-Received: by 2002:ac8:5e0c:0:b0:2f3:adfd:bd30 with SMTP id h12-20020ac85e0c000000b002f3adfdbd30mr18360872qtx.277.1652170148849;
        Tue, 10 May 2022 01:09:08 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86bd8000000b002f39b99f692sm8627919qtt.44.2022.05.10.01.09.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 01:09:08 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y76so29306618ybe.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:09:08 -0700 (PDT)
X-Received: by 2002:a25:448:0:b0:64a:94d6:e420 with SMTP id
 69-20020a250448000000b0064a94d6e420mr13062386ybe.89.1652170148174; Tue, 10
 May 2022 01:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
 <Ynk0rgKMdJuR/aB1@sirena.org.uk>
In-Reply-To: <Ynk0rgKMdJuR/aB1@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 10:08:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV8GdZnNSVrQiS-ZombAwJJK28Zz3Pzi04CXBOCmSmpkA@mail.gmail.com>
Message-ID: <CAMuHMdV8GdZnNSVrQiS-ZombAwJJK28Zz3Pzi04CXBOCmSmpkA@mail.gmail.com>
Subject: Re: [PATCH] arm64: ARM Scalable Matrix Extension is ARMv9-A
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, May 9, 2022 at 5:35 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 09, 2022 at 03:40:30PM +0200, Geert Uytterhoeven wrote:
> > The help text for the config option to enable support for the ARM
> > Scalable Matrix Extension does not mention the specification baseline
> > for this extension.  Make it clear this is an extension for the ARMv9-A
> > architecture, so users know when it is safe to disable this option,
> > which is enabled by default.
>
> If this is important we should probably also do it for SVE, it was
> introduced along with v8.2 but that's not called out in Kconfig.

Makes sense.

I jumped on this one in particular, as I believe it's the first v9 extension.

> > Fixes: a1f4ccd25cc25625 ("arm64/sme: Provide Kconfig for SME")
>
> Fixes?

That we can discuss about ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
