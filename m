Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763FB464BD5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348758AbhLAKpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbhLAKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:45:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC62C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:41:47 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638355304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=caithT0xgZSymhjyfplIkeBY3Nd1DYlAi7JqLqMk6As=;
        b=SPk1qywOrevJ7t1JKcF4w0YQt+oMlsr2z7vjgK9dOY3sYIak/Q7vXFyU5VBGwVApu3WRx8
        Q4o0OemN3KzJMjLr5+9K3Px2UWNkCpCF9QKnVUctfPTQUoiolsjMYTjZ9xW7svgVczjYnP
        YnD9jBdi+QC24GdHCrfqsbVYt/fTKDE9Tc99Inu1y26cZiW80Ku1dNtTxloY6Qh/3DgP8K
        PLt46tLJBeQb0RVQkIddrGV1N0G5/0MGIpWglHhqIScYfLTlctgEdUrsnKhls3W+ma01Ae
        PAikRseGjaM3aywLEvIjANOfbkFkAKs7wrVuI7jih+ZGgUoAjj/EPtKbofMjvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638355304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=caithT0xgZSymhjyfplIkeBY3Nd1DYlAi7JqLqMk6As=;
        b=FdVXYL2uE5TlR4fpjK33776foGHrxVyG85M8wbzPZ9MEPeBm4WK5xxjzUZc/IJxpUBOB1Z
        M+24rcxTbsd5ewCg==
To:     Luming Yu <luming.yu@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paulmck@kernel.org,
        rui.zhang@intel.com, andi.kleen@intel.com,
        Len Brown <len.brown@intel.com>, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for
 qualified platforms
In-Reply-To: <CAJRGBZxdtRgENVonpfJn-zFoQx_LB0ms=aS3wAJhRJO+_OqYFw@mail.gmail.com>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <CAJRGBZxdtRgENVonpfJn-zFoQx_LB0ms=aS3wAJhRJO+_OqYFw@mail.gmail.com>
Date:   Wed, 01 Dec 2021 11:41:44 +0100
Message-ID: <878rx4a9p3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luming,

please trim your replies.

On Tue, Nov 30 2021 at 23:45, Luming Yu wrote:

> We do need to decouple tsc from HPET as the current HPET as a
> clocksource watchdog for tsc is only useful to find HPET read skews in
> some circumstances and the variations of HPET read come from many
> different sources. But none of which really came from the tsc quality,
> AFAICT.

Sorry, but I fail to decode this sentence.

> so this patch is in line with my understanding of the problem.
> So , please use  reviewed-by :  luming.yu@intel.com , if it can help
> the merge of the patch. : -)

Please send Reviewed-by as a properly formatted single line tag:

   Reviewed-by: Luming Yu <luming.yu@intel.com>

so it can be picked up by tools automatically. Mangling it into a
sentence just creates extra work for maintainers.

Thanks,

        tglx
