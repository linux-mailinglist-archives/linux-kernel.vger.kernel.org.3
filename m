Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43C47D073
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbhLVLBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:01:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:60648 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240137AbhLVLBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:01:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="221273548"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="221273548"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 03:01:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="586982419"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 03:01:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mzzM5-000jZb-Dv;
        Wed, 22 Dec 2021 13:00:21 +0200
Date:   Wed, 22 Dec 2021 13:00:21 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused local OF node pointers
Message-ID: <YcMFRb6A43ma/hFi@smile.fi.intel.com>
References: <20211220132439.1194-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Md3bpCJe_eFBjiKuhCRO_xqnFxSc1sw100fgNmajy6gaw@mail.gmail.com>
 <CAHp75VcbaYXfDpc7xE=asSqUspscRoHfqrg-yMtx=uo5UNqxfw@mail.gmail.com>
 <CAMRc=MfWqV8UFWLaJO7JSo7N6MhYVMWdquMDJU7xR5gu8604AQ@mail.gmail.com>
 <CAHp75VfhY9zFxC_vDj0OH0Y0ah3RUgEEYO9p_uQsm7Xe63QF8w@mail.gmail.com>
 <CAMRc=Mfn9P30niRMNqV4f7VByzV0a+Sf2vS4OcU1qPa4o1O8Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mfn9P30niRMNqV4f7VByzV0a+Sf2vS4OcU1qPa4o1O8Lg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:06:53AM +0100, Bartosz Golaszewski wrote:
> On Tue, Dec 21, 2021 at 9:21 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Dec 21, 2021 at 9:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > I see. Probably I missed that somehow.
> > Nevertheless, do you want a new version or can you just revert that
> > particular change?
> 
> I removed it and queued the rest.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


