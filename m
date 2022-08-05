Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7522158A6F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiHEHWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiHEHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:22:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F818397
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC3DB8275D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924BEC433D7;
        Fri,  5 Aug 2022 07:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659684133;
        bh=7u3HxRp5NFkFE+bl2pbrO1Vom3p6Ci1YJ5qGLzvW4kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azUJW5HYl58q1jtoW4R7du9BvdG+qkRb7prxjH+hedfeH0LmF3zZCxUUe+xDopn4R
         WJ/drZzI97s3LMWdGFFxeaq9CIB/7HPxRx9dY2OaYzOI+J3zI8TTCkSZrl22v0+mfy
         KSMO02rpN6P995pDym/k/rwdDRvyz79An4JOD1boHBR3bulgkQOoLWNEEFLLcx8mcT
         Sp7YKaUVQNlUbxJcvx0r+FON07ySnLVMCNOwbAKdmDt0iik34ZYW51BdACFDSYhokR
         ZIi6wFKueDQbygGVQy9R85SZwNNohoPPc6nQc89nkK7rEs2aitDagfzNZF4C+Oxw/Z
         0TdtHLp5Pgreg==
Date:   Fri, 5 Aug 2022 00:22:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH 2/3] kernel/watch_queue: Improve struct annotation
 formatting
Message-ID: <YuzFIx36zDXX0z/0@sol.localdomain>
References: <cover.1659618705.git.code@siddh.me>
 <6bac2d4c2b50d921eb16fa5344ffe258be90c651.1659618705.git.code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bac2d4c2b50d921eb16fa5344ffe258be90c651.1659618705.git.code@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 07:00:23PM +0530, Siddh Raman Pant wrote:
> Improve formatting struct annotations in watch_queue.h, so that they
> fall in the preferred 80 character limit.
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

This patch isn't just fixing overly long lines, but rather is introducing
kerneldoc comments and documenting things that weren't documented before.
That's fine, but please make the commit message accurately describe the patch.

> diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
> index fc6bba20273b..c99c39ec6548 100644
> --- a/include/linux/watch_queue.h
> +++ b/include/linux/watch_queue.h
> @@ -18,57 +18,103 @@
>  
>  struct cred;
>  
> +/**
> + * watch_type_filter - Filter on watch type

If you're going to use kerneldoc comments, they should be correctly formatted.
This is not, since it's missing the word struct.  You can run this command to
see the kerneldoc warnings:

	./scripts/kernel-doc -v -none include/linux/watch_queue.h

> + * @lock: Spinlock

Please make sure that comments provide useful information and don't just repeat
what the code says.

- Eric
