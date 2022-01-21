Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF322495FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349259AbiAUNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiAUNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:32:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D40C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:32:35 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C6A81EC0606;
        Fri, 21 Jan 2022 14:32:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642771950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hdl5yhDBY86sBHAUwJnc4cfV4sB1Lwi1p/NJUmPImH4=;
        b=E/FzQC27PSURtfhOgSF/FIpNGZ2ViItTtlMWUTY+kdYBoUR90W2IFEItPW+P4344ZZxPs6
        ECSI4He2wC31QnTf3LH2qKSbPFauAgPchKL+AfEtOwvEDKoBwkatLUxrNhI3NJNvejIV6+
        2QbNIh2fiKa1ilNdE06iFyVoviBu3tY=
Date:   Fri, 21 Jan 2022 14:32:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Michael Matz <matz@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v1 3/3] Documentation: x86-64: Document registers on
 entry and exit
Message-ID: <Yeq16JjCBXmxgWaj@zn.tnic>
References: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
 <20220107235210.1339168-4-ammarfaizi2@gnuweeb.org>
 <37ce01e8-43eb-7eff-9667-745e17cdd65f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37ce01e8-43eb-7eff-9667-745e17cdd65f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 04:02:27PM -0800, Andy Lutomirski wrote:
> This is SYSCALL64 registers on entry, not general registers on entry. Also,
> this has little to do with the entry logic, so it probably doesn't belong in
> this file.

Right, except that syscall is also a kernel entry point so it kinda
belongs in a documentation file called "entry". :)

Srsly, I'd really like to keep the note about which registers glibc
considers clobbered and which not, documented somewhere as that is
practically an ABI which is not (yet) in the psABI doc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
