Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D0147C2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhLUPWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:22:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36524 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbhLUPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:22:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F5DD1F388;
        Tue, 21 Dec 2021 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640100133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z59VsQxPK7tcYGrkiUV7duMrk49fkRi2ISpPTXEYeVw=;
        b=kRHcuyPJG/g1WfdTCvJIc3r+XpE+Qmg+GMpFMQFebNt/s4nIc2+Yc3cnqkD6IdRvgIvrrU
        iiHPGfjbjzZvzMO6XE/SNro+KTKugA4MiYFWK9kztv+9f2b4BUYbMprXN0PDvRV2Ac4IJo
        4bU2ZCNjWT7xFIq0fqIJE8ENidBIYMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640100133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z59VsQxPK7tcYGrkiUV7duMrk49fkRi2ISpPTXEYeVw=;
        b=ddLjwFfbNdKuBPnlRt96fTBTphXHFMP5fn2SoN3I+ANCSmxD/X+5XmLoOt8OlwDnDXVw+/
        a7AQTg9lMxmjTzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10F9613C98;
        Tue, 21 Dec 2021 15:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TmKbAyXxwWGAZAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 21 Dec 2021 15:22:13 +0000
Date:   Tue, 21 Dec 2021 16:22:19 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Marco Elver <elver@google.com>
Cc:     Carel Si <beibei.si@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Message-ID: <YcHxKzB3WPurKlZ9@zn.tnic>
References: <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic>
 <20211221143153.GA4676@linux.intel.com>
 <CANpmjNO4hs1B9eDY9edGGOXY45a8smdtYfYfbDRnGWSYch4wGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNO4hs1B9eDY9edGGOXY45a8smdtYfYfbDRnGWSYch4wGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 04:10:31PM +0100, Marco Elver wrote:
> Also double-check the Makefile-based solution: the Makefiles in both
> directories already contain various KCOV_INSTRUMENT/K*SAN_SANITIZE :=
> n, so perhaps adding GCOV_PROFILE or GCOV_PROFILE_whicheverfile.o := n
> may be more appropriate should the functions that should not be
> instrumented be a moving target, and prone to breakage again in
> future.

Yeah, I asked whether we should exclude the whole ...cpu/common.c from
profiling - it has mostly init code so it probably doesn't matter
for coverage but no one said anything so I left it to the function
annotation.

And also, I'm still waiting on clang folks to chime in on the New Pass
Manager and whether there's a bug in clang there so that we won't need
the __no_profile annotation at all. I mean, gcc is fine with that config
so unless clang is doing more profiling gunk than gcc and requires that
__llvm_gcov_init constructor... see Nathan's mail upthread.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
