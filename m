Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE049215E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbiARIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:38:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:3670 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344523AbiARIiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642495101; x=1674031101;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FhVSDuFXzCYwf0ycFrcVmxrINtgqM1+o6yYDqyQgb7c=;
  b=HvBhHwrT1rVtQi2HT3Hsw6c8jACuRRMCABy9Mnb39M55/06t+8ye4zD3
   Y8MPZ38m1UiyHfbiCHOViC13E+pkXugY4YqFaP7Bd2TYM9AWs1KS8xvnK
   PV92HttH/6B+bw+mTF2wa1ZDMAT1PcqPGFGEDcioyi4fspDso00XCac3M
   tZdDGlItAqd2YWBLxgseOC8dFRHf3Fht/umwisItvb0Jxgkr2apr2U+Uk
   zbJHtNxtYixn3+D2eb5Vooi848yNhycQW7D6wKzK008ZVvVYrUAZOpiXL
   BYYZcSm15i4xuCHjqS3iaq5MkUJm/NCFq8W4ch7VRuiq9oF2JcL3cPFTX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269146339"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="269146339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 00:38:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625435611"
Received: from alexruss-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.3.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 00:38:15 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
In-Reply-To: <4f1d6018-d74e-8e62-ea4d-0ca79c6bbbc5@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <YeG8ydoJNWWkGrTb@ls3530>
 <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
 <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de>
 <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de> <87ee5659dt.fsf@intel.com>
 <4f1d6018-d74e-8e62-ea4d-0ca79c6bbbc5@gmx.de>
Date:   Tue, 18 Jan 2022 10:38:04 +0200
Message-ID: <87a6ft5thv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022, Helge Deller <deller@gmx.de> wrote:
> On 1/17/22 22:40, Jani Nikula wrote:
>> On Mon, 17 Jan 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> Seems like few people read linux-fbdev these days.
>>
>> How much traffic is there to linux-fbdev that is *not* Cc'd to dri-devel
>> also?
>
> Doesn't seem like much traffic - which IMHO is OK for such a tree with
> mostly just maintenance patches.
>
>> Do we still need a separate linux-fbdev mailing list at all?
>
> Yes. I want to have it seperate of dri-devel.
> Actually I'd prefer to drop dri-devel from the list where patches
> for fbdev are sent...

Disagreed. If anything, this thread shows we can't have fbdev and drm in
silos of their own.

Also, if the patches continue to get merged through drm-misc, they need
to be sent to dri-devel.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
