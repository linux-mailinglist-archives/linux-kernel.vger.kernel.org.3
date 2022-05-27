Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E2535D93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350675AbiE0JqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiE0JqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:46:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D11C1059D7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:45:59 -0700 (PDT)
Received: from zn.tnic (p200300ea97465727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB2BB1EC064E;
        Fri, 27 May 2022 11:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653644753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kLXC36TzhA2sMUFe04sMUab93cmrVRxZXTrD/L6ZlMQ=;
        b=J/ijhcKm+MI27ul7dux0KKQo0xGMr3vd4aqJVU9AQzLtG8rFima9JO0VSQcnE3f9ZAHReY
        VbNgRx0U/B+d0R2q0SOvkhFG7dB3+FJWBzfRU61ssYlPAXeZyAwiP7r6SwZhSE6/idI26W
        3hhrCsgGfNObb7Z4DjSghjdyq1Fj7JQ=
Date:   Fri, 27 May 2022 11:45:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Taint addresses
Message-ID: <YpCdzYVXM6NTzJoA@zn.tnic>
References: <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
 <Yo3cpb1yZhwhHEga@zn.tnic>
 <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
 <Yo5LAenZIsYmM9Ie@zn.tnic>
 <c40151ec88db4b7aa7dcadf6428b019e@intel.com>
 <Yo5SupgZjT/a1p5m@zn.tnic>
 <Yo9uYL9eL9KBuzam@zn.tnic>
 <Yo+tomN1kNkvXiBk@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo+tomN1kNkvXiBk@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:41:06AM -0700, Luck, Tony wrote:
> Also: Is it more useful to store the most recent taint of each type,
> or the first of each type?

Yeah, all good suggestions and valid questions. However, I'm still not
sure about this and would like to keep it in the bag until an actual use
case appears...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
