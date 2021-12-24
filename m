Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68E47EEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352710AbhLXNAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:00:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46404 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhLXNA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:00:29 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56CEA1EC047C;
        Fri, 24 Dec 2021 14:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640350824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UKOFa0PxUyKifdsyahgVU6kEgN7R2vRwQhsIcjDbUk0=;
        b=pniIqrjJ009jKE7RX25IZ5GrgiczuILp2EgHVfXfBepqeS7ljdUYS5RgyEaIesal4SMPub
        567sYYoskMPSjcfSBnxOVEztiWoUndQRv5zNqwDZAD4SL/9sPrtEjAhUXCZfUlO76i7Od2
        sTP2RMVsYZG/pa1O2NRXsnemImhAzPQ=
Date:   Fri, 24 Dec 2021 14:00:26 +0100
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
Message-ID: <YcXEaldvjULKAvhc@zn.tnic>
References: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
 <YcRPYHg3SMezrfiX@zn.tnic>
 <ed4ec4f9-9ede-8718-811c-8eae92c220bb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed4ec4f9-9ede-8718-811c-8eae92c220bb@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 06:01:44PM +0800, Tianjia Zhang wrote:
> I'm sorry for the trouble to the community and reviews. Thanks for your
> reminder. I will control the time interval when sending patches in the
> future.

Thanks and please peruse that file - it has a wealth of good suggestions
in it.

> Merry Christmas Eve.

Happy holidays to you too!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
