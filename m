Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83FB528430
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiEPM2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbiEPM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:28:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FFA2F389
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:28:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so25472892lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l7Fo0NeV7YueiEmkqNM4ZujNOBF0kyGi5nhK9D38CaE=;
        b=iiwL2Jqvlxyr2hAuSFDNP8tiNHrlQxAX6X5eXc/cmjVuAYKf/iJzMy3/a+Qcm5JmQL
         ANO+Qp7/aXRFbYOyyTTLldnKd18zxolxl4isMaGC4vJQu/+9sbuJytY3Ypx90mj8zQC4
         tzNBayxdsgod0IQH/BUq/qfbBMJ0FzLwTtHS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l7Fo0NeV7YueiEmkqNM4ZujNOBF0kyGi5nhK9D38CaE=;
        b=DjeuEKhTkzU/Hgjl887T6nKTj9ol2c6a/n90SGmF5D+sVWJW1xIjtRf6VFu4GZCOBE
         88Z9bCEbYBVxLINWOTu81VcBr4vyl7RTcVUcWGhMwNix13qg1NWGJWDXJIFYbLI9FzQG
         WZoguyeDYm/eYdfLRo1gdOl9pizR7Qrf41RNXpbMe777qpMBvyHXgDLjXFEVVeKvb6Pq
         uCdKyx7SwVS1eWstpN2RA8XE61Nii4OQswUsG4YGTdm8ceYrK5c/OHwhehWV+jd6frHr
         UdNVzDitXgGtIX+z+pOfWys2kxx5i7GWuEyS28xdlgQ3+mc517fSudVXgU4hvwC5TJ48
         60GA==
X-Gm-Message-State: AOAM531HkQ3iLEnr3njcrUeeA0r9mnWotXzha8S6jbDrU7ZN3RyWiZv7
        +x82x2it61BmfQlLq7eYSqGKhg==
X-Google-Smtp-Source: ABdhPJw4BLL5Yn4P0JiAebR1HlqACpRsi83Tuc5vArRTpPHSHMnS0jRcMj9vnWN/D0VLd8H8S3aGnA==
X-Received: by 2002:a05:6512:2391:b0:473:ac1e:f2ce with SMTP id c17-20020a056512239100b00473ac1ef2cemr12881841lfv.297.1652704104659;
        Mon, 16 May 2022 05:28:24 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 27-20020ac25f5b000000b0047255d210desm1296280lfz.13.2022.05.16.05.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 05:28:24 -0700 (PDT)
Message-ID: <9bd2db3e-2955-66ba-574e-7976bdd95a8e@rasmusvillemoes.dk>
Date:   Mon, 16 May 2022 14:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 07/21] cfi: Add type helper macros
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-8-samitolvanen@google.com>
 <202205141447.E3B5A29@keescook>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <202205141447.E3B5A29@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2022 23.49, Kees Cook wrote:
> On Fri, May 13, 2022 at 01:21:45PM -0700, Sami Tolvanen wrote:
>> With CONFIG_CFI_CLANG, assembly functions called indirectly
>> from C code must be annotated with type identifiers to pass CFI
>> checking. The compiler emits a __kcfi_typeid_<function> symbol for
>> each address-taken function declaration in C, which contains the
>> expected type identifier. Add typed versions of SYM_FUNC_START and
>> SYM_FUNC_START_ALIAS, which emit the type identifier before the
>> function.
>>
>> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> And the reason to not make this change universally (i.e. directly in
> SYM_FUNC_START) is to minimize how many of these symbol annotations get
> emitted? (And to more directly indicate which asm is called indirectly?)
> 
> What happens if an asm function is called indirectly and it doesn't have
> this annotation? 

Presumably that's a fail.

I'm also interested in how this works at the asm/linker level. I assume
that the .o file generated from the asm input has
__kcfi_typeid_<function> as an undefined symbol; the compiler emits that
symbol as an absolute one upon taking the address of <function>, and the
linker then has the info it needs to patch things up.

But what then happens if we have some function implemented in assembly
which for whatever .config reason never has its address taken in any .c
translation unit that gets linked in? Does the __kcfi_typeid_<function>
symbol silently resolve to 0, or does the link fail?

I can't really imagine the compiler emitting __kcfi_typeid_<function>
symbols for each and every function it sees merely declared in some header.

Two different .c files both taking the address of <function> should of
course emit the same value for __kcfi_typeid_<function>. Is there any
sanity check anywhere that that's actually the case?

Can we please have some objdump/readelf output from some .o files
involved here?

Rasmus
