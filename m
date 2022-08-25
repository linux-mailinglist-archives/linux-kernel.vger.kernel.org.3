Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD025A1866
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbiHYSJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiHYSJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:09:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B214BD08F;
        Thu, 25 Aug 2022 11:09:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 72B8F2E2;
        Thu, 25 Aug 2022 18:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 72B8F2E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661450976; bh=5vAHQVGvmhIm6rGzB0DMvadkCYOHywVDKSrP/IUHYKc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kSRWIw/Ak6lGd6CoGml8WhUs7+ybs0aOyaPwpM79tFAXB+ZjsPQkokUvdJzTK8e2o
         ZTDYDw2bs+omShQpeS1Tv3pgL5qewxFmLKxuXcrFWBp1TmFFmcNqkr7kU4rGirYwfG
         yVe9AY/dPLoErSUSG/RlEnxYcVOS/9PLLedrsF4fEqP53Po7Q83VRWPotXNBirPIia
         xLIocksnTJksthlgZy1U7gZcZLMjSLGCOVrXOtL5Y96F4mjUgC33uUIHOYOc18Lqra
         LDlwAEhYDfLE6f6VqybjDbvkeDKQ0QkAVAgXJdqJP6ECaOGU0GUDS+q5QYIVu6eK6u
         7KY+F0xpRJNNw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     yejiajian2018@email.szu.edu.cn, skhan@linuxfoundation.org,
        akiyks@gmail.com, rppt@kernel.org, zhangyinan2019@email.szu.edu.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: Re: [PATCH] Documentation/mm/page_owner.rst: update experimental data
In-Reply-To: <20220825172934.4344-1-caoyixuan2019@email.szu.edu.cn>
References: <20220825172934.4344-1-caoyixuan2019@email.szu.edu.cn>
Date:   Thu, 25 Aug 2022 12:09:35 -0600
Message-ID: <87ilmgyz34.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixuan Cao <caoyixuan2019@email.szu.edu.cn> writes:

> I noticed some experimental data need to be updated.
>
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  Documentation/mm/page_owner.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
> index f18fd8907049..8e2545bb4e17 100644
> --- a/Documentation/mm/page_owner.rst
> +++ b/Documentation/mm/page_owner.rst
> @@ -41,17 +41,17 @@ size change due to this facility.
>  - Without page owner::
>  
>     text    data     bss     dec     hex filename
> -   48392   2333     644   51369    c8a9 mm/page_alloc.o
> +   58581   3166     652   62399    f3bf mm/page_alloc.o
>  
>  - With page owner::
>  
>     text    data     bss     dec     hex filename
> -   48800   2445     644   51889    cab1 mm/page_alloc.o
> -   6662     108      29    6799    1a8f mm/page_owner.o
> -   1025       8       8    1041     411 mm/page_ext.o
> +   59085   3294     652   63031    f637 mm/page_alloc.o
> +   7464     125      28    7617    1dc1 mm/page_owner.o
> +   1396      32       8    1436     59c mm/page_ext.o
>  
> -Although, roughly, 8 KB code is added in total, page_alloc.o increase by
> -520 bytes and less than half of it is in hotpath. Building the kernel with
> +Although, roughly, 9 KB code is added in total, page_alloc.o increase by
> +632 bytes and less than half of it is in hotpath. Building the kernel with
>  page owner and turning it on if needed would be great option to debug
>  kernel memory problem.

This seems like a fine patch...but I do have to wonder if it really
makes sense to maintain this information, which will surely be subject
to frequent change.  Perhaps the whole thing is better replaced with a
line saying that enabling page owner adds ~9KB?

Thanks,

jon
