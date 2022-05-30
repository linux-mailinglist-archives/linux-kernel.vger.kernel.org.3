Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6418B5374C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiE3HMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiE3HML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:12:11 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B88B1D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:12:09 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b5so1639142qkd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdhRdmYpzSaLyDZukxciTRFSwXlW7RAhZsMxh7fK1iA=;
        b=BO4U0ug1GyTPNCqC/TI1bwa9VlB1J+mjlUpaC0ONYMEvdGv9QwG1vhEAJEiWVnerSx
         zCIK94CXWNmLJYHYVeqpSG4yobVI1iR3LQoa5934mw5BSLU1kDVlVFbHG3+yCbivdIOh
         sMsJTBeqQzVA00+a208YPuFNt7FaOM+EGqtVRNC/4mhPgN6SjVN8/jsJ9V5Y9Scm64HU
         qsKo4g4XafCtMre1Ie1iYuxsFIUJwdFZbi62VbseYy0WyjK4ua16iLAywdpWyidzcGkE
         b12tpEJJ7EgIRz7B2Nf2HH/XgN9HohnfTwH7PH51d20mSByylswH7clEQLsCgZrBUxgR
         LxkA==
X-Gm-Message-State: AOAM530wf0TRM3KMah7v6vhRXWSwxy4Ce0oMaZCqb84Lw9ozxM85lZxF
        Bx1ubG7eswCqumyrrHtMK4YlNCHcfDY=
X-Google-Smtp-Source: ABdhPJwt925Kqg+IPbw9QnZtf7d3RuBaQp/EiqEVHVmcjVlAAlPRH9bge4QJJCsUVpiyc0Ku9kEwUw==
X-Received: by 2002:a37:9e0f:0:b0:6a3:4918:d394 with SMTP id h15-20020a379e0f000000b006a34918d394mr32315276qke.764.1653894728619;
        Mon, 30 May 2022 00:12:08 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a165800b006a63cd08f3csm741949qko.16.2022.05.30.00.12.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:12:07 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-300628e76f3so99811577b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:12:07 -0700 (PDT)
X-Received: by 2002:a0d:f745:0:b0:2fe:e903:b0f8 with SMTP id
 h66-20020a0df745000000b002fee903b0f8mr58276985ywf.383.1653894726993; Mon, 30
 May 2022 00:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220530025312.55057-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220530025312.55057-1-wangxiang@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 May 2022 09:11:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVk+RStP90cmuWzAY+3tLEJwaaOPR-h=xrLahmCZ_CDOg@mail.gmail.com>
Message-ID: <CAMuHMdVk+RStP90cmuWzAY+3tLEJwaaOPR-h=xrLahmCZ_CDOg@mail.gmail.com>
Subject: Re: [PATCH] m68k: coldfire:Add const to clk_ops
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Xiang,

On Mon, May 30, 2022 at 4:53 AM Xiang wangx <wangxiang@cdjrlc.com> wrote:
> Struct clk_ops should normally be const.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -50,7 +50,7 @@ static void __clk_disable0(struct clk *clk)
>         __raw_writeb(clk->slot, MCFPM_PPMSR0);
>  }
>
> -struct clk_ops clk_ops0 = {
> +struct const clk_ops clk_ops0 = {

The "const" should be first on the line.
Please test-compile your patches before submitting them.

>         .enable         = __clk_enable0,
>         .disable        = __clk_disable0,
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
