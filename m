Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A954146CABE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhLHCTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:19:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:58555 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhLHCTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:19:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237546326"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="237546326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 18:16:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="462586499"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 18:16:16 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hasan Al Maruf <hasan3050@gmail.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        feng.tang@intel.com, hasanalmaruf@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mgorman@techsingularity.net, mhocko@suse.com, osalvador@suse.de,
        peterz@infradead.org, riel@surriel.com, shakeelb@google.com,
        shy828301@gmail.com, weixugc@google.com, ziy@nvidia.com
Subject: Re: [PATCH -V10 RESEND 1/6] NUMA Balancing: add page promotion counter
References: <20211207022757.2523359-2-ying.huang@intel.com>
        <20211207060509.79442-1-hasanalmaruf@fb.com>
Date:   Wed, 08 Dec 2021 10:16:14 +0800
In-Reply-To: <20211207060509.79442-1-hasanalmaruf@fb.com> (Hasan Al Maruf's
        message of "Tue, 7 Dec 2021 01:05:09 -0500")
Message-ID: <871r2n4z9t.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasan Al Maruf <hasan3050@gmail.com> writes:

> Hi Huang,
>
>>+#ifdef CONFIG_NUMA_BALANCING
>>+	PGPROMOTE_SUCCESS,	/* promote successfully */
>
> I find a breakdown of Anon and File page promotion can often be useful to
> understand an application's behavior (i.e. what kind of pages are moved to
> remote node and later being promoted). What do you think about adding
> counters for such a breakdown?
>
> What's your thought on adding counters for failures on different reasons?

I think that all these provide helpful information.  But I think that we
can add them in separate patches.  That will make reviewing simpler.

Best Regards,
Huang, Ying
