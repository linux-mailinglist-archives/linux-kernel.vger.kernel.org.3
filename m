Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4449115D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbiAQVk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:40:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:55609 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbiAQVk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642455628; x=1673991628;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HtUPxF3I/Nek045AhvkduD0dgoN3i5w23EDYGoJRe1c=;
  b=XXhx3PcYgZbs/ogNAT18ucKKfwVNuVSpzx16qEiIKfAZbDAOakJIQnMo
   /9MvNr78sYVzm6Y715YhhAGLHLTM/43l28y+42mDQTgzAXP9gX/9UsP04
   Oc7STOZyWo4qPFAiP2s6Koiemy3ou20+04LU59xsXthOrhZ0UQ5MSzOm0
   NrBAcCVWBWC1BWs02GyO5CY4FUA9jJP033NjG9xRGHTNShFfXm2yL2dFK
   bsPX2RRg+W1q2hG226wenzKkhjTOCLY2SIMtIPcOxpPx5vU1wf7Sx/dU4
   I39l9Jap1prtqDmKyExO5IHFQXHxrNguqnoaJzy32ou7uel9mhDGrREsL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="232053955"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="232053955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 13:40:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625305131"
Received: from neiljwal-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.3.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 13:40:24 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
In-Reply-To: <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <YeG8ydoJNWWkGrTb@ls3530>
 <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de>
 <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de>
 <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
Date:   Mon, 17 Jan 2022 23:40:14 +0200
Message-ID: <87ee5659dt.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Seems like few people read linux-fbdev these days.

How much traffic is there to linux-fbdev that is *not* Cc'd to dri-devel
also? Do we still need a separate linux-fbdev mailing list at all?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
