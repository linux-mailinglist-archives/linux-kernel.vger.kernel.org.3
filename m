Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0574A680D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiBAWgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:36:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiBAWgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:36:17 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643754976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2F/y8aSW2wR6OApW4m06nsn/aEgXYMJhkB+lhkwfTY=;
        b=TJ/yzs0uyiC4KQnSgCdCaCoXwPJ4CQ17pfrxAf1HKTBRWnMVdIx5XuRnLfVWb6R2fwQ8ea
        YzobF6RMS/zXXC/g/pYEYfGnAVx42gFXPlwzDcQOtbGvFCvSRysaB3+0o996rINHBHPCub
        2vnmGnKSAeJgsATSf0UJTdbvHVQZCFcGcervq+H5yDFMBM/hgzpYXziBlYii8koKCYdYwo
        8jX6DWvnV8jmtUoxfuCnX5ucsQBbMGUaRA/Y8gHzBrgX8CxIwGiWSdhxm0hhhpkiy6/Iwj
        GW3Mytvs75QyFwJ8q/XKS7jf/bBKj2Vwg/mwFH9BN0Zx6VVlbwth5NsBsvhz3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643754976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2F/y8aSW2wR6OApW4m06nsn/aEgXYMJhkB+lhkwfTY=;
        b=L7mN7BW1ZHVuMMoeu1DdxtfJFrgbLg65AbWM1ts1ZpeO9sJIJUNf0QAAE+qhPRCv0dUdk3
        Miuov1aZ9SsnarAA==
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 10/29] x86: Consolidate port I/O helpers
In-Reply-To: <20220124150215.36893-11-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-11-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 23:36:15 +0100
Message-ID: <87mtjaxli8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> There are two implementations of port I/O helpers: one in the kernel and
> one in the boot stub.
>
> Move the helpers required for both to <asm/shared/io.h> and use the one
> implementation everywhere.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
