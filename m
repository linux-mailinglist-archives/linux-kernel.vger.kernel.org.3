Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F50490398
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiAQITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiAQITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:19:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A5C061574;
        Mon, 17 Jan 2022 00:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B8961017;
        Mon, 17 Jan 2022 08:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE81C36AE7;
        Mon, 17 Jan 2022 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642407541;
        bh=ETISPVgo24AGeOAgB8tUjhJrTBKIAvd8h8N9Nd/B6qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCfqFO/kV9D6sYEiRkXw/hJbRTyhPndm+2Z9Yd6XoMu3XemG4oMnDxRA0+jq9ezwa
         pw5AfYgnsaMpTLiVi5yE2gWxFvLcLWPZ/yLohxgI7G7VfD4xhVoGjF+/b0QPICQiiq
         yqmgC5ku/Pro59ZZgiexHau/GBi1VVY7JwBG5sgU=
Date:   Mon, 17 Jan 2022 09:18:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <gleixner@linutronix.de>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc: Add missing SPDX license identifiers
Message-ID: <YeUmcnyx499r6oYq@kroah.com>
References: <f46026c3157dd856847ee8cb7ccac08453f58174.1642401402.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f46026c3157dd856847ee8cb7ccac08453f58174.1642401402.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 06:41:45AM +0000, Christophe Leroy wrote:
> Several files are missing SPDX license identifiers.
> 
> Following files are given the following SPDX identifier based on the comments in the top of the file:
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

Please also remove the old license text at the same time so that we can
verify that you got the licenses correct.  As-is, we can not do that
easily with this patch so it's not ok.

thanks,

greg k-h
