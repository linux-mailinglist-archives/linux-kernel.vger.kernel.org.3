Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7524554B4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiFNP3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbiFNP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:29:29 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD02377D5;
        Tue, 14 Jun 2022 08:29:28 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id l3so5003722qtp.1;
        Tue, 14 Jun 2022 08:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMlrFysL6NER0BlZN8jiCoV2LFdvTf/MmGUlZKHHukw=;
        b=ojbXCcKkbOHdD1xyrpe/zmRzfC8qA/YWYdgc/3bxEOAbaO6/eC/vr4WFzsVndFWZZR
         fuV2ItycLhzUWv4mr1hUGiTHX6OR54p7DToSgeUHfX9fyuqmFfQDecKOQBp5pLBvoC+q
         pl/UFmKdR6sR8YVo7bhbTxpTvzmBzWuqhEfgMzdW9/lp7UaCxfDnv4e/DraAzYTj0hqL
         lWl6TI3TdPE00//ojKvp9qwBzSXpqLQw5zRrt8a3VGuLsCH/e2Av8eCSdd2LX9TeqJPW
         JPBCcQDea69krqZQwSOYPv/hHBLic7GlgUoZL8LKpQJd4GB0DJN75P8wfFKpWf3dU1rV
         gK1Q==
X-Gm-Message-State: AOAM532cbRxWf9RCPB6JZPsgiyodzXS8f0iatwZCtH5ZfXVmHGPHvHHd
        ADA556l9gpkOb33kdd/00/zhM+0wBqZmIQ==
X-Google-Smtp-Source: ABdhPJxBBhea0ODzbRw9JZ69ent/Hrzi+3mK0sBTDk/5UchPN+9CFzfIqEX7AmRVkvBWmqMJrEGRTA==
X-Received: by 2002:ac8:67c8:0:b0:305:e4e:43db with SMTP id r8-20020ac867c8000000b003050e4e43dbmr4793499qtp.562.1655220567126;
        Tue, 14 Jun 2022 08:29:27 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 7-20020a370507000000b006a725432959sm9257393qkf.37.2022.06.14.08.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:29:26 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id p13so15790209ybm.1;
        Tue, 14 Jun 2022 08:29:26 -0700 (PDT)
X-Received: by 2002:a25:7307:0:b0:65c:b98a:f592 with SMTP id
 o7-20020a257307000000b0065cb98af592mr5524851ybc.380.1655220566545; Tue, 14
 Jun 2022 08:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220613131007.10027-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220613131007.10027-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 17:29:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUaSi_cnmVSARVsSpB_J=-rLwgg9+5+B3Qj1-+LccDGtg@mail.gmail.com>
Message-ID: <CAMuHMdUaSi_cnmVSARVsSpB_J=-rLwgg9+5+B3Qj1-+LccDGtg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,hscif: Document r8a779f0 bindings
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Mon, Jun 13, 2022 at 3:10 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
