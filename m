Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6B34BD4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbiBUE3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiBUE3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:29:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04661403E2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95E0D6119F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6782C340E9;
        Mon, 21 Feb 2022 04:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645417740;
        bh=24ZzGX0DqG1cObJI4k5KRxdsKfbrBF+H+rZLCUKtZhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMlZ3pXCzuWlKwhTbdmtJUrgzHctX7IiBFaMRVMxr7iqTIo6QLlL7lzwt29Gf34G5
         5Nto1ETBDea0ufHwplG9oDIQtdsi3c+TzbThchY6WP9wY+40dZT8HaCmIJJ6qUGPsm
         YosCH+bDHrWwqEZQ+eYxKT3J8jmnMj9U/0nWPRi0SrwRdd793+0ts9xn0h61n3SEnR
         SNOgW8UAL8NyuNFtlA4TD5UezFhls7LFdOmPE/m3jgB29nTtdm8D100us93OvBLoR3
         LZ0R+8VvEmYVAcE931q3XfxbW4Qs+V2lndQwifzQ6/TpQ6d20+GwaqGt0XGIA7bc7z
         XO18gd3wEcFHA==
Date:   Sun, 20 Feb 2022 20:28:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/3] random: remove unused tracepoints
Message-ID: <YhMVCgUCWK7eeQE8@sol.localdomain>
References: <20220210155012.136485-1-Jason@zx2c4.com>
 <20220210155012.136485-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210155012.136485-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 04:50:11PM +0100, Jason A. Donenfeld wrote:
> These explicit tracepoints aren't really used and show sign of aging.
> It's work to keep these up to date, and before I attempted to keep them
> up to date, they weren't up to date, which indicates that they're not
> really used. These days there are better ways of introspecting anyway.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c         |  30 +----
>  include/trace/events/random.h | 206 ----------------------------------
>  lib/random32.c                |   2 -
>  3 files changed, 3 insertions(+), 235 deletions(-)
>  delete mode 100644 include/trace/events/random.h

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
