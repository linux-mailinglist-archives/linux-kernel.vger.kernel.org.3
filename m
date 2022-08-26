Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444005A276F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiHZMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiHZMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:09:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7985D12B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:09:49 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A24211EC0535;
        Fri, 26 Aug 2022 14:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661515783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Mg7DAOq3IEg8MDzRq6v6t+024bsUKXA+6v5iREKj980=;
        b=WmHuPsBAFEBLG2zPMmV60IBbSXumK5uMnMxU4vDvbjoHAWY9vHBv/Dp7+osBwtIMc6wWdn
        ekfx1sXmZ9mcJxP6JevGhokDu5W7rhCg/9QYWhzVSqAUs9UMH+ZYL5zbAEg1A4+0Iu2I+u
        +pVSA1i7M88n5EF6d2Lvgj2vNKu1VDo=
Date:   Fri, 26 Aug 2022 14:09:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 2/5] x86/microcode/intel: Allow a late-load only if a
 min rev is specified
Message-ID: <Ywi4A8j7e8Z2girH@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-3-ashok.raj@intel.com>
 <Yv9vy/GTh/QInBPM@zn.tnic>
 <YwQae9yhJyjAQ5Xy@araj-dh-work>
 <YwaBim3Xt3Il3KXm@zn.tnic>
 <Ywb0PwxU7KMMetyu@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ywb0PwxU7KMMetyu@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:02:07AM +0000, Ashok Raj wrote:
> If you feel compelled to turn the print on early boot, I could flip it and
> send it along with my other changes? Let me know if you prefer that.

I'd prefer that you actually read what I'm trying to explain to you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
