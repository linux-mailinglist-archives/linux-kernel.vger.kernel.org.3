Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D28568366
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiGFJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiGFJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:25:05 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212511CFE1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:25:04 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id z7so10576913qko.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7X22/F6gzh/+so/Ni9is1UKMSi5o3TOeyFWgFdTdAM=;
        b=3aTLu+dQnH0iq8Kgjp0Vp8zMuo+DhCnvnLsEhQh6LFi+WKGG4UjmDeBu7rxeyulnJV
         sksYf/5TbCgtSV9+F04xtjaKlPJv+55YuF+dkrWbs6yRgNVMfTWhLJsV2dYNYYCqRzu2
         z8xmxd+0eIu91MSsUC1cgncnFvkQTaBhzt5ELh51995gpDvc93QhSlGIWayRdqeXf5NI
         VqbTxl+/USAsSWSJfW+MpK9QGAx8aIoqdD5SUO7LkEZPhgCD8buP0q4rRteVkB0lL+tS
         1Ouw5pSdYE7Y02aJKbNeRkL7Eg3rSS1s2wSqMLObd4b/WyUX+DswxJxx2cHh8cL+6RkC
         Fm1w==
X-Gm-Message-State: AJIora80GfkxA0QuGupqCjHc55f1m39nURPtaoOm2iQ38KmjgwsX+Cue
        YM3GiGNkOKrvc198i99+ZdGaHUc/ZznWnw==
X-Google-Smtp-Source: AGRyM1s79z7BXhu3YILGYay5mC41q4h6N8hqtF8b+KUbEhzamZx7r5rdThEcrQh+j5GisKj9VfxBNg==
X-Received: by 2002:a05:620a:4587:b0:6b2:527f:2059 with SMTP id bp7-20020a05620a458700b006b2527f2059mr19329857qkb.694.1657099503095;
        Wed, 06 Jul 2022 02:25:03 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id de4-20020a05620a370400b006b253a6dd1fsm12862229qkb.125.2022.07.06.02.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:25:02 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3137316bb69so133539337b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:25:02 -0700 (PDT)
X-Received: by 2002:a81:1090:0:b0:31c:9be5:6c95 with SMTP id
 138-20020a811090000000b0031c9be56c95mr16422508ywq.384.1657099502581; Wed, 06
 Jul 2022 02:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220524075848.21684-1-juergh@canonical.com> <20220524075848.21684-3-juergh@canonical.com>
In-Reply-To: <20220524075848.21684-3-juergh@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:24:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOHVO7Vte0FAMEhx=xRLRqjXsKqNR6Bz0TLqPDWddt9Q@mail.gmail.com>
Message-ID: <CAMuHMdXOHVO7Vte0FAMEhx=xRLRqjXsKqNR6Bz0TLqPDWddt9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] m68k: Kconfig.debug: Replace single quotes
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juerg Haefliger <juergh@canonical.com>
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

On Tue, May 24, 2022 at 10:03 AM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
> Replace single quotes in strings with double quotes to match the majority
> of the rest of the kernel's Kconfig files.
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
