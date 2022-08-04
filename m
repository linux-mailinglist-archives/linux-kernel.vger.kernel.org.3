Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8075899EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbiHDJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiHDJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:29:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4901E6715B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:29:32 -0700 (PDT)
Received: from zn.tnic (p200300ea970f4fa7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:4fa7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C80BB1EC0629;
        Thu,  4 Aug 2022 11:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659605366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I/Uy9+UH+hyHqkgD7Pc+RVO6YABs5/zAXDgvZMzohrw=;
        b=HewL1F2bKHIriv60rm8zcsmvl1aYZR0VXURKDhy466+eHlJwGWN5liiGZVhWTXN9XW2XgS
        sHCercMqyB4q3peTT91da6sSno2V6/RXaS65jH66fUBoyCAQNLS03G3IayfpmgWTBe00VJ
        sGiMZmI5rQRK4IgKJ7FXh9KsmU13KCY=
Date:   Thu, 4 Aug 2022 11:29:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Link: tag and links to submission and reports (was: Re: [GIT
 pull] core/urgent for v5.18-rc6)
Message-ID: <YuuRcit5hgzW1Pga@zn.tnic>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
 <Ynt1z0eZ19eMqp8I@zn.tnic>
 <YnvbLx9FKgQwZJ/F@mit.edu>
 <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
 <YnwP7QmPzyv5FhrZ@zn.tnic>
 <3cf09576-66f2-b18c-0057-2635fc9452de@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cf09576-66f2-b18c-0057-2635fc9452de@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:43:07AM +0200, Thorsten Leemhuis wrote:
> Which leads to the question: can we (and do we want to) teach
> scripts/checkpatch.pl to point out when a Link: tag is missing and
> likely appropriate? If a "Reported-by:" is present there should be a
> "Link:" as well, unless the issue was reported privately, via IRC or
> something like that. A "Fixes:" tag is also a strong indicator that a
> link might be appropriate, but not as good.

All good ideas, sure.

At least pointing it out as a hint - not necessarily as a warning -
would be a good idea. And say, "hey, and while you're adding a Link
tag, pls make sure it points to the mail which has the most relevant
discussion on the matter your patch is fixing."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
