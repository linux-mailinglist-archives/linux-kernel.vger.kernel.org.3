Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299A14C10C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiBWK4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbiBWK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:56:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C787DE04
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:56:22 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1DBF1EC053C;
        Wed, 23 Feb 2022 11:56:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645613776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZB7RXgS6DyEOW5exwHeKJnB2xnMEiocD/nGfQXmtimw=;
        b=FMCPi5uBaJPsYHj+LGWX98iaCD65rwk3D74N4bU8jIHhUJpuAOxBc8lcOx40FVY9au4s16
        EUQPGHJ+q5LJoY5NmH6s4VtzYCAkmwqXSm4hg/f2tKtGPZHz6ho+hnCLlRheVk41ozF5Ss
        vnYCWhWiv1kN+HbDB4cnLLmT49eKE4A=
Date:   Wed, 23 Feb 2022 11:56:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jmattson@google.com,
        seanjc@google.com, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM
 dependency
Message-ID: <YhYS00FywnE8g4Um@zn.tnic>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
 <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
 <YhVCoveTwsDZXE5G@zn.tnic>
 <4769a3c0-449b-184a-5c61-a0e155f9c5b4@gmail.com>
 <YhYPPHKZFsGzaI2U@zn.tnic>
 <bcdbd534-a077-3bb3-3d37-c9eb2a048854@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcdbd534-a077-3bb3-3d37-c9eb2a048854@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 06:43:40PM +0800, Tianyu Lan wrote:
> Hyper-V code check cpuid during runtime and there is no Hyper-V
> isolation VM option.

So how does "Current Hyper-V Isolation VM requires AMD_MEM_ENCRYPT" work
exactly?

Please explain in detail and not in piecemeal sentences.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
