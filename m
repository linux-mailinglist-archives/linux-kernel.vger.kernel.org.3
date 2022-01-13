Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837FD48D5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiAMKmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:42:53 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:60451
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbiAMKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:42:52 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 05:42:52 EST
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id 7xS7nVRjASGVw7xS9nNtM1; Thu, 13 Jan 2022 03:35:34 -0700
X-CMAE-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=61e00076
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=20KFwNOVAAAA:8 a=3a3v7Zz6WrtaihebJGEA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 13 Jan 2022 10:35:31 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     David Vernet <void@manifault.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, mcgrof@kernel.org, cl@linux.com,
        pmladek@suse.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, ghalat@redhat.com,
        allen.lkml@gmail.com
Subject: Re: [RFC PATCH v2 03/13] module: Move livepatch support to a
 separate file
Message-ID: <20220113103531.sn76g34tfkxscs4e@ava.usersys.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <20220106234319.2067842-4-atomlin@redhat.com>
 <Yd8j/Q2H0zYrAA2c@dev0025.ash9.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yd8j/Q2H0zYrAA2c@dev0025.ash9.facebook.com>
X-CMAE-Envelope: MS4xfMRZBsZt9wwkZjMH3N7eq8c6rDjO/mctLzhdDYgLDJ4J5XU2HoVtyeKJPSaWYj9Szc/gFSs8Jx2YTb4RikuCJxhzLeB/ub2EA6ez4mjRe8eK/0xiWKDw
 f1U3VjrGjnYyTbE1lYNPEEb6PIccnzNOeyR/yuhPi35xSnKzdQNARNdsCiIfpVyCE+JhkXVJtm4kK8ywoNvWPegGZlch8ABpSGrA62qy1TUg8ZqokaILZbhl
 YztiX5nbPwShbwqn5FhT1Ai0SPfdHAyVro59WlpwsvWrK1+P8EeWyC6NPBWo95IFn8+8AN7usmDRo7mTGK+0zeGKO8eJaJedj/j642OMyCrWrVuN8GoIjSQi
 BtK0Xo8Hhj30BAYKvbB+MuAamBB5vOY0ZuSORVdmm7n0Ivn3QxL0vdQk4HjtIgW1jFZ+PVacPHXBXwrXxDTAeIRxC2vVSsGOKRcq4a0DlntdJHZ/pAjakTwq
 yHZWjvNts7OFz4CSc/b/9HZhLfrrJpy4HcLGKkURJlWLfG3p+mef+KxfnPE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-12 10:54 -0800, David Vernet wrote:
> Thanks for doing this refactor. +1 to doing this, though Petr had some
> suggestions in another thread that I'll wait on before Acking.

No problem and yes, I will make the suggested modifications then add you on
Cc.

> Aaron Tomlin <atomlin@redhat.com> wrote on Thu [2022-Jan-06 23:43:09 +0000]:
> > diff --git a/kernel/module/livepatch.c b/kernel/module/livepatch.c
> > new file mode 100644
> > index 000000000000..e147f5418327
> > --- /dev/null
> > +++ b/kernel/module/livepatch.c
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * kernel/module/livepatch.c - module livepatch support
> > + *
> > + * Copyright (C) 2016 Jessica Yu <jeyu@redhat.com>
> > + */
> 
> Should the copyright year (and possibly author) be updated? Or just removed
> entirely?

Who should I specify? I'm not entirely sure. If I understand correctly,
Jessica was the original author of the majority.


Kind regards,

-- 
Aaron Tomlin
