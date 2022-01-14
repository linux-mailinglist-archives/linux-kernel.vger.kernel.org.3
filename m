Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFEA48F084
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbiANTf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbiANTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:35:56 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555AC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:35:55 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF4751EC050F;
        Fri, 14 Jan 2022 20:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642188949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=agjV9qi8tWl33B9p0ZJK5gU0anLZcKEwEfIbDdLAGaM=;
        b=Vj3wPFoiHj30mwjUEDaSfPXiPFf+oOBxQa69DTku5dVqstSHXUcHjieVi+10hzBTPoM50J
        wwFldl8AHcDoAHLZwa5aIveue9zcwBa8BY0buQrgYmJTy4F3mqL+bo4fqbnsF3yeuogGQK
        41ZW4SK0oNDMarkPMCafTN9pGnH52UI=
Date:   Fri, 14 Jan 2022 20:35:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YeHQmbMYyy92AbBp@zn.tnic>
References: <20220113160115.5375-1-bp@alien8.de>
 <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
 <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic>
 <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 08:21:36PM +0100, Geert Uytterhoeven wrote:
> I mean that I can rip it out on m68k.
> 
> Who's gonna take care of alpha?

I'm sceptical anyone would:

$ ./scripts/get_maintainer.pl -f arch/alpha/
Richard Henderson <rth@twiddle.net> (odd fixer:ALPHA PORT)
Ivan Kokshaysky <ink@jurassic.park.msu.ru> (odd fixer:ALPHA PORT)

which leaves me. I could give it a try.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
