Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F00568A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiGFN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGFN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33FA167EA;
        Wed,  6 Jul 2022 06:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F75761E2E;
        Wed,  6 Jul 2022 13:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30861C341C6;
        Wed,  6 Jul 2022 13:56:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QO+KNfi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657115762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iz7TiYsQg28wABHZ/Sl8o/JBmFyo1X4h6JHxFO/2QFU=;
        b=QO+KNfi7bosC2YJDjjg+3/p1YBt79iQ4yagiPDOsXPXuswqtg6CW7QzzzzLHe5bYAJajqz
        lJ1uYpw141WbDpvaa9p1cFXyX5AAi5jWxlLdhhC1cA7kV3FkaOwez6I8Mf7z7lgI0KslPb
        HD4WDjK1rPD6V6STN+1QfEhFQxvzuOo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c2f90772 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 6 Jul 2022 13:56:01 +0000 (UTC)
Date:   Wed, 6 Jul 2022 15:55:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] random: remove CONFIG_ARCH_RANDOM
Message-ID: <YsWUa7JWsYDYDFBL@zx2c4.com>
References: <20220706003225.335768-1-Jason@zx2c4.com>
 <20220706105411.406259-1-Jason@zx2c4.com>
 <YsWBhaZT5dCQHfwp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsWBhaZT5dCQHfwp@zn.tnic>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Wed, Jul 06, 2022 at 02:35:17PM +0200, Borislav Petkov wrote:
> On Wed, Jul 06, 2022 at 12:54:11PM +0200, Jason A. Donenfeld wrote:
> > So this commit simplifies things by removing CONFIG_ARCH_RANDOM, keeping
> 
> No need to say "this commit" or "this patch" - just write "as if you are
> giving orders to the codebase to change its behaviour."
> 
> In this case, "So simplify things by ... "

Thanks for the tip. I used to do this, and then in the last 3 weeks my
style unwittingly slipped into this new thing for some reason. I've got
to send a v+1 anyway for some more build breakage, so I'll fix that up.

Jason
