Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A054807E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbiFMHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiFMHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:24:29 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E671AD9B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:24:29 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id fu17so3337261qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jo6diAbkzH0dd9HLAnROmzlLspOkvFZqdSOZ8/PgR6c=;
        b=heMTY78PG7p435Rh6nJos1LjoNJknoxgZvefjHDwbCnY7b4ekyp5Pik/4Yp2eRtTjO
         qia5pFI/sIurNWjb4yabDvMznTZZjzVFqH96VlwTJxJaCSr7+GvGDlmy3R2mZcqqJ3FW
         QuApK5KX7hxCKoZrrO7Gli/g3CXF9FOvUpAnYlnh6YFBhnWJHciSJcRSxYuqHYpHSWYC
         g8ikvuZsUc79/wusoFymfteD8zzk3YsvcdLOyqbL9KG8ZnAR5K4xx/7u8Uhn5t7qwXyc
         bwslTBrvLy/ybI0JqT4BmB75Yybl4D8udThRsueAi5ba2Ly4PVx7SZAk+cqwOk+OCfF8
         /h0Q==
X-Gm-Message-State: AOAM532pabSJ8zTik0KCQpUv1udQw2YrpjhAC6AcDzhKKsukFoSdSVIN
        4BWdWtOadNBTRkNABktKPhiBtmJS+n0Rog==
X-Google-Smtp-Source: ABdhPJxcwddpmSFVzxuioCEC1+pHbex0SzgVJFu7m/xyuRa+PAtZqOuEsejq1lt9adLPY50SeImcYQ==
X-Received: by 2002:a05:622a:183:b0:305:45:98dd with SMTP id s3-20020a05622a018300b00305004598ddmr21635955qtw.158.1655105068194;
        Mon, 13 Jun 2022 00:24:28 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b006a6cadd89efsm6558051qkp.82.2022.06.13.00.24.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 00:24:27 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id u99so8415506ybi.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:24:27 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr59037253ybu.604.1655105067505; Mon, 13
 Jun 2022 00:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220610083924.32877-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220610083924.32877-1-wangxiang@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jun 2022 09:24:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYeSoRJ-bjxOMn8+qEZ8=VEO_yfg-gq1e3MxKix4GBLA@mail.gmail.com>
Message-ID: <CAMuHMdWYeSoRJ-bjxOMn8+qEZ8=VEO_yfg-gq1e3MxKix4GBLA@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: mac: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Joshua Thompson <funaho@jurai.org>,
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

On Fri, Jun 10, 2022 at 10:42 AM Xiang wangx <wangxiang@cdjrlc.com> wrote:
> Delete the redundant word 'an'.
> The second "and" should not be deleted, but replaced by "an".
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
> Changes since v1
> *Change comments "and and" to "and an"

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
