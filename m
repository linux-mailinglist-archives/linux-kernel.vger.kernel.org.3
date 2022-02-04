Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806174A94D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbiBDIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:04:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbiBDIED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:04:03 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 869161EC06A9;
        Fri,  4 Feb 2022 09:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643961838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s28PuTxPYod+byycJWmRofsjhJFgkcOYqHoOHuLpQ18=;
        b=EopqNrR4AWHHHSxq1qCATjmPeSdSsHMhwFGyp6ed41fv3IRkd3Ow9iQk7yCEOvU9vFfm0C
        1WhygHSTKjBsNfmNn+D7N/olpOG0+YKGGy4rmeVyzIOduqqNICl71AxMJCNgzPK9CVt7kd
        NQTjqGhPzDPvMpmGWTLfalKOM7yxV5o=
Date:   Fri, 4 Feb 2022 09:03:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <Yfzd6O/6FIM6KGz7@zn.tnic>
References: <20220203201754.1145358-1-keescook@chromium.org>
 <CAHk-=wj45HHNEvjKo-vNgFmCNtFW+rnQgmuBqhb9+eJ5pumvnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj45HHNEvjKo-vNgFmCNtFW+rnQgmuBqhb9+eJ5pumvnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:14:11PM -0800, Linus Torvalds wrote:
> There are still a few objtool warnings about other issues, all look
> somehow related to mce:

I have a small patchset addressing that, ofc. It is on its way to be
sent out but there's always something else preempting me... :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
