Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9274AD3FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351952AbiBHIvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351928AbiBHIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:51:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D342C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:51:32 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 034C71EC01A8;
        Tue,  8 Feb 2022 09:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644310287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WJE9d7NOSW1j3ID7IiMUtTIvjHFqpb9DDIs3faZbdZs=;
        b=pDAOBJ5ftiIsw8qc2VVfktFG9RD7UcuMtLiCAzY856xLhDwZxApTndnLxt1iM2dSaHiWVP
        V6SXUGOQrsq3zc8HmgZg3XuRvmNanBAxSecnrHKnIMGlhjpON+FM83wYugavuNXQ9iZQux
        7trOy6TrZ+f1ZrEWDB6TM07YdanVq9M=
Date:   Tue, 8 Feb 2022 09:51:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of
 X86_FEATURE_AMX_* to the word 18
Message-ID: <YgIvCIEeWK0wnq8M@zn.tnic>
References: <20220117062344.58862-1-likexu@tencent.com>
 <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
 <47362220-30d5-c513-a2aa-61187ee91c41@redhat.com>
 <bc272301-af11-621a-3bda-ee398754fd0a@gmail.com>
 <YfVM+xdDS76E3d6r@zn.tnic>
 <1105cf7d-0d61-3ae2-f372-3b1f80c08c60@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1105cf7d-0d61-3ae2-f372-3b1f80c08c60@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:08:17PM +0800, Like Xu wrote:
> Emm, are you willing to make "test-apply.sh" public (or have done) and let
> others benefit ?

It is nothing special - just a simple script which does first

patch -p1 --dry-run -l -i [patch file]

to see whether it would even apply.

> Sorry for the late reply, and here's a new version from git-send-email:

Yeah, someone already took care of this:

https://git.kernel.org/tip/ae75fa54228162ecd65341f9780886f21f557cc4

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
