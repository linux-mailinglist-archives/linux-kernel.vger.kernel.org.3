Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05D748B946
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbiAKVVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiAKVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:21:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6DC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:21:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso7679859pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bn/8Ac4W0r4XTxCDD0r5JK+AtFG0TJBq9VQF7nqi+D4=;
        b=HG9YW5VcGlGj76n2XHLdbx5sqoheLibrymWgXiITCxSBT15/MFDRYHv/fEjwo6wxHp
         QpcnS6CAJdfXfVUfSgX27TDTzA1dz8rqfhKYYCIbXeiWrHJ8Wp3/8CxdD71cq8u7e4j9
         4aNwHPVGv0Hfuu64D0hIuydoa2+NQldvqyXTuYGQTc4/ByZs48jEmdUEC8eewzSxJNGn
         xb1r+ETuHiHYVxEHs5SnuzI7aC19cQfQ/Emvp8lj4XJSYr0TQo8BoYXl2KSkHqyUnVoz
         v/9zRnPbS5rUMtj3FwytSzCpb8LJ7aVZxFW7Z23LZycdGRgUIKCt6VnJoyGsJGjW8BrJ
         EMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bn/8Ac4W0r4XTxCDD0r5JK+AtFG0TJBq9VQF7nqi+D4=;
        b=lUW5GbWOdi6gLPez5QWWUBG5m/5MWnCjo5BAsxz6TC01j69CdWF/U++7ussNs33Mc+
         kTHdo59uB9wL2m8kZUbUJPq2+hbaDgjmhUl/xvMdZAOfeJjTt/GiwJPxUESSUmiE4W6g
         5P0lfQC7bWGjJP7EjuvncTsbWfz8kxuOCVHrzcsaDTZ+orZyTYzC7YdOIHCB0sBV8+0o
         0zQ+i3+uGFCrDENr055O4D+u3c7bAGNFYf2mPsYK/3YJHU/irCI/ykt38f0cocyqiBoE
         e8A3Eh8uOLhPojPGmWz6e5cWi5rRA1v9Ya7yWaa4j9EKWGadPZxmnw7bO07FDhR1YRgp
         XwIw==
X-Gm-Message-State: AOAM533kQL8x09iPMuZ9c4EdMrYcZ/jxtR1EzT7SWTQjkLHzFAvhpDzB
        Kww4KUF6MYMxbhmxU8FC21SXdSMRLcOrEA==
X-Google-Smtp-Source: ABdhPJyOHkbc3tYs9bgzdFSau2ARTcJ136vBT/tII/MY16KnoA09G68sFtUKVCgxXipjA+PE3In/pA==
X-Received: by 2002:a17:902:c9d2:b0:14a:3335:accd with SMTP id q18-20020a170902c9d200b0014a3335accdmr6292521pld.94.1641936080620;
        Tue, 11 Jan 2022 13:21:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h8sm2107884pfc.185.2022.01.11.13.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:21:19 -0800 (PST)
Date:   Tue, 11 Jan 2022 21:21:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] perf/core for v5.17
Message-ID: <Yd30zIQsKTJCyGgO@google.com>
References: <Yd2+Wqrl0ax2JQjg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd2+Wqrl0ax2JQjg@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022, Borislav Petkov wrote:
>       KVM: Move x86's perf guest info callbacks to generic KVM

This commit, e1bfc24577cc, introduces a new warning on arm64 with CONFIG_GUEST_PERF_EVENTS=n.

  >> arch/arm64/kvm/arm.c:499:15: warning: no previous prototype for function 'kvm_arch_vcpu_get_ip' [-Wmissing-prototypes]
     unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)

I floated a potential fix[*], but we all lost track of it.  I assume the easiest
solution at this point is to post a proper patch to go on top?

---
 arch/arm64/kvm/arm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8129ee1ed3a4..e3b46951a92d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -496,10 +496,12 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu_mode_priv(vcpu);
 }

+#ifdef CONFIG_GUEST_PERF_EVENTS
 unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
 {
 	return *vcpu_pc(vcpu);
 }
+#endif

 /* Just ensure a guest exit from a particular CPU */
 static void exit_vm_noop(void *info)
--

[*] https://lore.kernel.org/all/YZvysKFSLTxDzaBs@google.com/
