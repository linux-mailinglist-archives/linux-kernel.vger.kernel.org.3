Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA764495C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379671AbiAUJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:09:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:40640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240382AbiAUJJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642756175; x=1674292175;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FtxghI/3srHjFevRT1v1DlUkGCseUklGodDeUCzopWs=;
  b=S7kZw+FaOXl1MGqevVeoHNEFy7eLAjL3ACQh05kJSsd/IIMCFh6MdDKq
   J2cZDHoUtOAXtID3b9321e7xXP0/E/41A/LlM7Vj2pSDhTGfM/ZADzG/D
   id+TjHq8/EXF7h/gFDZXVp4FUWurvSq3WQqJwMLaSCw+6MTiaEPdt8lqa
   7ebotmZ4NDGCo6m0WVsXnj51RXShbaxuRCH4pEjobi3SMBbQkwGYY+kpR
   Y10Y+wcgmhc8mMp7pj8Q9xAkhQ30PkuyTaw2nAPewgOlhQkVWhh8TVesT
   xqrdlGBsqP4vK/JYkRDMyVzFV9+cnLOrpymGWXAsZkNGYh+7Lv79JkAzE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="225589267"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="225589267"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 01:09:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="533198110"
Received: from chandra2-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.104])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 01:09:28 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.17-rc1
In-Reply-To: <CAKMK7uGeGBBvTGFyBxLwvTAxEWwXMS8U1rrYUb_7gbui-jV+KA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <Yeg11pHSqx29yg/T@ls3530>
 <CAKMK7uGeGBBvTGFyBxLwvTAxEWwXMS8U1rrYUb_7gbui-jV+KA@mail.gmail.com>
Date:   Fri, 21 Jan 2022 11:09:21 +0200
Message-ID: <87fsph4fr2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jan 19, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
>> A first bunch of updates and fixes for the following fbdev & backlight drivers:
>> ocfb, aty128fb, mb862xx, omapfb, qcom-wled, dt-bindings, hyperv_fb,
>> lm3630a_bl, omap2, controlfb, matroxfb
>>
>> Nothing really important, mostly cleanups, const conversions, added null
>> pointer/boundary checks and build fixes.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Not sure whether Linus missed this or just wanted to let the
> discussion settle first. But since this is all random patches for
> drivers that many distros don't even enable anymore there's no issues
> here, and I very much welcome someone volunteering to pick these up.
> I'd expect there's a pile more since it's been 1-2 years since Bart
> took care of these and merged them consistently.
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

...

>>  drivers/video/backlight/lm3630a_bl.c                     |  1 -
>>  drivers/video/backlight/qcom-wled.c                      |  1 +

Backlight changes usually go through the backlight tree.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
