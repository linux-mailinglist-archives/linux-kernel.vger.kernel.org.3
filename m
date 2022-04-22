Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C944750B397
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392477AbiDVJFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384353AbiDVJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:05:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B35371B;
        Fri, 22 Apr 2022 02:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8747FB82B30;
        Fri, 22 Apr 2022 09:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58570C385A0;
        Fri, 22 Apr 2022 09:02:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O4/4TS/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650618156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8cZDn3qYd+ueoTZ9NLotfCq+DmwY/broXFpZmnDL2E=;
        b=O4/4TS/OEcJTT8bRvQ9qp3xWnkpdcxhbS21LiwWZmxEolaZoL9nqJlwGw+ufi3u2vteXge
        qHJkHE+8PrTksYZ0SM/pQ2UQR8RgNRNOjWXe7+r32aIufY9ZiQf02qGhkYKhcC5dH6fvxD
        7NY0JEWbPyL6ur6zB0l7irmoTdYDtwQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6267a74 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Apr 2022 09:02:36 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:02:33 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the random tree with the jc_docs tree
Message-ID: <YmJvKZcYMsypQRZJ@zx2c4.com>
References: <20220422135927.7fa82fa4@canb.auug.org.au>
 <YmJMBnBV8wO4aco9@sol.localdomain>
 <87wnfhzip7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnfhzip7.fsf@meer.lwn.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jonathan, Eric,

On Fri, Apr 22, 2022 at 01:21:56AM -0600, Jonathan Corbet wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > That's not exactly the correct resolution, since it dropped the change to the
> > text of this paragraph that my patch made ("HalfSipHash" => "the hsiphash
> > functions").
> >
> > We should get the updates to this file to go through one tree.  Jason, probably
> > you'd want it to be yours?
> 
> If you want changes to parts of Documentation/ to not go through the
> docs tree, just say the word and I'll avoid it.  A MAINTAINERS file
> addition to direct those patches youward would also not be misplaced.
> 
> Meanwhile, Jason, if you want to pick up the offending patches directly,
> I can drop them from docs-next.

Ah, I hadn't seen that other patch because it wasn't CC'd to me, but
that makes sense since it was mostly a docs fix rather than a
substantive technical change. Since we've now got both going on at once,
I'll just take the docs one to make the conflict easier, so sure, drop
it from your tree, and I'll apply it to mine.

Jason
