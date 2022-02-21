Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BB4BD558
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbiBUFRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:17:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbiBUFQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:16:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF29FB86C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A525B80DAA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E27FC340EB;
        Mon, 21 Feb 2022 05:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645420593;
        bh=UmF304YoFctTRNyywcj5OJombGYazKDeHLPzskD9oYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OViIZeREw0fFKbHsEdgJ0BDYG7JI7hJEEjYfdEkyyCY0qS4ulmvbwiIkHaIia+mz2
         54wdPKltR0fM+b/EXTdSGFXaNKml+GmJvXXWAwyueTQNqAO6imNYpR6VGY64BSz0Do
         KdOMdaIrw72oQV8ZK4yYrsOrWfdU7ahEttbPKc43a36AyzFY4RmBvI0HpDnyTLK/7e
         jJyRBy+zDcluUPZLYn+tleM5pVblhRdHQ44uqGVg8o54OzfhvRpfuDWa2ZFw9P+x4f
         39uJljB9m5UdTckm7qCGJG74NUKEu7agfoEAFcP8BAQEyyB6Ox/Ml1QZaVAgyHAmZh
         QjszgenvZzBQA==
Date:   Sun, 20 Feb 2022 21:16:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 08/10] random: group userspace read/write functions
Message-ID: <YhMgL1rajn5C07/X@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-9-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-9-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:16PM +0100, Jason A. Donenfeld wrote:
> This pulls all of the userspace read/write-focused functions into the
> fifth labeled section.
> 
> No functional changes.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 125 ++++++++++++++++++++++++++----------------
>  1 file changed, 77 insertions(+), 48 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
