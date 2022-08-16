Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C2595623
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiHPJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiHPJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:25:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6D6C134;
        Tue, 16 Aug 2022 00:40:43 -0700 (PDT)
Received: from zn.tnic (p200300ea971b988d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:988d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FE091EC01D4;
        Tue, 16 Aug 2022 09:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660635637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ny96WAKfmGME+j1529xm2HCsQgz3HkjChhPV3xICU6o=;
        b=MPi4jGegmp/7rvudHSup1Uh5yjPtAXGC3i0opcZsM/PJ8U4ROWTK+1fYwWxPnqzNu1J/iM
        XG2KZIRAOpUvD+cMJjODFubR/4q2FTfrQYmQsxe3EGEACLmcrQeTKeEHMyMsnd+NgiqUXb
        4hKkR1vkPlAUXOHDRALElcjoyaxNAEw=
Date:   Tue, 16 Aug 2022 09:40:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>, Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: x86/microcode] x86/microcode: Document the whole late
 loading problem
Message-ID: <YvtJ8UvhnG+ph6qu@zn.tnic>
References: <20220813223825.3164861-2-ashok.raj@intel.com>
 <166059240569.401.7221163581479146132.tip-bot2@tip-bot2>
 <YvsNJ5Nk8xkt0MKn@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvsNJ5Nk8xkt0MKn@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:21:11AM +0000, Ashok Raj wrote:
> Seems like there is an extraneous 'e' at the start of a line. Think this
> existed in my patch patch, I noticed internally due to the 0day report that
> a newline was missing.

Yeah, I saw it and then forgot about it. Fixed.

On Tue, Aug 16, 2022 at 08:51:12AM +0200, Ingo Molnar wrote:
> Small nit: this capitalization change is spurious. The 'so' is a 
> continuation of the sentence, not a separate sentence - now that paragraph 
> is actively weird & grammatically incorrect, starting with a 'So'.
> 
> Maybe:
> 
>    ... so that the build system can find those files and integrate them into

Yeah, fixed.

This change was really spurious and had nothing to do there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
