Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994415249A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352363AbiELJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352324AbiELJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:58:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDBC22EA61;
        Thu, 12 May 2022 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652349516; x=1683885516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6GELAe/ApmVBKafQ2S7vNKp/RtrglRXEhF1UXL6PS3M=;
  b=P+ra6eRELOFYjAUEjyMlWl0p89RWLxKiY+3ScAYLNvk3hurrRzLuv4D7
   +IjAW9wJ6vKncHus1aPePHCP2Gm32Dz3MSHaahQwn3j0XHjQksjtqysrk
   dHKVgFlKrfn5WZq+KU0h8GUE63EEFZTtAaNeA40VIELXAuVifdo03355q
   Jzz23VPGxtGHBNhhMtmMGZrF1T1WvBejg5ZSp3QDCDYUutbCjISNgAXZw
   mz+mVwkjYN1tjCXKghJ64PEU7mVFXOmuwrsfitkH1OLRcp8+FSNs3HZba
   J7CoyLPYvstmFTm9Ebak8Vw3qLfB4eUTw1E6ea8uZjGSeL85LAlU5gzxZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249850492"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="249850492"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:58:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="542705299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:58:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1np5aV-00F9q1-T7;
        Thu, 12 May 2022 12:58:27 +0300
Date:   Thu, 12 May 2022 12:58:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v2 4/4] leds: simatic-ipc-leds-gpio: add GPIO version of
 Siemens driver
Message-ID: <YnzaQxProKeOkR41@smile.fi.intel.com>
References: <20220511153905.13980-1-henning.schild@siemens.com>
 <20220511153905.13980-5-henning.schild@siemens.com>
 <20220512104424.1430c9a3@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512104424.1430c9a3@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:44:24AM +0200, Henning Schild wrote:
> Am Wed, 11 May 2022 17:39:05 +0200
> schrieb Henning Schild <henning.schild@siemens.com>:

...

> > +config LEDS_SIEMENS_SIMATIC_IPC_GPIO
> 
> I wonder if i really should introduce a new switch here or just carry
> this one under LEDS_SIEMENS_SIMATIC_IPC
> 
> For a v3 i will likely put two modules under that one config switch.

For me either is okay, but I'm not a LED maintainer.

-- 
With Best Regards,
Andy Shevchenko


