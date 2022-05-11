Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39C2523CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbiEKSge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346355AbiEKSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:36:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B6B2715D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:36:27 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 062C21EC0535;
        Wed, 11 May 2022 20:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652294181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A270b9t9P5kCPcfe34jRXo9/Zav2yNHFkgsYFfjWaCk=;
        b=h17j89dq6s1q02WQMimA2WKWzxWZbCKfEfAVtNRbEytJkOdWStrRoMGKZuIbLgnN+6Prup
        VbPaFmOPO2XeDbp6K/ANGDwBm0YGH7xAw0LWWVvWsP9kkG7AR8zlH8rAa+MAHNc2LAWzeV
        sGsFWhzmxSPDzHgAetnWWFUROADFzAE=
Date:   Wed, 11 May 2022 20:36:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
Message-ID: <YnwCKP1YKVnjS3tC@zn.tnic>
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
 <202205111104.464A6619@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202205111104.464A6619@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:04:55AM -0700, Kees Cook wrote:
> Sounds legit! Can we switch the default to "none" while we're at it?

I'd say one breakage at a time. :-)

I am fearing us breaking some ancient crap with it and Andy assures me
there shouldn't be anything except some ancient "pin" binary which has
been fixed in the meantime.

I'd say we can do the "none" by default thing but do it as a separate
patch so that it can be reverted easily in case someone screams in a
justified manner.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
