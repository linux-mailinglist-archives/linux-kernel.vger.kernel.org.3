Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2C4788EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhLQKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:30:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235059AbhLQKaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:30:13 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BAB61EC0554;
        Fri, 17 Dec 2021 11:30:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639737007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tdo4CDZxm4mdgSRICCdU1txbPkkCZCgIrt4aDnHMyzs=;
        b=hFJIfU17piLrmQHHqqkSoqgZITmcQPSMnFIvb8y64h1JRZPJ4Q4wy7Dy0LJjnM4PkZoivw
        Bm9qoJVTsyaVS5HlCGw6XANZSnT7IM7lUn9gBp2MmDOSyXVpN1nfN82OgryMVv2d1B6SHH
        h4YDnJPQUzn2ynUTB+kedWHmdfd6eO4=
Date:   Fri, 17 Dec 2021 11:30:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: The code for returning to user space is
 also in syscall gap
Message-ID: <Ybxmsn1wp8NZjXaD@zn.tnic>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-4-jiangshanlai@gmail.com>
 <YbkR36Vpb1h5SlMZ@zn.tnic>
 <YbxhBQg99YCTrYN3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbxhBQg99YCTrYN3@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:05:57AM +0100, Joerg Roedel wrote:
> While it is true that the exit path can't trigger #VC right now, it will
> be able with SNP.

How?

I audited the handful instructions in there and didn't find anything
that would cause a #VC...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
