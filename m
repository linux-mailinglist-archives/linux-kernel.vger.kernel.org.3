Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BA5340EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiEYQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiEYQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:01:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD56B7FC
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:01:08 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08F681EC059D;
        Wed, 25 May 2022 18:01:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653494463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HZ5l5c5oFQU562TJ+oAgCesJ7Z1kou0lEyO+acuK3iM=;
        b=OocEOzI588LRLyT/n9RapoNWuVXVIK9A7BX+4ahTwYj22NgF9QNVgODf+et/ZEHxDrkASy
        XG6Hn+NQBd4XbiTr9jMPNnZxBtvgni/HOFgSxrcm54qwTm9ReejlwKYVKeglRWCH90jlbs
        7E9uyJDFycbLzqX/BUZuK14tak3IWKU=
Date:   Wed, 25 May 2022 18:00:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Message-ID: <Yo5SupgZjT/a1p5m@zn.tnic>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
 <Yo3cpb1yZhwhHEga@zn.tnic>
 <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
 <Yo5LAenZIsYmM9Ie@zn.tnic>
 <c40151ec88db4b7aa7dcadf6428b019e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c40151ec88db4b7aa7dcadf6428b019e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 03:40:50PM +0000, Luck, Tony wrote:
> That's very 1990's thinking. We have Unicode available now.
> We could start using Emoji like U+1F4A9 as a taint character :-)

LOL: U+1F4A9 PILE OF POO. Some fancy terminals might even show it
properly.

And sounds about the right one in this case.

> That sounds better than a string of Emoji (also better than the
> current string of upper case characters).

Yeah, we need to think about it. I would be lying if I said I had never
wondered before where a taint flag got set. Saving the address has a
problem when multiple times the same flag gets set - only the last
address will be there.

But I guess we can try it.

/me puts on todo.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
