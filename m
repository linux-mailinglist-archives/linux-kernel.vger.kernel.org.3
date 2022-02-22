Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38114BF974
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiBVNcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVNcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:32:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E898559A59
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:31:48 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66BD91EC02DD;
        Tue, 22 Feb 2022 14:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645536703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dMPfgK9l14zfB5CIOp6X889RI95VuFV1MpAKSkX+WTQ=;
        b=sGoCsotq9COa7KyqPk/wz8IXuReUGDpv0vcD8fa+tcL1xCXuQrU7ebarCjVbKvLRP9DWB2
        jKU+EiJUBZYylyv3UQTHLHcFakOtqGw9c0VP+1NENHrgncWhVkqzktdvkc9cvwRHDoVuDC
        3WGY2lSpZxm3eyQObQePTO8AGUtnitk=
Date:   Tue, 22 Feb 2022 14:31:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Message-ID: <YhTlxtS6Pb4MyFwm@zn.tnic>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
 <YhP+kES/UVx7RwYz@zn.tnic>
 <20220221221049.p5zvappg4s2mjem7@black.fi.intel.com>
 <YhQUB2dIQJ/Ov3zp@zn.tnic>
 <20220221232538.3pd3w63s5v3us5xt@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221232538.3pd3w63s5v3us5xt@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:25:38AM +0300, Kirill A. Shutemov wrote:
> I'm talking about potential issue if cc_set_vendor() and cc_set_mask()
> would drift apart.

As always, we don't code for some hypothetical case. If they do drift
apart, we'll go and fix the issue like we always do. As it turns out,
the kernel is the most flexible piece in this whole fat stack of hw and
sw so I wouldn't worry about us not being able to address any potential
"drift" apart, if it happens.

> But, okay, I see that you don't feel it an issue. Will do your way.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
