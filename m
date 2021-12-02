Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2B4669C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376582AbhLBSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344073AbhLBSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:22:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C559C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 10:19:04 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 174271EC0545;
        Thu,  2 Dec 2021 19:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638469139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4NrW6KpUSPqSJaUcGmatPS4l9HjHrumC5sHPlPOAEFA=;
        b=HqSxonHj10OyqkxDRrJttde9d8Xr7KVIzpi0C78bk6zYsFSdnXFhUK6FOS3hWm73ELVZpW
        3ymqX20vqI7Vbv4TZnpIe52wZbAXoEWITALQX7fcauMmEPU5xPreYBaA8tilItl6+Cj9T6
        n+TRHOCqoTUE/UsDIkDSxkHbXfRom0I=
Date:   Thu, 2 Dec 2021 19:19:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] x86/mm/64: Flush global TLB on boot and AP bringup
Message-ID: <YakOG4lGTk+qiy9N@zn.tnic>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-3-joro@8bytes.org>
 <YXfQoO0McyPiOFwz@zn.tnic>
 <YXf7hBEbW0CmwYwz@zn.tnic>
 <YajA/Ux5ydtP5Bi3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YajA/Ux5ydtP5Bi3@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 01:50:05PM +0100, Joerg Roedel wrote:
> Yeah, that would make sense, but is probably worth its own patch-set.
> Unifying this across arch/x86/ needs to touch a couple more places and
> needs special care so that the function is safe to call from early asm.

I'd gladly review a preparatory patchset doing that. The usual strategy
is, cleanup and refactoring first, new features later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
