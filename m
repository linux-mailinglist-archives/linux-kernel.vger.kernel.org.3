Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4561255DFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbiF1JUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbiF1JUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:20:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACC1CFD0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:20:13 -0700 (PDT)
Received: from zn.tnic (p2e55da55.dip0.t-ipconnect.de [46.85.218.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FC6D1EC0523;
        Tue, 28 Jun 2022 11:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656408008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P4I0TjKHjqOdYAYDzfzcgpCy0FJmUruFpcABPJLWdPI=;
        b=bKGNkZwLNtK8M8MJ96eVFTIilWJOxYvR7nriIHsKA83D4g0wWxIIRgCpkFM/XLJrKtUipg
        p54vyaYkjjVqUJ8MTQ82seMFM25J6PuA7R+8OqI4KDJJqtcYJX/cyDrZAkn8HFX2PhWzIJ
        gcwzIdn6GETgH4b8SUNQv9+jRiab5JE=
Date:   Tue, 28 Jun 2022 11:20:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Messier <alex@me.ssier.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Andrew.Cooper3@citrix.com, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] Unable to unlock encrypted disk starting with
 kernel 5.19-rc1+
Message-ID: <YrrHwxtD2dpts7PF@zn.tnic>
References: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 01:13:30AM -0400, Alexandre Messier wrote:
> Please let me know if more information is needed, or if some tests are needed
> to be run.

Yeah, pls send /proc/cpuinfo and full dmesg - privately is fine too.

Also, it would be lovely if I were able to reproduce this on a machine
here but mine doesn't have a crypto rootfs.

Perhaps you can point me to the exact instructions you're running to
decrypt your rootfs and I can try to create a usb crypto disk and try to
reproduce it with them...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
