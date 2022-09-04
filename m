Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D925AC253
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiIDEVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIDEVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:21:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF11F603;
        Sat,  3 Sep 2022 21:21:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y127so5693083pfy.5;
        Sat, 03 Sep 2022 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KOCmeCOmCproKzPB5kG3OeB8CLLbxI0u7IFRDyHEKhI=;
        b=CtnghyDNGabGTEYePnFVXhcKJyISoXtJgXWlUZa6QP/h6WBU6jZF0myKuUwTVNFYwg
         ko72WRJHCCh6cnuIQe8mfl4umlI0Sw0jkOSKoBxZFjd+0QlknkrPV4/1V3gO1O26SxrM
         xZ8r6yo3XkLAgRJyr2zGtVNGGG+gwkegjT9F66a7PwfWSnnHzEMmcZ4Hq9mO6s7vEXDx
         lRM7AwcDpA6eYanvInxLgTH9NtLjJbQ6fNlKuwXS8CTy6vz55LBcDq9fNbjJunatGZ3d
         FRKKDuScJTZS796r4agAIYqwZvAniZU2OBNpDOCSfvryN/2Jiw5GwGfHcIE7QrK899Iw
         hE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KOCmeCOmCproKzPB5kG3OeB8CLLbxI0u7IFRDyHEKhI=;
        b=fLKB+pDntgDhultrOcB55XmtN6/huQTllVA8CbxDcrKJPxDtlXO8pXBphqUfixAHIL
         7sShd5ZmcWap43qNS5GblG7/lw3Nxm8VeBVUO87CrEQPpN2yUHeNP1H/FsiQ81B7JE84
         fAnhu+uzVZ+cJFfaypUg/z5uUWbRRTeorqr605F/JRXdN6jT5wdVX9I/wsOgSx+SSmws
         uwoI/PGalvv8RGKyxVc6GEkbmHE1ieQ2vrkZ+Khs4O1cZVMqYuFD/BPFACZb8Pd55FCw
         JcEDdkF+yMNfFun9ogwvZf0Pn22cAzWNjn42x3ZNMWfnCf4DNBjMTjEBbixFwM1LEfVm
         i9+g==
X-Gm-Message-State: ACgBeo3ll4oqrotpW3k7haVdkbfmK1FFZ054VIraxhpeSu59LadlCy2Y
        3HB/YDOSHiMzTbF3q+6Msjo=
X-Google-Smtp-Source: AA6agR6hYZTrBTkQDJUvLxug9VjHl2U7wqhCxdOP0fZhzFz4LN8BZe62Mra7ccoVXm6UQ4BWC3/T8A==
X-Received: by 2002:a62:1ac5:0:b0:538:3332:d531 with SMTP id a188-20020a621ac5000000b005383332d531mr32734750pfa.46.1662265277037;
        Sat, 03 Sep 2022 21:21:17 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-57.three.co.id. [116.206.28.57])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79f90000000b0052deda6e3d2sm4914291pfr.98.2022.09.03.21.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 21:21:16 -0700 (PDT)
Message-ID: <d17bd7f8-a70e-dac3-be69-3cf10c2f19e4@gmail.com>
Date:   Sun, 4 Sep 2022 11:21:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] string: Introduce strtomem() and strtomem_pad()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220902224951.2625138-1-keescook@chromium.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220902224951.2625138-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/22 05:49, Kees Cook wrote:
> +/**
> + * strncpy - Copy a string to memory with non-guaranteed NUL padding
> + *
> + * @p: pointer to destination of copy
> + * @q: pointer to NUL-terminated source string to copy
> + * @size: bytes to write at @p
> + *
> + * If strlen(@q) >= @size, the copy of @q will stop after @size bytes,
> + * and @p will NOT be NUL-terminated
> + *
> + * If strlen(@q) < @size, following the copy of @q, trailing NUL bytes
> + * will be written to @p until @size total bytes have been written.
> + *
> + * Do not use this function. While FORTIFY_SOURCE tries to avoid
> + * over-reads of @q, it cannot defend against writing unterminated
> + * results to @p. Using strncpy() remains ambiguous and fragile.
> + * Instead, please choose an alternative, so that the expectation
> + * of @p's contents is unambiguous:
> + *
> + * +--------------------+-----------------+------------+
> + * | @p needs to be:    | padded to @size | not padded |
> + * +====================+=================+============+
> + * |     NUL-terminated | strscpy_pad()   | strscpy()  |
> + * +--------------------+-----------------+------------+
> + * | not NUL-terminated | strtomem_pad()  | strtomem() |
> + * +--------------------+-----------------+------------+
> + *
> + * Note strscpy*()'s differing return values for detecting truncation,
> + * and strtomem*()'s expectation that the destination is marked with
> + * __nonstring when it is a character array.
> + *
> + */

Hi,

I don't see the strncpy description above rendered in htmldocs output.
Instead, I got:

```

char * strncpy(char *dest, const char *src, size_t count)¶

    Copy a length-limited, C-string

Parameters

char *dest

    Where to copy the string to
const char *src

    Where to copy the string from
size_t count

    The maximum number of bytes to copy

Description

The result is not NUL-terminated if the source exceeds count bytes.

In the case where the length of src is less than that of count, the remainder of dest will be padded with NUL.
```

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
