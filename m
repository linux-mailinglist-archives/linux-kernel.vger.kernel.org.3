Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0848F68D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiAOLhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiAOLhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:37:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F01C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 03:37:44 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46B271EC0453;
        Sat, 15 Jan 2022 12:37:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642246658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lGTVstls7sMGNEIijAszX9pWArNBwTx4+HtSjL6CMPo=;
        b=NAW4JY2emteATbwsm9SfFeOUL2SLidNmsCxf5IID8gQ8ODXW2ygaAF+aqezZRxHxS8h5eB
        jGk0AhQ4uipUmvzhjrnCQleN9CwMf8WzdqticJHQY6vQO/VhsBugmpM1UVI2OiwiqXAATH
        HFNSIc4BcRxjIntbtx24QUO8k75FQ9g=
Date:   Sat, 15 Jan 2022 12:37:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Michael Cree <mcree@orcon.net.nz>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YeKyBP5rac8sVvWw@zn.tnic>
References: <20220113160115.5375-1-bp@alien8.de>
 <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
 <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic>
 <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeHQmbMYyy92AbBp@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 08:35:53PM +0100, Borislav Petkov wrote:
> On Fri, Jan 14, 2022 at 08:21:36PM +0100, Geert Uytterhoeven wrote:
> > I mean that I can rip it out on m68k.
> > 
> > Who's gonna take care of alpha?
> 
> I'm sceptical anyone would:
> 
> $ ./scripts/get_maintainer.pl -f arch/alpha/
> Richard Henderson <rth@twiddle.net> (odd fixer:ALPHA PORT)
> Ivan Kokshaysky <ink@jurassic.park.msu.ru> (odd fixer:ALPHA PORT)
> 
> which leaves me. I could give it a try.

Well, on that old thread from 2019 people expressed the wish to be able
to run a.out binaries on Alpha. Let's see whether that has changed in
the meantime.

/me CCs them.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
