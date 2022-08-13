Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692F9591C20
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiHMRUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiHMRUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:20:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF388DFC2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 10:20:42 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25C451EC064C;
        Sat, 13 Aug 2022 19:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660411237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rFJUbH12jSbptwlGtNVGv3gua2WyWKxARb6tx5OOFhw=;
        b=dir4FhiJgml+Icpb1kS9IZrrov2qYQPKTI90LtVrPHmfYvZeNwKxTEoQqW6tlCnahQBXT3
        BjO9lEDUDTLUrsMpF8NsxRK/zfxCK4ei/1x06xe4/Yzn/hq7Mkd0K41Qd3JAlC7gZ/oU7k
        M2NpnCUoEJfO43eMfQjS2g/hvHRylvM=
Date:   Sat, 13 Aug 2022 19:20:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     Juergen Gross <jgross@suse.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev
Subject: Re: PING [PATCH 3/3] x86: decouple pat and mtrr handling
Message-ID: <YvfdYS81vU66tQSs@zn.tnic>
References: <20220715142549.25223-1-jgross@suse.com>
 <20220715142549.25223-4-jgross@suse.com>
 <YtbKf51S4lTaziKm@zn.tnic>
 <d838264a-bcd0-29e2-3b23-5427ee0ee041@netscape.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d838264a-bcd0-29e2-3b23-5427ee0ee041@netscape.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 12:56:44PM -0400, Chuck Zmudzinski wrote:
> Why has Juergen not at least responded in some way to the
> comments that Boris has made here? Why has Boris not
> pinged Juergen by now,

How about: it is summer here and people usually take their vacations
during that time and everything takes a bit longer than usual?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
