Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF894C1450
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiBWNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBWNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:39:25 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44169F6FD;
        Wed, 23 Feb 2022 05:38:57 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id f12so12199268vkl.2;
        Wed, 23 Feb 2022 05:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTposQLuymO44pbPyYRUL/sGoep7NH0SVuUoddkxcYw=;
        b=wdddxZFbGwLNygq82veni4RAYkcUJ18nauOW8yRNEgaqpir5d3iM6F8zfRKeUGKC2Q
         t9sqbifjghNleZd/nPl5A20XTtJ1uXj/vH8zlTKsIG7Co5Eefq9Z4SXHSDrV+7ueeUPM
         8687lrNZ3Z0V0FaPRhoOm51SVcsN+ojXvfDrxy9RX1eWgs17zpp0iBO350ZVK4uOBt2+
         AZwtLwrRPWKClxAF3FI0uf/qxWl/JxSVCo8JlAohErVnSyBXTpx5Mlto6JVyi3jeLxFZ
         80zquxTj3AEaYM3+CrnfC8ThqeRQFnjKe3RaO3LHpcBhGh8zDTATOa22YFWZ4v03ooDJ
         4tLg==
X-Gm-Message-State: AOAM530rRFqYFBjmi0WJGCnoYu4Eo+qNZqXxtIk6A5tBqQQbKHY9xt/p
        h8CstKs0AVu7HE12DX6j+brhfzl3IyNH6g==
X-Google-Smtp-Source: ABdhPJyDNhRNfBLkrrIicLkjr/CQky9hFswFZI5ZyBcMJJEtd1h2kfOVnvlpjP0soCYB2ByswPI7rA==
X-Received: by 2002:a05:6122:114e:b0:32d:4662:65a8 with SMTP id p14-20020a056122114e00b0032d466265a8mr12534019vko.0.1645623536942;
        Wed, 23 Feb 2022 05:38:56 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id d11sm668612vsk.21.2022.02.23.05.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:38:56 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id c36so1424872uae.13;
        Wed, 23 Feb 2022 05:38:56 -0800 (PST)
X-Received: by 2002:ab0:69d0:0:b0:345:72b0:ee12 with SMTP id
 u16-20020ab069d0000000b0034572b0ee12mr3390138uaq.78.1645623536345; Wed, 23
 Feb 2022 05:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20220221095032.95054-1-jjhiblot@traphandler.com> <20220221095032.95054-2-jjhiblot@traphandler.com>
In-Reply-To: <20220221095032.95054-2-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 14:38:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1eb1F5GbvfAydxyMnqLVMmGDTVCxudpgc63WV4wGAQA@mail.gmail.com>
Message-ID: <CAMuHMdX1eb1F5GbvfAydxyMnqLVMmGDTVCxudpgc63WV4wGAQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: r9a06g032: Add the definition
 of the watchdog clock
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

On Mon, Feb 21, 2022 at 10:51 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> This clock is actually the REF_SYNC_D8 clock.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18, as this is only used by DT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
