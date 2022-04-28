Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A512251299B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiD1CrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiD1CrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:47:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E681EFD;
        Wed, 27 Apr 2022 19:43:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so3238067pjf.0;
        Wed, 27 Apr 2022 19:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Lj+eh3dTxxaeVwGltXHl3N3Y99pyZQ7NZmAw/2kQH7Q=;
        b=o+VzduRIn1GcZtLdQcq24NtWvIjYhLB1Kz2GrCNZaZgeOL4NsHnsxSTz6592idlP+s
         b9UPSnIOnXDEaOMbJBaZurorv5jebHHbLmtDITkt+k0abWGIc0F7Ko3twVgq/Tf90J8v
         FgE+Sjy23G2Khmr0FYWJhowz5qx1ec5kpU8viTRe4IRHIlCM56aLHZ635fkGc16veL1Y
         sfvHDyUhPk9zbkZc2fBm8pAPzv+dk67uMH7bwWhnjBN1eOaF6r/uXemiLUvLnXK3U9W2
         Lq8O9SNh6eZEiPDX3cR3068eqGscIjZDJkisH120wpLANMHLnPxzB+zaM/uLzxwHarXB
         jD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lj+eh3dTxxaeVwGltXHl3N3Y99pyZQ7NZmAw/2kQH7Q=;
        b=gnJUUrXmzzPilYYW2sAKr75F1WbewIYCC/uSSdOBKYIFHXB/4OUcM5uhhiq/xdGUOT
         +6EH3Gaz4TQZ/WkCtndSGwQWA3fOphgW2/EHaMY9p2QNHK1mzKgPGnyjjOIdyU48tWe0
         R1sCmyMVjAgVv8m5RXLD5TE4dvqkwkRl/mzlAa7pGqx/U6GqhI267EbM7h5a7+Rkc/Gt
         WL4SdJxpFIR2Qz/IbLJJcWEFPEe50S7l2hOJcm4X4fSsJkgsgHS4IZX6xo/uVnNC6TjZ
         pUMlhwun+ghBscIg2KHSBfX4A6LqZDR3ffR0tBzwdMfMxJuM4BfTAYt9jUcyvaFOCy2h
         Vx/w==
X-Gm-Message-State: AOAM531Gno3Sfnp6qHFovwuHPx/A37lJOoqrGEy6/rNoAXfwgboynfyE
        VHQck607oF/NPkIfYxXw86uWRect+cKUARBc
X-Google-Smtp-Source: ABdhPJy9qxchv+7KPQHx7/ZjnWbpz7vPusXjAkWsY6Yf1XjQ/8HfQn/uj3J1dd1Z4yFfqimjAxAB2Q==
X-Received: by 2002:a17:90b:3ec8:b0:1d9:6cbb:8222 with SMTP id rm8-20020a17090b3ec800b001d96cbb8222mr21970841pjb.104.1651113826218;
        Wed, 27 Apr 2022 19:43:46 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id p34-20020a056a000a2200b004cd49fc15e5sm22809470pfh.59.2022.04.27.19.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 19:43:45 -0700 (PDT)
Message-ID: <e65cac81-3f56-3ba0-6ce1-bc07e9d0617c@gmail.com>
Date:   Thu, 28 Apr 2022 10:43:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] docs: vm/page_owner: Use literal blocks for param
 description
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Haowen Bai <baihaowen@meizu.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cfd3bcc0-b51d-0c68-c065-ca1c4c202447@gmail.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <cfd3bcc0-b51d-0c68-c065-ca1c4c202447@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/22 20:58, Akira Yokosawa wrote:
> Subject: [PATCH] docs: vm/page_owner: Use literal blocks for param description
> 
> Sphinx generates hard-to-read lists of parameters at the bottom
> of the page.  Fix them by putting literal-block markers of "::"
> in front of them.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

LFTM

Reviewed-by: Alex Shi <alexs@kernel.org>

> Fixes: 57f2b54a9379 ("Documentation/vm/page_owner.rst: update the documentation")
> Cc: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Alex Shi <seakeel@gmail.com>
> ---
> Hello Andrew,
> 
> This is the first time I send a patch in your way.
> So I'm not sure this works as I intend.
> If anything goes wrong, please let me know.
> 
> This issue is in discussion in a linux-doc thread triggered by
> a post from Haowen Bai [1]. (Warning: The thread looks confused
> due to Haowen's unnecessary uses of In-Reply-To: headers.)
> Jon suggested the route via your tree, but he keeps posting
> to linux-doc.
> 
> [1]: https://lore.kernel.org/all/1650424016-7225-3-git-send-email-baihaowen@meizu.com/
> 
> Haowen's patch uses tables to improve the look of param lists.
> I suggested him using literal blocks instead, but I failed to
> hear any response. So I'm sending my version of the fix in your
> way.
> 
> I believe this fix is worth for 5.18-rcX.
> 
> Side note 1: I see another patch queued for -next around here, which
> has broken indents by white spaces.  You might want to fix or drop it.
> 
> Side note 2: page_owner.rst is not covered in MAINTAINERS.
> You might want to add an entry, maybe, under "PAGE TABLE CHECK".
> 
> Again, if there is anything I can do better, please let me know.
> 
> Best,
> 
>         Akira
> --
>  Documentation/vm/page_owner.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 65204d7f004f..7e0c3f574e78 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -110,7 +110,7 @@ Usage
>     If you want to sort by the page nums of buf, use the ``-m`` parameter.
>     The detailed parameters are:
>  
> -   fundamental function:
> +   fundamental function::
>  
>  	Sort:
>  		-a		Sort by memory allocation time.
> @@ -122,7 +122,7 @@ Usage
>  		-s		Sort by stack trace.
>  		-t		Sort by times (default).
>  
> -   additional function:
> +   additional function::
>  
>  	Cull:
>  		--cull <rules>
> @@ -153,6 +153,7 @@ Usage
>  
>  STANDARD FORMAT SPECIFIERS
>  ==========================
> +::
>  
>  	KEY		LONG		DESCRIPTION
>  	p		pid		process ID
> 
> base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
