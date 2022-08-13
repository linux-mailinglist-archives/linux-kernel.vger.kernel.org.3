Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C4591CD5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 23:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiHMVs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 17:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiHMVsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:48:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822EF2AC5E
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:48:30 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 032B81EC067E;
        Sat, 13 Aug 2022 23:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660427304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fz37332wiyn8xQubKBZViow+AZzqnLB/tSNjoT3q33w=;
        b=I7+hyv2sQPb93AEybpUHKY08eB77sAwaoHenTwceUENNJJMIyIC/Ox7n7SlyTOp9A5mt1H
        /S3M4Z18PCt0cBj/MqT9dgXm8E1pi03QhHfZqm2bp3/twcuf/oi4tnp8NvCNJGOeZQB9ju
        YV/XDWfjLIBP2016iz4+2X0TlBxXOis=
Date:   Sat, 13 Aug 2022 23:48:18 +0200
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
Message-ID: <YvgcIu/Y1GMD5WNo@zn.tnic>
References: <20220715142549.25223-1-jgross@suse.com>
 <20220715142549.25223-4-jgross@suse.com>
 <YtbKf51S4lTaziKm@zn.tnic>
 <d838264a-bcd0-29e2-3b23-5427ee0ee041@netscape.net>
 <YvfdYS81vU66tQSs@zn.tnic>
 <3de36953-9b8a-d040-c8dd-44af1ae2d56d@netscape.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3de36953-9b8a-d040-c8dd-44af1ae2d56d@netscape.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 05:40:34PM -0400, Chuck Zmudzinski wrote:
> I did a search for Juergen Gross on lkml and he is active submitting and
> reviewing patches during the past few weeks. However, he is ignoring
> comments on his patch to fix this regression.

Please stop this non-sense and be patient. We will fix this soon. For
the time being you can use Jan's patch locally.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
