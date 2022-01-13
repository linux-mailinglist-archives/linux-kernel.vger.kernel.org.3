Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13BE48D595
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiAMKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:16:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44360 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbiAMKQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:16:44 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81B301EC051E;
        Thu, 13 Jan 2022 11:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642068999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+QhzEG6ToIFAz/w6NjWJu8fdA/A/YpiVUdgwWkB2yJY=;
        b=K682OL/4UTttex7hTZxAHc7vk3PAMy3xEOKEq8cVV6K/4HnEsYIdom8VqkxK18c1Gku0E/
        SFFBD7wz7gjla34CamBfOtQ6I8yhpPc35ELNC5QRCKn8+QcdGBOcrmHXhS9EFmmF8THn/L
        4v7juh2eYIrua38dCk2S96rjwKJKTUE=
Date:   Thu, 13 Jan 2022 11:16:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
Message-ID: <Yd/8Ck06NXI4sR4U@zn.tnic>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
 <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
 <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
 <YdMOiFDdEny4Jicc@kernel.org>
 <YdMP5vmU+uqMz04d@kernel.org>
 <c7ac518e-82fb-eb51-7778-5e9b1aaed9a9@intel.com>
 <YdM/A3pWcQi87DbT@kernel.org>
 <YdNArxYU25LfrS52@kernel.org>
 <678169e0-de12-6a61-d0df-cd898b9377a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <678169e0-de12-6a61-d0df-cd898b9377a9@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 08:52:58AM +0200, Adrian Hunter wrote:
> Peter or Borislav, could these patches be considered as a late
> inclusion for v5.17?

Stuff for the merge window gets queued before the merge window, in the
overwhelming majority of cases.

Is there any particular reason this needs to be rushed to Linus now or
can I queue it after the merge window is over, in less than two weeks?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
