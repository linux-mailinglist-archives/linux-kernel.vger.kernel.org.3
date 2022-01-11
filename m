Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D89748B9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbiAKV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:28:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55030 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245218AbiAKV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:28:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90B301F385;
        Tue, 11 Jan 2022 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641936491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11zMbRrBVlSd1cMlN8I5pipflLFwumZQPppQkq6GMck=;
        b=cQ/0SV0tNvmI25UYI5jHj2b2yav0UXE2qyZZhd7+hHz3E0k/YXg921X+d023upofwTeM8w
        /WmaKwGj6FtIg9S247ao2oCUULMeKc6NaEmScKNw17WlyK03Q90vG6c9SBhvLlWFI2BFSm
        G2HKaBXrQ8Fr5Al2hmFEIXpnyuG9irA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641936491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11zMbRrBVlSd1cMlN8I5pipflLFwumZQPppQkq6GMck=;
        b=2JV392hZwXF1YL9mNrmSsYYR1MvaU1EX0KKQt3gnFrSSJzZvQRmq/tic+JyFupwEn16LmX
        NF2zSjRtMSNX0FAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78BF913DE9;
        Tue, 11 Jan 2022 21:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FEFcHGv23WF2OAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 11 Jan 2022 21:28:11 +0000
Date:   Tue, 11 Jan 2022 22:28:15 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] perf/core for v5.17
Message-ID: <Yd32b/VmTz4jpkkY@zn.tnic>
References: <Yd2+Wqrl0ax2JQjg@zn.tnic>
 <Yd30zIQsKTJCyGgO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yd30zIQsKTJCyGgO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 09:21:16PM +0000, Sean Christopherson wrote:
> On Tue, Jan 11, 2022, Borislav Petkov wrote:
> >       KVM: Move x86's perf guest info callbacks to generic KVM
> 
> This commit, e1bfc24577cc, introduces a new warning on arm64 with CONFIG_GUEST_PERF_EVENTS=n.
> 
>   >> arch/arm64/kvm/arm.c:499:15: warning: no previous prototype for function 'kvm_arch_vcpu_get_ip' [-Wmissing-prototypes]
>      unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
> 
> I floated a potential fix[*], but we all lost track of it.  I assume the easiest
> solution at this point is to post a proper patch to go on top?

Right, you could send it as a reply to this thread and Linus could
simply pick it up directly, after he merges.Probably the easiest ...

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
