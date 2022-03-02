Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3364CA48B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbiCBMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiCBMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:14:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A23968E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:14:01 -0800 (PST)
Received: from nazgul.tnic (nat0.nue.suse.com [IPv6:2001:67c:2178:4000::1111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B15C1EC0453;
        Wed,  2 Mar 2022 13:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646223236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h/juSED0BY9xQegEP1aVPjnNsSWTmusjEfk83FwsvqM=;
        b=Fs1OmRa2nBarNzvmGsMx5J0+XU7Cj2px3qzr9GEBikZ2ERAwGPc8rWnM5fx9BY+DJc+hNQ
        cQK+WxT/5qAnoLq3hfRnGwH81WkMr26DllBxUDFT41ynxvowwLbAbLsnV7Oe+tKgnTKuNC
        WpARMEJ4GWJNaiV6BhIvg6tg5eptj3A=
Date:   Wed, 2 Mar 2022 13:14:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        jeremy.fitzhardinge@citrix.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Use strtobool for noexec parsing
Message-ID: <Yh9ffhD3809qieua@nazgul.tnic>
References: <20220227201356.241452-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220227201356.241452-1-linux@treblig.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 08:13:56PM +0000, Dr. David Alan Gilbert wrote:
> Use strtobool to parse the 'noexec' parameter rather than open coding
> it.
> 'disable_nx' is changed to a bool and flipped to 'enable_nx'
> so it's meaning follows the command line option.
> 
> There's no change in behaviour for noexec=on/off.
> noexec=junk will now warn
> strtobool allows 0/1 and y/n (etc) as well as the on/off.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  arch/x86/mm/setup_nx.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

https://lkml.kernel.org/r/20220127115626.14179-6-bp@alien8.de

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
