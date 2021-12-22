Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757AD47D85A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhLVUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:43:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45736 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhLVUnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:43:23 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C18A1EC04EC;
        Wed, 22 Dec 2021 21:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640205797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IYOkv/wZNRUq1jFqHRJ8eEFsPFIJMsHiVgTrU4Qn3jE=;
        b=AdNHqG0gUsIG3OleVyOwpKWaZF+BWvfo7oDTY7Flv5oE833oieZI8yK763E0zBAn7kwP2v
        vxwARfMnrEUI+3boPNc+2pCmF032MCFqpYL/RT9oszqYwiLYxogzRsG3FiZ7IUeM9oNanJ
        23K6P1n8ngHQDKH/C/8cFigN0UWHt5o=
Date:   Wed, 22 Dec 2021 21:43:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: Re: [PATCH v18 01/17] x86/setup: Move CRASH_ALIGN and
 CRASH_ADDR_{LOW|HIGH}_MAX to asm/kexec.h
Message-ID: <YcON5Y7DKitiQhHu@zn.tnic>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211222130820.1754-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:08:04PM +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> We want to make function reserve_crashkernel[_low](), which is implemented
  ^^

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> by X86, available to other architectures. It references macro CRASH_ALIGN

"x86"

> and will be moved to public crash_core.c. But the defined values of
> CRASH_ALIGN may be different in different architectures. So moving the
> definition of CRASH_ALIGN to asm/kexec.h is a good choice.
> 
> The reason for moving CRASH_ADDR_{LOW|HIGH}_MAX is the same as above.

This commit message needs to say something along the lines of:

"Move CRASH_ALIGN and ... to the arch-specific header in preparation
of making reserve_crashkernel[_low]() generic, used by other
architectures."

or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
