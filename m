Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB856881C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiGFMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiGFMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:15:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8509264F;
        Wed,  6 Jul 2022 05:15:42 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="370047194"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="370047194"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:15:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="568045878"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:15:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1o93wP-0016Sw-2p;
        Wed, 06 Jul 2022 15:15:37 +0300
Date:   Wed, 6 Jul 2022 15:15:37 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 3/3] gpio: adp5588: sort header inclusion
 alphabetically
Message-ID: <YsV86YmZNpieqxiB@smile.fi.intel.com>
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
 <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
 <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com>
 <PH0PR03MB67861277E1AE456A316DFFEB99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <CAHp75VfeZ9jbWvFwL+Sae0h8DG36GeV4PKtskVQe10hpWGf28w@mail.gmail.com>
 <PH0PR03MB6786A0E94BEC148D3547D90A99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB6786A0E94BEC148D3547D90A99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
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

On Wed, Jun 29, 2022 at 10:40:00AM +0000, Sa, Nuno wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Wednesday, June 29, 2022 12:33 PM
> > On Wed, Jun 29, 2022 at 12:10 PM Sa, Nuno <Nuno.Sa@analog.com>
> > wrote:

...

> > Ah, Okay, I was thinking about a week or two from now. Let's see how
> > it will go and let Linus decide how to proceed.
> 
> Yeah, if it does not happen today, I will only get into it again next
> Wednesday (so in this case, might make sense).

If I'm not mistaken, that didn't happen.

Bart, can you apply this series then?

-- 
With Best Regards,
Andy Shevchenko


