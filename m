Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AA56971C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiGGBB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiGGBB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:01:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2B2D1CE;
        Wed,  6 Jul 2022 18:01:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g126so1825062pfb.3;
        Wed, 06 Jul 2022 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VIGPj4rVRvxRmGjzajy7JLwRvjlm/OlZ/IQ+zB8PolQ=;
        b=VsF8zBLrrTAsVg90E851X0ASp+KiZKRL8z2U+FO30fBLXg8Iod8MZ1qmN7geVzJH3/
         vm5zY1dWtbPkn409SJi5MgrQXziLKmmR9YiNUk4tj3JcUxovRTl/cmsCL2h1jDzhaWpC
         ptpEXWQQBivB5FK64qJdMbHNCZy6XZIz+x92gd9vC0eo8tuxgXyr3QHtstUTI9V9tPzK
         MEi7SR1u1LIC7L5VlIkKXk0AwvIty7L6jvZ2AlecLJfiibsbs1NXds9bv2jZDPoEgduS
         lZFhgyd9wIcMzJj9ZHeylIl+nl8yTDUGDvK1L+2GRLt4R9Es6Fp2jRfoYqDSznm0iSFm
         YgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VIGPj4rVRvxRmGjzajy7JLwRvjlm/OlZ/IQ+zB8PolQ=;
        b=WHfsmBBbVv0zCS0QuPgC+OlplYdhiExpAoxtj2YBtflJiWFwE4VJaDxPfnmQ3nUfm9
         wDlrrtqNleTENeNY61n35M96NhrUV+6KsHb8FXs+GEWVKGMDiwk2xYaDwlRvd4oMwHiZ
         X3gsalZBj/pYpRb+n9ev8rnldTeWUXXBq/4NsdbaM6tt6H3kOQ0RRGKyx5O1te+mQ6xZ
         RBDBV/NXUhW9iTCCIlgCk9eJEko8yzuL/b6UIyVBSbsNSyayL+tNoJABdHbzri3pq7o4
         5zpDK+b2WJ4zKODT3g2fZBs8IQ7FBmpeaMPRJQL6aiZ7cF+4qBIJCdc7WzZ03oUxYozp
         S48Q==
X-Gm-Message-State: AJIora/fn6zmvdViLENe3KaaR4fSNAZbtbC6vwZKZvPm5pYRAP6cFlJy
        D6pe+WBfLmrWR1Vuxa962NI=
X-Google-Smtp-Source: AGRyM1uu4T1H+2wc6LQb7IJVSvu9RmvYTaxgXQxl79JFt5CO6Y9Kq5Z1t6OWBcLjz9xZ1uPr9FDqag==
X-Received: by 2002:a17:90b:8d:b0:1ef:74c8:1541 with SMTP id bb13-20020a17090b008d00b001ef74c81541mr1785443pjb.103.1657155715387;
        Wed, 06 Jul 2022 18:01:55 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902da9100b0016be7a89ac9sm6896975plx.94.2022.07.06.18.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 18:01:54 -0700 (PDT)
Message-ID: <edaf107b-da65-9b90-aed9-bbedff9c7783@gmail.com>
Date:   Thu, 7 Jul 2022 10:01:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] media: docs: Remove extraneous \endgroup from P010 table
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <c3254669-cd71-48e5-665c-430b76f77baa@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c3254669-cd71-48e5-665c-430b76f77baa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 22:01:17 +0900, Akira Yokosawa wrote:
> The \endgroup command at the bottom of a table added in commit
> 5374d8fb75f3 ("media: Add P010 video format") doesn't have a
> corresponding \begingroup command preceding it.
> 
> This imbalance causes an build error in "make pdfdocs".
> 
> Fix the issue by removing it.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Fixes: 5374d8fb75f3 ("media: Add P010 video format")
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> Hi Mauro,
> 
> In my (bi-weekly) test of "make pdfdocs" against next-20220629,
> I encountered a build error of userspace-api.tex.
> 
> This patch fixes it.
> 
> This is relative to 'master' of git://linuxtv.org/media_tree.git
> as merged by Stephen.
Gentle ping, Mauro.

I assume the offending patch is destined for the next merge window.
If it lands as is, "make pdfdocs" will end up in: 

> Latexmk: Errors, so I did not complete making targets

> Collected error summary (may duplicate other messages):

>   xelatex: Command for 'xelatex' gave return code 1

>       Refer to 'userspace-api.log' for details

> Latexmk: Use the -f option to force complete processing,

>  unless error was exceeding maximum runs, or warnings treated as errors.

> make[2]: *** [Makefile:29: userspace-api.pdf] Error 12

> make[1]: *** [Documentation/Makefile:115: pdfdocs] Error 2

> make: *** [Makefile:1686: pdfdocs] Error 2


Here is the relevant part from the middle of userspace-api.log:

> ! Extra \endgroup.
> l.27734 \endgroup
>                 
> Things are pretty mixed up, but I think the worst is over.

Or am I missing something?

        Thanks, Akira

> 
>         Thanks, Akira
> --
>  Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index a900ff66911a..997ce2d094fc 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -570,9 +570,6 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
>        - Cb\ :sub:`11`
>        - Cr\ :sub:`11`
>  
> -.. raw:: latex
> -
> -    \endgroup
>  
>  Fully Planar YUV Formats
>  ========================
> 
> base-commit: 945a9a8e448b65bec055d37eba58f711b39f66f0
