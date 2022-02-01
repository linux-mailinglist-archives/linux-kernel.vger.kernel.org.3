Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9044A6859
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbiBAXF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBAXF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:05:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C84C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:05:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643756726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G3sjsFjjlBmrrAj4qtnYfkyIdeyVnCMbduYcN+2xMBA=;
        b=bfPENEQ3VMntqFtfBQZuJc+qgTugxjI6ggY+dS6/OEuQYfIzXoggUA2hErBn/+IoEVs2PN
        s5qwcUf51wW8LSXgJSp0MyiuACYJfVQpNMsdVjM0H/MnJRisz8ucZNstnYB9Av5z6wXkT+
        O/uxUsZufAK8B2TBLlrD+/rEw3nlmInddGo0nma7TjuDkz7y8k/XyIqEvAVTcJSe+5M/Fw
        6aXLpVsb5ouOOzZePcbozcylI0X3E1xEMY9puG0OL7OC5KY0Hsu1oK4wQgmADNzu5UUeaH
        OwRhZe3JtTYfbPDk9B30xDwPcTS8ZRUWczwOMhUd+iQawU9RkAqRAZQn+Ot5fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643756726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G3sjsFjjlBmrrAj4qtnYfkyIdeyVnCMbduYcN+2xMBA=;
        b=Fu7twI7L0aRzn1UvWRl1vsFONjFUlgDIy1o/+ydcY0vQyNlQSoAW72TzWQdzs7Jp1En0EB
        nQV2siVLF5WOzWDg==
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
Subject: Re: [PATCHv2 15/29] x86/tdx: Wire up KVM hypercalls
In-Reply-To: <20220124150215.36893-16-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-16-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 00:05:26 +0100
Message-ID: <871r0mxk5l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> Among other things, KVM hypercall is used to send IPIs.
>
> Since the KVM driver can be built as a kernel module, export
> tdx_kvm_hypercall() to make the symbols visible to kvm.ko.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
