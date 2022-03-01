Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BDD4C9086
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiCAQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiCAQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:38:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C340483BD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:38:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFA37B81B46
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD0FC340F0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646152692;
        bh=o0GEpUU5lCIEFkss9VdE1n+5jj+Irmt9ZGLtnqZXuxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F/pgVlo+fHbXRTSbXgWdNaiDIdor7BP32yQ954X5N3tCI2AXcZMOlN05ioC4ggLuS
         hbBMtUHHclrT2yBXOBPUx3LKLN5NqSoNWfMfMI629l6jHUHbbh2JgSi8vj7jSumXGa
         3R7z2eKAuaT3kgQSP08wSsUClYU7gVBdB85FuCdu4vpyrcfIh7LEmgrFalW235vhvk
         Nu6UnKH1j4kAPoOfkIBbCkD4pJDKZWtgUUEUAi5wRxt/rPD/WBjjR+mQryfiQP7a8D
         QGgQVC/HiCnhiCkHeqe+CNgNJZ8WnZJEC1v1WVcKRM/MUR3MAe2ayuCrl+Aci+yQAK
         TvV/HFWsrDEkQ==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2dbfe58670cso9211827b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:38:12 -0800 (PST)
X-Gm-Message-State: AOAM531atLubq4iAmQUhByRDsOFhKu7uS9ASBg6H6/d1HhE24G8SJgVe
        EWk5X8v6KBB4CWpvsHDpx+q3q3e+/epg4rQgjNQ=
X-Google-Smtp-Source: ABdhPJx7H9z9CiGthKSa+ZkFp2GOZZvI/rJ0lPpOzIRe07DAsT1OlEia/NoCLmOJvzh4QW6uuSRaCFIxzeh9tIkz6eE=
X-Received: by 2002:a81:84d5:0:b0:2d1:e85:bf04 with SMTP id
 u204-20020a8184d5000000b002d10e85bf04mr26274102ywf.465.1646152691456; Tue, 01
 Mar 2022 08:38:11 -0800 (PST)
MIME-Version: 1.0
References: <Yh5ASXVoWoMj7/Rr@Red> <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
In-Reply-To: <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Mar 2022 17:37:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
Message-ID: <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
Subject: Re: boot flooded with unwind: Index not found
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 at 16:52, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> > Hello
> >
> > I booted today linux-next (20220301) and my boot is flooded with:
> > [    0.000000] unwind: Index not found c0f0c440
> > [    0.000000] unwind: Index not found 00000000
> > [    0.000000] unwind: Index not found c0f0c440
> > [    0.000000] unwind: Index not found 00000000
> >
> > This happen on a sun8i-a83t-bananapi-m3
>
> Have you enabled vmapped stacks?
>

This is probably related to

538b9265c063 ARM: unwind: track location of LR value in stack frame

which removes a kernel_text_address() check on frame->pc as it is
essentially redundant, given that we won't find unwind data otherwise.
Unfortunately, I failed to realise that the other check carries a
pr_warn(), which may apparently fire spuriously in some cases.

The 0x0 value can easily be filtered out, but i would be interesting
where the other value originates from. We might be able to solve this
with a simple .nounwind directive in a asm routine somewhere.

I'll prepare a patch that disregards the 0x0 value - could you check
in the mean time what the address 0xcf0c440 coincides with in your
build?
