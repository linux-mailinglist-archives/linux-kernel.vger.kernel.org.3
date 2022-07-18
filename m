Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC918578BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiGRUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiGRUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:44:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377517669;
        Mon, 18 Jul 2022 13:44:21 -0700 (PDT)
Received: from zn.tnic (p200300ea972976d7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76d7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C50431EC0101;
        Mon, 18 Jul 2022 22:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658177055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZP2vkej0wYXy+Nm97C9iE2vLBuD5ySSEp+w+nPmn4f4=;
        b=C05L3+9Kk7XLS86ABrP1NMuUZ7ZFWzdpiYVvcVXK+yiZ3giOpBoDnT6vJc3PxopCF60Wwe
        lcYyPhiTfhFpCLNNXN4c5cu8/6tTaJbkAVAKkeva3RcPmz0J4ZBY2p+fVK0hdRhF8YhMWy
        fnaAlUb8Xw+w03/Gxu7Jyvfv5VFrV/I=
Date:   Mon, 18 Jul 2022 22:44:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/sgx: Set active memcg prior to shmem
 allocation
Message-ID: <YtXGFWOJ4Z3BURa3@zn.tnic>
References: <20220520174248.4918-1-kristen@linux.intel.com>
 <165419442842.4207.2566961916839377924.tip-bot2@tip-bot2>
 <YtUs3MKLzFg+rqEV@zn.tnic>
 <b1476c7d-c514-227f-2735-092b5afb7d3a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1476c7d-c514-227f-2735-092b5afb7d3a@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 11:52:54AM -0700, Dave Hansen wrote:
> As a further cleanup, it would probably be nice to explicitly document
> that "lookup" and "alloc" also require a subsequent "put". 

Certainly. That is not really clear from the sparse comments over it.

> It would also be nice to change sgx_encl_get_backing() to
> __sgx_encl_get_backing() to make it clear that it's an internal thing.
>
> So, I think the _code_ is OK as-is, but it could use some more love.

That makes a lot more sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
