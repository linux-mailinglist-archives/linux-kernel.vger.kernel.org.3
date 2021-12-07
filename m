Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA946B2ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhLGGeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:34:31 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5508 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234853AbhLGGea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:34:30 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ARnAY7qgSt+DTUd19u2+X9gyiX161pxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUHmmFJDT+GbKuPNmH0Kd0kPdm38xgPuZbXyN5jG1Y6/Hw8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?eYn8pHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6Wk0DTqTTMA7mZnh+C/Xk3EgE/3ZrlP9kb5Lwam8O49mNt9JszNRE85i5V?=
 =?us-ascii?q?g4tOoXNnv4cWl9WCUmSOIUWqeaZcSTi2SCU5wicG5f2+N1sC0weJYAC8eZ6Gid?=
 =?us-ascii?q?F8vlwADkOdhWrg+Ow3aL+RO5xgMgqMMjsOsUYoH4I5TfYHfcvRpXCRari5cJRw?=
 =?us-ascii?q?zoxwMtJGJ72Y8MGYD5rRAbBZhdVMxEWDog/laGmnBHXeDpTo1O9vrsy+2GVzQp?=
 =?us-ascii?q?r0bGrPsC9UtiLQ9hF20WVvGTL+0znDRwAct+S0zyI9jSrnOCntSbwV5gVGpW7+?=
 =?us-ascii?q?+RsjVnVwXYcYDUIVEG8ieu0jE+gHdZeLVEEvC00ou4v9ySDQ9P8UhG1unusrhs?=
 =?us-ascii?q?dQMFRFOt84waIooLX7guCDW8DTRZKaMYhsc4rQHotzFDht9HtDC1zt7u9Sn+H8?=
 =?us-ascii?q?LqQ6zSoNkA9J2EDaCsIViML4tTnrJo+lVTIVNkLOL+nh9z2GDfYzDeNoywzwb4?=
 =?us-ascii?q?UiKYjyKy98lTK3Rqsu5HWQw9z7QLSNl9JRCsRiJWNPtPzrwGBtLAefMDJEx+bs?=
 =?us-ascii?q?WZCgMaEquYDEfmweOW2aL1lNNmUCzytaVUwWWJSIqQ=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A71W5maC1uBINn+XlHemx55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBKiC9Hfbo8vxG8M506faWslYssQ8b6LK90cC7KBu2n6Kdh7NxAV7IZmXbUQ?=
 =?us-ascii?q?WTQb2KlbGM/wHd?=
X-IronPort-AV: E=Sophos;i="5.87,293,1631570400"; 
   d="scan'208";a="8916845"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:30:59 +0100
Date:   Tue, 7 Dec 2021 07:30:59 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
In-Reply-To: <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2112070729520.3011@hadrien>
References: <20211207011320.100102-1-nixiaoming@huawei.com>  <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org> <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Dec 2021, Joe Perches wrote:

> On Mon, 2021-12-06 at 17:38 -0800, Andrew Morton wrote:
> > On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> >
> > > To avoid duplicated code, add a set of macro functions to initialize the
> > > sysctl table for each feature.
> > >
> > > The system initialization process is as follows:
> > >
> > > 	start_kernel () {
> > > 		...
> > > 		/* init proc and sysctl base,
> > > 		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
> > > 		 */
> > > 		proc_root_init(); /* init proc and sysctl base */
> > > 		...
> > > 		arch_call_rest_init();
> > > 	}
> > >
> > > 	arch_call_rest_init()-->rest_init()-->kernel_init()
> > > 	kernel_init() {
> > > 		...
> > > 		kernel_init_freeable(); /* do all initcalls */
> > > 		...
> > > 		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
> > > 	}
> > >
> > > 	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
> > > 	do_initcalls() {
> > > 		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
> > > 			do_initcall_level
> > > 	}
> > >
> > > The sysctl interface of each subfeature should be registered after
> > > sysctl_init_bases() and before do_sysctl_args(). It seems that the sysctl
> > > interface does not depend on initcall_levels. To prevent the sysctl
> > > interface from being initialized before the feature itself. The
> > > lowest-level late_initcall() is used as the common sysctl interface
> > > registration level.
> >
> > I'm not normally a fan of wrapping commonly-used code sequences into
> > magical macros, but this one does seem to make sense.
> >
> > I wonder if it is possible to cook up a checkpatch rule to tell people
> > to henceforth use the magic macros rather than to open-code things in
> > the old way.  Sounds hard.
>
> Almost impossible for checkpatch.
> Likely easier in coccinelle.

Is there a typical example of the open coded version?

julia
