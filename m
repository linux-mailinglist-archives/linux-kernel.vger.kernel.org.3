Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05A54AA40A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377986AbiBDXIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377961AbiBDXI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:27 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644016105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioETADAglXgU7/nCVQ1BpNy2uCmftOElgPaC9jxSrBA=;
        b=vKBTzAOLOxtb08dhyPmkwzz0MTgCFqgykNqkMx2NUhvtHw3FGaFdF4byhGaGHwaSzYL/hZ
        GEhZQJQz7HDPLP5s4clRD+Wgoj0aY6vK/R8zOtgS/0+dTK+1/EJuLk3InEXjY/kVJbhcw8
        cg0GRWCH7ctYxkW1IkbwxwyvVhfgJLr/OEGy8g/0QEdY2HKY0LI4A0eWoFeotDST++NnK/
        alPEHNr9zUvyn7P4J/t4Kc4eipX9I0NTB9jZsazV/Ww72IhVwhzQqmAyBtIY8iqSLkRLNk
        UbMV6sOHt9RQ59SqeWW1LXPRmRNkfS0WbXBVNvxhomuEsGZ2j9GzripnJy2yDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644016105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioETADAglXgU7/nCVQ1BpNy2uCmftOElgPaC9jxSrBA=;
        b=aEyXhf3heFmuN6wYwYAFWRHlony1PmCD+zGPLBWLk8KpHguVQbfrhOmuoyGQnFUe5xbUo9
        jgPbFNHS95SMZaDA==
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
Subject: Re: [PATCH v3 03/11] iommu/ioasid: Introduce a helper to check for
 valid PASIDs
In-Reply-To: <20220128202905.2274672-4-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-4-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:08:24 +0100
Message-ID: <871r0icjrr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:
> pasid_valid() is defined to check if a given PASID is valid.
>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
