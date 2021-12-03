Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25D46742C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbhLCJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:42:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351460AbhLCJmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:42:53 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF06D1EC056D;
        Fri,  3 Dec 2021 10:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638524365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=erx7Grh6f9xu51WALClCrV83+AKmHQ8bL8nyvUzpln0=;
        b=D2qljebn2T9ZhBbKvW9GDcgdKoWix5xa1D6kF9iWZy3YqvpQxlc76CAoHxFv+rmOToaZ9z
        opvSmcY7mfAqwyKkwGA8oUzzIprNABRTtsMYO6aMEIt5vNFwELf0aPOhAi3H20/19MsUSq
        FTYDmYE4lNmy4hNFrkqHY7YXxAjOb0I=
Date:   Fri, 3 Dec 2021 10:39:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH V6 00/49] x86/entry/64: Convert a bunch of ASM entry code
 into C code
Message-ID: <Yanl1HeO1m2TNbyv@zn.tnic>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
 <8dc8ec1c-3146-09fe-36ce-52999b06f6a0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dc8ec1c-3146-09fe-36ce-52999b06f6a0@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:31:11PM +0800, Lai Jiangshan wrote:
> Ping.

Can you explain to me what's with all the pinging?

Does your patchset contain anything urgent that needs immediate review
and handling or is it something which is a nice idea but needs to be
reviewed very carefully because it is asm entry code which is always a
pain and careful review cannot be done when rushing people?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
