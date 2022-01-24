Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937AF49A175
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360271AbiAXXgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:36:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50958 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383911AbiAXWs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:48:28 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C90FE1EC02DD;
        Mon, 24 Jan 2022 23:48:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643064502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i3ynX/3WyXL+RIfj1UToTdc8PkhLwkgiGCcTadCCkMY=;
        b=gVtVcine7JJA4nWZ+l9gsKrWP0huJ2VGNVQQM0s7mdqyMK59z8o2N0Nzb+TN11jeCU94hU
        X13uUgORFoSIl82EqnY2FEOi5hl+y+z8NWtImSFyRCxA3jOQaK8vSx6nUKxFEpyYjm/Ezo
        XVkIoGU6T74ygiaQTqTcVX992KuTtow=
Date:   Mon, 24 Jan 2022 23:48:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     dave.hansen@intel.com, benh@amazon.com,
        dave.hansen@linux.intel.com, kuni1840@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH] x86/boot: Avoid redundant address overlap tests in
 memcpy().
Message-ID: <Ye8ssRJEpau57jKj@zn.tnic>
References: <bd7c111c-8bd4-9c4d-4715-c0fb5fd034ee@intel.com>
 <20220124221447.1030-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124221447.1030-1-kuniyu@amazon.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 07:14:47AM +0900, Kuniyuki Iwashima wrote:
> > Also, is this worth the churn?  It probably saves less than 10 
> > instructions, all of which are ridiculously cheap.  Is there a *reason* 
> > for this other than being a pure cleanup?
> 
> This is just for cleanup.

Was wondering the same thing, whether this is even worth the trouble.
I'm sure you can find real bugs to fix.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
