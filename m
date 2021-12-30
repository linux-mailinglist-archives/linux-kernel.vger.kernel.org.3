Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4954F481F15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhL3SNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:13:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237218AbhL3SNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:13:12 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44B371EC047E;
        Thu, 30 Dec 2021 19:13:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640887987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HWMPRh25ZbodNOXgfw96x5j8RUQdYVL2P7Y+IUXk+B4=;
        b=msub9hV4adDaT9sL/9IJ6InZn2634sRUPbLyk0JrpgQb8egmxRLanime/h2VRe6u/pvsaC
        D47F/8tTMW5MIGO7nepybE/d8M8PJWLVB70d6Q+JXtUGIfwMyK5BL03oRXVrDoCOpbB7pC
        f7G6ZKwqdOiEgdk7pbJF9cIoynNR6Vw=
Date:   Thu, 30 Dec 2021 19:13:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] x86: Add definitions for the Intel Hardware
 Feedback Interface
Message-ID: <Yc32tQF+rvuqwLYf@zn.tnic>
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
 <20211220151438.1196-3-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0if855q45KOvCkOGq3DZfx4nsH1yzr5qCEYvZCe1bzASw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0if855q45KOvCkOGq3DZfx4nsH1yzr5qCEYvZCe1bzASw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 07:03:57PM +0100, Rafael J. Wysocki wrote:

> Subject: Re: [PATCH v2 2/7] x86: Add definitions for the Intel Hardware Feedback Interface

Make that subject prefix "x86/cpu:" when committing pls.

With that:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
