Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB6578336
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiGRNJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiGRNJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:09:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D312AD6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 460CFB815F8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6738EC341C0;
        Mon, 18 Jul 2022 13:09:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HAYepAxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658149742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7QlNK74ybwRYfzHI8TBP3B7VtPI78+Og9U+7B0YR44=;
        b=HAYepAxMlmZJztlmTWH49hY3/hDdlc+XMv8oBROFi7vjUqOiXNfm3X5k2ibtbnCnOfeAWw
        +gWYnD2ZcIAw8ondAmKUpoALBxjS6O7VZ/NnB1jEZulYYuKMpSPj8+MvXHnZRVrtFGh32Y
        T0nCK1ypSrkG4t9I2xiIcP9zvBJtwvk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dd83422f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 18 Jul 2022 13:09:02 +0000 (UTC)
Date:   Mon, 18 Jul 2022 15:09:00 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sachinp@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] powerpc rng cleanups
Message-ID: <YtVbbMpRbfCWEIFn@zx2c4.com>
References: <20220711232448.136765-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711232448.136765-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Tue, Jul 12, 2022 at 01:24:46AM +0200, Jason A. Donenfeld wrote:
> These are two small cleanups for -next. This v5 rebases on the latest
> git master, as some whitespace was added that made v4 no longer apply.
> 
> Jason A. Donenfeld (2):
>   powerpc/powernv: rename remaining rng powernv_ functions to pnv_
>   powerpc/kvm: don't crash on missing rng, and use darn
> 
>  arch/powerpc/include/asm/archrandom.h |  7 +--
>  arch/powerpc/kvm/book3s_hv_builtin.c  |  7 +--
>  arch/powerpc/platforms/powernv/rng.c  | 66 ++++++++++-----------------
>  drivers/char/hw_random/powernv-rng.c  |  2 +-
>  4 files changed, 30 insertions(+), 52 deletions(-)

I think v5 has reached a completion point. Could you queue these up in
some PPC tree for 5.20?

Thanks,
Jason
