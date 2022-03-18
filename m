Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F144DDA97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiCRNd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiCRNd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:33:56 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC43111DFA;
        Fri, 18 Mar 2022 06:32:36 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id i65so904003qkd.7;
        Fri, 18 Mar 2022 06:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ws/WgsI+NgYJBvxRZWDWAq8NCIF4x7eB852P4+r+ZlQ=;
        b=wrVA6N2gRNLSu9TR0BBzzIFYBDaBOCjTuWWRHWOcOahXcdaYjMj1P1UuBoQm7riiN6
         hLiGg5YfEh2I37Wf9AgWwov0Qsy52QKmIM35X96N5uMfObrBMGMJi39ZggKLTaiGA+jz
         4gVpNAZtimmh+g5ce6sa7K6i+kVp6QkbfU7ImA+BAxhROOA61bmmy8NdV2DPgvAgQmpO
         kRpRZcUCMNs/bICRiaCrMkYlyCFsNUI9di5o23V/0SlMgZ7UP6pk7Sn8ykkNwYqgFWEP
         wR28IMm1IXmtJgBGEbwzUuzDcCsdyQCNTBY9JmLxk1QCUMJpkeRakQaHZsL5mrK1Mqxm
         gvHQ==
X-Gm-Message-State: AOAM532MBEan0CHfmtei1R7LIR6gopRLNLgoPzL5s6rByou6CpV3yMUG
        3mmdbtaaekyv86+eKB9Qw+BkjvKfaEaCsVMT
X-Google-Smtp-Source: ABdhPJyATVE8LsURnvhzpkzCNNImVaW8iYxsiuhTCRpXp2xxmZQVJgt+8wRLKNW+X+MiTbQkjEAKxQ==
X-Received: by 2002:ae9:f501:0:b0:67b:2d97:93c5 with SMTP id o1-20020ae9f501000000b0067b2d9793c5mr5796600qkg.380.1647610354924;
        Fri, 18 Mar 2022 06:32:34 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85c52000000b002e1b9897ae7sm5636584qtj.10.2022.03.18.06.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:32:34 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2dbd97f9bfcso90763657b3.9;
        Fri, 18 Mar 2022 06:32:34 -0700 (PDT)
X-Received: by 2002:a81:59c4:0:b0:2e5:c7c3:5d29 with SMTP id
 n187-20020a8159c4000000b002e5c7c35d29mr7200941ywb.512.1647610353914; Fri, 18
 Mar 2022 06:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220309190631.1576372-1-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20220309190631.1576372-1-kieran.bingham+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Mar 2022 14:32:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWmu1hzpf+yYicLLjRQFCC7voXUAY7An4EEgCDTNZsnQg@mail.gmail.com>
Message-ID: <CAMuHMdWmu1hzpf+yYicLLjRQFCC7voXUAY7An4EEgCDTNZsnQg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: falcon-cpu: Use INTC_EX for SN65DSI86
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 8:06 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
> The INTC block is a better choice for handling the interrupts on the V3U
> as the INTC will always be powered, while the GPIO block may be
> de-clocked if not in use. Further more, it may be likely to have a lower
> power consumption as it does not need to drive the pins.
>
> Switch the interrupt parent and interrupts definition from gpio1 to
> irq0 on intc_ex, and configure the PFC accordingly.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> ---
> v2:
>
>  - Define irq0_pins, and ensure pinctrl is set in the bridge node.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
