Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294AE4DDA5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiCRNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCRNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:20:27 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9517C40B;
        Fri, 18 Mar 2022 06:19:07 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id t7so6771472qta.10;
        Fri, 18 Mar 2022 06:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vi9OsCC2WmX2jq3U8mK95xBaMNeoUqasMNRe8AvIFuQ=;
        b=aydQRKzFhoMHDzpI8/QNTs+qL+ZPCQQMAbQcrvlQjA6d5bqGhZ/PxLHZVU/xW7R4lR
         vIp/ysJ7fIm+XS4qmNASiK016HLyU/hjyz8tw0bwN9IBS5OUOKGHBFhGBFXsE4Z9TgCB
         ZhUMhdmlgvFxs8Tbb93HFyN41QPQ+vxXjp+kUlJWFpr3YnDHsvACllareg2B3mIPxv4A
         KK2HrseqvbV11AQmJV+GoUnb93VCqy7YgvllT7LLXubn5yhitVJ/DtXQG0Cfc7eg3+iM
         6NYalLXPQDuD9SAdQL9UiKUjzp6isSOSEc1mYYK5HuujoiTnevgPL0NkBLUGvyogaEoc
         6Xxg==
X-Gm-Message-State: AOAM530hOl+p0PTF1K+vnOgYNuROwCuKld0gSD9/TISZ4/jSyJBzXp/2
        nkFKpEdlwIRpiGyMGlfkyfNTL4+5dw+XQuo0
X-Google-Smtp-Source: ABdhPJzAlT1g+rR58/62CXoosmLZHGTOzkx6rvvnqHqbH9dLYnWpxZv6B3Xj9+H+KVQmmCIFTqTdTA==
X-Received: by 2002:a05:622a:613:b0:2e2:5fc:ea1a with SMTP id z19-20020a05622a061300b002e205fcea1amr860449qta.372.1647609546768;
        Fri, 18 Mar 2022 06:19:06 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id h17-20020a37de11000000b0047caf996ef8sm3777649qkj.20.2022.03.18.06.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:19:06 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id v130so15732980ybe.13;
        Fri, 18 Mar 2022 06:19:06 -0700 (PDT)
X-Received: by 2002:a25:bc8f:0:b0:628:8649:5c4b with SMTP id
 e15-20020a25bc8f000000b0062886495c4bmr9812914ybk.207.1647609546005; Fri, 18
 Mar 2022 06:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220308140033.10501-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220308140033.10501-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Mar 2022 14:18:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfwXP1xYTLj=19gg2z5F4eUw5k+r2yh2efyjfyGYPGuw@mail.gmail.com>
Message-ID: <CAMuHMdXfwXP1xYTLj=19gg2z5F4eUw5k+r2yh2efyjfyGYPGuw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable ARCH_R9A07G054
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Tue, Mar 8, 2022 at 3:00 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable the Renesas RZ/V2L SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
