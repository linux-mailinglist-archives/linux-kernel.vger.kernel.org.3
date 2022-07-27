Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84E2581CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiG0AN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiG0AN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:13:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F94D2C67A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:13:56 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e69so12516433iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R2qD9ax08h9nKFO1+IcTWhLCwKpkzgVVPrZ1uEJXMzU=;
        b=O39nmq3Fa3xXO2eNr2WDsfIOFsBx/Agfx0G7paz+IEzhMwjHOgWPgKuW9UDzGUGcVN
         BLCHzlVtcuFd1lHCKyTH+zKIySPD2inblpqIDGJWxaXTvNVSTLqyLqe898w2cBawQap5
         YVgewCoXMLGo6FU3BwqduskKqmpzpl6u5x9zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R2qD9ax08h9nKFO1+IcTWhLCwKpkzgVVPrZ1uEJXMzU=;
        b=TgWDr72znciEz3R23PsAjHLWUHEFV5xYC1BDBRXruk4l/uXJzjazOEgXvmdJZne8RH
         Y7bXHGqeshNeBy5tHjzbrweazWEUAD45flMOtHKU+U+YtKZkL58H7+9ZvTFHlKKgjWk1
         GPuplkO3kUAAexn1lSnRpKJjmDmXRRWxGPYyXf2euBi7lMJDucJtC7eVdkvVGyHC+S4n
         iW3C8CrNExbv0hohyjmHm/xJLZTjLUmzaUcoIvb6ZUMrCjQYhY7c7kWlk1t+IAPh5Hkz
         +N0PvGFdAmOTWagtHsU/iK0dyGqQJQVRrg63aGtrjtTq7/sVtm4AJfANjZVoCatp778J
         bFmw==
X-Gm-Message-State: AJIora8n6eUXrtmG2xAXQEOyOMtbVbMdSCEOTG2i2YMdswql0yODNhvn
        /wSgNPZa/oYBoIT0zna2a0bTfg==
X-Google-Smtp-Source: AGRyM1vH3cJG6PYumk1AjyMd2TV9Hzppapg1EgTQOvu2+RZBu5ZKQdBtQKOp3uTHLvR9/RYndv5f1Q==
X-Received: by 2002:a02:b697:0:b0:341:5553:ae49 with SMTP id i23-20020a02b697000000b003415553ae49mr7617346jam.109.1658880835497;
        Tue, 26 Jul 2022 17:13:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z27-20020a027a5b000000b003322a709c7esm7272755jad.30.2022.07.26.17.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 17:13:54 -0700 (PDT)
Subject: Re: [PATCH] Makefile: replace headers_install with headers for
 kselftest
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Tim Bird <Tim.Bird@sony.com>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <a7af58feaa6ae6d3b0c8c55972a470cec62341e5.1657693952.git.guillaume.tucker@collabora.com>
 <f35a71d6-bd96-7aa9-c143-39ae88bc85d5@linuxfoundation.org>
 <8fc9d169-78ff-0fe4-67c0-784097861f12@collabora.com>
 <CAK7LNAQ4iMBwu4bOmmOrMudNH49ruz-7AK_H3-ceTixd=G+brQ@mail.gmail.com>
 <81241d70-7952-2f55-9181-d18679068998@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8a3c18c5-2abc-9ea2-0867-95b31d45da1d@linuxfoundation.org>
Date:   Tue, 26 Jul 2022 18:13:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <81241d70-7952-2f55-9181-d18679068998@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 11:31 AM, Guillaume Tucker wrote:
> On 19/07/2022 17:06, Masahiro Yamada wrote:
>> On Tue, Jul 19, 2022 at 9:37 PM Guillaume Tucker
>> <guillaume.tucker@collabora.com> wrote:
>>>

>>>
>>> Masahiro-san,
>>>
>>> A you OK with applying this in the kbuild tree ahead of the
>>> upcoming merge window?
>>
>>
>> No.
>>
>> This is a fix-up patch on top of the previous one [1],
>> which  was applied to the kselftest tree.
>>
>> This cannot apply to the kbuild tree.
> 
> OK thank you for confirming.
> 
> Shuah, I guess you're happy to apply it to the kselftest tree
> instead then?
> 

Sorry for a late response due to time off. Working through my Inbox.

Applied now to linux-kselftest next for 5.20-rc1.

thanks,
-- Shuah


