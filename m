Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F545AA556
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiIBBxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIBBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:53:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05EA927A;
        Thu,  1 Sep 2022 18:53:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so723263pgs.3;
        Thu, 01 Sep 2022 18:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AO+iD8/ND+0+YgmXrFc7bXRlSy/yl/dmt5F+NlX7ri0=;
        b=op8Taa6drdciJKjFm46xGztxaYxY6UY11Y7IBFgfd/2C+pbRhmFlz8EH48Lnh1qa9p
         KVxI2NAXssheZNNVVEHBRxoIPc0QPTyfZZmccm4rn+ZmVl8XbyKZJIlk2IunXL6EjflQ
         uPQ1owHyBpNIqa/h5GCi9lwOtiEF1Dxwt08TQtKFHcyNP5223g25IyynhgBFzvTBi8tB
         YwClvnCGR7UUgPpJuSslqwXNPXDQf0UO2OTR1PJyhPerz02SM5bbmENgQa0R0Yw18R1D
         FQ/YSKFciCu8nCxwtqf8imOiPpxGDLP3C17kAMGCcG0iB0uFzO/JTu8nMsGEZMMjCsHk
         Gf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AO+iD8/ND+0+YgmXrFc7bXRlSy/yl/dmt5F+NlX7ri0=;
        b=YpXjZ10F3Fha0oOyav4J86sWMeOTe2h2UPaP+BSsDsbV595VJX920cfZppqy888Ipl
         RiU/i/lXlOhw/vHavApCsCKyMB9ItyznlQyTL2nvMvdBZ/B2JL3KFMYevGf/QptTc+UU
         FkxcQENWuc9E16u+iQo2xnGjplwLUvNdPEmdM4QZ5+h5fteF73niebDbCbWurgmS7aGf
         OH7h7jjXPFCnfP11RnSktOuhY+bGWqhdy7Or0s6NETSLtvzXJj6ROWmkyyahybhxnCGz
         rmPbtBbV57JgOOizq+Q8mWKE2SW7m2h8yD4wQtCfGO2IyjPVYLVGVpdajvdiqL6vXJCp
         I8pQ==
X-Gm-Message-State: ACgBeo3KsVAZCJqIBNZymlRt60GeEQkf9UtlaqcY2cX5ec8nX64zpPRM
        PD/rJ/dlwO37yNPLEJYXuvQ=
X-Google-Smtp-Source: AA6agR55VB8kobBINExhpqw6xUyQgHx5tu5ajEBmpC+2oGJQSX7q6Q+GJVQkNw2f21a3Zb1yKew05w==
X-Received: by 2002:a62:b614:0:b0:537:6d2:85e0 with SMTP id j20-20020a62b614000000b0053706d285e0mr33826053pff.40.1662083619775;
        Thu, 01 Sep 2022 18:53:39 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-57.three.co.id. [116.206.12.57])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b001755ac7dd0asm232158plc.290.2022.09.01.18.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 18:53:39 -0700 (PDT)
Message-ID: <88e8b096-aa04-2447-cb21-a83b5e57e963@gmail.com>
Date:   Fri, 2 Sep 2022 08:53:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] string: Introduce strtomem() and strtomem_pad()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220901190952.2229696-1-keescook@chromium.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220901190952.2229696-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 02:09, Kees Cook wrote:
> One of the "legitimate" uses of strncpy() is copying a NUL-terminated
> string into a fixed-size non-NUL-terminated character array. To avoid
> the weaknesses and ambiguity of intent when using strncpy(), provide
> replacement functions that explicitly distinguish between trailing
> padding and not, and require the destination buffer size be discoverable
> by the compiler.
>> For example:
> 
> struct obj {
> 	int foo;
> 	char small[4] __nonstring;
> 	char big[8] __nonstring;
> 	int bar;
> };
> 
> struct obj p;
> 
> /* This will truncate to 4 chars with no trailing NUL */
> strncpy(p.small, "hello", sizeof(p.small));
> /* p.small contains 'h', 'e', 'l', 'l' */
> 
> /* This will NUL pad to 8 chars. */
> strncpy(p.big, "hello", sizeof(p.big));
> /* p.big contains 'h', 'e', 'l', 'l', 'o', '\0', '\0', '\0' */
> 
> When the "__nonstring" attributes are missing, the intent of the
> programmer becomes ambiguous for whether the lack of a trailing NUL
> in the p.small copy is a bug. Additionally, it's not clear whether
> the trailing padding in the p.big copy is _needed_. Both cases
> become unambiguous with:
> 
> strtomem(p.small, "hello");
> strtomem_pad(p.big, "hello", 0);
> 
> See also https://github.com/KSPP/linux/issues/90
> 

Should'nt strscpy() do the job?

-- 
An old man doll... just what I always wanted! - Clara
