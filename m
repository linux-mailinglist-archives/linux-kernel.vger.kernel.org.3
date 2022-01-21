Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED88A496132
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351062AbiAUOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:36:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35850 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347568AbiAUOgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:36:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF696185C;
        Fri, 21 Jan 2022 14:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1CFC340E1;
        Fri, 21 Jan 2022 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642775784;
        bh=kXpwOXT1nIvhly2udYx2qRpbQIg4fCR3FP1QYarDZuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GO3LxVF/0++4Ij2aw75wvOrdoMPMtwCkSsKEae6vS5ZvlNsasWKn1dDcbXSClt5Zg
         XMnhaT54HVwL/pMNW1vERm3KmHAezhtQ5Wy0ZFkjsu71SD8bYbC5oYb9KhlDBw60PN
         UQ4K24Ecvoc7/0UpxAWGV7xngm+HiN0W2/p54ku4=
Date:   Fri, 21 Jan 2022 15:36:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc: Add missing SPDX license identifiers
Message-ID: <YerE5fXIUJQZbhZU@kroah.com>
References: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 11:03:20AM +0000, Christophe Leroy wrote:
> Several files are missing SPDX license identifiers.
> 
> Following files are given the following SPDX identifier based on the comments in the top of the file:

Nit, please wrap your changelog text properly.

> 
> 	boot/crtsavres.S:/* SPDX-License-Identifier: GPL-2.0+ */
> 	include/asm/epapr_hcalls.h:/* SPDX-License-Identifier: GPL-2.0+ OR BSD */
> 	include/asm/fsl_hcalls.h:/* SPDX-License-Identifier: GPL-2.0+ OR BSD */
> 	include/asm/ibmebus.h:/* SPDX-License-Identifier: GPL-2.0 OR OpenIB BSD */
> 	include/asm/sfp-machine.h:/* SPDX-License-Identifier: LGPL-2.0+ */
> 	kvm/mpic.c:// SPDX-License-Identifier: GPL-2.0
> 	lib/crtsavres.S:/* SPDX-License-Identifier: GPL-2.0+ */
> 	mm/book3s64/hash_4k.c:// SPDX-License-Identifier: LGPL-2.0
> 	mm/book3s64/hash_64k.c:// SPDX-License-Identifier: LGPL-2.0
> 	mm/book3s64/hash_hugepage.c:// SPDX-License-Identifier: LGPL-2.1
> 	platforms/pseries/ibmebus.c:// SPDX-License-Identifier: GPL-2.0 OR OpenIB BSD
> 	tools/head_check.sh:# SPDX-License-Identifier: GPL-2.0+
> 	xmon/ppc.h:/* SPDX-License-Identifier: GPL-1.0+ */
> 
> Add to other files the default kernel license identifier, in extenso GPL-2.0.

That might be good for a single commit alone, don't mix it up with the
other files that you are removing stuff from.

thanks,

greg k-h
