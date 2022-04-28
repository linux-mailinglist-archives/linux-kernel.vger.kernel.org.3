Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825C512B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbiD1Fpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiD1Fps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:45:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EF4EA36;
        Wed, 27 Apr 2022 22:42:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g8so948655pfh.5;
        Wed, 27 Apr 2022 22:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=FqD5G36biLawWcOes7LrqV4VL0YSmtfbCjVowyib5Tc=;
        b=D/Ama1fcdeoRZtw8N33NtAqBl1jMIazAhX86YxYuBHV3PqmlcV2WMfxpSC4rwU91hg
         wuT9ldYztHDmx512Ha94LzfDUxznl0OYxYBV5nj489TswcRBKJxC9wzsemKgHpGk8Fsi
         8vqXNZCQNEVFMzifw4NaPgZqtvL/JOc980zoB7SvqWtkwa5zJgiH8L1YxP4EIw7Pw92I
         0xp5M9q9xM7nFdM7RZDUoyVGElZD6hMoPR4JXf/avbFyijzPLeF7V/w7op5vP8SCZwFk
         N3VTydXcWBgtr+8NU/QRhwUSDlJKvIZ0LP14ARyjjt5wd9WXwhS7oSSvQn3Rw13dfiRv
         m1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FqD5G36biLawWcOes7LrqV4VL0YSmtfbCjVowyib5Tc=;
        b=0CVge1/lfiG3KzOjjo6JYvE6E2DoARhhRbKo+3USJ8FkIx8g9yrX9gmS/yQ+0sF81r
         SMKUlX4obVsagAiECl4NX4E7FK/q+Wth6qpohlS3yyUNzyd9x4+902RV3z9cMofN51W3
         p3nc7DGqu2YkWmUxcFXuzFFSg/9Xxphy++VgdtIs6diJypWmTISaT0/ALx0zmLyMyQOZ
         Nl5kXBRnSopcNf1S9GWojQLN/+Ie+l6osNXKBNUaEv3UmWjNngssEIGeV8swvYNowgqr
         4xbqseLobDDoESJqHWzobvCrA8WlkCAzxRxDk7PGQL73AVTCBcZMzpYpYtnbW1XW5Vqy
         86mg==
X-Gm-Message-State: AOAM530wGYJFDrz83kDt+C5dhcsjfFImWxOEG0Rl1rBWtVkACOG5XuFc
        TLQp1FLxJS8Vh4XO4/GiRAVhkaWPMlTi/w==
X-Google-Smtp-Source: ABdhPJzMnYJWW2LdHUoSWxcBBpfWjIMRID/ho7nbxjsETdFiBNyvLMaahUmeHilYfB4of0Du+hVWhA==
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id bk3-20020a056a02028300b00342703e1434mr26633013pgb.74.1651124553764;
        Wed, 27 Apr 2022 22:42:33 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm22077701pfu.120.2022.04.27.22.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 22:42:33 -0700 (PDT)
Message-ID: <0d32cc45-bf65-e279-19f5-3db078ee8cc8@gmail.com>
Date:   Thu, 28 Apr 2022 12:42:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Documentation/process: use scripts/get_maintainer.pl on
 patches
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427185645.677039-1-krzysztof.kozlowski@linaro.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220427185645.677039-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 01:56, Krzysztof Kozlowski wrote:
> diff --git a/Documentation/process/3.Early-stage.rst b/Documentation/process/3.Early-stage.rst
> index 6bfd60d77d1a..894a920041c6 100644
> --- a/Documentation/process/3.Early-stage.rst
> +++ b/Documentation/process/3.Early-stage.rst
> @@ -154,10 +154,11 @@ that the kernel developers have added a script to ease the process:
>  This script will return the current maintainer(s) for a given file or
>  directory when given the "-f" option.  If passed a patch on the
>  command line, it will list the maintainers who should probably receive
> -copies of the patch.  There are a number of options regulating how hard
> -get_maintainer.pl will search for maintainers; please be careful about
> -using the more aggressive options as you may end up including developers
> -who have no real interest in the code you are modifying.
> +copies of the patch.  This is the preferred way (unlike "-f" option) to get the
> +list of people to Cc for your patches.  There are a number of options
> +regulating how hard get_maintainer.pl will search for maintainers; please be
> +careful about using the more aggressive options as you may end up including
> +developers who have no real interest in the code you are modifying.
>  

This raises my question: Supposed that I'm ready to send multiple-patch
series (two or more patches in the series). How can I get maintainers list,
given such series?

-- 
An old man doll... just what I always wanted! - Clara
