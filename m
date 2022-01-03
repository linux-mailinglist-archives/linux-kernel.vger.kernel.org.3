Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1F4833CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiACO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:56:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45236 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiACO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:56:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C32061120
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 14:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564AEC36AEE;
        Mon,  3 Jan 2022 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641221770;
        bh=IMKdqtvcu8qkZ5ZOB20uMwA3UPGhxDdm1YVKxA2Q2iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgdJX6jESnjsXgeQOEq15k+aDth+cw3gtucdl1SK2VrFNRU/gNtKpb37bsoaEWVi6
         WCtfvtGGX6QXPHSFUOtK8cdkn4GRMQlarMXryYCFO7agycv1LLbMWj8/eYibrcig7z
         1MQiVf/KerVRAFJQedGNS6N8KZxW3wf1P8pAcpNLBcM3F2IJqH3wCBsdRGbrGEuHgg
         gBtrZl8h9NDI8ySX/GIw3yBWIzv23w//Aa6UnFXQBZv/VSE0gzcHWagHUuRnRIsTnN
         1xGOsz9Y9v2bycO0uTShrK/MDJ8YdZdIUJiUyWur5wzj/jhaEieb+1SY3w1YbfDUb9
         YN224NSX7yWZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88A3D40B92; Mon,  3 Jan 2022 11:56:08 -0300 (-03)
Date:   Mon, 3 Jan 2022 11:56:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
Message-ID: <YdMOiFDdEny4Jicc@kernel.org>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
 <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
 <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 03, 2022 at 10:13:24AM +0200, Adrian Hunter escreveu:
> On 23/12/2021 08:38, Masami Hiramatsu wrote:
> > Hi,
> > 
> > Sorry, I missed this series.
> > 
> > On Thu,  2 Dec 2021 11:50:23 +0200
> > Adrian Hunter <adrian.hunter@intel.com> wrote:
> > 
> >> Hi
> >>
> >> Here are patches to bring the kernel and tools x86 instruction decoder
> >> more up to date.
> >>
> >> x86 instruction decoder is used for both kernel instructions and user space
> >> instructions (e.g. uprobes, perf tools Intel PT), so it is good to update
> >> it with new instructions.
> > 
> > Hmm, I thought perf used objdump for that purpose internally.
> > Anyway, this series looks good to me. I'm a bit surprised that the
> > insn decoder can actually support those instructions only changing
> > X86_EVEX_M() macro :-)
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thank you!
> 
> Thanks!
> 
> Arnaldo, could you consider taking these patches?

I can pick the tools/ bits, the arch/x86/ should go via PeterZ, right?
Peter?

- Arnaldo
