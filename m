Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B22475049
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhLOBFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbhLOBF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:05:28 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C4FC06173F;
        Tue, 14 Dec 2021 17:05:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u80so19251231pfc.9;
        Tue, 14 Dec 2021 17:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uRlQqvF6RG8Zsg1nyt0JSPZT8TYRrqVaCal8RO4v+zE=;
        b=fWB6oS3lFyO6Sdao+Aee3tpYOhqVqkVQ7o9u7nynsuoVNn81beGq0mVT23SY1epDfX
         HjxweStERrIh1v+C7ge3tECcUtDUNLIQEn3RUiTg/fQOPLQyox7lzknLBL+5/Jusq8IT
         lJSaLO8K85gssQNmQdBjXoKYw5wjsTL0tyOz57gEMl4VA06h9s1QQbelB1hj5RJeHlnz
         ugUSQU2pbzatMDN2ROxVbsKgNNbH0w2oPiIF+1jIBlfCam6pZAOYtKGqN9bI0PJduDTF
         QEgdQlaKiSHbEo8oZx8Qfk1z1607wfjXtKUr+06v74yUNXy50dyi/Bn5LGRv5p5V+Z2R
         aJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uRlQqvF6RG8Zsg1nyt0JSPZT8TYRrqVaCal8RO4v+zE=;
        b=vjfzz49TpjMJ6Jf3bAJIEtlqaQK89RKEg2t2pXAs0rbotEmvHuUT2refDPfuK9W2Lg
         h6b8xlVy8960aL8ZMsDE0PR4LUlHdmt3GF0phfXaWYT3pvEWUX8GiljmFYOO1CC4ysG4
         aEtbw4ppNMRHdDbHQMArGTJoynEg3H4tXcnhKGSXBQtu1Pgoo0E6PlOBdzhrDi8rL884
         0tmoyEfwh+q9SZoJ2mrKRkmjHnf20Mo8nQjgqvQGRsS0q5BaVVafSDHjlvnUY1Ny1tfv
         mM4npwi6pAPDratp8066tNQgwwBnra3w208/F5pfipkj0Lru9OQ+UhMJ1XJpwLZ7CJW5
         AeQg==
X-Gm-Message-State: AOAM532BiEJxcT8HQ6qclT4mrwNmbwjZcQ4hKvRoR3ou1oKkFGaWsrC1
        BGTjW2j8fDAfpJG2/yKNEkqrEZnurPU=
X-Google-Smtp-Source: ABdhPJy/TNd+1wVxgVnqnblxWVOtWxryPBZ+qm2AvWo8XnMsokoPWxmozPvKVcEk4VYa8L2v+dKxlQ==
X-Received: by 2002:aa7:9207:0:b0:4a4:f59a:9df with SMTP id 7-20020aa79207000000b004a4f59a09dfmr6752405pfo.63.1639530327904;
        Tue, 14 Dec 2021 17:05:27 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id mm22sm175208pjb.28.2021.12.14.17.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 17:05:27 -0800 (PST)
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211215001929.47866-1-skhan@linuxfoundation.org>
Subject: Re: [PATCH] docs/vm: fix Unexpected indentation warns in page_owner
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <e3acf716-edd2-91d5-24c9-02c547f0d168@gmail.com>
Date:   Wed, 15 Dec 2021 10:05:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215001929.47866-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Dec 2021 17:19:29 -0700, Shuah Khan wrote:
> Fix Unexpected indentation warns in page_owner:
> 
> Documentation/vm/page_owner.rst:92: WARNING: Unexpected indentation.
> Documentation/vm/page_owner.rst:96: WARNING: Unexpected indentation.
> Documentation/vm/page_owner.rst:107: WARNING: Unexpected indentation.

I guess these outputs should have been literal blocks.
Then Sphinx wouldn't complain about indentations.

        Thanks, Akira

> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/vm/page_owner.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 9837fc8147dd..9a3af6aafa09 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -89,11 +89,11 @@ Usage
>  
>  	Page allocated via order XXX, ...
>  	PFN XXX ...
> -	 // Detailed stack
> +	// Detailed stack
>  
>  	Page allocated via order XXX, ...
>  	PFN XXX ...
> -	 // Detailed stack
> +	// Detailed stack
>  
>     The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
>     in buf, uses regexp to extract the page order value, counts the times
> @@ -104,7 +104,7 @@ Usage
>  
>  	XXX times, XXX pages:
>  	Page allocated via order XXX, ...
> -	 // Detailed stack
> +	// Detailed stack
>  
>     By default, ``page_owner_sort`` is sorted according to the times of buf.
>     If you want to sort by the pages nums of buf, use the ``-m`` parameter.
> -- 
> 2.32.0
