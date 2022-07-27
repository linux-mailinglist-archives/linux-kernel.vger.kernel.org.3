Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237F5581D39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiG0BhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiG0BhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FC205DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E1E6175F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50503C433C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:37:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IGQbirVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658885830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Fmgx8N0WQu3EBYzpYloNNBsA8XbCPiWqgOrlE5ogDk=;
        b=IGQbirVRt+XAEdw/tsv9aC4FXX47bbZHb8uoUE2Sl7Y3abOnW/dWAYjjAxmKxWQLvnrfw1
        RyslTfS71yq0xis8gHLpEiS2spKWYXibLTxUFLH+mMFI3JFeHllHM1P5m/ncXMJYMrvkYs
        b6LzVMecFEZTK9S/KMuditRJSEAJ+sU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf5d4848 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 01:37:10 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31f445bd486so41895547b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:37:10 -0700 (PDT)
X-Gm-Message-State: AJIora8kBUwAOgY2Nl2yhwYzX2EBlGzbbFK9LcP1hqVGZCMDoZ45qcfu
        SYUsg52Sl7JOMvYk69vhKhtB99wRdbx4oBML5ic=
X-Google-Smtp-Source: AGRyM1tHtJ03wVUfoEkcgXr50XYYj4caRdR7VA2UuBfl7LiVUfhisHMKiq0eLG6EFkJRUzT6AFqBdhb+qZrKlPUwn0s=
X-Received: by 2002:a81:59c4:0:b0:31f:4804:76ad with SMTP id
 n187-20020a8159c4000000b0031f480476admr5528716ywb.143.1658885829426; Tue, 26
 Jul 2022 18:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220711232448.136765-1-Jason@zx2c4.com> <YtVbbMpRbfCWEIFn@zx2c4.com>
In-Reply-To: <YtVbbMpRbfCWEIFn@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 27 Jul 2022 03:36:58 +0200
X-Gmail-Original-Message-ID: <CAHmME9pMOQKnMUQQyOA+CkN5scQjtLN79pvdYSu70MkuU207cw@mail.gmail.com>
Message-ID: <CAHmME9pMOQKnMUQQyOA+CkN5scQjtLN79pvdYSu70MkuU207cw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] powerpc rng cleanups
To:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, Jul 18, 2022 at 3:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey again,
>
> On Tue, Jul 12, 2022 at 01:24:46AM +0200, Jason A. Donenfeld wrote:
> > These are two small cleanups for -next. This v5 rebases on the latest
> > git master, as some whitespace was added that made v4 no longer apply.
> >
> > Jason A. Donenfeld (2):
> >   powerpc/powernv: rename remaining rng powernv_ functions to pnv_
> >   powerpc/kvm: don't crash on missing rng, and use darn
> >
> >  arch/powerpc/include/asm/archrandom.h |  7 +--
> >  arch/powerpc/kvm/book3s_hv_builtin.c  |  7 +--
> >  arch/powerpc/platforms/powernv/rng.c  | 66 ++++++++++-----------------
> >  drivers/char/hw_random/powernv-rng.c  |  2 +-
> >  4 files changed, 30 insertions(+), 52 deletions(-)
>
> I think v5 has reached a completion point. Could you queue these up in
> some PPC tree for 5.20?

Just paging again. Do you think you could queue these up for 5.20?
This trivial series is over a month old now.

Thanks,
Jason
