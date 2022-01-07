Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529C5486E85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbiAGAQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343805AbiAGAQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:16:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B835C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:16:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE55B61E9A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 00:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A8C36AE0;
        Fri,  7 Jan 2022 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641514592;
        bh=OfWvjgMz/3A2cIrWooPNudV7uT9VchsrhR5VhQdH8dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soRh/bTmEiDBwxCHqevgGU3/fdavQHU24UxRQTjfUtXb7JO/wMUwf48N1HOl/IH3n
         VU2yg3yrwiQDFjhMs47yHKhbqolAHqGBOl/0pyvo24POpX7YLDzbXkZz0Rpg/ufW2C
         nZvMnM9ocIgL7yr2Q4IeS3c2zwuHCzj3TF84A9oo5k5X0Zq01bpcoGHUwCuXCMPSsH
         4DQFGtRINjGlkGuiHQQqKZUJFucR+J+Bu/gm3E6qyIv2cghrXZfQ79BJvbvR0BecEk
         XyGzG4Bg6BdzgkMI0Tm+0dnqcT4De+LebwYHo01kwobUBqPnldzGPq0OF/4aJ9O4z5
         MdsHT4qeNKfJw==
Date:   Thu, 6 Jan 2022 17:16:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Samuel Zeter <samuelzeter@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/2] *** Fix reformat_objdump.awk ***
Message-ID: <YdeGWyzvsXxntcAT@archlinux-ax161>
References: <20220106023606.283953-1-samuelzeter@gmail.com>
 <Ydc8wUjX4hnHg7ZE@archlinux-ax161>
 <Ydd522/ivtZunIXl@szeter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydd522/ivtZunIXl@szeter>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:23:07AM +1100, Samuel Zeter wrote:
> Thanks for the feedback, Nathan.
> 
> > For the future, I recommend putting the maintainers in the "To" field,
> > rather than "Cc", to ensure they actually see it. Additionally, I see
> > some small nits in the commit message that the tip maintainers might
> > comment on, see
> > 
> > https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> > 
> Thanks for the link, I missed that one. What were the nits apparent to you
> in the commit message?

I primarily just saw a couple instances of "This patch", which is
frowned upon in the main submitting patches document:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#submittingpatches

I thought I saw something else but upon further inspection, I didn't.
It is minor enough that I would wait for further review comments from
others to submit a v2.

Cheers,
Nathan
