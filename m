Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94250B3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445911AbiDVJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445872AbiDVJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:20:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC256426;
        Fri, 22 Apr 2022 02:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D192B82B0E;
        Fri, 22 Apr 2022 09:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16259C385A4;
        Fri, 22 Apr 2022 09:16:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Nm35tUwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650618974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxKZTmMR0fxvcFScAWIaAotfvQtArVbDqcf74lzw3NE=;
        b=Nm35tUwoqwGaX4PWGNhSbkqbvHA/Xlpceq0dE1nWgqDo7fN3XzQzHAH1QOC8tZ5w53v9B9
        2MYqo9N6xgtiPiDGPceLI+57N94NmaQ620Aj/xLZngBfI17mVAmEzma+dlWXx+swKeQxxe
        4HphdveCQ/wwWOXKZOEL2rJ2EmsYqJI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 69716d1a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Apr 2022 09:16:14 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:16:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the random tree with the jc_docs tree
Message-ID: <YmJyXEg6O5vxKYFO@zx2c4.com>
References: <20220422135927.7fa82fa4@canb.auug.org.au>
 <YmJMBnBV8wO4aco9@sol.localdomain>
 <87wnfhzip7.fsf@meer.lwn.net>
 <YmJvKZcYMsypQRZJ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmJvKZcYMsypQRZJ@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Fri, Apr 22, 2022 at 11:02:33AM +0200, Jason A. Donenfeld wrote:
> > Meanwhile, Jason, if you want to pick up the offending patches directly,
> > I can drop them from docs-next.
> 
> Ah, I hadn't seen that other patch because it wasn't CC'd to me, but
> that makes sense since it was mostly a docs fix rather than a
> substantive technical change. Since we've now got both going on at once,
> I'll just take the docs one to make the conflict easier, so sure, drop
> it from your tree, and I'll apply it to mine.

Done, with the build conflicts fixed up. These are now in my tree:

- 3608cbde2518 ("Documentation: siphash: convert danger note to warning for HalfSipHash")
- 3addb633c82f ("Documentation: siphash: enclose HalfSipHash usage example in the literal block")
- 1ed2075e7202 ("Documentation: siphash: disambiguate HalfSipHash algorithm from hsiphash functions")

Jason
