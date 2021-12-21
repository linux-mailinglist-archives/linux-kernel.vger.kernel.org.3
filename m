Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD55A47C349
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhLUPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:45:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37738 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhLUPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:45:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C36D1F3A5;
        Tue, 21 Dec 2021 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640101502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiktIFHSUQ6e0zGuhbR7ig72QI0RwFUNvOYZUCFaXcQ=;
        b=zNKVNm17tSQKtl8MW38wQ+xIy+c5OOeaDm71N36XmS3gpNGuLhruzomshrqK0shpx0yR0x
        pYMXkn22qwSVJDLTK0rHFCaoaI9naI/rnC86OIpWwQ6T6G5rwqEy2whGORG7lyGxNI2m4u
        WSU472wDi08w+4vg+a5PY0WHl945G7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640101502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiktIFHSUQ6e0zGuhbR7ig72QI0RwFUNvOYZUCFaXcQ=;
        b=KZRkhWDVe63YxIW1Sd03kdMs4U5FZ/zWv6t7chm+mDBxWTKyjrjGhOEphmNcxRySH3iYMl
        ht7jusDcuLRGuOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F75213CB7;
        Tue, 21 Dec 2021 15:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EhaOGX72wWFPbgAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 21 Dec 2021 15:45:02 +0000
Date:   Tue, 21 Dec 2021 16:45:09 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>, linux-pm@vger.kernel.org,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 02/14] x86/msr: add AMD CPPC MSR definitions
Message-ID: <YcH2hYJN9+NudhH4@zn.tnic>
References: <20211219163528.1023186-1-ray.huang@amd.com>
 <20211219163528.1023186-3-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211219163528.1023186-3-ray.huang@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:35:16AM +0800, Huang Rui wrote:

Capitalize subject's first letter:
 [x86/msr: add AMD CPPC MSR definitions]
 [x86/msr: Add AMD CPPC MSR definitions]

> AMD CPPC (Collaborative Processor Performance Control) function uses MSR
> registers to manage the performance hints. So add the MSR register macro
> here.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 01e2650b9585..e7945ef6a8df 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -486,6 +486,23 @@
>  
>  #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>  
> +/* AMD Collaborative Processor Performance Control MSRs */
> +#define MSR_AMD_CPPC_CAP1		0xc00102b0
> +#define MSR_AMD_CPPC_ENABLE		0xc00102b1
> +#define MSR_AMD_CPPC_CAP2		0xc00102b2
> +#define MSR_AMD_CPPC_REQ		0xc00102b3
> +#define MSR_AMD_CPPC_STATUS		0xc00102b4
> +
> +#define CAP1_LOWEST_PERF(x)	(((x) >> 0) & 0xff)
> +#define CAP1_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> +#define CAP1_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
> +#define CAP1_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
> +
> +#define REQ_MAX_PERF(x)		(((x) & 0xff) << 0)
> +#define REQ_MIN_PERF(x)		(((x) & 0xff) << 8)
> +#define REQ_DES_PERF(x)		(((x) & 0xff) << 16)
> +#define REQ_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)

All those bitfield names are too generic - they should at least be
prefixed with "CPPC_"

If an Intel CPPC set of MSRs appears too, then the prefix should be
"AMD_CPPC_" and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
