Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF26C5450C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbiFIP0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344422AbiFIP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:26:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E33DA7C;
        Thu,  9 Jun 2022 08:26:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BF268732;
        Thu,  9 Jun 2022 15:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BF268732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654788377; bh=kzXiyg6PaQ9/LR5j+f389QxXJKQf9bbIWSaEQxA3ZNs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Nysfa1cYifs83+aNRNQneXD2iTLzP8n3HJYTXr4KVmG39r4MI36b4Pu+euWKbsUSN
         fCQ0v8XcLNTiFDtQtWG+n4sTepKv4NHuvxrmT1pmMOUYXL8U3LydixO1aJu4OGJ4Z2
         KrcRhOnfh4egJhfk5Ls1OLvvp7P62eswgwE7VLR9GZ6YKKAWqTahrJwyPIunLE+N21
         YLFU4g+z531cyvibbykzDzz4vNrbcVbnZ+5p1fAtWpcoiBW2rZRDf0hzkSCdR1JKEF
         xhSrZNmiXDFj3DfyoVUEwMYsoF8zyhPuIFMXDe9jGKVJ7tzSIq/yrs/yt8uM1XrqY0
         pZPt3gFfqHiTg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 2/5] docs/doc-guide: Mention make variable SPHINXDIRS
In-Reply-To: <ff89c064-e24a-0f2f-fc03-b029e5d04338@gmail.com>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
 <ff89c064-e24a-0f2f-fc03-b029e5d04338@gmail.com>
Date:   Thu, 09 Jun 2022 09:26:17 -0600
Message-ID: <87v8t9504m.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> SPHINXDIRS is useful when you want test builds of only those
> documents affected by your changes.
>
> Mention it in the "Sphinx Build" section.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> This change is inspired from correspondence with Maciej [1].
>
> [1]: https://lore.kernel.org/r/f4d40da6-756b-9e75-b867-cc9eedc4b232@gmail.com
>
> --
>  Documentation/doc-guide/sphinx.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index edc4fa023986..efcccab68286 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -151,6 +151,10 @@ If the theme is not available, it will fall-back to the classic one.
>  
>  The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
>  
> +There is another make variable ``SPHINXDIRS``, which is useful when test
> +building a subset of documentation.  Again, see the documentation section
> +of ``make help`` for the details.

This should definitely be documented, it's kind of sad that we never did
that.  Rather than redirect readers to type a "make" command, though,
why not just tell them how to use it here?

Thanks,

jon
