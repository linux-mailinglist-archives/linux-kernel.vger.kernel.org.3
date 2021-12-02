Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543344665B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358757AbhLBOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:49:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358739AbhLBOtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:49:36 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1216E1EC0502;
        Thu,  2 Dec 2021 15:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638456369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=03L8firayfNqE0AmRNi7Je/+w89Oeq/vbQJSfiMXE6Q=;
        b=LJuPpsbQLyiqsyamWdotHKEcfSuompbKbaupEtC/mVPyhmmxgRJSPEMYHVkzsCQ6QAUNbo
        4qqjUbPV9HejNKmIq5rBk0jxcmTo5IIxMW8o5PVB40KcsMK4JgJoppW9ntrRdlpJ2Tft7Q
        IT2Yx9RgSgC2Q0ONB/EgGPtI5BhvflI=
Date:   Thu, 2 Dec 2021 15:46:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notifier: Return an error when a callback has already
 been registered
Message-ID: <YajcNeY4og9GXV+n@zn.tnic>
References: <20211202133601.23527-1-bp@alien8.de>
 <20211202141630.rdkrtrltxhzdqtyb@linutronix.de>
 <YajW6LRVJi2IEHlU@zn.tnic>
 <20211202143149.jeqf4bhhsr534pwo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202143149.jeqf4bhhsr534pwo@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:31:49PM +0100, Sebastian Andrzej Siewior wrote:
> I meant without the extra function. I'm fine either way, just curious :)

Extra is cleaner and simpler and you know we love that. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
