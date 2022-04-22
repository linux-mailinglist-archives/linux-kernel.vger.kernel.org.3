Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D814F50BC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449639AbiDVPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449611AbiDVPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:52:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CFE7C;
        Fri, 22 Apr 2022 08:49:57 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A6B3337B;
        Fri, 22 Apr 2022 15:49:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A6B3337B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650642597; bh=kmBmM6ImSSkBoCPI9+MAJ+IgzekeSpjXPOqoI+wvquQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=edIVtJByWOf+ZHuBIi7vV5QUDSPFJTrSjWNlfdIaIlDHF4e3dzKj/fBSAM4ncDT7Y
         aPdd95GvEY01bf97q/p6mYyiHigIgR6gbmpLZdCeXvlmcIcuP0jrn/zlf0zA2B9tj3
         UVHDQlg4UBrP/G2VyoOBFIycY0dg+8ZkECGm8xmCU653+XgbG4/s6nUXdSA8DOXaAK
         zx3z62SIjeALPyBuV0lNTWXaQxs8Fpv4fgdD4e52xxIE5ItBXSBWWdZni5PlWs0fj5
         aBZmDtT/Z4NJbmZR668xD1fSp7revTuSwWc6rutcbe1qOPT0WuD7UkJJAtl8iCZxaH
         qhDp6xHOKQKWg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the random tree with the jc_docs tree
In-Reply-To: <YmJvKZcYMsypQRZJ@zx2c4.com>
References: <20220422135927.7fa82fa4@canb.auug.org.au>
 <YmJMBnBV8wO4aco9@sol.localdomain> <87wnfhzip7.fsf@meer.lwn.net>
 <YmJvKZcYMsypQRZJ@zx2c4.com>
Date:   Fri, 22 Apr 2022 09:49:53 -0600
Message-ID: <87levxyv6m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Ah, I hadn't seen that other patch because it wasn't CC'd to me, but
> that makes sense since it was mostly a docs fix rather than a
> substantive technical change.

If you do want to see such things, I recommend a line in MAINTAINERS to
make it happen.

> Since we've now got both going on at once,
> I'll just take the docs one to make the conflict easier, so sure, drop
> it from your tree, and I'll apply it to mine.

OK, I've disappeared the offending commits and force-pushed docs-next.

Thanks,

jon
