Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3A599383
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbiHSDfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242374AbiHSDfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:35:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AC4C59D4;
        Thu, 18 Aug 2022 20:35:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d16so3094945pll.11;
        Thu, 18 Aug 2022 20:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JZwTxIjZdK3eeeynNetfRffvQYVNIdx1KtctWmB4uOs=;
        b=CpcK6Xq8AQBsTaC8iTZlqnR8WjvsgkNpaBKHPZ92mhk8SAINSyuE9MQFiQDOCFqelq
         syIFpWnoX5v17c33IHU42AIWdXsqxknNcVCemBLKZ5kqgg7ZOyI9nI5owWpHxiJnizgs
         xb9RQPWHyHxo9U3d2N4cjnzbTnAVR/fRhlrlo8tYS2y/3nv8/DLm64VosxnpKV5nGxGP
         zdTHM+jcIhdUdXJHi2yumtTqrRP2NvKYtJiTvdrL23lm0O0QAyOw1/8YDiGtYVZMiE+t
         6tsha6IiR+LufjAXv6PdnYXVY1Po67cu4UmxJgb0HTANKPp8YNECGnYdOZncLdK23hd7
         lW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JZwTxIjZdK3eeeynNetfRffvQYVNIdx1KtctWmB4uOs=;
        b=MPrrF3JYBKyy8rtwm1+orLUSAXNCpeg1Egr5ccFjre6vM00r/0m0JXJEvMVwUUeRgo
         Bu1tiz8G+MT/IxFyAg7Zhw6frYymwWorQRH38FZWSmk1cmRxqv/XfmZgITlxUcgGH/R0
         2lA15FSFQ2mE99ORXiQYqSMZ1yLyNz5MF+JTX7r5FSef9Lkdb0dw2zrmDCjUC2/zuMi7
         CrahbSAZ8WRkTnVps5GbJUroENKoYWzZUjA2QL8px2O1+bqS4ehfI0nWX9rRuy5yFQY7
         KinkguX4qGtDnr+MlAUbfnybe2F4RD5sEfURaY9WVwFhdyXXnxmFJqpai3QKWu1fChW0
         KP7A==
X-Gm-Message-State: ACgBeo2zvpjcNDSQZrE3wF0c/TXWD6oJ2JDz/G/KkKowpSS00Zm6j2PY
        Bm/TOFi5xKGwoaA66UK+54c=
X-Google-Smtp-Source: AA6agR6QkMVDyEgNBZF3cqgm5OpS+kC4fttvctAVRZu0j6scYhiBr/ZlSJt2hCbEzdWzBjjUTEYvlQ==
X-Received: by 2002:a17:90b:164f:b0:1f5:4ced:ed81 with SMTP id il15-20020a17090b164f00b001f54ceded81mr11603530pjb.122.1660880109850;
        Thu, 18 Aug 2022 20:35:09 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-41.three.co.id. [116.206.28.41])
        by smtp.gmail.com with ESMTPSA id e66-20020a621e45000000b005251f4596f0sm2397774pfe.107.2022.08.18.20.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:35:09 -0700 (PDT)
Message-ID: <8b8f463d-092e-fad2-e812-68a44b2dc362@gmail.com>
Date:   Fri, 19 Aug 2022 10:35:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 06/13] Documentation: coresight: fix a documentation build
 warning
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        corbet@lwn.net
Cc:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1660829433.git.mchehab@kernel.org>
 <ff5c57f03d106dc5cc14448ec0db224267fb1bfb.1660829433.git.mchehab@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ff5c57f03d106dc5cc14448ec0db224267fb1bfb.1660829433.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 20:38, Mauro Carvalho Chehab wrote:
> Using wildcards for cross-reference doesn't work, as the Sphinx
> automarkup plugin is not smart enough. So, changeset
> c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
> tried to fix it, but at the wrong way, as it the building system
> will keep producing warnings about that:
> 
> 	Warning: Documentation/trace/coresight/coresight.rst references a file that doesn't exist: Documentation/devicetree/bindings/arm/arm,coresight-
> 
> As automarkup will still try (and fail) to create a cross reference.
> So, instead, change the markup to ensure that the warning won't be
> reported.
> 
> Fixes: c06475910b52 ("Documentation: coresight: Escape coresight bindings file wildcard")
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/
> 
>  Documentation/trace/coresight/coresight.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 4a71ea6cb390..826e59a698da 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -130,7 +130,7 @@ Misc:
>  Device Tree Bindings
>  --------------------
>  
> -See Documentation/devicetree/bindings/arm/arm,coresight-\*.yaml for details.
> +See ``Documentation/devicetree/bindings/arm/arm,coresight-*.yaml`` for details.
>  
>  As of this writing drivers for ITM, STMs and CTIs are not provided but are
>  expected to be added as the solution matures.

This makes YAML wildcards be inline code. LGTM.

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
