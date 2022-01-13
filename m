Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDF48E0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiAMW5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:57:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238106AbiAMW4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:56:54 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D8451EC051E;
        Thu, 13 Jan 2022 23:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642114609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E3WuuaSgTUMYWkpFdHRm3G2QEc/a7IU5Qwj1BCmzeFQ=;
        b=ENMe7pAdUZJzsDQ7dj/zrBXcEdh8iy0SlEOsWUzpWzzbsGR02yfveITl07N0vqVXCcHoNu
        XOid+ikv7bkQHf9hYZfEqY/4e4z6c48zF8fMEtMdQooKqfbiNdL6S7p2oGUdF0m2vijuWM
        az5gQmZjI0rFrkrlEqYch0ssOWB2A00=
Date:   Thu, 13 Jan 2022 23:56:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YeCuNapJLK4M5sat@zn.tnic>
References: <20220113160115.5375-1-bp@alien8.de>
 <YeBzxuO0wLn/B2Ew@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeBzxuO0wLn/B2Ew@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 01:47:34PM -0500, Theodore Ts'o wrote:
> Let's pour one out for being able to run Minix binaries on Linux.  :-)

https://en.wikipedia.org/wiki/Minix_3:

"2013-02-21 ... Dropped support for a.out binaries"

They themselves killed that support a lot earlier. :-)

> Speaking of which, if we're doing this, are there some old system
> calls that we could remove at the same time?

Good question.

Unfortunately, I'm just the janitor removing this and a.out is waaay
before my time. :-)

But I'm open to suggestions on how to determine which are those obsolete
syscalls.

Btw, pls do note that this is removing only the x86 a.out support -
other arches (m68k and alpha) still select HAVE_AOUT and thus the
respective glue in fs/binfmt_aout.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
