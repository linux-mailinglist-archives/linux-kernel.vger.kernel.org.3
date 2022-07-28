Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEEB5842C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiG1PP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG1PP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:15:56 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9670243319;
        Thu, 28 Jul 2022 08:15:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3EF2821F;
        Thu, 28 Jul 2022 15:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3EF2821F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1659021355; bh=quglmyTcDMfNz+EfwOq2c2h7dkjzivKLmZ5MAUxgYMI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pIh2JIW7idg1XWwuau6ucRm6OwuugZHSiduyzmXbOq/ulhQuNrOlW+80Ex3VAN+QD
         T/c5jWiEVuDDKeW07AWlpPnLlidWLq8EwIoynp+0JQvcaIKghPsZWnhubBY3EvLvox
         0QM6hcgizZez3xMaSoIpHGsBfYHO1UUuS5njHAiqHEEvynKtMVGXkvLnESRA6GX4tJ
         eU0KIazJIfSogC15ej847o1VDT2ISC9JFPUMgISIhlKRYeUA48JLQ1jrOid9z1smOv
         84Y2xbiFfs3UWEoHKS1T1hTEaeyjacWr8sorvgGDhdllWslY9ASANWHSjps3lUZSue
         FrGbpxeSFEXSQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     fslongjin <longjin@RinGoTek.cn>, twoerner@gmail.com,
        keescook@chromium.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        fslongjin <fslongjin@vip.qq.com>, longjin <longjin@RinGoTek.cn>
Subject: Re: [PATCH] Documentation: Fixed errors in the title level of
 coding style documents
In-Reply-To: <20220728074224.155298-1-longjin@RinGoTek.cn>
References: <20220728074224.155298-1-longjin@RinGoTek.cn>
Date:   Thu, 28 Jul 2022 09:15:54 -0600
Message-ID: <8735elclp1.fsf@meer.lwn.net>
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

fslongjin <longjin@RinGoTek.cn> writes:

> From: fslongjin <fslongjin@vip.qq.com>
>
> In Section 3, `Placing Braces and Spaces`. In the previous document, only
> `Spaces` is written in the subtitle without the `Braces`. I think this
>  may be a format error caused by negligence, so I fixed it.
>
> Signed-off-by: longjin <longjin@RinGoTek.cn>
> Signed-off-by: fslongjin <fslongjin@vip.qq.com>

I don't understand this signoff chain; did both of you work on this
small patch?

Signoffs should also have full legal names in them.

> ---
>  Documentation/process/coding-style.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 03eb53fd029a..2a26bcb9f391 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -120,6 +120,9 @@ that breaks the ability to grep for them.
>  3) Placing Braces and Spaces
>  ----------------------------
>  
> +3.1) Braces
> +***********
> +
>  The other issue that always comes up in C styling is the placement of
>  braces.  Unlike the indent size, there are few technical reasons to
>  choose one placement strategy over the other, but the preferred way, as
> @@ -231,7 +234,7 @@ Also, use braces when a loop contains more than a single simple statement:
>  			do_something();
>  	}
>  
> -3.1) Spaces
> +3.2) Spaces
>  ***********

This seems like a fine change but, as you notice here, putting section
numbers into the text leads to ongoing update problems.  Sphinx can add
those nicely, so I generally suggest just removing them entirely.  I
wouldn't insist on that, but if you felt so inclined, that would be a
good improvement to the patch.

Thanks,

jon
