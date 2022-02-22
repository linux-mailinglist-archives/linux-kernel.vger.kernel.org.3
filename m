Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8944C0360
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiBVUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiBVUwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:52:44 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A58F205ED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:52:19 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B5001EC053C;
        Tue, 22 Feb 2022 21:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645563133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OehPvAe51/Hegsk3hGHGd+Cljc8mg4MRgR1iYEq0Guc=;
        b=g0O5hyQdof+qx2KHe5+qC1UG4sdfSjwzJWClN1fc7eXw2hq/ZP05HRcOGW2MQof6ln/11y
        oHi11WamFLrdzoqTFr+Y2hXoBGHEr/lG9DrEsXPz4mYqQxJzY5zvF4Hv87xrBeqAmXqBbb
        N0Gh2c+l/YB3OQbIGHROkwC9R0v53NQ=
Date:   Tue, 22 Feb 2022 21:52:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86: Rename cc_platform.c to arch/x86/coco/core.c
Message-ID: <YhVNBaTeqAktvuAw@zn.tnic>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
 <20220222185740.26228-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222185740.26228-3-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 09:57:38PM +0300, Kirill A. Shutemov wrote:
> Subject: Re: [PATCH 2/4] x86: Rename cc_platform.c to arch/x86/coco/core.c

Just like git formats it:

Subject: x86/cc: Move arch/x86/{kernel/cc_platform.c => coco/core.c}

> Move cc_platform.c to the newly created arch/x86/coco. The directly is

s/directly/directory/

> going to be a home space for code related to confidential computing.
> 
> Intel TDX code will land here. AMD SEV code will also eventually be
> moved there.

Yap, that's the plan.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
