Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3885595FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiFXJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiFXJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:03:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E3B457BB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:03:54 -0700 (PDT)
Received: from zn.tnic (p200300ea97465750329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5750:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 805E51EC067D;
        Fri, 24 Jun 2022 11:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656061429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujNEl865h+t1Hm0WUWdzJgGciSyTPiwv6jdUXq5CLcE=;
        b=cSU9oPssKyzOCoNiJCoyyDrkhCgSsmypVu+/DyHpr6mDj1qQvo6xF3UGvpRvrpxrOk4Mjl
        imiRkY8gmfQWtVZ3i7yc11Zvwt6PGyJ2B7wN8XhNri+ScEmEFPDwEIMc1TEs9s61JOksei
        mvy37zVj0BX3fS8viMDJom1l+2KE3dk=
Date:   Fri, 24 Jun 2022 11:03:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>
Cc:     "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <YrV98fRJuN3ifQ1j@zn.tnic>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:44:52AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> I found crash kexec fails to boot the 2nd kernel since v5.19-rc1 and

What system is this? Full dmesg and .config pls.

How exactly are you launching the kexec kernel, etc, etc?

IOW, how can one reproduce this?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
