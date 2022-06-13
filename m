Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BC5482EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiFMJLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFMJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:11:29 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7477F5A4;
        Mon, 13 Jun 2022 02:11:28 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 43so3946518qvb.3;
        Mon, 13 Jun 2022 02:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0o2bWkZ5eL+Cgv0KyJpTUTbbygBAqPHJMqEpfwXn/fY=;
        b=LGDUsHJO8Fn76tUqTfPSRsXSNprLSeRI+2L8yua+zvAQ0kfTBTFmbBwmGFEOtc0qie
         7wqdBvG8mMnzSOOSrf5HwLRjGGZw5eWqWcNR4RiL7947AGAOrIySA6FBDQ0cQOqUzZ08
         zyutMx9dq9J4Xb4Z4FdYZCFAobCkJngnOoMiANjC5Yd1Uu8r83ruCZ45RR5gZqrb50ES
         sen8kXAa/MiNwDxltiwKcbEz7PEIftsho4TSILPovoGFqYA19geoCK9u/p2nQpYBG6lQ
         v7xbUk3vAx6wdDVGfcsETmq8KhPWi388qVzUGZ0UNM4lZFHONAgdfbjwJq2aSV3bjCeK
         UsPw==
X-Gm-Message-State: AOAM533zM0AIqFywindqSoWo/0qWsD4XgxAYYa1gxnQvTyYLoKRdyQoT
        cwPwPjkJjPelIDE1ouAvYbOp1gWMuRvNCw==
X-Google-Smtp-Source: ABdhPJzMdhYtqJGs0UxkaBX5BQdmZWm/z02gU//ZqQh62x5yRueEdzOpgBcNnCnDxR7IgxIef3cViA==
X-Received: by 2002:a0c:f88f:0:b0:46b:8c17:bd18 with SMTP id u15-20020a0cf88f000000b0046b8c17bd18mr31219431qvn.9.1655111487737;
        Mon, 13 Jun 2022 02:11:27 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a440c00b0069fc13ce23dsm6430815qkp.110.2022.06.13.02.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 02:11:27 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-30ec2aa3b6cso44391207b3.11;
        Mon, 13 Jun 2022 02:11:27 -0700 (PDT)
X-Received: by 2002:a81:f41:0:b0:313:4d6c:49db with SMTP id
 62-20020a810f41000000b003134d6c49dbmr33105243ywp.384.1655111486940; Mon, 13
 Jun 2022 02:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151355.24175-1-wsa+renesas@sang-engineering.com> <YqZDAiB/taLwmamr@shikoro>
In-Reply-To: <YqZDAiB/taLwmamr@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jun 2022 11:11:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWO0zgmRKMpcSXSdshj6Fh8uu3Ch_FCVDEocdaVPaAUUQ@mail.gmail.com>
Message-ID: <CAMuHMdWO0zgmRKMpcSXSdshj6Fh8uu3Ch_FCVDEocdaVPaAUUQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a779f0: Add thermal support
To:     Wolfram Sang <wsa@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linh Phung <linh.phung.jy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
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

Hi Wolfram,

On Sun, Jun 12, 2022 at 9:48 PM Wolfram Sang <wsa@kernel.org> wrote:
> On Wed, May 25, 2022 at 05:13:55PM +0200, Wolfram Sang wrote:
> > From: Linh Phung <linh.phung.jy@renesas.com>
> >
> > Add support for 3 TSC nodes of thermal. The 4th node is for the control
> > domain and not for Linux.
> >
> > Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
> > [wsa: rebased, fixed resource size, removed unused 4th node breaking probe]
> > Signed-off-by: Wolfram Sang <wsa@kernel.org>
>
> Eeks, this should have been:
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Shall I resend?

No need to resend, I can fix that while applying.
Unless you want to make other changes, which I believe is not the case,
as only the DT bindings patch needed a new version?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
