Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A7545E21
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbiFJIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346525AbiFJIEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:04:55 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E66633F;
        Fri, 10 Jun 2022 01:04:52 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id i25so689081qtq.0;
        Fri, 10 Jun 2022 01:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfQ6+6RXDzdhBSxFYL22382fD6+9vWq5XpLo77tRV5s=;
        b=KKgnB0aw3wPaLB9jNcWz1aoTIswa/9UFRANbq651X6a13JW4kBoUx8EDzhsCdfYolt
         BYpzVzwn0lEML5J98j+jEcl2o2m9PdQTKvuunm1kvQn+tmcL/u8Ztypky7MTpjoI9asi
         cqkofyC1LbWRSJBAi8SEV3tuqgBuThBc5kQKTOaGbrMBvNfxDqgAfGovkBaPbo6qAYEW
         U/lOfYYbFzfYlGlbVNYoPmbY14xeKOg9R/vLr/8BAt19r60IlFQrpGeRYuujVGsEvy2M
         OWv+u1I4D7BkA5ANOU7BtQOrDddQ9DucuO1KLxQ+6trmAdRbZDTmUmDpY7Jvg6mT6Tc5
         2MTw==
X-Gm-Message-State: AOAM531tc88HpgxWO/9kf8irM9gEp2FNXkkG2gMtEr6h0GcbsUghAAEM
        XcT6KZ0ZEvGQFpFVkPqAK0EQU/jqidZrkw==
X-Google-Smtp-Source: ABdhPJw3cPFK4IBmJ5EmAWsFjoKeSOaweaDZWsEgAcXl6aka4cE3wwHbrZYXSGQ2wrDlDY5Br9yqkQ==
X-Received: by 2002:ac8:5856:0:b0:304:da79:e117 with SMTP id h22-20020ac85856000000b00304da79e117mr32243128qth.379.1654848291909;
        Fri, 10 Jun 2022 01:04:51 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a448e00b006a6f8d26b35sm8041803qkp.63.2022.06.10.01.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 01:04:51 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id r82so45689700ybc.13;
        Fri, 10 Jun 2022 01:04:50 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr44746879ybh.36.1654848290710; Fri, 10
 Jun 2022 01:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220609200709.4455-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220609200709.4455-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Jun 2022 10:04:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbq+AUq6LoT3+b0NqjqyNtS3BKvonzt2PLuTAPv-GwQg@mail.gmail.com>
Message-ID: <CAMuHMdWbq+AUq6LoT3+b0NqjqyNtS3BKvonzt2PLuTAPv-GwQg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: rcar_gen3_thermal: improve logging during probe
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Jun 9, 2022 at 10:23 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> When setting up a new board, a plain "Can't register thermal zone"
> didn't help me much because the thermal zones in DT were all fine. I
> just had a sensor entry too much in the parent TSC node. Reword the
> failure/success messages to contain the sensor number to make it easier
> to understand which sensor is affected. Example output now:
>
> rcar_gen3_thermal e6198000.thermal: Sensor 0: Loaded 1 trip point
> rcar_gen3_thermal e6198000.thermal: Sensor 1: Loaded 1 trip point
> rcar_gen3_thermal e6198000.thermal: Sensor 2: Loaded 1 trip point
> rcar_gen3_thermal e6198000.thermal: Sensor 3: Can't register thermal zone
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change from v1: reword the dev_info string to be more like the original
> one. Added a check to add the plural-'s' only when needed.

Thanks for the update!

> Geert: is this better now?

Much better!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
