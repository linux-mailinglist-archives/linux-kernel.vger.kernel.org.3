Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1C474CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhLNU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:59:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhLNU7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:59:01 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DF941EC01DF;
        Tue, 14 Dec 2021 21:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639515536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MktwpOWLa2cY49EwlbrvmOr9KgEnQs/S2u9h9zMrhXE=;
        b=dtRpBVMmF0KjeprDpz+PMzUc+ph0umJ/B3lJKYN3C8ZFemY1QLmkgGko7go+u7zxCxLCBS
        naau1O+iCf6BcM7MMXFs5iOl/JvTTbPdaxa226kcUERh+uhzaK8v0qnzWF7N/F6l84y+qx
        B8GOatULJZHcQX1BG8f35C6gZPzkOOY=
Date:   Tue, 14 Dec 2021 21:58:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/26] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <YbkFkSPriw2bX2yC@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-2-kirill.shutemov@linux.intel.com>
 <Ybjf5g66cFHpUKMH@zn.tnic>
 <20211214202106.uazcwby3365x2ymw@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214202106.uazcwby3365x2ymw@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:21:06PM +0300, Kirill A. Shutemov wrote:
> But I think it should be pretty self-explanatory. I'll drop it.

Right, otherwise we'd have to document all the depends in Kconfig which
would be a pointless exercise in useless work.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
