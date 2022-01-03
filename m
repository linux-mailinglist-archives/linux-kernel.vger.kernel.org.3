Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569674832E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiACObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:31:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbiACO3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:29:49 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74FF91EC03C9;
        Mon,  3 Jan 2022 15:29:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641220183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oE7Hh2g3joX5kAqP0+tlJVwo2oeAGS331TRpaZv2Mmc=;
        b=MjC/g0mmC1FI5Zb/TO43NrKn1ydnM0xSeh6AqovnbBZiX3TC44csAEBvM4xCqdzrqNmZjk
        04k1egrrs5IeEACO4S5OAIAtgM6JcJNXZtKsbt2sKLpGBMRPiwcI1NDmdb4zQ/MGJ/80Vk
        DXq9xzfS7A5EfhZur6SgIBBMA7ysW5k=
Date:   Mon, 3 Jan 2022 15:29:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <YdMIWAT42el4D6wJ@zn.tnic>
References: <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 05:17:05PM +0300, Kirill A. Shutemov wrote:
> I'm not sure how to unwind this dependency hell. Any clues?

Forward-declaration maybe?

I.e., something like

struct task_struct;

at the top of arch/x86/include/asm/switch_to.h, for example...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
