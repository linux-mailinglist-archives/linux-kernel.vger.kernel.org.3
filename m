Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242BE46CE43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbhLHHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:24:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:7164 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236023AbhLHHYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:24:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237581905"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="237581905"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:20:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="515652550"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:20:35 -0800
Date:   Wed, 8 Dec 2021 15:20:22 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v11 4/4] tools: Introduce power/acpi/tools/pfru
Message-ID: <20211208072022.GB261963@chenyu-desktop>
References: <cover.1637505679.git.yu.c.chen@intel.com>
 <a1f688cd4ade1257e96d13c91eba72a1aeef5d59.1637505679.git.yu.c.chen@intel.com>
 <CAJZ5v0gLXxvzKcjSFH0Coq_VRE9fiT9AiCD_vsg7x1Gaq62V+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gLXxvzKcjSFH0Coq_VRE9fiT9AiCD_vsg7x1Gaq62V+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:52:03PM +0100, Rafael J. Wysocki wrote:
> On Sun, Nov 21, 2021 at 4:18 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Introduce a user space tool to make use of the interface exposed by
> > Platform Firmware Runtime Update and Telemetry drivers. The users
> > can use this tool to do firmware code injection, driver update and
> > to retrieve the telemetry data.
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v11:No change since v10.
> > v10:No change since v9.
> > v9: Add this tool into tools/power/acpi build infrastructure.
> >     (Andy Shevchenko)
> > v8: Print the length of OEM information if requested.
> > v7: No change since v6.
> > v6: Simplify the userspace tool to use while loop for getopt_long().
> >     (Andy Shevchenko)
> > v5: Replace the read() with mmap() so that the userspace
> >     could mmap once, and read multiple times. (Greg Kroah-Hartman)
> > ---
> >  tools/power/acpi/.gitignore          |   1 +
> >  tools/power/acpi/Makefile            |  16 +-
> >  tools/power/acpi/Makefile.rules      |   2 +-
> >  tools/power/acpi/man/pfru.8          | 137 +++++++++
> 
> I would call it pfrut, because it is for both the update and telemetry
> retrieval.
>
Ok, will change it. 
[cut]
> > diff --git a/tools/power/acpi/tools/pfru/pfru.c b/tools/power/acpi/tools/pfru/pfru.c
> > new file mode 100644
> > index 000000000000..eeec5043f825
> > --- /dev/null
> > +++ b/tools/power/acpi/tools/pfru/pfru.c
> > @@ -0,0 +1,417 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Platform Firmware Runtime Update tool to do Management
> > + * Mode code injection/driver update and telemetry retrieval.
> 
> I would be good to say a bit more here, like what interfaces are used
> by this tool etc.
>
Ok, will do. 
> > +}
> > --
[cut]
> 
> Please adjust the patch for the build fixes sent separately.
> 
> Otherwise it is fine with me.
Ok, that patch has been sent separately.

thanks,
Chenyu
