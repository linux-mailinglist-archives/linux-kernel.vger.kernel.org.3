Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F213494B17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359647AbiATJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:50:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:43635 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359565AbiATJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642672240; x=1674208240;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XcNQCT88V6+x4YNFwMV/mTmNxx13Q91Zj8HJkW17GnM=;
  b=DCJza3tIsKqgZgDrw5DzFZVVk1Cy4HxwrXkTHA6lC4jbUEaTdWqERAIR
   4Ryj8/R7aB4GUmurH98vTk5xHrcSfnVL5KH2seMxOTRcj/3K0csAJiMUu
   sJa90NjFGsiadL4UMAF6GUhA7QkIRYFhRJK3f17NqCrBDM+sQIrXN1IZV
   OUjwCW+kEJ9Oy8CQlUb2+uDJxReqmgu3MXitEECPsriN5OzlaA/t2u0bf
   o67mLLf361C6fBWxwifpLYRQHphYGUBG6yJ+uEBbmPx8WXB2RnLV0mkMO
   kwH6jWlmjdpFby3mHfcliHsf3G9r8l9DoHoB3E3ir5ELcb5XL6m9DnI2X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="269713092"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="269713092"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:50:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="477734540"
Received: from davidfsc-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.52.140])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:50:32 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
In-Reply-To: <20220120141951.30609ba3@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211015210104.0f034544@canb.auug.org.au>
 <20220120141951.30609ba3@canb.auug.org.au>
Date:   Thu, 20 Jan 2022 11:50:27 +0200
Message-ID: <87y23aag7w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Fri, 15 Oct 2021 21:01:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the drm-misc tree, today's linux-next build (htmldocs)
>> produced this warning:
>> 
>> include/drm/drm_modeset_lock.h:74: warning: Function parameter or member 'stack_depot' not described in 'drm_modeset_acquire_ctx'
>> 
>> Introduced by commit
>> 
>>   cd06ab2fd48f ("drm/locking: add backtrace for locking contended locks without backoff")
>
> I am still getting this warning.

Sorry about that, patch on the list [1].

Thanks,
Jani.


[1] https://patchwork.freedesktop.org/patch/msgid/20220120094856.3004147-1-jani.nikula@intel.com

-- 
Jani Nikula, Intel Open Source Graphics Center
