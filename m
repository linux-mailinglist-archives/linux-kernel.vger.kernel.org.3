Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20A516C21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383799AbiEBIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEBIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:41:19 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7395818396;
        Mon,  2 May 2022 01:37:51 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id e128so10903938qkd.7;
        Mon, 02 May 2022 01:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfOGQBmuow0XJRSClS83s9wqJs62SvttChLLjbwtT1k=;
        b=6gQVYiIaRr6YYTijldbNZzqoQpp9eZq/B4aKSGRd9cDbCb4bf6HQR5J2DaLNn3OyKq
         P8t3NdyT3LBMz5s2RllW8bolhd7UWoEQUlNwJQqg2Vv62voUMbqv5G/JtQNvwCm4Zrj0
         qaov185fAgO3I6KI3aQEFa8gGyabl8I9qVFe548Wpz0Ls1UErhEyVG5vVwDrgCXyDQKi
         8gXW5jRpaHnDu+jju/P1BMfpJ9r0S1KBamwMuO9JSq+ePIPxi4LKM7A0v+YjoID1y+V+
         nP5LCjUhL2o610VWOz6GNETBYrdldtgut5iZWxY73KLAQDhGZAEzPlMm83w3anTaWWtT
         LYRQ==
X-Gm-Message-State: AOAM530FvyUyK3mYOt9K3TJCFS7tNFLhRsD8hz6LYmDheRHzp/P630Ca
        Z0j8chvKSMx3wZcANr/1+l1jMTUQ3B5Wrg==
X-Google-Smtp-Source: ABdhPJzgj21K+va5fCRAXvcWIk60OJqB1YsSxUN6km/Wvxz5ZuKQUyFYtzRTgCE7dC2+RMaNK/4ceQ==
X-Received: by 2002:a37:b3c5:0:b0:69c:52ee:3a93 with SMTP id c188-20020a37b3c5000000b0069c52ee3a93mr7720559qkf.640.1651480670433;
        Mon, 02 May 2022 01:37:50 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id h12-20020ac846cc000000b002f39b99f68esm3704599qto.40.2022.05.02.01.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 01:37:50 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7d19cac0bso140053797b3.13;
        Mon, 02 May 2022 01:37:50 -0700 (PDT)
X-Received: by 2002:a0d:d953:0:b0:2f7:d5ce:f204 with SMTP id
 b80-20020a0dd953000000b002f7d5cef204mr10194780ywe.502.1651480669896; Mon, 02
 May 2022 01:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220430191122.8667-7-Julia.Lawall@inria.fr>
In-Reply-To: <20220430191122.8667-7-Julia.Lawall@inria.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 10:37:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX03F0zbGHik4zqqHZEu4Xwu7679HO9HHNcLRdr=0T9Bw@mail.gmail.com>
Message-ID: <CAMuHMdX03F0zbGHik4zqqHZEu4Xwu7679HO9HHNcLRdr=0T9Bw@mail.gmail.com>
Subject: Re: [PATCH] m68k/math-emu: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
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

On Sat, Apr 30, 2022 at 9:11 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.19 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
