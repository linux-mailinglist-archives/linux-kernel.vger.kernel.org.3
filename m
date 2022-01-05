Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF77C4851A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiAELMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiAELMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:12:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D67C061761;
        Wed,  5 Jan 2022 03:12:24 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FB221EC00F4;
        Wed,  5 Jan 2022 12:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641381138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1PC4ZwioAXCt2f/k2N13mQc197AOanSe8z/TnLKgbpU=;
        b=I9A8EM86AD163L4BKSU1pVWJ8YRBMXDmzGJgY8H86BN5Z3KDkbCYDJ0oBAeHYbU9CxqlM9
        GeZeMOCZYlBymd+7n8pgyQTiBfxwVNNMwA+SvyXks3tXK5Xgb7Y/R+hc9C5l4JJ4JXbpmr
        lkowCm4k6cIub5OIde0CoPjK8HDnVgk=
Date:   Wed, 5 Jan 2022 12:12:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu Zhao <yuzhao@google.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <YdV9FNxYDRrgiejD@zn.tnic>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220105085534.22981-1-sj@kernel.org>
 <YdV4k1+zEbtzmUkK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdV4k1+zEbtzmUkK@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 03:53:07AM -0700, Yu Zhao wrote:
> Look, I'm open to your suggestion. I probably should have been nicer.
> So I'm sorry. I just don't appreciate alternative facts.

Yes, you should've been *much* nicer. I'm reading lkml for pretty much
20 years now and you just made my eyebrows go up - something which
pretty much never happens these days.

So you need to check yourself before replying. Looking at git history,
you're not a newbie so you've probably picked up - at least from the
sidelines - all those code of conduct discussions. And I'm not going to
point you to it - I'm sure you can find it yourself and peruse it at
your own convenience.

Long story short: we all try to be civil to each other now, even if it
is hard sometimes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
