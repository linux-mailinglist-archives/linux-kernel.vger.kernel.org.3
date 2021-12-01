Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F94464E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349510AbhLANRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:17:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:35539 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240707AbhLANRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:17:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223332603"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="223332603"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:13:46 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="609547456"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:13:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msPPd-000zQr-BK;
        Wed, 01 Dec 2021 15:12:41 +0200
Date:   Wed, 1 Dec 2021 15:12:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpio: dwapb: clarify usage of the register file
 version
Message-ID: <Yad0yWqMMe13ruEO@smile.fi.intel.com>
References: <20211130164956.37540-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MfC0wwa+T40eqUTx5w_X6ioqDbL3a7nnOTogpE2j4HVOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfC0wwa+T40eqUTx5w_X6ioqDbL3a7nnOTogpE2j4HVOg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 09:29:54AM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 30, 2021 at 5:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>

Thanks!

> Please send it with your PR.

Will do.

-- 
With Best Regards,
Andy Shevchenko


