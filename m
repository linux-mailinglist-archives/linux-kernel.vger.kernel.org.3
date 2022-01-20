Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4B494F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiATNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:32:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbiATNcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:32:43 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 772C11EC0495;
        Thu, 20 Jan 2022 14:32:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642685562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=28wI6iedsNvzH0vXzCzIubkiRJPe6oBSNXexv601jfA=;
        b=bR9MG4UEhv5B+m20bHlrVDgjDm9PHntMieBMJoipMJhkHBOvvbCO01uwDoR2ZWYTKCYWlM
        Wow0cEUPaIQ2HO1XURYKxLvTohalSkhHAcrLrsKwIje1jH9uplE8LRV3VF4RKMppJsYnWr
        WaNAj/jV7TkU1kbAV0JUBijJ+f3bBMw=
Date:   Thu, 20 Jan 2022 14:32:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH 2/5] x86/ras: X86_FEATURE_INTEL_PPIN finally has a CPUID
 bit
Message-ID: <Yelkc2Lcul0hAV5A@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220107225442.1690165-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220107225442.1690165-3-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:54:39PM -0800, Tony Luck wrote:
> After nine generations of adding to model specific list of CPUS that

CPUs

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
