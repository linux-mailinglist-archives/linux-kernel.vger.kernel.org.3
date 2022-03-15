Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534EE4D9803
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbiCOJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346901AbiCOJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:48:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620E4ECD6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:47:11 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E89C1EC0374;
        Tue, 15 Mar 2022 10:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647337626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nkcnMhMLGkZMB3rh6duTo8CW4F5wZyX3B2sIvZEMXyE=;
        b=BGQJK5dhi6l8N5MZsrC68XE4hhmKMWxRE6TL6q+1jfW0+zCBEYbK081S4Si4J7S2Wz/70M
        Xcvx3AifRUbKs/oCuJZTgru7gUuV3s65oGNW3PxRKYZxJEozUQwXGb6sMv6zLGF3mlKv9f
        R+2AEkMU78qDvwlJuO1sP6L9hPGkaJU=
Date:   Tue, 15 Mar 2022 10:44:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Jones <linux@theinnocuous.com>
Cc:     keescook@chromium.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YjBgE1Howd5WnQ3P@zn.tnic>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <Yi3b/GpUuhkI5lv7@zn.tnic>
 <785a6348-e1c5-7900-78bc-af8b6923cc8a@theinnocuous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <785a6348-e1c5-7900-78bc-af8b6923cc8a@theinnocuous.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 06:26:31PM +0000, James Jones wrote:
> ...
> This all probably seems absurd now, but note the newest version of these
> tools was released in 1995, when Linux ELF support would have been brand
> new. I don't know when the tools first shipped on Linux, but it would
> have been a few years before that, so a.out would have been the only
> option. It seems some Atari Jaguar developers were rather early Linux
> adopters.

Ok, that explains it fine, thanks.

Please put that explanation in a text file somewhere in
Documentation/x86/ so that we know why we're keeping a.out support.

I'll zap the removing patch from the lineup now and you can send me your
fixes whenever you're ready.

If you're wondering on how to format them and what to do, we have it all
documented in Documentation/process/. I'd especially suggest reading
Documentation/process/submitting-patches.rst

HTH.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
