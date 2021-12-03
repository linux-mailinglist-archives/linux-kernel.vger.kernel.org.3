Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566974674A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351498AbhLCKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:21:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34268 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239694AbhLCKV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:21:56 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B83B91EC04F2;
        Fri,  3 Dec 2021 11:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638526707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UpVtLakh6TxIEmDLQ5jw4zQYg2Y5AU8T2AtN4sR7uZ8=;
        b=XZPYWGMXcw7ZW4q6+lzGWqixe6uz+19Wg5UOJKOfDDZ4cC9yptm1uUXBePj8T/Q+1rIdum
        /QR0mcuraguA4L8ljffa6Nasf5VQ0bpacNtZD4qpKnKgU9B79ukUFfknuh59Q9us/1NG/8
        KMQpPGmodu5yQdB/qSQi2QffhM5Fpbo=
Date:   Fri, 3 Dec 2021 11:18:31 +0100
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
Message-ID: <Yanu9wLar6Dp6UQ6@zn.tnic>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
 <8dc8ec1c-3146-09fe-36ce-52999b06f6a0@linux.alibaba.com>
 <Yanl1HeO1m2TNbyv@zn.tnic>
 <3a4e3ba6-0ee1-b65f-f2b8-744d4dded6f8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a4e3ba6-0ee1-b65f-f2b8-744d4dded6f8@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:10:47PM +0800, Lai Jiangshan wrote:
> It is not urgent nor it is something should be put in cold cellar.
> Please consider queuing the first three patches at least.

So there are fixes in there, which should go now. It's what I thought
too when looking at those and was about to suggest to send them
separately but that's fine - I can pick them out.

> It is cold for a week, I think a ping is proper than a resending.

With such a huge patchset I don't think you need to ping or resend every
week but only after people have looked at it at least somewhat. But I'm
sure you can imagine people are busy as hell so looking at that takes
time so you'd need to be patient.

It might be even helpful if you could split it into more palatable
portions of maybe 10-ish patches each, if possible, and then send the
first portion, wait for review and only send the second portion after
the first has been applied, etc.

That would make life easier for everyone involved.

> The asm entry code is always a pain and this patchset gives a start
> in future with reduced asm code and pain because some future changes
> might be redirected from asm to the C hopefully.

Yes, I think we all agree on that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
