Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3DD4A35B9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 11:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354606AbiA3KcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 05:32:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36688 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbiA3KcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 05:32:03 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF9BD1EC0249;
        Sun, 30 Jan 2022 11:31:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643538718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sms0XPOHzhyDEB3CLBC6GV1oYGHnfiOfdOCw6rR3WcQ=;
        b=EMkjyEjPNLWOpzYrft1itNiqCdlPIbvzZMy6qdJMw6RuhXjxku7KIohNwUb/H+JqOydR1d
        1GJ06MI0xgXk0ow8U13B1oXb5S5PLBn8VZciNj+XyYTYy/dG5beFe5nx5nb4Hrb2xJa8bM
        /Xm6fjP2MKuXaP3WNeZp1JxxdbHR3DU=
Date:   Sun, 30 Jan 2022 11:31:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the edac tree
Message-ID: <YfZpGHVjE+Hn+ZSv@zn.tnic>
References: <20220130103712.391407a7@canb.auug.org.au>
 <YfXW6+1hTVVTodeI@zn.tnic>
 <3b00d41c-b25a-fc5b-c1b7-b3cdbc5e5bba@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b00d41c-b25a-fc5b-c1b7-b3cdbc5e5bba@omp.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 12:30:24PM +0300, Sergey Shtylyov wrote:
>    Oops, that was me, :-/ TY! :-)

No worries, my patch massaging script catches those things now so I
should be able to catch them in review.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
