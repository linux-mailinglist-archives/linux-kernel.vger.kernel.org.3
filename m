Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C677754C41A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiFOJAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbiFOJAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:00:03 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E97A240A4;
        Wed, 15 Jun 2022 02:00:02 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id b142so8258057qkg.2;
        Wed, 15 Jun 2022 02:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrrdL6cjB6w0MhOfJZE/2LfI4a2CPe5QZKVfSPZsjhs=;
        b=3bnroyl5CZ902Vjh0DBx/OKtC1Kx//1wAIclGlU3daNSsGb5z8h+dGF82rQ6jmQSsz
         9jwA5U5jrHfTTLNGQo7SHOvJBI3s4mRBrJGmqONp6su7qh7GpYreqoUJuGlJEaGSnkRL
         qOeEjBL067Lskw6deF9DZIjGWrsclDPXgR5f8tXGJ0qBvHV66ADtPvbgethkxBlEVmbA
         RtMx2hZD0zb7aoJi3AiCnIbaMsChxJUkkEUV8rkNayolbRj2Eo2Fqv6U33jElVqVrleD
         EWwn4iCnKy2fY2x81tP53Z5a9Bsi3/nOXP/39kQvLIFgb44z2dqvXaPYeRKLIBLNX7Hf
         J6hg==
X-Gm-Message-State: AOAM531f+mV2Q+phwiQciD4LLz0J/XAkp9wgrdBsyHN9huZSsUCk/6Vt
        7ap2ZHDlWMOdg555prroAdIEjXzWpKJfOQ==
X-Google-Smtp-Source: ABdhPJyUqmSpi50NAJWeTVFlBuDCpMbY7ZsVecPVW6xlP+KNAnb6nO3zmXlxMXMYX6jGyWdZUIbAsw==
X-Received: by 2002:a05:620a:4589:b0:6a6:ca11:7e75 with SMTP id bp9-20020a05620a458900b006a6ca117e75mr7199660qkb.693.1655283601453;
        Wed, 15 Jun 2022 02:00:01 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006a6b6638a59sm11538615qkp.53.2022.06.15.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:00:01 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id t32so19311137ybt.12;
        Wed, 15 Jun 2022 02:00:01 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr8642665ybg.365.1655283600738; Wed, 15
 Jun 2022 02:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220613134914.18655-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220613134914.18655-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jun 2022 10:59:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcWxjBewZ=Cji1+N4pL-5efcBJ9e8R26rZnpA5ALRP8w@mail.gmail.com>
Message-ID: <CAMuHMdVcWxjBewZ=Cji1+N4pL-5efcBJ9e8R26rZnpA5ALRP8w@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: renesas: r8a779f0: Add DMA properties to SCIF3
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Mon, Jun 13, 2022 at 3:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
