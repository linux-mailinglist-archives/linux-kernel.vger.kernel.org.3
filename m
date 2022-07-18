Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50887577BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiGRGz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiGRGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:55:22 -0400
X-Greylist: delayed 324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Jul 2022 23:55:20 PDT
Received: from mx02.puc.rediris.es (outbound1sev.lav.puc.rediris.es [130.206.19.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6EE13D78;
        Sun, 17 Jul 2022 23:55:20 -0700 (PDT)
Received: from mta-out02.sim.rediris.es (mta-out02.sim.rediris.es [130.206.24.44])
        by mx02.puc.rediris.es  with ESMTP id 26I6l6DX004035-26I6l6DZ004035
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 18 Jul 2022 08:47:07 +0200
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPS id E2B90C0F386;
        Mon, 18 Jul 2022 08:47:04 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTP id 9D9D7C17E64;
        Mon, 18 Jul 2022 08:47:03 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-out02.sim.rediris.es
Received: from mta-out02.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out02.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9qTGP4eSaCwO; Mon, 18 Jul 2022 08:47:03 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPA id 625F7C0F386;
        Mon, 18 Jul 2022 08:46:57 +0200 (CEST)
Date:   Mon, 18 Jul 2022 08:46:52 +0200
From:   Gabriel Paubert <paubert@iram.es>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] random: handle archrandom in plural words
Message-ID: <YtUB3Iola9R0OwN6@lt-gp.iram.es>
References: <YtP1+MJ1tNdJA60l@zx2c4.com>
 <20220717200356.75060-1-Jason@zx2c4.com>
 <87a697dj9s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a697dj9s.fsf@mpe.ellerman.id.au>
X-FE-Policy-ID: 23:8:4:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iram.es; s=DKIM; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=Wg38rCj2x4YYjxQL6BVoKGWVRrD69jESiDVvF8U5xmg=;
 b=W+WzCvv0eeULltUer/AJgfAyg3adRlOqeJJCwsrUFP/G/1bkoAxquvG21QbEnxEpYRVTkoFuvkrF
        pFNh8TEZdk4pCeDgow0o89jeSjCXtkmJXgaFKDx1itCdOomjBrRbgIeQKUrq8tmiKY1Z5NkfmwGQ
        155G1h9LL3VMAGWQLv70SdVbh1DkWNIn1mUnMGUmaWmypGQt5UH6NJoiEwPM3hbYPxWOIVkKFHUf
        E5xXAs1ZvUL2DL1A1D19oeXmI5r8n7qPsXGAh86o8d4DDP7UwdPlWaVPIoson7YntX3H6FrX2DAa
        27+DFutwLm3R/a3QqGl8Dt0uQsGYqS+KPGbBow==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 04:31:11PM +1000, Michael Ellerman wrote:
> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> > The archrandom interface was originally designed for x86, which supplies
> > RDRAND/RDSEED for receiving random words into registers, resulting in
> > one function to generate an int and another to generate a long. However,
> > other architectures don't follow this.
> >
> > On arm64, the SMCCC TRNG interface can return between 1 and 3 words. On
> > s390, the CPACF TRNG interface can return between 1 and 32 words for the
> > same cost as for one word. On UML, the os_getrandom() interface can return
> > arbitrary amounts.
> >
> > So change the api signature to take a "words" parameter designating the
> > maximum number of words requested, and then return the number of words
> > generated.
> 
> On powerpc a word is 32-bits and a doubleword is 64-bits (at least
> according to the ISA). I think that's also true on other 64-bit
> architectures.

IIRC, this is (or was) not the case on Alpha, where word was defined as
16 bits. All assembly mnemonics had w for 16 bits, l for 32 bits, and q
for 64 bits.

Blame the PDP-11...

	Gabriel

> 
> You could avoid any confusion by defining the API in terms of "longs"
> rather than "words".
> 
> But that's just a comment, see what others think.
> 
> >  arch/powerpc/include/asm/archrandom.h |  30 ++------
> >  arch/powerpc/kvm/book3s_hv.c          |   2 +-
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> cheers
 

