Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D74FFD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiDMRxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiDMRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:52:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6594D37ABA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:50:35 -0700 (PDT)
Received: from zn.tnic (p2e55d808.dip0.t-ipconnect.de [46.85.216.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD8141EC058B;
        Wed, 13 Apr 2022 19:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649872229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A9tbo9wtlWsR5nO6kSBjtjKkte6hQMXr6KoMWcv4AZI=;
        b=pR4oUUWl4TlMyjkz0P+7ELCABmoB5Au8sP9bFrMX3orZ82ylII0lGRwKrW/VaS36Mnkyq3
        C0740sIDnQxq/ieV55WK0gDcuXwL5Q9kHlb3964tzG/QWNDalrPuhyOHnp1zVKMxYn58vt
        2l0sSHm0WeWoA2V8HlYlgJ/rHVW9Ah4=
Date:   Wed, 13 Apr 2022 19:50:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Add an efi.h header for the decompressor
Message-ID: <YlcNZY9bQTmSHlfx@zn.tnic>
References: <YlCKWhMJEMUgJmjF@zn.tnic>
 <CAMj1kXGvXsZmRkRk32TpueVU1FcFGcDPr-Bd2Op0taWPPEs0SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGvXsZmRkRk32TpueVU1FcFGcDPr-Bd2Op0taWPPEs0SQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 07:35:05PM +0200, Ard Biesheuvel wrote:
> No objection from me.

Thanks. We will have to copy stuff from kernel proper's EFI headers from
time to time but I think it shouldn't be all that much, and the whole
deal would start to separate the decompressor namespace nicely.

Oh well, we'll see.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
