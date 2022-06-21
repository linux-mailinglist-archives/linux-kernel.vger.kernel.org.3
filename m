Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAC8552FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348565AbiFUK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbiFUK0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:26:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AC28726;
        Tue, 21 Jun 2022 03:26:35 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="281144103"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="281144103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:26:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="729778749"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:26:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1o3b5Z-000qvj-Kg;
        Tue, 21 Jun 2022 13:26:29 +0300
Date:   Tue, 21 Jun 2022 13:26:29 +0300
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
Message-ID: <YrGc1WKpZ/ik3Bt+@smile.fi.intel.com>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CtjkjsbOTaNF7+Hwswsn-fs2WNK=zyFL53JnBBpS8=0Q@mail.gmail.com>
 <CAHp75Vd9yah3D8dUOPinhj=nm9GQs3xOsWZRL=6CvaROZC3OCQ@mail.gmail.com>
 <CAOMZO5Bp83NSWPmbwp4uzrGSVkW2xQ+pRMFHaghs_XN+j32fcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bp83NSWPmbwp4uzrGSVkW2xQ+pRMFHaghs_XN+j32fcw@mail.gmail.com>
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

On Mon, Jun 20, 2022 at 06:56:27PM -0300, Fabio Estevam wrote:
> On Mon, Jun 20, 2022 at 6:34 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> 
> > Still? Does it mean you have it before my patch? If no, I will be very puzzled...
> 
> Yes, the warning is present before your patch.
> 
> > Otherwise does the touchscreen work?
> 
> I cannot test touchscreen at the moment.
> 
> >> Any suggestions?
> >
> > Perhaps, but we need to eliminate the proposed change from the  equation
> 
> If you send a v2 with "#include <linux/property.h>" then you can add:

Actually the entire thingy with setting node is not needed in this driver.

> Tested-by: Fabio Estevam <festevam@gmail.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


