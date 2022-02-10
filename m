Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BDD4B1374
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbiBJQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:49:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbiBJQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:49:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE3128;
        Thu, 10 Feb 2022 08:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70184B8085E;
        Thu, 10 Feb 2022 16:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5413C004E1;
        Thu, 10 Feb 2022 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644511791;
        bh=2GTpiJMOFBRO5W5Mh+SNZSt4e8y2L+JqYTp5Ygi3iu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2IdSsKH1/ow2uRdtx9WV41fjzx7zt61pGTNCd+1b3JaNz1ia/JnIQcY+oN58SGAs/
         BjfZWAePOkZGHcaazGJU+5fkj0659S3HQNQxoCSKMwiJFJ9ZhQ5erbZmEBVg2y0Etj
         +4KSXQ/wur4FssFPogQxXF/vyre9ItE6wS9vWHKc=
Date:   Thu, 10 Feb 2022 17:49:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: add proper SPDX header
Message-ID: <YgVCKjDpuYChCKzu@kroah.com>
References: <CAHmME9pc5NRLW4wUy57bqd_gX01PBVoydOQp9Z0rWT+j+fAb+Q@mail.gmail.com>
 <20220210161611.157765-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210161611.157765-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 05:16:11PM +0100, Jason A. Donenfeld wrote:
> Somehow this file missed the SPDXification efforts several years ago.

That is because it required manual review.

> Convert the current license into "(GPL-2.0-or-later OR BSD-3-Clause)".
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Hi SPDX List,
> 
> I think I got this conversion right, but I would certainly appreciate a
> review on this from somebody with more legal expertise than me.

Where did the "or later" come from?  I don't see that in the original
text.

> 
> Thanks,
> Jason
> 
>  drivers/char/random.c  | 40 ++--------------------------------------
>  include/linux/random.h |  5 -----
>  2 files changed, 2 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 324574b03120..a2bbae5a693d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
>  /*
> - * random.c -- A strong random number generator
> - *
>   * Copyright (C) 2017-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> - *
>   * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
> - *
> - * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
> - * rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, and the entire permission notice in its entirety,
> - *    including the disclaimer of warranties.
> - * 2. Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in the
> - *    documentation and/or other materials provided with the distribution.
> - * 3. The name of the author may not be used to endorse or promote
> - *    products derived from this software without specific prior
> - *    written permission.

BSD-3, great.

> - *
> - * ALTERNATIVELY, this product may be distributed under the terms of
> - * the GNU General Public License, in which case the provisions of the GPL are
> - * required INSTEAD OF the above restrictions.  (This clause is
> - * necessary due to a potential bad interaction between the GPL and
> - * the restrictions contained in a BSD-style copyright.)

I do not see a "or later" here.


> - *
> - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> - * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> - * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> - * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> - * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> - * DAMAGE.
> + * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All rights reserved.

Why break the line-wrap?



>   */
>  
>  /*
> diff --git a/include/linux/random.h b/include/linux/random.h
> index e92efb39779c..1a6861aa1277 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -1,9 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * include/linux/random.h
> - *
> - * Include file for the random number generator.
> - */

This doesn't have to do with the SPDX change in the other file, it
belongs in a different patch, sorry.

thanks,

greg k-h
