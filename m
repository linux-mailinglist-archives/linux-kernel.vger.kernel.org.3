Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F815566360
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiGEGoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiGEGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:44:21 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534E5F54;
        Mon,  4 Jul 2022 23:44:20 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id he28so12447752qtb.13;
        Mon, 04 Jul 2022 23:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8sxu7/OBs27vuUuqX70lIqFEE2fpcrCtPxgFzDgyeY=;
        b=FrvGVHiJhj4Ec9J0nfPHHYyWkOs8bRyaCQJHWC7ful08n9UykKyGyzXc00TZJkyWEb
         l2ADDD9wAXdHLiznM8HjKHrh+qgVlblJp3f4xuvjUN3AW0NApRBzezcA6Ts/ynxXiZE1
         //WG9OaINdn2qlhAg2hJWfUm/MnFEbsXla2abCf8Ai8FJEje1rTfa2EnshxbFV8Xa3Bj
         OyjtaOChUn3Xn9WDa6NYSTOchzrTo/i9SxU+o4KLpRNN2R4gCB/OOXB7Ph/Z6SH101gh
         AKhOPS1Jl/zaFGn+1NEIW4KHMJ1MKXx8KImOqGTkvMXWW8uOz78OQ/KT84FfYF+6M2gf
         +p8Q==
X-Gm-Message-State: AJIora+pFx7zrZaVR5lJkTbg750Qhrh0q0UNvaz7YGz0Ae8CAgSPwVUp
        k5WwFbIHc/6PoHBQJhx96dwZ0JU4yJ8EOl25
X-Google-Smtp-Source: AGRyM1ta3qwRmHO8uhIWaUDbSrPfFMyCLvxQx1BuvtZtmmbT/zp2Iar3cmpAPfH+Up4eEcXUboHqyg==
X-Received: by 2002:a05:6214:27cc:b0:470:9aaa:94b5 with SMTP id ge12-20020a05621427cc00b004709aaa94b5mr29976541qvb.129.1657003459926;
        Mon, 04 Jul 2022 23:44:19 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006b25570d1c2sm10347686qkh.12.2022.07.04.23.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 23:44:19 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i14so471533yba.1;
        Mon, 04 Jul 2022 23:44:19 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr34817718ybr.380.1657003459192; Mon, 04
 Jul 2022 23:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220705015036.106937-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220705015036.106937-1-yang.lee@linux.alibaba.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jul 2022 08:44:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvmRdQcJwYKu+c8aav89KQNcXAaTYLvwx-jreeQXW7-g@mail.gmail.com>
Message-ID: <CAMuHMdUvmRdQcJwYKu+c8aav89KQNcXAaTYLvwx-jreeQXW7-g@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: renesas: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Tue, Jul 5, 2022 at 3:50 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
> Eliminate the following coccicheck warnings:
> ./drivers/pinctrl/renesas/pinctrl-rzv2m.c:487:3-4: Unneeded semicolon
> ./drivers/pinctrl/renesas/pinctrl-rzv2m.c:519:3-4: Unneeded semicolon
> ./drivers/pinctrl/renesas/pinctrl-rzv2m.c:591:4-5: Unneeded semicolon
> ./drivers/pinctrl/renesas/pinctrl-rzv2m.c:620:4-5: Unneeded semicolon
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
As the original commit has not been pulled into the pinctrl tree
yet, I will amend the original commit in renesas-pinctrl-for-v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
