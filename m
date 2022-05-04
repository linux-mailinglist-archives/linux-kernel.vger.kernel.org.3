Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5000B51AE76
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355177AbiEDT73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbiEDT7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:59:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1CD282
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34088B828AA
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDC2C385AF;
        Wed,  4 May 2022 19:55:43 +0000 (UTC)
Date:   Wed, 4 May 2022 20:55:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        alex.popov@linux.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 01/13] arm64: stackleak: fix current_top_of_stack()
Message-ID: <YnLaOw49WTbhmflw@arm.com>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-2-mark.rutland@arm.com>
 <YnKsvNtIlE6cZEOa@arm.com>
 <202205041200.147A737@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205041200.147A737@keescook>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 12:01:11PM -0700, Kees Cook wrote:
> On Wed, May 04, 2022 at 05:41:32PM +0100, Catalin Marinas wrote:
> > On Wed, Apr 27, 2022 at 06:31:16PM +0100, Mark Rutland wrote:
> > > [...]
> > > Fixes: 0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Popov <alex.popov@linux.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Will Deacon <will@kernel.org>
> > 
> > I thought this was queued already but I couldn't find it in -next. So:
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Should this patch go via the arm64 tree for -rc6, or should I just carry
> it as part of the overall stackleak series?

I'll leave this up to Will (we take turns in managing the kernel
releases) but it doesn't look urgent at all to me since it fixes a
commit in 4.19.

-- 
Catalin
