Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C054646BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbhLAFgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:36:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:2150 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhLAFgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:36:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223266987"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="223266987"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 21:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="745016748"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2021 21:33:13 -0800
Date:   Wed, 1 Dec 2021 13:33:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     ligang.bdlg@bytedance.com
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ben.widawsky@intel.com,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH v7 0/5] Introduce multi-preference mempolicy
Message-ID: <20211201053313.GB14778@shbuild999.sh.intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <b0d1f682-6868-c5f6-631c-2da93ee2b479@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d1f682-6868-c5f6-631c-2da93ee2b479@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

On Wed, Dec 01, 2021 at 11:09:18AM +0800, Gang Li wrote:
> Hi Feng:
> 
> I am a little confused:
> We have `MPOL_PREFERRED`, why you introduce `MPOL_PREFERRED_MANY` instead of
> making `MPOL_PREFERRED` support multiple preferred nodes?

Cc Ben and Dave.

Actually in the end of this cover letter, there is some explaination
about it, qutoed here:

"
In v1, Andi Kleen brought up reusing MPOL_PREFERRED as the mode for the API.
There wasn't consensus around this, so I've left the existing API as it was. I'm
open to more feedback here, but my slight preference is to use a new API as it
ensures if people are using it, they are entirely aware of what they're doing
and not accidentally misusing the old interface. (In a similar way to how
MPOL_LOCAL was introduced).

In v1, Michal also brought up renaming this MPOL_PREFERRED_MASK. I'm equally
fine with that change, but I hadn't heard much emphatic support for one way or
another, so I've left that too.
"

Ben made this as he initiated the patchset, and I agree this can keep
the API consistent for user . Also at that time, there was another
factor that policy MPOL_PREFERRED and MPOL_LOCAL were coupled tightly
together. 

Thanks,
Feng


