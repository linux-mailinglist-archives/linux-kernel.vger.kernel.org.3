Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8ED4F07FC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346578AbiDCGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiDCGAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:00:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EAE287;
        Sat,  2 Apr 2022 22:58:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t4so5718416pgc.1;
        Sat, 02 Apr 2022 22:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YXwQ+k39kV8MTJdL0uwWm6r+cjDkWPDQbE11claVeoE=;
        b=OoRx6DVEbSCME9Spbp+EEF3z8Cq8UkNCpcTD5zx4/gAyUIdZLI4PGHtrakwMR6a1NP
         0pjGuFAVjS40+x1EkolRh9s18J/SWxSvEQw2VJg/4zPdVLU1Mvd+rGDDaZTI6mw5dhYw
         DBhx7/JVFpxdK8ovNYAue3R2/E6jvlAQVqr5TtsfuJ6D/jhJ0U94t/LKrZat+UQHM5em
         JKEyovUPV7BuxoO12dj10h6B1pLFnxUFB9SIo8q4msuGFHmjmifOI2mpznjUJKoU4EIk
         xqqwZPxdYyPT0BuAShn8gnTacyFtYy3wu7HAAR7/tX2hdbV7Y+ni1TogOuPZ5yXe/rdL
         Uqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YXwQ+k39kV8MTJdL0uwWm6r+cjDkWPDQbE11claVeoE=;
        b=FTqvod6CcMe9glpwp9UWwjUdpd0XC1dyZwbgYtuLvGd1Im/+do1aAqVJyR/4AZzoFS
         vNiW9eqrHyL2IbeHeqRcP+k+VLi859JNrAt6jp9hPd0QgMcSxHAiPZtw+9Ve7P61/ELh
         KqRderedbFxPFROxMrLvXNnY9M2aPR7ZgTpwzlbcoNhXyh7FBVElK2/9lAh3eNC3Jdq6
         mX2D2AfbB+5veSK61sgcCQvTCSSLEHPQmTGfYyeOqlTlg7lfjI0gD0jx1W74Ejurr5l3
         DnG/oD0vEuxXercXxKp9t6EyNHbsUxZ2LcyRl2EodX4DoWyZmcAHNqwyZdc6SMJ9gC36
         K5mQ==
X-Gm-Message-State: AOAM5316wgSY6wA8cBCJqWwPQnJ+N2LzN8bVdSHAvyxOQ5p7o1rqkbsT
        894MlTQ+vu2zVgp4Lk2aVP4=
X-Google-Smtp-Source: ABdhPJwHmDnHJZLVAAjdOzUFr0Lf8D2K3vLpnvrmujIr7Enj1O9SPTwX+R/SIwB1tk+Y4WvvVkvyUw==
X-Received: by 2002:a63:5ce:0:b0:382:1f05:c8b1 with SMTP id 197-20020a6305ce000000b003821f05c8b1mr21131901pgf.19.1648965499591;
        Sat, 02 Apr 2022 22:58:19 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a005000b001c7511dc31esm6610845pjb.41.2022.04.02.22.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 22:58:19 -0700 (PDT)
Message-ID: <c3ea5966-cfc3-8e36-3f0d-dbaf1b1665b9@gmail.com>
Date:   Sun, 3 Apr 2022 12:58:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation/process: mention patch changelog in review
 process
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>
References: <20220402100706.57507-1-krzysztof.kozlowski@linaro.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220402100706.57507-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 02/04/22 17.07, Krzysztof Kozlowski wrote:
> Extend the "Respond to review comments" section of "Submitting patches"
> with reference to patch changelogs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/process/submitting-patches.rst | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index fb496b2ebfd3..9bb4e8c0f635 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -318,7 +318,10 @@ understands what is going on.
>   Be sure to tell the reviewers what changes you are making and to thank them
>   for their time.  Code review is a tiring and time-consuming process, and
>   reviewers sometimes get grumpy.  Even in that case, though, respond
> -politely and address the problems they have pointed out.
> +politely and address the problems they have pointed out.  When sending a next
> +version, add a ``patch changelog`` to the cover letter or to individual patches
> +explaining difference aganst previous submission (see
> +:ref:`the_canonical_patch_format`).
>   
>   See Documentation/process/email-clients.rst for recommendations on email
>   clients and mailing list etiquette.

What about range-diffs?

-- 
An old man doll... just what I always wanted! - Clara
