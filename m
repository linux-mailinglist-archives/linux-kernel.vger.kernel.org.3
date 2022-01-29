Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B524A3007
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbiA2OT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiA2OTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:19:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC552C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 06:19:49 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCEE91EC0523;
        Sat, 29 Jan 2022 15:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643465983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mlgkQN30yKP1yyHab8epCYEqHFx4EKvPLpk45D+Gg4g=;
        b=lhZQUwXgKfpVTKr8jpkl9oT2DfptDGoeXkzEocDK6ttv5boT0sMYUcsvIw+ZpvlI8ITC4U
        T2+TBI5zzjGPpk4ChHtP4yblViSspzTsVGXvWctHdgZ0Vf+DAYE+oMG9oCCYG1Kpc3Rbsc
        nOt23QX+t5i98zrLplL1L4QWsYZXSM8=
Date:   Sat, 29 Jan 2022 15:19:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of
 X86_FEATURE_AMX_* to the word 18
Message-ID: <YfVM+xdDS76E3d6r@zn.tnic>
References: <20220117062344.58862-1-likexu@tencent.com>
 <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
 <47362220-30d5-c513-a2aa-61187ee91c41@redhat.com>
 <bc272301-af11-621a-3bda-ee398754fd0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc272301-af11-621a-3bda-ee398754fd0a@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:41:31AM +0800, Like Xu wrote:
> Thanks Dave and Paolo.  Just for your convenience:
> 
> From 588c2221999c1f5860188a7cbaeb0d4f80c6d727 Mon Sep 17 00:00:00 2001
> From: Like Xu <likexu@tencent.com>
> Date: Mon, 17 Jan 2022 14:23:44 +0800
> Subject: [PATCH v2] x86/cpufeatures: Move AMX CPU feature defines to correct
>  word location
> 
> From: Like Xu <likexu@tencent.com>
> 
> The word 18 for Intel-defined CPU features from CPUID level 0x00000007:0 (EDX)
> has been defined in the same file. Move the definitions of X86_FEATURE_AMX_* to
> the right entry to prevent misinterpretation. No functional change intended.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1 -> v2 Changelog:
> - Refine the commit message and subject; (Dave)
> 
>  arch/x86/include/asm/cpufeatures.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

$ test-apply.sh /tmp/urgent.01
checking file arch/x86/include/asm/cpufeatures.h
Hunk #1 FAILED at 299.
patch: **** malformed patch at line 45: IBPB) */

Don't ever send patches from

User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0) Gecko/20100101 Thunderbird/91.5.0

That thing mangles them.

See Documentation/process/email-clients.rst for further info.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
