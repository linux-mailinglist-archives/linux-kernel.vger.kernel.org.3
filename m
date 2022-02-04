Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B254AA3F8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377867AbiBDXHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:07:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34952 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377862AbiBDXHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:07:50 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644016069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ld1PFYBLYxe6OCr2s2kgC8WKseN0fuK+fr3Z4cIGHcU=;
        b=EEXdM43YWo46V68aujQjWgrltp7wN0bI61WoXn8oEWXUGhsDkJVlbSYLsoizCE+o1vi4Yj
        fYyrfor/EEQMTJdDd7IKEg9wMLJVARTHls75/ey2yrDQATdI8KRUnesWnivrQmBowOK/tj
        a3YOG/Vv1PXc4dI+8wP2Y0j9MmrXLdPksjIFxQX87FkLu2KQzVkdEDjjhM6fWta+HZajiT
        EUFW0WQ/9lScvrcnJgHE0tFSQ56JwhsKxTVZ8sp+2X3N7Gyli87O7MLyUjVSSV1p7z1IQa
        Ak7UMA5ODZX6MWc2P/OTBRZifM+eKnJj4ROqhUw3xl6OZAEuyrWhU0CJfv1kww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644016069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ld1PFYBLYxe6OCr2s2kgC8WKseN0fuK+fr3Z4cIGHcU=;
        b=jMvBOaIpolZEID1SEOxXurziTcZcYEdIzb/6ZjUwcwqwQdwZTGgmPAxu5pPaw9fac9erdB
        kyYeyxTCNno1lMDw==
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 02/11] mm: Change CONFIG option for mm->pasid field
In-Reply-To: <20220128202905.2274672-3-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-3-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:07:48 +0100
Message-ID: <874k5ecjsr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:

> This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
> needed when CONFIG_IOMMU_SVA option is enabled.
>
> Change the CONFIG guards around definition and initialization
> of mm->pasid field.
>
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
