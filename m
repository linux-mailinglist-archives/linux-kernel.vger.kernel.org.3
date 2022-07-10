Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4F56CF05
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiGJM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGJM1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:27:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D43E0F2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:27:23 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff643329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f643:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 547E11EC01D4;
        Sun, 10 Jul 2022 14:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657456038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J4RWO6tkR4gZwdaGb8kJFZOpsJ0WNMT+Yzp1DE8/sJw=;
        b=KK7+CkNHFu2fA7h+rRT2zHVv0e7iqdmiLViQBgyLzzrKBBeoeTaozayFHMnfhI5AQo5t6b
        iHg7y/tZ9dkjKn6D5p2674UOVZ8/GpJIZ88IpHxvCpyiuu+F9Z+3ngwsezRORA3djfh6al
        CtzPyc0H43dwI5I4elxDxpJZQ/51Xa4=
Date:   Sun, 10 Jul 2022 14:27:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Message-ID: <YsrFoaQzoO7NlgPN@zn.tnic>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
 <YslPKbrmwF0uSm7p@zn.tnic>
 <191d8f96-7573-bd0e-9ca4-3fc22c5c9a49@zytor.com>
 <Ysn5uvBKBpcZ4j6m@zn.tnic>
 <8e5eb2db-ce31-3dc8-8f75-3959036686f8@zytor.com>
 <YsqfuPeB5jhFU9g5@zn.tnic>
 <CAHmME9rBRvU1z5Je1B2ahiTWuBaeJ9mHmohMAxLeoPMubT1+zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rBRvU1z5Je1B2ahiTWuBaeJ9mHmohMAxLeoPMubT1+zw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 01:11:16PM +0200, Jason A. Donenfeld wrote:
> Do you want me to rebase mine on top of the 5.19 fixup? Or is that
> trivial enough that you'll just do it when applying?

Yeah, I'll take care of it, no worries.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
