Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248064AA4C7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378550AbiBDX6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:58:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiBDX6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:58:37 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644019116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGG+8m9FDJcTBlNTm2rGW7J3KpLFh6WAlzYPrg8D8XA=;
        b=q8awpzQl2BviFbJfR8uRC1lxGHv8i+UynGOYNdEwp/+gcxxeeLfY6elBW7YsE1/R7yTPL6
        wSrUXNNGDh72fA55nM8Pf97lVC4r0fYE+OBS0ETTFA05t/6XwZtOmpVN+dJ+TifDSFEdMW
        q7vYgVLV4luzveN51m1Al50l8PmhmLyCqpnbVfdxNrEZwu+z5Av9pw+JgJet5cRErBfJFF
        n0DLmcWgzHErTNEdkEshcYQdNJRcU42oLo9jCKqzM0N/xbeH0wYZjWtl7kYcNzNgUBpVqw
        9frBN1ZfKjlDYxGUILzlX+dM9zpiMSAxOYXEStZDw6wU54QUIRdEZocGNXBvzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644019116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGG+8m9FDJcTBlNTm2rGW7J3KpLFh6WAlzYPrg8D8XA=;
        b=8PXiQzaB6ZIsilh5I34F7mtIbgvAF0htL3btQ0SZG7iVI8hLDY65Xh/QF7xAE3Ww4QNB8y
        iNzLS4/+XkcvU/DA==
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
Subject: Re: [PATCH v3 07/11] sched: Define and initialize a flag to
 identify valid PASID in the task
In-Reply-To: <20220128202905.2274672-8-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-8-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:58:35 +0100
Message-ID: <87leyqb2vo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:29, Fenghua Yu wrote:

> From: Peter Zijlstra <peterz@infradead.org>
>
> Add a new single bit field to the task structure to track whether this task
> has initialized the IA32_PASID MSR to the mm's PASID.
>
> Initialize the field to zero when creating a new task with fork/clone.
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
