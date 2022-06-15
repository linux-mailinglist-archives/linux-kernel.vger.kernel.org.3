Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96054C417
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbiFOI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346642AbiFOI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:59:33 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98053193D;
        Wed, 15 Jun 2022 01:59:30 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id p31so7220822qvp.5;
        Wed, 15 Jun 2022 01:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LGNHnzrTgoysDDqvGoC2cbC9qqf5MTo99yN/7m20Ys=;
        b=qNtNcuRAThsgGLiMWs+QdTy7oh5iAq8eKbAllDfodM5wbg1IapXZHQ0Yedk9P0lm30
         dHy5KRLelev4WQX9iLryOD6JsYrasFFp7i14uOyXm0A81jECZM4Rr9K4SFF9fxwab6Sm
         ZskzKqc7XsFuzgTCBjLqsRTDTUL3+ZMzl7X4fkRm79CHLWxNBH8Pahy93qlhQ1+qMbE7
         qFZjZJlOM7siLsojY08TL7Nc1Cusn0POePZqlkX5vNx41Gfprr1DQK3N0K+kTuhb/fWS
         iy+j7okGdwDVlAZ/W6TW4CPE9qnULERBN7q0RLkmMSKZuyHjVhaEAJt/5brpDxOoxFtp
         Stng==
X-Gm-Message-State: AJIora/auv/tSqrcJ7ikX1g3LLL3gMwH1WfmsAuH6NdUHuUAKWzASVtG
        PBdxiPFnhhxZPAOm5LeUraVZc9VYt5sefA==
X-Google-Smtp-Source: AGRyM1sqc+Y2qZtgrAXHdI4Zwmty3GarZDfgG0WeKcFhHJMx/OtXQbic36LR/RKL6NaSQls7fBt8JA==
X-Received: by 2002:a05:6214:3015:b0:46b:c894:a499 with SMTP id ke21-20020a056214301500b0046bc894a499mr6868441qvb.81.1655283569801;
        Wed, 15 Jun 2022 01:59:29 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id br30-20020a05620a461e00b006a726b03ad1sm11914111qkb.52.2022.06.15.01.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 01:59:29 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-313a8a8b95aso54356147b3.5;
        Wed, 15 Jun 2022 01:59:29 -0700 (PDT)
X-Received: by 2002:a0d:e657:0:b0:314:7e4d:30a9 with SMTP id
 p84-20020a0de657000000b003147e4d30a9mr6072754ywe.316.1655283569213; Wed, 15
 Jun 2022 01:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220614095242.8264-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220614095242.8264-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 10:59:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU36tAerp7_DoMMAq9QowQMs6GOC5nM9H-PyD9qS8FwAw@mail.gmail.com>
Message-ID: <CAMuHMdU36tAerp7_DoMMAq9QowQMs6GOC5nM9H-PyD9qS8FwAw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a779f0: Add SCIF nodes
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linh Phung <linh.phung.jy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Tue, Jun 14, 2022 at 11:52 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Linh Phung <linh.phung.jy@renesas.com>
>
> Extracted from a bigger patch in the BSP, rebased, reg length corrected,
> and DMA properties added.
>
> Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1: include all SCIF

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
