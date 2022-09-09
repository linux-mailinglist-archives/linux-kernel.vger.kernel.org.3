Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB15B2DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIIFIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIIFIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:08:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBAE125185;
        Thu,  8 Sep 2022 22:08:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s206so547432pgs.3;
        Thu, 08 Sep 2022 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=H6g0zw3x4uhdRShDitcctRPwuYOehec1y5QBtGADziI=;
        b=AT+UNya2KqPtonAW2GUdtaoo3iFkrMfKIoqAq0Gw8GeyMrKL1lMSLpf+2w4LkFVSmd
         rF5ZkbBN8oRUfZaS3wOuba33F07ttW5ivZYhvYDdDHVLOzs80JFedoPISk7NUMhu74MA
         Zr/QcYtDp7TLq3sudBFrI77fT5mKT9vmlPLD59egzWKS7ugwJNTUrbbg4Z/BldIyEylR
         CYkSS9owOSN59B9v6OHSagL6zyQwqTrLdMYxo6RuyfPF/WAtm7deFAXPMn0hDhilFSY9
         okSqyCWxlt+Cks/WpfEHYTdcncqYv253gOZoYF/yQPqZ6fI/XHK0s1uUfKIGdBZldpiX
         tE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=H6g0zw3x4uhdRShDitcctRPwuYOehec1y5QBtGADziI=;
        b=ONh9KvNDA/yAT1Dlqt3Pb7wg8GVmPi4XXQBBpPiGB4nnjKMg9t8LDlyyV8Z1pNoy9W
         DKRMe2y8f3O5+22s+whMsxs/DaBvCqv/VVBLCDvComM0GhwggEclTOm0MrGPUJseM1tV
         uZl4gg96T+GZdrunhn9l6ZPfYbWc1WWVDC849w+YLfnS6bCJQjTBSxsyddD9/QoiYKe6
         0jMMzvfEfm8wKBgPCYWC1xi6df5L7ycCxAr6LOUVjtcYAhhjRiRgXNvuGfBIAgJfw06A
         LTgsrWnMfvyaolM1q2exbgwl+8e0BtMPAkGPIWaTjMUGFuhADMTdIgAH/BPl1S4gselh
         y0sA==
X-Gm-Message-State: ACgBeo3yfnldA03vRUXS8MDw7FSqSKB3/H7mdTYZFS3z8bF4b15lV85U
        MD49mswIUXZlH8M/ogjRg7E=
X-Google-Smtp-Source: AA6agR7gN7EshBqO1ylnbrWnBbL9+E1IKd2SVzOkBZFoasIfE3oF3x9tt81XF1xqi+eQ5iv1XatfyQ==
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id v8-20020a655688000000b003c21015988emr10719184pgs.280.1662700118976;
        Thu, 08 Sep 2022 22:08:38 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b81-20020a621b54000000b005380832c1fesm605544pfb.10.2022.09.08.22.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:08:38 -0700 (PDT)
Message-ID: <d1af650a-1e0b-a650-4cda-57fb1d54f1af@gmail.com>
Date:   Fri, 9 Sep 2022 14:08:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20220902223507.2537469-1-keescook@chromium.org>
Subject: Re: [RFC] docs: Define c_paren_attributes for attributes with
 arguments
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220902223507.2537469-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I expected some responses from Jon, but looks like he's been busy
elsewhere. Let me chime in.

On Fri,  2 Sep 2022 15:35:07 -0700, Kees Cook wrote:
> While Sphinx's "c_id_attributes" is needed for basic attributes, any
> attributes with arguments need to be defined in "c_paren_attributes"
> to avoid errors like:
> 
> include/linux/fortify-string.h:116: warning: Function parameter or member '__builtin_strncpy' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '1' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '2' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '3' not described in '__diagnose_as'

These warnings are from ./scripts/kernel-doc.
So I think you need to teach the script about "__diagnose_as" so that
the kernel-doc comment of strncpy() can be converted to reST doc
which Sphinx can understand.

Past changes in ./scripts/kernel-doc might give you some hints.

That said, I think Jon should be able to provide a pin-point suggestion.

HTH,

        Thanks, akira

> 
> Move such attributes to "c_paren_attributes" and add __alloc_size
> and __diagnose_as to the list.> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This patch is a lie (the above warning is actually not fixed), but I
> was hoping someone could help with this. The Sphinx documentation says:> 
> c_paren_attributes
>   A list of strings that the parser additionally should accept as
>   attributes with one argument. That is, if my_align_as is in the list,
>   then my_align_as(X) is parsed as an attribute for all strings X that
>   have balanced braces ((), [], and {}). This can for example be used
>   when attributes have been #define d for portability.
> 
> However, this appears to only work for attributes with literally a single
> argument not "all strings X", so things like __printf and __diagnose_as
> don't work.
> 
> Does this need fixing in Sphinx? Or am I missing something?
> ---
>  Documentation/conf.py | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 934727e23e0e..17f996e3709f 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -59,18 +59,14 @@ if major >= 3:
>  
>              # include/linux/compiler_attributes.h:
>              "__alias",
> -            "__aligned",
>              "__aligned_largest",
>              "__always_inline",
> -            "__assume_aligned",
>              "__cold",
>              "__attribute_const__",
>              "__copy",
>              "__pure",
>              "__designated_init",
>              "__visible",
> -            "__printf",
> -            "__scanf",
>              "__gnu_inline",
>              "__malloc",
>              "__mode",
> @@ -80,7 +76,6 @@ if major >= 3:
>              "__noreturn",
>              "__packed",
>              "__pure",
> -            "__section",
>              "__always_unused",
>              "__maybe_unused",
>              "__used",
> @@ -97,6 +92,21 @@ if major >= 3:
>  
>              # include/linux/linkage.h:
>              "asmlinkage",
> +
> +            # include/linux/fortify-string.h:
> +            "__FORTIFY_INLINE",
> +        ]
> +
> +        # Same as c_id_attributes above, but for those with arguments.
> +        c_paren_attributes = [
> +            # include/linux/compiler_attributes.h:
> +            "__aligned",
> +            "__alloc_size",
> +            "__assume_aligned",
> +            "__diagnose_as",
> +            "__printf",
> +            "__scanf",
> +            "__section",
>          ]
>  
>  else:
> -- 
> 2.34.1
