Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0988E49849C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbiAXQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:23:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:14634 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243618AbiAXQXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643041417; x=1674577417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zkVnxmZoUn2PXNTt6Cj60EJHO4p9UXlPBZUS9Jg10dI=;
  b=I/7WiJCWS15OfMwS/K9XQtepGgrH3VrwfgvNz8lNek8LjnI5cQTgLiBX
   g7dUxBB/zRs1ULXCY81aqRQKDs7r1LsOofAvqtOfQa6ws3zMLcfwvMyqG
   qYVaD+gEXQcLkHZqwqd8hN/owQcz/oUQYA35xj+IWNs5aECwB/HD2/iz7
   fjXvJVReWGRSujBqZWNbOKOthTMrbcV+Iz5URz7uxZsGGH5VhI873rcDO
   ejg3BypMpuFsaf2o/2DQUsrYWEeS9bK3pQm1NdEnzZIUKQKntS6Muy4Gt
   674Sb2blDkt3x94IUvDQld1+ifhUTg9RyeSyudvAXY5ZmSYTqE2t7Yhdy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226064467"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226064467"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:23:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="479135670"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:23:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nC26t-00Dwzw-NZ;
        Mon, 24 Jan 2022 18:22:27 +0200
Date:   Mon, 24 Jan 2022 18:22:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary
 inclusions
Message-ID: <Ye7SQ7Na4Q5KyvOk@smile.fi.intel.com>
References: <20211222164534.67636-1-andriy.shevchenko@linux.intel.com>
 <20211229095345.GX18506@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229095345.GX18506@ediswmail.ad.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 09:53:45AM +0000, Charles Keepax wrote:
> On Wed, Dec 22, 2021 at 06:45:34PM +0200, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> > 
> > Replace kernel.h inclusion with the list of what is really being used.

> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks!

Takashi, should I resend this?

-- 
With Best Regards,
Andy Shevchenko


