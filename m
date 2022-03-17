Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FA4DC3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiCQKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiCQKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:18:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1971DDFD9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:17:29 -0700 (PDT)
Received: from zn.tnic (p200300ea971561b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 622B91EC05B0;
        Thu, 17 Mar 2022 11:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647512244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/6h+4CTlKfIpc7jRUmZz8FIxIfmUZfkd19wtpU9eCO0=;
        b=YjWnbOD7Qy30aVbNmIYvKRJ1r/qzsgPgWb0bpBr3Yw+50my7Q2ohYNGDuCX8IkiVi/w20/
        4zACbBHtuDEaEO/wSUih0SsDvtHr3PQfYNnuaan+EicisI6w5rdRiy44voWuoxFRIHUE8R
        Z5oZYusOi3EFjb4mtozJHUn9Ans+DoI=
Date:   Thu, 17 Mar 2022 11:17:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Jones <linux@theinnocuous.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YjMKsM6LzEmpGTzN@zn.tnic>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
 <202203161523.857B469@keescook>
 <59fb3d14-423a-d39b-04cb-1e60ee67d3f1@theinnocuous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59fb3d14-423a-d39b-04cb-1e60ee67d3f1@theinnocuous.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:04:46AM +0000, James Jones wrote:
> Yes, works perfectly, thank you. I like the idea of using this much
> better than getting emailed every time someone wants to delete the a.out
> code again. Consider my use case withdrawn. I've already pushed an
> update to my jaguar-sdk project to use this tool instead.

Ok, pls do test this solution extensively and let us know if there are
other problems. I'll schedule a.out removal then for the next kernel so
you have a month or two time to experiment.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
