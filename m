Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DED4DC5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiCQMiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiCQMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:38:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF81EB80C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:36:53 -0700 (PDT)
Received: from [127.0.0.1] (pd95ca587.dip0.t-ipconnect.de [217.92.165.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C7361EC0445;
        Thu, 17 Mar 2022 13:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647520608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6Zxd2VYhQrI2aAFFNauLBhUPTPx9U8Drl5PLJFD5jc=;
        b=NJb/1gN2vzDGI+WgyySEAxQ4JxFrMhA7quxKcM/UKSX3CL4OttsIotwEpI8v5qiff37qno
        C/tfsPdGqzDuKP325S0JHieRB+e5NOPv1Bk4KHkpGZHmI5Zq9sscSE0eh6OElpadkNh2Bc
        ILd4YW5DIcEPezlIgVyeO3FdqgtwYJ0=
Date:   Thu, 17 Mar 2022 12:36:46 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Beru Shinsetsu <windowz414@gnuweeb.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_boot_install=3A_Partially_ref?= =?US-ASCII?Q?actor_the_logic_for_detecting_bootloader?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220316173221.5937-1-windowz414@gnuweeb.org>
References: <20220316173221.5937-1-windowz414@gnuweeb.org>
Message-ID: <2E28CA0C-34F2-4985-86CC-B1823AF8D747@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 16, 2022 5:32:21 PM UTC, Beru Shinsetsu <windowz414@gnuweeb=2Eorg>=
 wrote:
>While running `make install` after building the kernel and installing
>modules on several distros like EndeavourOS, there would be a pretty
>little output (To be exact, "Cannot find LILO") due to lack of LILO
>bootloader, which is really uncommon for a user to have it while
>GRUB is there=2E=20

As a matter of fact I saw this yesterday on one of the test boxes here and=
 was wondering why I am even seeing this=2E So before we do anything, it'd =
be prudent to know what has changed recently to cause this error message to=
 happen=2E Because we would have to backport a fix to some kernels probably=
=2E

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
