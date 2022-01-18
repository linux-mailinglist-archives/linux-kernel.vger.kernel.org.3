Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F52492749
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiARNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:33:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:20237 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbiARNdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512816; x=1674048816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r12jMZqW3/WnUriCyz5HZN5FFe5jtdoU3x0kjbYDskE=;
  b=G68f3MLGTdNdm88aRRyVd9ID8cSTf4QpmOdxXX5YcoVYnurntZtoRuGr
   BH8lUfNLDFNyxW79uNVKllXIArYnB6H12EyWitOnE5lRFGPugzw8FfnCr
   ezAvh5OKk57BemsXP54eDs2XxsGUFYA1WGypq9JHK5b4rCJ6HDwI/d3eS
   3U5bJ8GGKaMgEL05xzdZ6/xEowV8f8djWE0G6gZrGhobN52uwHG9ptMvI
   bpABLbyvwiqNiMYv5FI55Ajas1rrY3dZXpiUSEYBuwGEObSLoYvjPCvHy
   dsa0ydE02df2ejSY7BTjSClRDb8I6WwdJoOU4EjLgPVBqCQiLR0YKx9fY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="225492554"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208,223";a="225492554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:33:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208,223";a="671839651"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Jan 2022 05:33:32 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 Jan 2022 15:33:31 +0200
Date:   Tue, 18 Jan 2022 15:33:31 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org
Subject: Re: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e,
 the kernel stops loading on my devices.
Message-ID: <YebBq/WDeYCIvwYw@kuha.fi.intel.com>
References: <CABXGCsNb22JCJ4AyR1sYqFtF4QUnvM3B2zQcc1svcm2mquWxoA@mail.gmail.com>
 <YeUvvIaVJnJrrpYe@kuha.fi.intel.com>
 <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
 <YeVQsRp7aDMcQKs7@kuha.fi.intel.com>
 <CABXGCsMWXFFQY3L8ixK9K-gYX41_gTjqHRBXNp6gDpUgdnvFfg@mail.gmail.com>
 <YeVfYOhxGTgg8VpZ@kuha.fi.intel.com>
 <CABXGCsOwsP7NJ67oyK3HPs2EarSJKLB9EVW7oEh+8bAFihSa8g@mail.gmail.com>
 <Yea8p1b/sZYKNGaB@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MxjOsjrC21eCMA0L"
Content-Disposition: inline
In-Reply-To: <Yea8p1b/sZYKNGaB@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MxjOsjrC21eCMA0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 18, 2022 at 03:12:10PM +0200, Heikki Krogerus wrote:
> Hi Mikhail,
> 
> On Tue, Jan 18, 2022 at 04:26:27PM +0500, Mikhail Gavrilov wrote:
> > On Mon, 17 Jan 2022 at 17:21, Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Have you modified the file, or something else that you have not
> > > committed yet?
> > >
> > >         % git status
> > >
> > > Checkout the file, and then try to apply the patch:
> > >
> > >         % git checkout drivers/usb/typec/port-mapper.c
> > >         % git apply -v 0001-usb-typec-Test-fix.patch
> > >
> > 
> > I understood why the patch was not applied. The "Window line endings"
> > in the attached file were.
> > 
> > $ dos2unix 0001-usb-typec-Test-fix.patch
> > dos2unix: converting file 0001-usb-typec-Test-fix.patch to Unix format...
> > $ git apply -v 0001-usb-typec-Test-fix.patch
> > Checking patch drivers/usb/typec/port-mapper.c...
> > Applied patch drivers/usb/typec/port-mapper.c cleanly.
> 
> Oh, I'm sorry. Something corrupted the patch, which is a bit alarming,
> but good that you managed to test it in any case.
> 
> > Unfortunately the attached patch didn't fix the issue.
> > 
> >  BUG: kernel NULL pointer dereference, address: 0000000000000008
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 0 P4D 0
> >  Oops: 0000 [#1] PREEMPT SMP NOPTI
> >  CPU: 10 PID: 459 Comm: kworker/10:2 Not tainted
> > 5.16.0-patched-455e73a07f6e+ #26
> >  Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY,
> > BIOS G513QY.316 11/29/2021
> >  Workqueue: events_long ucsi_init_work [typec_ucsi]
> >  RIP: 0010:component_master_add_with_match+0x14/0x110
> >  Code: 72 d7 48 89 ef 5b 5d e9 1a 5c 9f ff 66 2e 0f 1f 84 00 00 00 00
> > 00 0f 1f 44 00 00 41 55 49 89 fd 41 54 49 89 f4 55 53 48 89 d3 <48> 8b
> > 72 08 48 3b 32 74 10 48 89 d7 e8 4b fd ff ff 85 c0 0f 85 bb
> >  RSP: 0018:ffffba4581837d90 EFLAGS: 00010282
> >  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >  RDX: 0000000000000000 RSI: ffffffffc04f58d0 RDI: ffff9c5afe43a808
> >  RBP: ffff9c5a81076358 R08: 0000000000000001 R09: 0000000000000001
> >  R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffc04f58d0
> >  R13: ffff9c5afe43a808 R14: ffff9c5afe43a808 R15: ffff9c5a832c4010
> >  FS:  0000000000000000(0000) GS:ffff9c5d88a00000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000000000000008 CR3: 00000002e5028000 CR4: 0000000000750ee0
> >  PKRU: 55555554
> >  Call Trace:
> >   <TASK>
> >   typec_link_ports+0x5d/0x70 [typec]
> >   typec_register_port+0x1e6/0x2e0 [typec]
> >   ucsi_init_work+0x463/0x840 [typec_ucsi]
> >   process_one_work+0x2bb/0x600
> >   worker_thread+0x55/0x3b0
> >   ? process_one_work+0x600/0x600
> >   kthread+0x17c/0x1a0
> >   ? set_kthread_struct+0x40/0x40
> >   ret_from_fork+0x22/0x30
> >   </TASK>
> 
> This is not the same issue, this is another bug :-(. The original
> issue does seem to be fixed.
> 
> I can reproduce this one by simply not creating the component list in
> the code. That function - component_master_add_with_match() - can't
> handle situation where the list is empty. I'll prepare the fix.

I'm again attaching the proposed fix, just to see if it also gets
corrupted. Can you test does it fix this issue?
You need to apply it on top of the previous one.

thanks,

-- 
heikki

--MxjOsjrC21eCMA0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-typec-Don-t-try-to-register-component-master-wit.patch"

From acae81528b4c2bd0b461a4c3bd66b9df10947ac9 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Tue, 18 Jan 2022 16:15:37 +0300
Subject: [PATCH] usb: typec: Don't try to register component master without
 components

This fixes NULL pointer dereference that happens if
component master is registered with empty component match
list.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Fixes: 730b49aac426 ("usb: typec: port-mapper: Convert to the component framework")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/port-mapper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index b6e0c6acc628c..a7d507802509f 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -60,6 +60,8 @@ int typec_link_ports(struct typec_port *con)
 		return 0;
 
 	bus_for_each_dev(&acpi_bus_type, NULL, &arg, typec_port_match);
+	if (!arg.match)
+		return 0;
 
 	/*
 	 * REVISIT: Now each connector can have only a single component master.
-- 
2.34.1


--MxjOsjrC21eCMA0L--
