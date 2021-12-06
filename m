Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2C469762
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbhLFNrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:47:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:3659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244642AbhLFNro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:47:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="217338493"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="217338493"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:44:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="611240840"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:44:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muEGt-002nQb-8m;
        Mon, 06 Dec 2021 15:43:11 +0200
Date:   Mon, 6 Dec 2021 15:43:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <Ya4Tb9NUj33UdxmI@smile.fi.intel.com>
References: <20211206144901.63529ac9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206144901.63529ac9@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 02:49:01PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/misc/eeprom/at25.c
> 
> between commit:
> 
>   9a626577398c ("nvmem: eeprom: at25: fix FRAM byte_len")
> 
> from the char-misc.current tree and commits:
> 
>   5b557298d7d0 ("misc: at25: Make driver OF independent again")
>   a692fc39bf90 ("misc: at25: Don't copy garbage to the at25->chip in FRAM case")
>   58589a75bba9 ("misc: at25: Check proper value of chip length in FRAM case")
>   51902c1212fe ("misc: at25: Use at25->chip instead of local chip everywhere in ->probe()")
> (and probably more)
> 
> from the char-misc tree.
> 
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

The result from char-misc.current should be used as is and I guess it's
what you have done, thanks!

-- 
With Best Regards,
Andy Shevchenko


