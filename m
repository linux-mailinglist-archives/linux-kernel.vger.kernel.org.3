Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709984F5EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiDFNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiDFNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:01:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A85BC1C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:26:32 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90CD81EC0426;
        Wed,  6 Apr 2022 11:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649237147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4cZSb3cc+Gu90BQrKaaggIaclA4W6uCeg9JKu/+H7fE=;
        b=OPQ0p0uQnCJZWG8yZP+JQxzuxibM2vDmCkRqvV7WvCxeAkvhBxP8DukTYbfViuL2uAcrg3
        x2geai0zDRVlcnAML5np+1n5PyMLnBRdmY5gS1NfXiuPuE3FlfUmmbYyRV6ODwWIirGymO
        tPatFAlJLZ/RWM2xExOCiuDIpyft8VU=
Date:   Wed, 6 Apr 2022 11:25:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-kernel@vger.kernel.org, Lewis.Carroll@amd.com,
        Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
        Ananth.Narayan@amd.com, bharata@amd.com, len.brown@intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        chang.seok.bae@intel.com, keescook@chromium.org, metze@samba.org,
        zhengqi.arch@bytedance.com, mark.rutland@arm.com
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Message-ID: <Yk1cnYWF+L+OgoCa@zn.tnic>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxMtx9zdk+nH33r@zn.tnic>
 <c6ceb0a5-c3fa-790e-d3c7-228c71a477c2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6ceb0a5-c3fa-790e-d3c7-228c71a477c2@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:44:52AM +0530, Wyes Karny wrote:
> If x86_FEATURE_ZEN is set and X86_FEATURE_MWAIT is not set or has
> X86_BUG_MONITOR then it won't return correct value.

Can that ever happen on Zen uarch?

Also, what does this mean: "allow MWAIT early on."?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
