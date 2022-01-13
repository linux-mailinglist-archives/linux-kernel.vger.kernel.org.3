Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C616648D5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiAMKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:33:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:58331 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbiAMKdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642070011; x=1673606011;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QJEVau8ikyEQIyyTU64n1+vG/9kHJJvqjAzCPt0IOu4=;
  b=c+ezgsLNexwAXX4c5OoRKsnyc/bpnSsfOdbVM+RrGjWYPmd7OBFjY3HQ
   CfidhlHAvxkrdBB5M6Q2W4CLZ49/2VXl1VL9CoiDBjHD5ciSh4RN+DuUH
   /PzGeDfQmuKko+TEI5aGggmlzWcyLpVWl2V6FIQ1oAbumyDK3pie6RDt7
   O4y1F46M9dKvQ49jq9TBxN8jTPI8etueiHjyOfYIiSsY5yC2sWoG8LB6y
   J5Fjux2EyVfP+IDQrVnO3RKA6w4czlJOfoSxK4GLQjGVEhU2nfRvL9qbu
   K4tAxgj8JePwk8G+2MUj0KxGn/picyMwRt6EVG4tKe5p4YCn1W+OXBWga
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330329460"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="330329460"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529611559"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 02:33:27 -0800
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
 <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
 <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
 <YdMOiFDdEny4Jicc@kernel.org> <YdMP5vmU+uqMz04d@kernel.org>
 <c7ac518e-82fb-eb51-7778-5e9b1aaed9a9@intel.com>
 <YdM/A3pWcQi87DbT@kernel.org> <YdNArxYU25LfrS52@kernel.org>
 <678169e0-de12-6a61-d0df-cd898b9377a9@intel.com> <Yd/8Ck06NXI4sR4U@zn.tnic>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ad6f061d-3891-2578-ee5b-653129c6074d@intel.com>
Date:   Thu, 13 Jan 2022 12:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yd/8Ck06NXI4sR4U@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 12:16, Borislav Petkov wrote:
> On Thu, Jan 13, 2022 at 08:52:58AM +0200, Adrian Hunter wrote:
>> Peter or Borislav, could these patches be considered as a late
>> inclusion for v5.17?
> 
> Stuff for the merge window gets queued before the merge window, in the
> overwhelming majority of cases.
> 
> Is there any particular reason this needs to be rushed to Linus now or
> can I queue it after the merge window is over, in less than two weeks?
> 

No, it can wait. Thanks for responding so quickly.
