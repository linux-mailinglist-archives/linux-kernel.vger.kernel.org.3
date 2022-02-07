Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3931A4AC420
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385123AbiBGPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiBGPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:35:00 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F58BC0401C1;
        Mon,  7 Feb 2022 07:34:58 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id b37so23283292uad.12;
        Mon, 07 Feb 2022 07:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yr/4ROsgOU431C1IiWwLR/syaidumkl+irkvpYDiwSI=;
        b=bJXmYzmzwSDfgMR1pZL/ZRobj//YHYggW4BxivvYjEKZxP4DFOCTLVZ1lnzRWyb/Y2
         9JkEoaVJ+B7i1PJ9MSZjisp74wh03A/oIbgEH6SPK8knPo1KP1CWuDOaYxEOQjqEOILt
         0+Qsyizb0QRlS5+DR01Pf6ygBXhArNJzsNu5irMlCrX+Z7jn3SAcZElMsGwH5yQtcBf5
         +P+NGaLRXvVGli/HGkDuCG7Y6/5y27+ZJkQv6PfDs8MOwMUWa+yAZE+7Us5149MqZVo6
         sX3u/9d8WJQayoM2oihanAjSOkC1D3rH89UNsxjoOcdXDnK1ceJS7QqZlwiAlx7ha+4w
         tANQ==
X-Gm-Message-State: AOAM530vvXPTdkk5kog3ava3rcTFqnpx443Tf7sAnIZ6ODvFzoQ2ircr
        5k3rCzlU3zy1PwyhExLd81OnG1OVaCUP7g==
X-Google-Smtp-Source: ABdhPJxMrIwxEwZadMNHbyaEOfAt8qT7Ifbk5/OuvGu+3OLCP/EFGhigjnyztPKSD8ENauTGHcUSvA==
X-Received: by 2002:ab0:4d6d:: with SMTP id k45mr56143uag.55.1644248097141;
        Mon, 07 Feb 2022 07:34:57 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id o16sm2201539vss.9.2022.02.07.07.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 07:34:56 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id w21so23313835uan.7;
        Mon, 07 Feb 2022 07:34:56 -0800 (PST)
X-Received: by 2002:a67:b00e:: with SMTP id z14mr93827vse.57.1644248096517;
 Mon, 07 Feb 2022 07:34:56 -0800 (PST)
MIME-Version: 1.0
References: <20220204161806.3126321-1-jjhiblot@traphandler.com> <20220204161806.3126321-2-jjhiblot@traphandler.com>
In-Reply-To: <20220204161806.3126321-2-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 16:34:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUsWSXqQ6oOP8c0XBJpAoMUg74kTJN1rU8uiq7UXRiKkw@mail.gmail.com>
Message-ID: <CAMuHMdUsWSXqQ6oOP8c0XBJpAoMUg74kTJN1rU8uiq7UXRiKkw@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: renesas: r9a06g032: Enable the watchdog reset sources
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Jean-Jacques,

On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> The watchdog reset sources are not enabled by default.
> Enabling them here to make sure that the system resets when the watchdog
> timers expire.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks for your patch!

R-Car Gen3 and RZ/G2 SoCs have a similar mechanism.
On these SoCs, the boot loader takes care of the configuration, as this
is a system policy that goes beyond the Linux realm.
Perhaps the RZ/N1 boot loader can do the same?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
