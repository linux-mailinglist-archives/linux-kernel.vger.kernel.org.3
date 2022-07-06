Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6456836C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiGFJZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiGFJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:25:25 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16961A044
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:25:24 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id h19so17392015qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaDAtHQWvfEw5MYYPxQYlNYkXhU2XcrxUemUI7UF4Pc=;
        b=UFiZuMab9z+/IU39R3YHBfXL/c3V5C/GOzUghnl1/Ddy5242Pb0woqtd/Nu+jkoW0C
         4LND/CabkWCq6XuyGe8WRDmZx3Pspm8uevw4nzwwQpquShXJ1WnW5AtpXuboh4ydabVr
         wf/Q5nIlgKQBRMFtGT+rzRc5/lM8Tz4OS7geyELDi3upyeCNt9TJHFODSDHrq+DGGs/6
         nH5lsGMveLoKc2H+654lBWndzGZOUnHM936qkQv4cxyvDI53DxrMMlok3hPONrhox0tZ
         WaRC9j4aL1KPAuPPYuyV4iO4gJmOq3NaPnm2MD5HNpyFtYckgL4uq4YQPWkFy9pAcqS9
         OQcQ==
X-Gm-Message-State: AJIora8zueGpz3GcijoWcchyFtQwPL1FHWM01bQ4WoEKJkaarsD+abCN
        RgiPWfIYqFlySlxw8vgyeCNmeMKEpfXtIQ==
X-Google-Smtp-Source: AGRyM1uhCOHRVyYoJjPmEhsXiPKov9HOgtypXfv6dnSE3D68xJDLMlfr+OFHTCs/105XBF9mCPzjWA==
X-Received: by 2002:a0c:8084:0:b0:472:f26b:59f7 with SMTP id 4-20020a0c8084000000b00472f26b59f7mr12874863qvb.62.1657099524007;
        Wed, 06 Jul 2022 02:25:24 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a69d7f390csm29933734qkp.103.2022.07.06.02.25.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:25:23 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c8a1e9e33so81519907b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:25:23 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr18140330ywj.316.1657099523437; Wed, 06
 Jul 2022 02:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220524075848.21684-1-juergh@canonical.com> <20220524075848.21684-4-juergh@canonical.com>
In-Reply-To: <20220524075848.21684-4-juergh@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:25:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVih0jegzAD32_tNHheGCFavV7RPGtHTtos3=-AX4D2Cg@mail.gmail.com>
Message-ID: <CAMuHMdVih0jegzAD32_tNHheGCFavV7RPGtHTtos3=-AX4D2Cg@mail.gmail.com>
Subject: Re: [PATCH 3/3] m68k: Kconfig.machine: Add endif comment
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juerg Haefliger <juergh@canonical.com>
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

On Tue, May 24, 2022 at 9:58 AM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
> Add missing trailing endif comment.
>
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
