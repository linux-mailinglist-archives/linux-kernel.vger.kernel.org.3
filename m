Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFB552FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiFUKfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFUKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:35:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FC213DD1;
        Tue, 21 Jun 2022 03:35:50 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="278856732"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="278856732"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:35:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="729782212"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:35:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1o3bEW-000qw8-M5;
        Tue, 21 Jun 2022 13:35:44 +0300
Date:   Tue, 21 Jun 2022 13:35:44 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <YrGfAD/zNdsH4cw/@smile.fi.intel.com>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CtjkjsbOTaNF7+Hwswsn-fs2WNK=zyFL53JnBBpS8=0Q@mail.gmail.com>
 <CAHp75Vd9yah3D8dUOPinhj=nm9GQs3xOsWZRL=6CvaROZC3OCQ@mail.gmail.com>
 <CAOMZO5Bp83NSWPmbwp4uzrGSVkW2xQ+pRMFHaghs_XN+j32fcw@mail.gmail.com>
 <YrGc1WKpZ/ik3Bt+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrGc1WKpZ/ik3Bt+@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 01:26:29PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 20, 2022 at 06:56:27PM -0300, Fabio Estevam wrote:
> > On Mon, Jun 20, 2022 at 6:34 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:

...

> > If you send a v2 with "#include <linux/property.h>" then you can add:
> 
> Actually the entire thingy with setting node is not needed in this driver.

I stand corrected, the fwnode assignment is done fore the IIO parent's parent,
it's needed...


-- 
With Best Regards,
Andy Shevchenko


