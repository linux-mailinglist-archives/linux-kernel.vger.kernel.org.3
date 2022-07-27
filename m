Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792E4581CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbiG0ACQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG0ACK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C9205D6;
        Tue, 26 Jul 2022 17:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341A26171D;
        Wed, 27 Jul 2022 00:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6213AC433C1;
        Wed, 27 Jul 2022 00:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658880128;
        bh=hVS0UzV9td77mCUTc5XRrrAMTubY3281sDj0b9Bw3fg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bgJG/AoRhpYqly+BRSIJhDXqfByFj1B8Zl/kfMnItW4mY2aOtkiqsDd4y0/MyIxTh
         1UXi9A31UPIJoTDpVWhzmZzhUzVYph/y5rwT26VPttmsUeMY8MdLsoBaHKHPZ0asku
         YdLtXcn20RB1CMWAp75j+Ucv1De5BBb6ALlnwAjg=
Date:   Tue, 26 Jul 2022 17:02:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Adam Sindelar <adam@wowsignal.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Message-Id: <20220726170207.d902aebccf46c855c490b251@linux-foundation.org>
In-Reply-To: <20220727092329.2a4aade0@canb.auug.org.au>
References: <20220727092329.2a4aade0@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 09:23:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In commit
> 
>   1da6684b4930 ("selftests/vm: fix va_128TBswitch.sh permissions")
> 
> Fixes tag
> 
>   Fixes: 1afd01d43efc3 ("selftests/vm: Only run 128TBswitch with 5-level
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.  Also keep all
> the commit message tags together at the end of the commit message.
> 
> This commit is also missing a Signed-off-by from its committer.

Bah, thanks.  Fixed&rebased.
