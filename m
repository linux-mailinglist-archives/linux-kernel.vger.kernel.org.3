Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB025515223
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiD2RdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379357AbiD2Rcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:32:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC701DB2E9;
        Fri, 29 Apr 2022 10:29:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 710DD37A;
        Fri, 29 Apr 2022 17:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 710DD37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651253360; bh=w39UN1ykg1ooCxdjBDrKaihPs4YfzGqKEKjdMBJfh1s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mylkgZ0nMBITZO4cE2d39uL+LgiomfKSG9I2W3RyA1sSnk2//94ogjSI6H5uYoFnM
         olLfgcXFt6u44uRAxxZ1TUnt/h/ATm0e6hXoKOFtEn4ova2Hs2EsiUvNYCmf0czU99
         eek1EHsk0sjskGjT5dwW925pt3oNYsgPGpbFZYtDbUXSXNHxh481toCTc5eildsoSn
         uqHhfTtrCVqoVLpiwVU5r/9zOFjMUzpYAWei4VRCFwgtBW59hLVFvfRgiWHSIY6CAp
         VfAdVeyLoLbFH6gdPg3w9QdrjkpW0kex81HTSaT7WNz2tuwRVVGfoYk1qZrgPOHni1
         X1y+YycGPhHjQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     akiyks@gmail.com, baihaowen@meizu.com, seakeel@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Yuhong Feng <yuhongf@szu.edu.cn>
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and
 Describe details using table
In-Reply-To: <20220429171844.9673-1-hanshenghong2019@email.szu.edu.cn>
References: <20220429171844.9673-1-hanshenghong2019@email.szu.edu.cn>
Date:   Fri, 29 Apr 2022 11:29:19 -0600
Message-ID: <87wnf73ij4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenghong Han <hanshenghong2019@email.szu.edu.cn> writes:

> Some syntax errors exist in "page_owner.rst". Thanks to Akira Yokosawa and
> Haowen Bai for tips to help improve the documentation.
>
> We try to fix them. Hope that the Documentation is showed as we expect.

You *have* built the docs and know that they render as expected, right? 

> Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
> Fixes: edc93abbcc6d ("tools/vm/page_owner_sort.c: support sorting blocks by multiple keys")
>
> Co-developed-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> Co-developed-by: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
> Co-developed-by: Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>
> Co-developed-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
> Co-developed-by: Yuhong Feng <yuhongf@szu.edu.cn>

As I mentioned the last time I saw a version of this work, if it really
took this many people to develop this one patch, then we need signoff
lines from all of them.

> ---
> Hello Andrew,
>
> In Commit 57f2b54a9379 ("Documentation/vm/page_owner.rst: update the
> documentation") and Commit edc93abbcc6d ("tools/vm/page_owner_sort.c:
> support sorting blocks by multiple keys"), some incorrect syntax
> are used, which laeds to "build warning after merge of the mm tree".
> Apologize for that!
>
> This issue is trying to fix it.
>
> Best,
>
> 	Shenghong Han
> ---
> ---
>  Documentation/vm/page_owner.rst | 67 ++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 25622c715..f900ab99d 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -171,26 +171,47 @@ Usage
>  
>  STANDARD FORMAT SPECIFIERS
>  ==========================
> -::
> -
> -For --sort option:
> -

So the simplest fix, of course, would be to just put some leading white
space before the "For" lines.  Then the literal block would be
syntactically correct.

> -	KEY		LONG		DESCRIPTION
> -	p		pid		process ID
> -	tg		tgid		thread group ID
> -	n		name		task command name
> -	st		stacktrace	stack trace of the page allocation
> -	T		txt		full text of block
> -	ft		free_ts		timestamp of the page when it was released
> -	at		alloc_ts	timestamp of the page when it was allocated
> -        ator            allocator       memory allocator for pages
> -
> -For --curl option:
> -
> -	KEY		LONG		DESCRIPTION
> -	p		pid		process ID
> -	tg		tgid		thread group ID
> -	n		name		task command name
> -	f		free		whether the page has been released or not
> -	st		stacktrace	stack trace of the page allocation
> -        ator            allocator       memory allocator for pages
> +
> +1) `Table 1`_ for the ``--sort`` option.
> +
> +.. table:: Table 1
> +   :name: Table 1

This seems like rather more markup than is really needed?  What is the
point of these tags?

> +   +--------+--------------+----------------------------------------------+
> +   | KEY    | LONG         | DESCRIPTION                                  |
> +   +========+==============+==============================================+
> +   | p      | pid          | process ID                                   |
> +   +--------+--------------+----------------------------------------------+

...and this seems over the top.  I saw a version of this that used the
simpler format:

> +	====		==========	===========
> 	KEY		LONG		DESCRIPTION
> +	====		==========	===========
> 	p		pid		process ID

That's just as easy to read and much easier to maintain, is there a
reason you moved away from it?

Thanks,

jon
