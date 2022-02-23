Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666824C1461
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiBWNk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiBWNk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:40:26 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900EAC056;
        Wed, 23 Feb 2022 05:39:59 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id k5so1450987uao.2;
        Wed, 23 Feb 2022 05:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPeYplQbbLYXGtovtVVhsdi1q95Z7tVy8kR/XdoEwFw=;
        b=PX7Nt9qXpqmTjlFOhhrsb5M/khaHHVULEAZc7ld8M2DZqySjYEcdAERmkeamrdW/aU
         Vy91Muu7B/Qi09vclq9GJ3lSKdbRjnWlNa4bjwT1LX4jqIWqCHomrF6Js/54IQsdCGgl
         tYPIW0jKrvm88C/94Zebd9QiCvh2mreNv5QBAk/j3/sTeQW64tGMETml+dan/2Inlhns
         8hUrm8iBx3vO7BjOiaFscGf7Itc8ZgN7rjDu0Vzr/CErLH4bnqvMRMS1aMqCakGv2e4L
         NSGAHCtwMxnIqB6JHsigQnVmLdDIEMp60YQRqoL2IDnrYLmWCIvBKgp597YTnicPyrqs
         ldHg==
X-Gm-Message-State: AOAM531a69GdEbv6Vhvyy1rl+1jKsNe3FwsHb8Q3ivxLXaF93y2xgPQG
        0d35jLtEVe4FJoWRcdvAQ2yZzq0H4qG2ng==
X-Google-Smtp-Source: ABdhPJwNxI2R6AEdabxPGiQHMAf1Ybqt+uMRJxs0wwwqMa5UMibfkulRZnrAVCVLljIQa5ADJ/LFiQ==
X-Received: by 2002:ab0:2111:0:b0:341:8339:51b4 with SMTP id d17-20020ab02111000000b00341833951b4mr10756970ual.76.1645623598626;
        Wed, 23 Feb 2022 05:39:58 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id t127sm4198604vkb.31.2022.02.23.05.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:39:58 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id y26so3187221vsq.8;
        Wed, 23 Feb 2022 05:39:57 -0800 (PST)
X-Received: by 2002:a67:e10e:0:b0:31b:956b:70cf with SMTP id
 d14-20020a67e10e000000b0031b956b70cfmr11904088vsl.77.1645623597826; Wed, 23
 Feb 2022 05:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20220221095032.95054-1-jjhiblot@traphandler.com> <20220221095032.95054-5-jjhiblot@traphandler.com>
In-Reply-To: <20220221095032.95054-5-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 14:39:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX=Yos_CGcBXbV_+WGcTkz18mxiR4xbXwPqjR4mUGnMtQ@mail.gmail.com>
Message-ID: <CAMuHMdX=Yos_CGcBXbV_+WGcTkz18mxiR4xbXwPqjR4mUGnMtQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] ARM: dts: r9a06g032-rzn1d400-db: Enable watchdog0
 with a 60s timeout
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Mon, Feb 21, 2022 at 10:51 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> 60s is a sensible default value.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Will queue in renesas-devel for v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
