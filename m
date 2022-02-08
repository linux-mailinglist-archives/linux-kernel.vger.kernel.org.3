Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35D4AE41D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387778AbiBHW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386270AbiBHT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:57:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A72C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:57:05 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C8B31EC04AD;
        Tue,  8 Feb 2022 20:56:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644350218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z4g372sF4SgwftB4VSg+I9CoA90UzTFKC7ERx8vpRgU=;
        b=OotyMg+XP8/iYuL9+6C1y1PDccLiSI1HYgm1tTYJrAzVymG5NgdK59kKwHi8xlP0ajlqUp
        K/5+c8KMyx532vnZWvkWS6rW/2v2Z30RmMM6d3uATSihklzzW2toF6IFx914YnvYgqJnIF
        LWf4VujIFxfY2WGicAYhRvCdkO4AFxk=
Date:   Tue, 8 Feb 2022 20:56:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 5/6] x86/cpu: Remove "noexec"
Message-ID: <YgLLBAieD625MK6A@zn.tnic>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-6-bp@alien8.de>
 <202202071419.E21C67553@keescook>
 <YgKrCZkiU3X2OV6b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgKrCZkiU3X2OV6b@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:40:25PM +0000, Sean Christopherson wrote:
> Heh, I've actually used noexec relatively recently to triage KVM goofs.  That
> said, the same net result can still be achieved via clearcpuid=52, so I've no
> objection to removing the dedicated parameter.

Even better: clearcpuid=nx works now too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
