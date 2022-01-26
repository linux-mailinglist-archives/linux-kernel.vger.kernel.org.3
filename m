Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A0249D0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbiAZReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:34:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:31882 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243769AbiAZReW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643218462; x=1674754462;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=K129hl5RytW5ura24/yx7HTDJHZL++ViTWK4Ed5BQCk=;
  b=NrxADOJzzBssggdR/hkBY8P7s1z2d6nq6xu571XAoMcfz+yvPCXJKE7F
   CsD1mn46zIuFy7pcX324McLQCmZD22zGmgE0kNCK3nzmyj0SZyUJkBd6u
   O86OvCZgtMLNssMd/aFMcuxthgBxi0FLnQe5BMUthNZslw8ypy8q5C4CW
   32yTGIHYBGdMpWv9fst6v2XUZVRhczbqoBpcKr7Zx+3MMHTG++Sd0C8qC
   5AaNuD6Nsf3C/iKmHQcMXpgDto0j+W15srt29+9ZlT8BhQGJLRLnIstgh
   LwTCj1+cKeKdU2dEJlnmwozSTWE7YB5FfUNRhofkRzdg55vs3h7y2sDgk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="245438929"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="245438929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 09:34:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="624901254"
Received: from nbasu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.16.197])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 09:34:16 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
In-Reply-To: <YfFV4EJosayH+e6C@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com>
 <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com>
Date:   Wed, 26 Jan 2022 19:34:13 +0200
Message-ID: <87v8y6xuy2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> And basically create a MIPI based driver for I2C.

What does that even mean?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
