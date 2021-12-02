Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E6F466756
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355540AbhLBQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:00:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355283AbhLBQAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:00:12 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 760191EC0136;
        Thu,  2 Dec 2021 16:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638460604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NbpZQfmvDZ+EDAo0C4jao84LNxSxMOr4OJNT2eDaPMA=;
        b=GdtBBwPQ7cApqtWvTHKJ+3QMEjHjPuL7N4gZ0z6nbUTmP922o/Zwlo2fmUbQmbr638PIye
        1j7GGfnxJIZLzZlkF5SAzvXB9OjzOnkEo88f+YOrnz/I+H5rmNYlopXd0ejrIz/Quk4evN
        dRQEh+N7A8pdBMjW4FhZdC9sJhKQtH4=
Date:   Thu, 2 Dec 2021 16:56:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notifier: Return an error when a callback has already
 been registered
Message-ID: <YajsxJpcM/f7cZjF@zn.tnic>
References: <20211202133601.23527-1-bp@alien8.de>
 <YajpQ/dA7h3QnkCR@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YajpQ/dA7h3QnkCR@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:41:55AM -0500, Alan Stern wrote:
> A patch that adds three new lines of code has got to be simpler than and 
> preferable to a patch that adds about eleven lines (including a whole new 
> function), right?

Well, I like keeping things separate and prefer to keep the error
handling and warning in another function. But Sebastian asked the same
thing already so if people prefer that, I'll change it. I don't feel too
strongly about it, tbh.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
