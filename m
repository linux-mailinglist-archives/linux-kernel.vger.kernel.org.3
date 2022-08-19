Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C58599807
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiHSI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347898AbiHSI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:58:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D4D87CA;
        Fri, 19 Aug 2022 01:58:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y4so3623446plb.2;
        Fri, 19 Aug 2022 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nWaJnY+l7BaR73wsAx3UWKzK5S7csngJ+iHmS6igh5w=;
        b=VFaYIMiguTV6F5C0msAYjc7i3JnNpfV5c6Gn0NF9J102niQQ9Vr5VqE8UUKvZuCQIb
         GA/m+FE9hXDBPCSftQueIwfbY0xohgGAxtytNwF56kA0vcN8h/3E0OAi8LdkNvyWDJWy
         NBKy2e2uIwXPhfbsDt88wBWYbua4SesIT2+qBuxUY96jPn9ve9rzihW2aPKGtPO/Fzlz
         hH7dDU3Tg83gqR4UpN+e+3TdxNPwBCxgwAqQK/HEBfX1SZfhzSJOyVJ3qHM21VjNuSnY
         PcCtxDf8cN2dC3MpnBfbGysWOYmY5VqBOZywbdKMSqJ005OsN4xxJIjvrbSA/dIv2bLg
         /4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWaJnY+l7BaR73wsAx3UWKzK5S7csngJ+iHmS6igh5w=;
        b=nVVOHS1jOQZQyZVQbNF+xqKqEGzr1PIwa5Y8TQpj4aYaGuFxn5fUEroWKwamWQqSsj
         Ek+GUKW6t10CqAQ48A/QOIZOZIURTyNOqprY+5SweXeN/33M660VL+PPlCdYO6n9l1CK
         FFEUZSVwx+tIxgobwHcVw7ZQEnQciWV6S+eE3K8JnIj/p2lGCVxHwA4BVEG0Q/A/s/IH
         qloJLUciI/L8SnU7Xx9JgUhqTXzqcHFLNejZIpwMSoFBuWTi6sifc2JEaOs8u+abhnUb
         fTlzKwKS+AKKLngLYKZPTKleTjQ7uihFb/b6w6db7HhozS0EMO/iWK0O2DKXCEqwTmI/
         3tRQ==
X-Gm-Message-State: ACgBeo0D6BUi2ey/okkqvRJFXMieseo5px1wTGE4c5VyXCnsD20c889x
        1VxPO/2evRmDxGfVZsZjRzkrpv9WJgk=
X-Google-Smtp-Source: AA6agR6q5ONCG2ueuWev3RJd3j6DwcTj9Kzi/o2D0bvWo8WVDZ3K1W3YsDf7NLr/oakCI+ZgkhzgyA==
X-Received: by 2002:a17:90a:c782:b0:1f7:a4ed:11a1 with SMTP id gn2-20020a17090ac78200b001f7a4ed11a1mr7501758pjb.12.1660899526766;
        Fri, 19 Aug 2022 01:58:46 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id i8-20020a63e448000000b0041c35462316sm2490349pgk.26.2022.08.19.01.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:58:46 -0700 (PDT)
Message-ID: <831ebaf6-6fea-65ea-aa60-c47f6f05dbb0@gmail.com>
Date:   Fri, 19 Aug 2022 15:58:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 2/3] kconfig: allow to choose the shell for $(shell )
 functions
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819065604.295572-1-masahiroy@kernel.org>
 <20220819065604.295572-3-masahiroy@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220819065604.295572-3-masahiroy@kernel.org>
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

On 8/19/22 13:56, Masahiro Yamada wrote:
> GNU Make uses /bin/sh by default for running recipe lines and $(shell )
> functions. You can change the shell by setting the 'SHELL' variable.
> Unlike most variables, 'SHELL' is never set from the environment. [1]
> 
> Currently, Kconfig does not provide any way to change the default shell.
> /bin/sh is always used for running $(shell,...) because do_shell() is
> implemented by using popen(3).
> 
> This commit allows users to change the shell for Kconfig in a similar
> way to GNU Make; you can set the 'SHELL' variable in a Kconfig file to
> override the default shell. It is not taken from the environment. The
> change is effective only for $(shell,...) invocations called after the
> 'SHELL' assignment.
> 

Hmmm...

Can we say that if we run SHELL=/bin/bash make nconfig, Kconfig will use
$SHELL but we can't set it as environment variable?

-- 
An old man doll... just what I always wanted! - Clara
