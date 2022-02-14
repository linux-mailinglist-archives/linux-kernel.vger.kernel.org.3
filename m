Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469124B5875
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357059AbiBNRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:25:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357061AbiBNRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:25:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C1652FD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:25:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644859527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IghW1yCinRwuBjJx96OYf7MGD4W3BpFS4t1OFpWxVSI=;
        b=SJoIEu+zLBfbz6vLUXj9gi0gd07aWubitxSgMTJPpUwLAfs0fzPkU8lQo8iw6FRMAPfZwh
        +MQ55maPhXPwHtfR4DIycocNvWKWOteRwVUetW2c4n2UND92FeVkJe3qFsFL4M6N7i2WlZ
        P6bFMf4WdSrMZqiHsTOzNnZs/Fy0YjiMp5C1NvK4HVZx1If5GuKnnzO0OSamq98fr6BhuW
        oXX6gqqFJ/QV10xyuMP4nn+K5MpBMgLfdJ++bVkWlRgBTcl+9NMadoFNYt598UaxHTOC71
        QvdCgUau0gpqRWVIHlbB6+EMWbyu5i0e7S7Coq+7G654Be8R62qm4wfSgHn7fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644859527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IghW1yCinRwuBjJx96OYf7MGD4W3BpFS4t1OFpWxVSI=;
        b=RUraRs3WKaydP/V+PymWCuyEhkM1iPNtIRvbGsRlGzJV2xkqE01bl1/JChsJJ6bYPM6ths
        HHhS6pGEglO1nSCw==
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
Subject: Re: [PATCH v4 11/11] docs: x86: Change documentation for SVA
 (Shared Virtual Addressing)
In-Reply-To: <20220207230254.3342514-12-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-12-fenghua.yu@intel.com>
Date:   Mon, 14 Feb 2022 18:25:26 +0100
Message-ID: <87pmnpqs1l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07 2022 at 15:02, Fenghua Yu wrote:
> Since allocating, freeing and fixing up PASID are changed, the
> documentation is updated to reflect the changes.
>
> Originally-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
