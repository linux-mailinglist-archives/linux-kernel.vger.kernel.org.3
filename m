Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCE15220BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347236AbiEJQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347202AbiEJQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:09:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C32670B7;
        Tue, 10 May 2022 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652198737; x=1683734737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=knKoDSX6XXVi1UoUVL9DwH66JaiGwiaJztWXaAd6inc=;
  b=XryxLngxqZCXypeKsueZ0AsnkNZ++ArGYWUAOhsrAy7R5n23abIRRjsZ
   eg8YLcC1nP95DD0AJhuZ6+PC96L7lwOT25Yg5aBDE3A4+Q+7473Lemrpj
   wJg5SgCrPj44Tu3yLaFimmfHpNdKdbEDvqaTluegaCZ4Tpif+3XcDLqs1
   o07bfPLT9y7cj+8MXp6TMDAb+AHJ+AcXXHbMZ8A547sQnB5Kzy8ECoqbH
   wdjeOrRCHPKHP1s4weEy0OaWXrHCjmBeh6i8cOvU+UilOmuMANkGU8nQo
   iNH3hxghXgrLoIZsCQjqPE0K/JY+u6/jbcAWwr11emAJQ1E/UF98xpn+R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269558159"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269558159"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 09:05:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="738765503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 09:05:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1noSMR-00EOjV-12;
        Tue, 10 May 2022 19:05:19 +0300
Date:   Tue, 10 May 2022 19:05:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 0/2] simatic-ipc additions to p2sb apl lake gpio
Message-ID: <YnqNPpIKFAoLegMr@smile.fi.intel.com>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
 <20220308193522.26696-1-henning.schild@siemens.com>
 <YnJ2tYjCpJi7yc4j@smile.fi.intel.com>
 <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
 <20220510173053.10a14aeb@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510173053.10a14aeb@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 05:30:53PM +0200, Henning Schild wrote:
> Am Wed, 4 May 2022 17:19:51 +0200
> schrieb Henning Schild <henning.schild@siemens.com>:
> > Am Wed, 4 May 2022 15:51:01 +0300
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > > On Tue, Mar 08, 2022 at 08:35:20PM +0100, Henning Schild wrote:

...

> > > [1]: https://gitlab.com/andy-shev/next/-/tree/topic/p2sb-next
> > > It would be nice if you can perform another round of testing.
>
> Just got around to testing this with my patches on top. My stuff will
> need some more work before i can send again.
>
> Is this a rebasing branch?
> With efc7d77ea372 ("EDAC, pnd2: convert to use common P2SB accessor")

It's rebased over and over. I just pushed the same version I have sent as v5.

> I am seeing problems while booting ... things do work but still error
> messages which probably should not be there.

It's okay. This is not related to my stuff, it's a new series from Marc which
enables that (harmless) warning.

> [    2.217506] broxton-pinctrl apollolake-pinctrl.1: Failed to attach ACPI GPIO chip
> [    2.217542] gpio gpiochip1: (apollolake-pinctrl.1): not an immutable chip, please consider fixing it!
> [    2.217771] i801_smbus 0000:00:1f.1: Failed to enable SMBus PCI device (-22)
> [    2.217788] i801_smbus: probe of 0000:00:1f.1 failed with error -22
> [    2.221460] broxton-pinctrl apollolake-pinctrl.2: Failed to attach ACPI GPIO chip
> [    2.221482] gpio gpiochip2: (apollolake-pinctrl.2): not an immutable chip, please consider fixing it!
> [    2.222010] broxton-pinctrl apollolake-pinctrl.3: Failed to attach ACPI GPIO chip
> [    2.222023] gpio gpiochip3: (apollolake-pinctrl.3): not an immutable
> chip, please consider fixing it!

-- 
With Best Regards,
Andy Shevchenko


