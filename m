Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530DC4BD4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiBUFFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:05:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiBUFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:05:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC592A722
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:05:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B162F611A7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F352FC340E9;
        Mon, 21 Feb 2022 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645419916;
        bh=e8/OECjAlQyZK71hxF56T6x7py1w/KM2yPf4UpUo0uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnbRU2GX3ZEHFuntGwgUxKuFIf4HMM+VSrH8Yc6PvVNGiobA3kjMvAlhmtNyIrFzA
         sX5SF97+KOms6BJn7jZIRMneSoFLQGx1FvDfbGJyR/BHLgxl7nvXkXWXkkBeu7WaLa
         Mxg5+/j6fppQb3tQxORXS8CxlQHZFpRV+Y7Qy20QdL9QJw2ulC3E896xpb8UId6+D9
         aIJIFYwBmhKCpqWyJaYA/GfB6IQq4I0hB4cfj/t8QBPbPQZJTZjIHbo7zFVsl6n0pu
         3dy26NrCvyZ8EhT+aSuxoniF2ovOKqNdQJXTbU0THVIMzxufLSh+q6w0bO+R93Nn1E
         1UTTPWOpcrpbw==
Date:   Sun, 20 Feb 2022 21:05:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 06/10] random: group entropy extraction functions
Message-ID: <YhMdit7XCcno/Nz/@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-7-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:14PM +0100, Jason A. Donenfeld wrote:
> This pulls all of the entropy extraction-focused functions into the
> third labeled section.
> 
> No functional changes.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 217 +++++++++++++++++++++---------------------
>  1 file changed, 109 insertions(+), 108 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
