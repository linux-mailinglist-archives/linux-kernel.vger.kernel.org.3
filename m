Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4A4C87FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiCAJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiCAJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:28 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9538BA;
        Tue,  1 Mar 2022 01:32:39 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id k5so7175639uao.2;
        Tue, 01 Mar 2022 01:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T6sA7KXpR9ERGgH74XNT9BrH80aJg0yLcmWFccMqc8=;
        b=Wzy5XDC2pHsyJTmN4u2JMsNVwR1pRGuRaJc+PziErKyTjQLmaZe2VdVwM/Syabchpm
         CEPCic7dW8FSHnWYOJ2mLckfuwKg7CHOmL/bfztReiUCb23BIX0ZNQXhvBFsj1dQP2Pq
         wf2U7urbctNeA1FSIdxGGYxoPWwwMLtd8LC6Pjw/bGiXgQAJjcQhIlmVFy8Xt6JC+aTG
         uqCwAOQMLVA4mN1oGy5T8212DChA0Ak8/XiRTB0LRX9tEzia/6Sa2ko6uPMzNX9b7s+Z
         QuD1cZVgBuo/mzw0s5/2Ko+iEfZpM9FIGtiuCxwFxtocwwvSbD/YecNTQpkmOGj+9AUI
         UMuQ==
X-Gm-Message-State: AOAM531lIG1fFjMPqUh3grMk3HRncUEV9JCH1xsUeP7u6WD1xJvm6kFG
        Mz/26H2f863zSM1rtaku4LRQOGS7Mz68HA==
X-Google-Smtp-Source: ABdhPJx0dLJaP7rObEXPFZ4Xfs1Qfx2xrX7b+fxqISaLsl+ojfAOWTbFhizaAS5oivXNRggiQgnNZQ==
X-Received: by 2002:a9f:2482:0:b0:341:c96f:e71d with SMTP id 2-20020a9f2482000000b00341c96fe71dmr9032268uar.9.1646127157986;
        Tue, 01 Mar 2022 01:32:37 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id s18-20020a05612204d200b00332f05df61bsm1798644vkn.49.2022.03.01.01.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:32:37 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id 63so6624451uaw.10;
        Tue, 01 Mar 2022 01:32:37 -0800 (PST)
X-Received: by 2002:a9f:3b2e:0:b0:347:33ae:e5e4 with SMTP id
 i46-20020a9f3b2e000000b0034733aee5e4mr3399508uah.49.1646127157366; Tue, 01
 Mar 2022 01:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220227203744.18355-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227203744.18355-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 10:32:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2dFJH5jfO_+LEy+OyqC-9SPOPxYWQUHCYHBq-ApO_2A@mail.gmail.com>
Message-ID: <CAMuHMdV2dFJH5jfO_+LEy+OyqC-9SPOPxYWQUHCYHBq-ApO_2A@mail.gmail.com>
Subject: Re: [PATCH 04/12] arm64: dts: renesas: r9a07g054l2-smarc: Drop
 deleting can{0,1}-stb-hog nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Sun, Feb 27, 2022 at 9:38 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Drop deleting can{0,1}-stb-hog nodes so that CAN becomes operational on
> Renesas RZ/V2L SMARC EVK.
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
