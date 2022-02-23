Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB64C163F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbiBWPNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBWPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:13:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC37B12E7;
        Wed, 23 Feb 2022 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645629193; x=1677165193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a68exJg5PUkXlSFsTW/nFLDiaj4D+gBrJFzqKkgzm1g=;
  b=UW6uz91oDEfFZjFzZCecs7HwTUiTlIlYkhIgykDV7SCj58KJfFU68LiB
   VXdkYMEg+7QPm9EJPkW0C7/xMABvRjDxGxZj21L/CPKhM1v+7OEwCNDzY
   e9Il3x6wq+9nQ/UwGkpgGW7u+rWUYxCkz6Vj8FFPgr+x7p+mOk98OiNtY
   XxjNJ4600Gs7gNHQKJd2VxS0NtO5W79BiVmJWC+VS13ADPfCp+IGOpUVZ
   +aL5hQ6N7VzmEyFYwh0Dqe596/1PsB+ZJ4eG9ClrNB91GMSk280QJmqu6
   lq8cAUliVZulXteOOcRaYvNcnxYYYPL98jYUOG6NpizoWvs1wv16K8UH8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250811824"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="250811824"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:13:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491228551"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:13:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMtJU-007TEX-Aj;
        Wed, 23 Feb 2022 17:12:20 +0200
Date:   Wed, 23 Feb 2022 17:12:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 4/4] pinctrl: icelake: Add Ice Lake-N PCH pin
 controller support
Message-ID: <YhZO021m102OOJsk@smile.fi.intel.com>
References: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
 <20220215152800.21104-4-andriy.shevchenko@linux.intel.com>
 <YhOvuFwr2v15zY3u@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhOvuFwr2v15zY3u@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 05:28:56PM +0200, Mika Westerberg wrote:
> On Tue, Feb 15, 2022 at 05:28:00PM +0200, Andy Shevchenko wrote:
> > This adds pinctrl/GPIO support for Intel Ice Lake-N PCH. The Ice Lake-N
> > PCH GPIO is based on the same version of the Intel GPIO hardware than
> > Intel Cannon Lake with different set of pins and ACPI ID.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

All pushed to my review and testing queue, thanks!


-- 
With Best Regards,
Andy Shevchenko


