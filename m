Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D252BE26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiEROeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiEROeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:34:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D3134E2B;
        Wed, 18 May 2022 07:34:22 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="269284214"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="269284214"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:34:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="627067527"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:34:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nrKkj-000EtI-Gj;
        Wed, 18 May 2022 17:34:17 +0300
Date:   Wed, 18 May 2022 17:34:17 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] pinctrl: intel: make irq_chip immutable
Message-ID: <YoUD6QeWZWqLdX94@smile.fi.intel.com>
References: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
 <YoR/QXuS+VlLVWto@lahna>
 <YoSyTq2908EptTGd@smile.fi.intel.com>
 <YoS6EkfU1TdggKS/@lahna>
 <CAHp75VenknSRSUkGj9rKfzw2q1Mm-+zRrzAmcYRLdK1GJHDoHw@mail.gmail.com>
 <YoTGXmxTMFTBgwy9@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoTGXmxTMFTBgwy9@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:11:42PM +0300, Mika Westerberg wrote:
> On Wed, May 18, 2022 at 12:05:38PM +0200, Andy Shevchenko wrote:
> > On Wed, May 18, 2022 at 11:19 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Wed, May 18, 2022 at 11:46:06AM +0300, Andy Shevchenko wrote:

...

> > > Hope this explains.
> > 
> > Yes, thanks!
> > 
> > Okay, can you give your conditional Ack if there are no other
> > comments? I will fix it locally.
> 
> Sure. There was typo also in the second patch $subject, please fix it
> too while you apply them.

Fixed.

> For both,
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


