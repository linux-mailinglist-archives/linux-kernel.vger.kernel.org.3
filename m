Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77659FEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiHXPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHXPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:49:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A865B5;
        Wed, 24 Aug 2022 08:49:05 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87C401EC06C1;
        Wed, 24 Aug 2022 17:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661356140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MxmGGXRqvy/kg2UXwgf3BTIi/G3tnob4EQvNp/M87dg=;
        b=edWs/RGlWPHohWezYHzoJbU9dRiEhHFyWoNdS92OSV80ZKfDJ1FxJk8Wi4RFo170tz66KE
        Q1zXpPSLDqUtB6xCpnnt0X4D8EBwM5QykrLTtOf/hyOnYaT5c/yjCw9WIgrMV1LOCLqw2m
        VUSteKrfbIdRO1piuGefKQWTQ8bmTsY=
Date:   Wed, 24 Aug 2022 17:48:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Michael Matz <matz@suse.de>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <YwZIaJIr4Zmpaams@zn.tnic>
References: <20220824152420.20547-1-bp@alien8.de>
 <YwZF8pvWHqFYQOVB@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwZF8pvWHqFYQOVB@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:38:26PM +0200, Peter Zijlstra wrote:
> You'll probably also have to add it to the
> objtool/check.c:global_noreturn[] list, for the case where objtool fails
> to recognise it as noreturn.

How come?

Doesn't objtool see the attribute?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
