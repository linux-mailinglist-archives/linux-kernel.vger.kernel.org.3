Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7A4A680A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbiBAWdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:33:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42316 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiBAWdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:33:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643754804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7UPmmkqkcvqDHfbHRskhsk07k+lUBDTgeH+LaUXusg=;
        b=IoE/TMuEKFHBH0rceSnUDBNbmoWCBfUJQlg2gRnzMZiO9TsiFvxhoKxD34nP/o2Rv57qqh
        ta2nnyKnLWf7fYTnAjs5+NXbT7kwvsFlUpq3kr6+TME9+S7+V/k1NIhVZw0lPcUedIzp7V
        dtysvmviLWRuydlU0dhRCaAoD2F2xyuGiO874NDbl8UntW3XQg1yXihFKiKj7/7tBz91ON
        6Gsbv0nqv2n7pgjx//pSLGjM1VQYQyiAK8Noie8hL+xnt7q2y9jr6Mn6XIComXRZgwjMwh
        6zCKHXFdYsRfUydO5wZL6u3137PDr+l1hUXHAcnmQhCh9RARvTMHCBs24IL/HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643754804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7UPmmkqkcvqDHfbHRskhsk07k+lUBDTgeH+LaUXusg=;
        b=QwvdufO0RzBy5i5E9zXBYNzZW8TMwIyxy4mkAz1MBkIee6Y0c/I5tuzz025XeXHtOEjura
        XzMyBypW7Pm0pDAQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 09/29] x86/tdx: Detect TDX at early kernel
 decompression time
In-Reply-To: <20220124150215.36893-10-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-10-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 23:33:23 +0100
Message-ID: <87r18mxln0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> +++ b/arch/x86/boot/compressed/tdx.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tdx.c - Early boot code for TDX

Please get rid of this filename reference here. It's pointless and stale
once this file is renamed.

> index 000000000000..12bede46d048
> --- /dev/null
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -0,0 +1,7 @@

Lacks a SPDX identifier 

Thanks,

        tglx
