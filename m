Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE265446F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbiFIJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiFIJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:10:35 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078BF16595;
        Thu,  9 Jun 2022 02:10:32 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id c144so14799821qkg.11;
        Thu, 09 Jun 2022 02:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vC3VltqqExhpg4bVcodGmmZh57yEeJ2TT5vRq10L3PA=;
        b=tDKt1ZNaA9qtM8g6z/sLEgOpA5e6tXx08mGGdAN4eTeXf6OmR+2OtXwrOjtSEsojR+
         +6BaP3Z5ITE3MGYZaOE6tKS/wWw0PVtPHEynkSNq8zQ3GGJwVuxCh5ii3n4ReHxMS9iR
         fbs/13lA4uSCxkxstJf5zhP42v+f0ZKgAZV1Ml1+WWmu20+L7eGBRY84ukhr6Ic7mVij
         vp8WetcWlqo8MT6nDUi71vUu4xU04zmKSWzUmLSYA4TOgI1/kCvc5Rap14my8JZkIDHb
         kF9aD8bJft3YgzqxT07eldI+Ssx7nLnL6+72GlDadus1mzZDpIGG+oz7w1f+DQ2Cd+G0
         07Zg==
X-Gm-Message-State: AOAM533r2udvKr8LGL0rPYSKhA9iWCnMPMtP3IlgBqn5cjiIQrb1NQkM
        WNLv1E8I57lhPRoCm27N3w7EmEDXWi29TQ==
X-Google-Smtp-Source: ABdhPJwpVisI3Uf1g2Bf2eVrPv3YznTh3vAE7Jc3tA0eoTyjpEQkyqHNt8xg/4d/seu1yluqeH6OoQ==
X-Received: by 2002:a05:620a:1415:b0:6a6:c052:97e3 with SMTP id d21-20020a05620a141500b006a6c05297e3mr12898812qkj.196.1654765830985;
        Thu, 09 Jun 2022 02:10:30 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t69-20020a374648000000b006a71c420460sm2173532qka.22.2022.06.09.02.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:10:30 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id r1so12133076ybd.4;
        Thu, 09 Jun 2022 02:10:30 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr39893413ybu.604.1654765829891; Thu, 09
 Jun 2022 02:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151216.24133-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220525151216.24133-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 11:10:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1W8kMpw2CT7hX7ULd_fzP_S6+bciLMgJ3OHLwgqvYRg@mail.gmail.com>
Message-ID: <CAMuHMdU1W8kMpw2CT7hX7ULd_fzP_S6+bciLMgJ3OHLwgqvYRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: rcar_gen3_thermal: Add r8a779f0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
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

On Wed, May 25, 2022 at 7:04 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Add support for R-Car S4.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
