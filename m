Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2953BD13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiFBRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiFBRRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CA41EE6D5;
        Thu,  2 Jun 2022 10:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A3261640;
        Thu,  2 Jun 2022 17:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D40C385A5;
        Thu,  2 Jun 2022 17:17:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TzTHRt6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654190220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ol51kojIDVTX67XNo1r9xkX1Rn7xIiFkir89GDhaQf0=;
        b=TzTHRt6wzUpoQFJjxjnGku/qMLTCYzOwofINhVujc/zx89yRYeMqS2NwOVmhOY+N6CaPzI
        dWgoSqBFajVxoTtl+fEpM4VtzJphPDCSlqLybMWoDfIkv9cDeYvwsRA4VpLCUB26B25pNi
        7TbsKg0OC1jt8KBXlYAbdgrAB1zuVP0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3434207 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 2 Jun 2022 17:16:59 +0000 (UTC)
Date:   Thu, 2 Jun 2022 19:16:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Roger Knecht <roger@norberthealth.com>,
        linux-kernel@vger.kernel.org, Ivo van Doorn <IvDoorn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        Kristian Hoegsberg <krh@redhat.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        akpm@linux-foundation.org
Subject: Re: [PATCH v5] crc-itu-t: Fix typo in CRC ITU-T polynom comment
Message-ID: <Ypjwh5f6ByoZl5YE@zx2c4.com>
References: <20220521124745.8747-1-roger@norberthealth.com>
 <a728cf17-4866-1151-0740-56b06257c917@infradead.org>
 <CAO_iFwrHcSWJm17fL-Q83DZ5i1xr+_dkEjh5Yt3Hxso0VtnzZw@mail.gmail.com>
 <47a68855-4547-49dd-d7eb-8ef83630552c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47a68855-4547-49dd-d7eb-8ef83630552c@infradead.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Jun 02, 2022 at 09:31:24AM -0700, Randy Dunlap wrote:
> 
> 
> On 6/2/22 07:24, Roger Knecht wrote:
> > On Sat, May 21, 2022 at 5:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> I don't know which maintainer will merge this since no one is Cc:ed on it.
> >> You will probably need to choose some maintainer to send the patch to.
> >>
> >> But let's add the people who merged the header file in the first place
> >> for their comments/review. (done)
> > 
> > Thanks Randy.
> > 
> > The CRC implementation seems to be unmaintained (no entry in the
> > MAINTAINER file).
> > Any idea which maintainer I can send the patch to?
> 
> Yes, the 2 people who signed off on its merger are not active AFAICT.
> 
> > The kernel doc mentions Andrew Morton as last resort (added to CC):
> >> You should always copy the appropriate subsystem maintainer(s) on any patch to
> >> code that they maintain; look through the MAINTAINERS file and the source code
> >> revision history to see who those maintainers are. The script scripts/get_maintainer.pl
> >> can be very useful at this step. If you cannot find a maintainer for the subsystem you
> >> are working on, Andrew Morton (akpm@linux-foundation.org) serves as a maintainer
> >> of last resort.
> > source: https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> Yes, Andrew can merge it.
> Or possibly Jason (also Cc-ed).

Sure, I can take this.

Jason

> 
> thanks.
> 
> -- 
> ~Randy
