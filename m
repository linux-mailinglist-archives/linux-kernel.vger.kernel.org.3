Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BFD49C008
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiAZAQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiAZAQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:16:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE55C06161C;
        Tue, 25 Jan 2022 16:16:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6B212383;
        Wed, 26 Jan 2022 00:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6B212383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643156177; bh=Vk8OWoiBSEPrB/jgtobB703X7p3CtfIrPbAGBh1H48c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MUTQNyw3NIudqvekkheT1kHE8Vv9d/0cZpSW8g/f6F/Xq9y0E3YRgbNp/x8Vf9c/l
         SUCDTSzH3LHTup7tIndnkAnJjbtG2bDfbxaaoP2tzNtacYmsbZY4Xu9l6zQQoWw7ho
         XQZMCmIuE2RjnbVxI1d2tVtBo79WvAXQh9LwGnrhasdtyUgBxEWYbLZdmwndhElv6x
         nmw1kgpwbUC9v+8MCKMwUESLFJQOT7Lh6gaHHEEb2brhgZvp5CrjG11I7Qkt7aRkwC
         5DhVS7xb9Q0Op9qRex+GDPwcL5oLrwQ0ehd1jZ1x9FF2KLBHt2f2zCrFnmp+b+lVN4
         bTZJVNsxykIbA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Takahiro Itazuri <itazur@amazon.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Takahiro Itazuri <itazur@amazon.com>
Subject: Re: [PATCH] docs: fix typo in Documentation/kernel-hacking/locking.rst
In-Reply-To: <20220124081447.34066-1-itazur@amazon.com>
References: <20220124081447.34066-1-itazur@amazon.com>
Date:   Tue, 25 Jan 2022 17:16:45 -0700
Message-ID: <87k0enwdua.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro Itazuri <itazur@amazon.com> writes:

> Change copy_from_user*( to copy_from_user() .
>
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
>  Documentation/kernel-hacking/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
> index e6cd40663ea5..4cbd50edf277 100644
> --- a/Documentation/kernel-hacking/locking.rst
> +++ b/Documentation/kernel-hacking/locking.rst
> @@ -295,7 +295,7 @@ Pete Zaitcev gives the following summary:
>  
>  -  If you are in a process context (any syscall) and want to lock other
>     process out, use a mutex. You can take a mutex and sleep
> -   (``copy_from_user*(`` or ``kmalloc(x,GFP_KERNEL)``).
> +   (``copy_from_user()`` or ``kmalloc(x,GFP_KERNEL)``).
>  

Applied, thanks.

jon
