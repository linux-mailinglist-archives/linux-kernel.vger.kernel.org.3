Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4D4EA313
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiC1WiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiC1WiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:38:08 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B547559
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:36:24 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g21so5738826iom.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AExd4vaFTbJ590yLTEsxZaq1Tm0Bzwb1nLh9ynuGeIw=;
        b=DTRFn7+l1UKGJysQuFvGqP5W+I598Bx27SczkLubNCt0VlS2qdgUPay/HmX8b6XpGC
         PTu66/GD01WGJz9u0XQ35hx2zataUVLZX413a+wYt3JptVnM1+bb2pnMkZFqWgVlM2je
         s4wGDP20Dm3uuXw4kmJXTzk4OU+xgUe94XwiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AExd4vaFTbJ590yLTEsxZaq1Tm0Bzwb1nLh9ynuGeIw=;
        b=DiIPfts/YQR/xVc6vDBNScmoG/vDO/dpgwY8mIcEq6xhUdpOuLmrxsu2Fa7O/8dmYj
         o6jLCcaWvf14+yQHclwc2qgxPLSwm3rT8LRJsEBtYsX3Cx/S4kp5nDivos5Akh/Yhvij
         UZhtNgi//mMxa3tPFSfyw/W1aQRypqwld6bfQWvNn/UYxRnNvoqBcmfb5HQqJSPQDhbk
         DkhY5NzVO6r9ldMH9jeJaZrUGvqKvauqRXL57sxlLcpXq9nvwQD13XjVc+COMLel++vW
         wDYnSqTmLznoK7vx6i5eCCfzY/ubYBVL1s0DL0BTeMXGOsr2nADv57YO+XU3Rbi+0QDm
         uHLA==
X-Gm-Message-State: AOAM531URk6kzWFIMpIxNd/9pg2bTfxKrqN1r960DyHT8CXHbPGqDMtn
        KoXnLLFn51p6laOu+2ACK00P1Q==
X-Google-Smtp-Source: ABdhPJxHgbesdx6T5wcEa6Fn7Cv//g3Oqi2VOyXANaYIxT1Jk5KGVgEj1yKkQN/+2BN4fxIYPra8Lw==
X-Received: by 2002:a02:cb0d:0:b0:321:4041:f680 with SMTP id j13-20020a02cb0d000000b003214041f680mr13781718jap.162.1648506983900;
        Mon, 28 Mar 2022 15:36:23 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y20-20020a5d94d4000000b00640843474e2sm8434240ior.10.2022.03.28.15.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 15:36:23 -0700 (PDT)
Subject: Re: [PATCH] Documentation: dev-tools: Add a section for static
 analysis tools
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, corbet@lwn.net,
        mchehab+huawei@kernel.org, dlatypov@google.com, davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6f1e410e-4b35-eb37-153a-8f5959ef0a49@linuxfoundation.org>
Date:   Mon, 28 Mar 2022 16:36:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 3:19 PM, Marcelo Schmitt wrote:
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Hey everyone,
> 
> I think this patch can be a good addition to the documentation as
> discussed in the thread for the testing guide documentation page:
> Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/
> 
> If you think it would be worth it, I can try making something more
> elaborated. Maybe provide some guidance on when to use each tool.
> I've been studying how Linux device drivers are tested.
> Here's a post I wrote talking about some testing tools.
> Link: https://marcelosc.gitlab.io/how-is-linux-tested/
> 
> Best regards,
> Marcelo
> 

This a good addition to the testing overview doc. Please see a couple of
comments below

>   Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b00511109a9d 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
>   Some of these tools integrate with KUnit or kselftest and will
>   automatically fail tests if an issue is detected.
>   
> +Static Analysis Tools
> +======================
> +
> +In addition to testing a running kernel, one may also scout for bugs by
> +analyzing the source code semantics. Three tools are well known for serving this
> +purpose.
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +> +Smatch extends Sparse and provides additional checks for programming logic
> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +We also have Coccinelle as an option within static analyzers. Coccinelle is
> +often used to aid collateral evolution of source code, but it can also help to
> +avoid certain bugs that have been expressed semantically. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +These static analysis tools support running tests on the whole source tree or
> +over a specific file or directory.
> 

You can also add a couple of sentences along the lines to clarify why static
analysis is beneficial:

"It is easier to detect and fix problems during the development process."

Also add a word of caution:

"Static analysis tools suffer from false positives and errors and warns need to
  be evaluated carefully before attempting to fix them."
  
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
