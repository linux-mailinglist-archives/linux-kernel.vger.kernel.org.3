Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF785445F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiFIIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiFIIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:34:29 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9C1DD4E4;
        Thu,  9 Jun 2022 01:34:27 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id 15so12058675qki.6;
        Thu, 09 Jun 2022 01:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4Ec1eljUBeyb1Vvi018mHmYfxdCiE/QJI1+tCxJr6Q=;
        b=VgbloTMo1rVtVO8eprugfabvxi//YTy+JkrVb5CGkj3EMyhiX/ePxZZklvC7KMDgqu
         5MnGHdqhcUS4NXWo0d+nq1ZB4plciE1TjONzKZDJgDYvIyq3rpEyZhYzOMuFavFjvcPD
         OD0ZGurjZwMdz9cSy9u8Mk27/GpM815dDdKMhuYJVllX1RAfJ0QN1Q2LXOnahaL0Cq8w
         oHiXssNBdMbboGVrBFbVSURETB9VuXMNvz0EH7lxDGwuXJO2dVUNNTp4JiQzqNdjhBmG
         yiHQazfYCpsEEb0SEARayBFT3vQUtCKzL1fChAj3Yyez76HJZOrM5TXWDUPNL00S0OrI
         wA3A==
X-Gm-Message-State: AOAM530wxxz1nQgOTVc+1Ztec2bMuQ7SBKDSDVxk+9upsy6agDJRyny7
        TkBKFjly+8SdRCphlaOAEYGX120EOd0Jww==
X-Google-Smtp-Source: ABdhPJw502T52BLEZSaHzNV7lXCfnU9SIIWtVxO8E47YhW8bIkEC4+OWvVMo3kT4nsRACjEMGQkplQ==
X-Received: by 2002:a37:a781:0:b0:6a6:9b4c:fc8d with SMTP id q123-20020a37a781000000b006a69b4cfc8dmr21277333qke.657.1654763666860;
        Thu, 09 Jun 2022 01:34:26 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id f6-20020ac84646000000b00304e9dc0fd5sm8866586qto.12.2022.06.09.01.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 01:34:26 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id r3so6413901ybr.6;
        Thu, 09 Jun 2022 01:34:26 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr39779941ybu.604.1654763666155; Thu, 09
 Jun 2022 01:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151130.24103-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220525151130.24103-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 10:34:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2az5kt9+ZC5YdjLJ6rVaxw2WeLV-0N6BON6jZNuRzKA@mail.gmail.com>
Message-ID: <CAMuHMdX2az5kt9+ZC5YdjLJ6rVaxw2WeLV-0N6BON6jZNuRzKA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r8a779f0: Add thermal clock
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
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

On Wed, May 25, 2022 at 5:11 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
