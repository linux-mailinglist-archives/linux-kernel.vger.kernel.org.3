Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59DD4639F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbhK3P1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:27:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:24582 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244310AbhK3PYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:24:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234958803"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="234958803"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:16:22 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="540441666"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:16:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1ms4qg-000aHE-IN;
        Tue, 30 Nov 2021 17:15:14 +0200
Date:   Tue, 30 Nov 2021 17:15:14 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Henning Schild <henning.schild@siemens.com>, kai.svahn@intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v4 2/4] leds: simatic-ipc-leds: add new driver for
 Siemens Industial PCs
Message-ID: <YaZAAgDPquDMpvIn@smile.fi.intel.com>
References: <20211126141027.16161-1-henning.schild@siemens.com>
 <20211126141027.16161-3-henning.schild@siemens.com>
 <CAHp75VcD0FQuG_AToNkVHHD9e6WV6=18P4U0cSi0qzD3FL=ssw@mail.gmail.com>
 <20211126191203.663e0d90@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126191203.663e0d90@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 07:12:03PM +0100, Henning Schild wrote:
> Am Fri, 26 Nov 2021 17:02:00 +0200
> schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> > On Fri, Nov 26, 2021 at 4:10 PM Henning Schild
> > <henning.schild@siemens.com> wrote:
> > >
> > > This driver adds initial support for several devices from Siemens.
> > > It is based on a platform driver introduced in an earlier commit.  
> > 
> > ...
> > 
> > > +static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
> > > +       {0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
> > > +       {0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
> > > +       {0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
> > > +       {0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
> > > +       {0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
> > > +       {0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
> > > +       { }
> > > +};  
> > 
> > Like I said, this is not okay.
> > 
> > Why can't you simply enable the pinctrl driver and use it?

I have talked to my boss today and I have got an approval to prioritize
the task, so I'm all yours starting from tomorrow.

Let's finish it once for all!

> I propose we set up a call, that might help clearing up the situation.
> If you agree please send me an email and possibly propose a time-slot.
> I would take it from there and send you a meeting link.

Sure!

-- 
With Best Regards,
Andy Shevchenko


