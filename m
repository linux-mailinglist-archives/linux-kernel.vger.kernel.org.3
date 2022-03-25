Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895A4E7D26
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiCYUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiCYUIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33510FE2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD12661D0A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487CDC2BBE4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648238697;
        bh=JI28cFosj0hQbiQ6cYI23TSiq2VzCwRhljqgvQDbbQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQzDytrmidWl11PE7mtefAgXudCIC5wg7deMIrHPFvoK33hiKNb2LWZpkWQFKow0x
         Ty9B9vw7hrbJe+wp1YeescGfNE5FZw8JlVlKTonO78PDQK2mf3YsGV4oCGjoWsWT22
         oRd3py9q+DMmyQCHf8h/xqabTxUmEpN9JkmdJbiZnlfh/9vQHfKXzR8+kNUEWUq7Kq
         sxgPcUH4UhQ5JaiHotjc27whL2rYnSXH1w0dybOQbZrhOAsc9gsg+nSd3nlBXB5nRK
         18cFOewREj6hRa4PJQD4fCnsD4T3NRok3824hD/mJrX+oi2AGT7l9kZhtpxdvGpPG0
         o6TOXeVquUgQg==
Received: by mail-ej1-f53.google.com with SMTP id a8so17388379ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:04:57 -0700 (PDT)
X-Gm-Message-State: AOAM531XNbMhd9qNEL6cfJTHfeRqr1gZ3UzgLEpxgvuaEran50DOGlma
        UtucMMAi/ftpvgumPUGvTCL0uMzCgQ3WhRoXHQ==
X-Google-Smtp-Source: ABdhPJxIvvSbFL4Y+P7z8qk4Jutm9EIjreGeujAgtNHussiNQ0ZYgeUd3M6mdAAI87dQAF9rWTSVQaigvBxy0g4IjHU=
X-Received: by 2002:a17:907:1c1b:b0:6e0:6618:8ac with SMTP id
 nc27-20020a1709071c1b00b006e0661808acmr13342258ejc.82.1648238695556; Fri, 25
 Mar 2022 13:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
 <CAL_JsqJqb6HYN5cw7GsyFobZxFmhU-ci8w4HKQEdFsx=bC_F3w@mail.gmail.com> <CAPM=9tx+YeOCBZ0WRcSMKTyUYr5ngySratZ0K8tmRZ0rCaFf8Q@mail.gmail.com>
In-Reply-To: <CAPM=9tx+YeOCBZ0WRcSMKTyUYr5ngySratZ0K8tmRZ0rCaFf8Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Mar 2022 15:04:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ7EN0_4qxZL55j2GOHc_D0zEeH1TS+Dp5WJA1bPdgwEQ@mail.gmail.com>
Message-ID: <CAL_JsqJ7EN0_4qxZL55j2GOHc_D0zEeH1TS+Dp5WJA1bPdgwEQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.18-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:01 PM Dave Airlie <airlied@gmail.com> wrote:
>
> > FYI, this breaks the DT bindings. The relevant patches didn't get
> > reviewed nor run thru automated testing because their encoding was
> > 'charset=y'[1]. (While email clients seem to just ignore that
> > encoding, patchwork and b4 do not.) linux-next is still broken and has
> > been since Mar 2[2]. v2 of the fixes[3] have been posted since Mar 9,
> > and still aren't in linux-next.
> >
> > It doesn't have to be fixed in this PR, but it needs to be fixed
> > before rc1. Otherwise, no one can test their bindings using rc1. In
> > general, there's no reason fixes need to wait until after rc1 as
> > Chun-Kuang suggests[4].
>
> With the conflicts that Linus merged, can we get this rebased onto
> Linus merge, and submitted to him?

I applied the series without issue on Linus' current tree aa5b537b0ecc
("Merge tag 'riscv-for-linus-5.18-mw0' of
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux") and
confirmed the binding errors are fixed. Must be some difference in
what's in the Mediatek PR...

b4 shazam -lsSt 20220309134702.9942-1-jason-jh.lin@mediatek.com

Rob
