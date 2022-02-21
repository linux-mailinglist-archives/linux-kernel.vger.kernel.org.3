Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53F4BD58B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiBUF1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:27:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiBUF0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:26:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080E388
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:26:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8815DB80CE7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14183C340E9;
        Mon, 21 Feb 2022 05:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645421189;
        bh=ArGbRZdIIXyagzCug4BIrRjC6JZg5MHGwz0HckdUsB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2BTmUogpmhj7oj70PwF6+0MvzXJF46BnonxztpdKULOjQnxZx5aRmX5IY4KHmy6u
         KL1emVrDLt+PHSCH+r1zy5vEdU9Wpz39Rj0UbYtBq+hXO32eJE4bO9h/qtDgx2oPIv
         wdyXtJQeT+cxfxLTrlAGofcG1QuW4M3jU/YYDGK72Qj4OfD8V7F/Q8eV2VYR0cAaHD
         hzlZhvTsfPkVtAV2ONpuh/MPWKWz4lTcPPI3S7xhqPH/pg6/ezOAy+3YYLAm9nTUez
         W6EqrvxWf+dO1lLHL3pX2YRR0NUIkhi06xMjVyW1y3M8XfYckvqlo2EySDD8RMTyU/
         syDe7W59y4nIg==
Date:   Sun, 20 Feb 2022 21:26:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 10/10] random: rewrite header introductory comment
Message-ID: <YhMigxWjidrz4QPY@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-11-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-11-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:18PM +0100, Jason A. Donenfeld wrote:
> Now that we've re-documented the various sections, we can remove the
> outdated text here and replace it with a high-level overview.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 183 +++++-------------------------------------
>  1 file changed, 21 insertions(+), 162 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
