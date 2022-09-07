Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78785AFE34
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIGH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIGH47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:56:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7188F977
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:56:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2C7620114;
        Wed,  7 Sep 2022 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662537416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GpUp6OvQ8i7Mr4bNR7ArwU7puV1iks8tSDio6W89hzQ=;
        b=z+DrRMxS2yUAdV29d2dJyk+TRFJjQkOGmIySRKN8Xrb9Bnc5Ulo/wMkE88vhmug3dlj9dz
        /yprAILyLOa1eIPZ5w5oD/SIdTKH84n6pDwnjvY9+WjgJ3Sz/TdnNX1NVsAwXriPBMDBhc
        /hcFBlZnhsDMmgRMnX/60jWji971IUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662537416;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GpUp6OvQ8i7Mr4bNR7ArwU7puV1iks8tSDio6W89hzQ=;
        b=WpubPanU4Wqy7dLBVQp1HpmhkdroiWwLSVDMZzonPwgg7/aO5CIYBvmHHDeTKMF9f6NfJp
        Zng1TZAhyyvxs+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7F5213A66;
        Wed,  7 Sep 2022 07:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8sUGKshOGGMFCAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 07 Sep 2022 07:56:56 +0000
Date:   Wed, 7 Sep 2022 09:56:54 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [GIT PULL] dmi update for v5.19
Message-ID: <20220907095654.4b1ea5b0@endymion.delvare>
In-Reply-To: <CAHk-=wiFRok=hU_BNEsqodjyGm=XV9LVZ1w=cm4ooEtWVpYLPg@mail.gmail.com>
References: <20220822141930.5f43b5e7@endymion.delvare>
        <CAHk-=wiFRok=hU_BNEsqodjyGm=XV9LVZ1w=cm4ooEtWVpYLPg@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 24 Aug 2022 10:31:35 -0700, Linus Torvalds wrote:
> On Mon, Aug 22, 2022 at 5:19 AM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > Andy Shevchenko (1):
> >       firmware: dmi: Use the proper accessor for the version field  
> 
> I pulled this, but I kind of question it.
> 
> This replaces a single 32-bit memory access (and an optimized byte
> swap) and a mask operation with three load-byte-and-shift operations.
> 
> It's not clear that the new code is better.

For reference, I had the same objection originally, but Andy convinced
me that code clarity was more important than a minor one-time
optimization. The whole discussion can be read here:

https://lore.kernel.org/all/YuVUdOUl7zwE0QsV@smile.fi.intel.com/T/#mf41d04beeb1d4fddadf77248eec8be397f77cdb5

> That said, I can't imagine it matters - but because I looked at it, I
> note that the length check seems to be kind of iffy.
> 
> The code checks that the length of the block is < 32 before doing the
> checksum on it, but shouldn't it also check for some minimum size?
> Otherwise the dmi checksum is kind of pointless, isn't it?
> 
> It will access a minimum of 24 bytes for that dmi_base thing, so that
> would be the most obvious minimum value. But maybe there is some
> spec-defined size for that that only covers the header?

Thanks for taking the time to look into this. You have a point.

It doesn't utterly matter in practice because it's hard to imagine that
the checksum would be correct if the size is not. The check for
size < 32 is to avoid a walking past the end of the buffer if the entry
point is incorrect or corrupted. Every other case of incorrectness or
corruption is assumed to be caught by the checksum itself.

I suppose that the lack of a check for a minimum size comes from the
fact that the legacy DMI entry point did not even have a size field. As
a matter of fact, dmidecode does not have a minimum entry point size
check either.

I can add a minimum entry size check if you want. Some extra robustness
can't hurt.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
