Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6CE48B623
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiAKSwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:52:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:20707 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350196AbiAKSwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641927165; x=1673463165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sua0LrwqqZdGAfIsKVCvbngimpLDy6yy/a/Faw9JSso=;
  b=U5+5cHThWF1WnuACgO++UtvT/QOUXtOShJcumMySq8LkURpxXjyZLXw/
   D4TjY2VLpopg91KKhD9c8rPk9b33mkXhbtXfZmI+P5/Z9ajSLft1NSpbC
   /4W2si5LwSf0EhtdY2LYCu1rkqhh5kWhO9EAWaPlXd1LQDtfYLG3+zbb+
   XmzFCsGUToj1reu1oTvqVfgT/OH6rJmgmt80GPvoTVGp2USA3BC5vkMSK
   DIE2bY0+Kdcp6/Q6CIrVRGy7ti9dJDhVGS7/msYBl7yrDzQZNaxRUe8AB
   r3MFiHvZP22xiWQBkE7X7xxmOHlrjRA+2djzEeSfpeE8GGj4R/pAgBm81
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="224256273"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="224256273"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 10:52:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="528400339"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.36.204]) ([10.209.36.204])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 10:52:44 -0800
Message-ID: <4b655bf8-ce56-ffe6-78b6-1f949b8df11f@linux.intel.com>
Date:   Tue, 11 Jan 2022 10:52:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 1/1] perf tools: Add 'm' event modifier for counting
 machine
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
        linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220111142054.18733-1-nikita.shubin@maquefel.me>
 <20220111142054.18733-2-nikita.shubin@maquefel.me>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220111142054.18733-2-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   
>    u - user-space counting
>    k - kernel counting
> + m - machine counting


You really need to explain what "machine counting" actually is, as well 
that is likely irrelevant for most CPUs.

I also didn't see that anywhere in the commit logs.

-Andi

