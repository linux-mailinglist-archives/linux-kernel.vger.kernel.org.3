Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001BB4BD4C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbiBUEfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:35:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343831AbiBUEfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:35:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C6D40A05
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:34:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2352B80DA6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30381C340E9;
        Mon, 21 Feb 2022 04:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645418085;
        bh=Q1nzzgOs5FDyrLR8TnVC0uaFJzh+dOrtZmQKr0oYaz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0RnM4v2uOHH92pRYJLgTnRWGmz/9lWCQSm+TvLFVetxlMKpFYcUukVXvfF6QmjiL
         ctDWnrbZRZhpCMMu4E52S8sHMUiALkcJmNrWFkCj3fCTAYtLQw5pUlWi5sVd7YLAxs
         9nwWSayRsAWKkf6k7C7JUrNYn31lnno1bhLNeI9oOGAp8j0I6ZueonsbO+Rugmk1Dp
         PYyBmfIuhx3edGLFThsicYl8OfgJZGLcDBNCOk9qkpENGR5MkpyzNOXFgItnk4sbjV
         5KvokBISM1WyqbfZH+h6j6lXJitROI+nXoUXjM2YefAsUQelGdHrmpDs6CmvrNq39k
         fMd4ZZ1a5OrvQ==
Date:   Sun, 20 Feb 2022 20:34:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 02/10] random: remove useless header comment
Message-ID: <YhMWY5PgvOwMbLAZ@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:10PM +0100, Jason A. Donenfeld wrote:
> This really adds nothing at all useful.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  include/linux/random.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/random.h b/include/linux/random.h
> index e92efb39779c..37e1e8c43d7e 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -1,9 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * include/linux/random.h
> - *
> - * Include file for the random number generator.
> - */
> +
>  #ifndef _LINUX_RANDOM_H
>  #define _LINUX_RANDOM_H
>  

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
