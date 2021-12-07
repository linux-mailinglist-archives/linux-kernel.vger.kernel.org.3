Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0AC46B93A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhLGKin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:38:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:30917 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLGKim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:38:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237491952"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237491952"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:35:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="461210699"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:35:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1muXnV-003Avc-Tu;
        Tue, 07 Dec 2021 12:34:09 +0200
Date:   Tue, 7 Dec 2021 12:34:09 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andy@kernel.org" <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: intel: Assume 0 by default for PNP UID
Message-ID: <Ya84odaFgmqygJ2I@smile.fi.intel.com>
References: <20211204030452.1482507-1-kai.heng.feng@canonical.com>
 <CAHp75VccS43XVophOW=+5=A4p4cUiwvXdwGp-yU+BNDN3cOu3g@mail.gmail.com>
 <CAAd53p7L6Wcp7wBeHRp7NDPbKJ+kPPAPXi27zWQ08jZbt3M6aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7L6Wcp7wBeHRp7NDPbKJ+kPPAPXi27zWQ08jZbt3M6aA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:48:23AM +0800, Kai-Heng Feng wrote:
> On Sat, Dec 4, 2021 at 8:49 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Saturday, December 4, 2021, Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > There's an EHL board that the DSDT doesn't have _UID for pinctrl device,
> > > and that causes a NULL pointer dereference in strcmp().
> > >
> > > So in the absence of _UID, assume it's 0 by default to avoid the issue
> > > and get a pinmap.
> >
> > Do you have updated firmware?
> 
> Customer confirmed new code drop from Intel does have _UID defined.
> So I guess this patch is not needed anymore?

It is not, this is the idea, thanks for confirming!

-- 
With Best Regards,
Andy Shevchenko


