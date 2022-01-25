Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465F549B597
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386656AbiAYOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:02:35 -0500
Received: from protestant.ebb.org ([50.56.179.12]:57469 "EHLO
        protestant.ebb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387012AbiAYN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:59:10 -0500
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 08:59:10 EST
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by protestant.ebb.org (Postfix) with ESMTPSA id CC12F820C4;
        Tue, 25 Jan 2022 05:50:13 -0800 (PST)
Date:   Tue, 25 Jan 2022 05:47:39 -0800
From:   "Bradley M. Kuhn" <bkuhn@ebb.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc: Add missing SPDX license identifiers
Message-ID: <Ye//e3q46n57x/1l@ebb.org>
References: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
 <YerEuE6XlslE3Goo@kroah.com>
 <24829c2f-6855-c8d6-7ae4-17c5517f890d@csgroup.eu>
 <YerO8MjbXlvbMEsZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YerO8MjbXlvbMEsZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jan 21, 2022 at 03:13:50PM +0000, Christophe Leroy wrote:
> > Isn't it what GPL-2.0+ means ?

Greg Kroah-Hartman wrote:
> Yes, but look further down, as I point out below...
>
> > >> 	include/asm/epapr_hcalls.h:/* SPDX-License-Identifier: GPL-2.0+ OR BSD */
> > >> 	include/asm/fsl_hcalls.h:/* SPDX-License-Identifier: GPL-2.0+ OR BSD */
> > >> 	include/asm/ibmebus.h:/* SPDX-License-Identifier: GPL-2.0 OR OpenIB BSD */
> > >> 	include/asm/sfp-machine.h:/* SPDX-License-Identifier: LGPL-2.0+ */
> > >> 	kvm/mpic.c:// SPDX-License-Identifier: GPL-2.0
> > >> 	lib/crtsavres.S:/* SPDX-License-Identifier: GPL-2.0+ */
> > >> 	mm/book3s64/hash_4k.c:// SPDX-License-Identifier: LGPL-2.0
> > >> 	mm/book3s64/hash_64k.c:// SPDX-License-Identifier: LGPL-2.0
> > >> 	mm/book3s64/hash_hugepage.c:// SPDX-License-Identifier: LGPL-2.1
> > >> 	platforms/pseries/ibmebus.c:// SPDX-License-Identifier: GPL-2.0 OR OpenIB BSD
> > >> 	tools/head_check.sh:# SPDX-License-Identifier: GPL-2.0+
> > >> 	xmon/ppc.h:/* SPDX-License-Identifier: GPL-1.0+ */

If you're combining GPLv2-or-later works with LGPLv2.0/2.1 works, you'll have
to normalize to some GPLv2-based license (such as GPLv2-or-later), since
LGPLv2.1 requires that for combinations.  You won't be able to carry along
the "OR 3-Clause-BSD" part once the combination is made.  Similarly true with
GPLv2-or-later, but LGPL is the interesting one because it's explicit about
the need to change license notices to GPL notices when you combine.

 -- bkuhn
