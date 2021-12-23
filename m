Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1947E16F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347702AbhLWK2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347617AbhLWK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:28:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C7C061401;
        Thu, 23 Dec 2021 02:28:53 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24EB11EC01B5;
        Thu, 23 Dec 2021 11:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640255327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sE9XUSmb98mGygWI+QfBs1UVYkXVDPFx3JTyph/k4Wc=;
        b=QguZZpuvymf4rmGgMS0TO7xhrU6h7S75ZJ8XcLe0REA4VVi7+KTcPjE+wXpa5dwtl72z/b
        9V3/Zm5SMR6KyuxAjaD59kVe+oXTC6w1cqFfKM0vX1CHwMCWfo4Aji37DhLYU5nCxuL3US
        dCr48kXUakC3nZ0P36nIkkfjd0FbWs4=
Date:   Thu, 23 Dec 2021 11:28:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Introduce x86 assembly accelerated implementation
 for SM3 algorithm
Message-ID: <YcRPYHg3SMezrfiX@zn.tnic>
References: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:35:41PM +0800, Tianjia Zhang wrote:
> This series of patches creates an stand-alone library for SM3 hash
> algorithm in the lib/crypto directory, and makes the implementations
> that originally depended on sm3-generic depend on the stand-alone SM3
> library, which also includes sm3-generic itself.
> 
> On this basis, the AVX assembly acceleration implementation of SM3
> algorithm is introduced, the main algorithm implementation based on
> SM3 AES/BMI2 accelerated work by libgcrypt at:
> https://gnupg.org/software/libgcrypt/index.html
> 
> From the performance benchmark data, the performance improvement of
> SM3 algorithm after AVX optimization can reach up to 38%.
> 
> ---
> v3 changes:
>  - update git commit message for patch 01
> 
> v2 changes:
>  - x86/sm3: Change K macros to signed decimal and use LEA and 32-bit offset

So you sent v2 yesterday. One day later, you're spamming again.

So we have those process rules for a reason - use the time to read them
before sending again a day later please.

Documentation/process/submitting-patches.rst:

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
one week before resubmitting or pinging reviewers - possibly longer during
busy times like merge windows."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
