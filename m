Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963C52C597
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiERVeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 17:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbiERVeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 17:34:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E0A2370E5;
        Wed, 18 May 2022 14:34:19 -0700 (PDT)
Received: from zn.tnic (p200300ea97465796329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5796:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D229E1EC053F;
        Wed, 18 May 2022 23:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652909653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c41NaJmVmHFZHCOhh+O6Ca1I/+Z3sEzcffT/LbNeE3M=;
        b=KxJWwcwjsFBbZOli2xs8Izbkovahw8hIfgf/y1HORYrtp7bvWPLXkD4JPPT3DkR2H31uvx
        mLvjnse6hkI0oC0Fx8vBhDzsUPG5jhTBi3eTj6BDdqQ/5IcM/diu9KOOh9dbjcwYXqZWUA
        FY+aHvKL4cTdtfTFcFkE1BlYmQCo1Pw=
Date:   Wed, 18 May 2022 23:34:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: linux-next: Tree for May 18
 (arch/x86/kernel/cpu/microcode/intel.o)
Message-ID: <YoVlwN/IeVXoMaq1@zn.tnic>
References: <20220518202934.730a8aba@canb.auug.org.au>
 <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:05:28PM -0700, Randy Dunlap wrote:
> on x86_64:
> 
> CONFIG_PROCESSOR_SELECT=y
> # CONFIG_CPU_SUP_INTEL is not set   <<<<<
> CONFIG_CPU_SUP_AMD=y
> # CONFIG_CPU_SUP_HYGON is not set
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> 
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y   <<<<<
> CONFIG_MICROCODE_AMD=y

Hmm:

$ grep -E "(PROCESSOR_SELECT|CPU_SUP|MICROCODE)" .config
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_AMD=y
# CONFIG_CPU_SUP_HYGON is not set
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y

that builds fine here on tip/master. Or is it linux-next specific? I'd
hope not.

Can you send me your whole .config pls and how exactly you reproduce it,
i.e., on which tree?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
