Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F72B52D00C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiESKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiESKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:02:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFEB9155E;
        Thu, 19 May 2022 03:02:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p74so1592071iod.8;
        Thu, 19 May 2022 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4V3FHl6Sp2rspEutBjNH83AvfS51jkWxQNxW2j1ppMU=;
        b=ebAe34nxtjgbtT9SueCzVUEURo1uYyacCjduzPaw8pjq+GBiBj/gz5dBhXwCHfF08J
         zSLzDaqN3iTAXRHnGaAoSmOk6xYzLm7lVcID2LiFZHo8aiYMBKHwWvC1FfvppqoQFHfN
         u381P7T7w6OUe4CsJmhVfAM/bjZVl1+2IV8HlKc6H77p29TjWAn1n7IapkdDkVUT9Fwi
         oK83FFISwtP6Y/9vxND1TjMD1I1JqwtM8BcGnVewx7QVdwTuvDAVMe4vT3ykc1Ka2i0I
         aqE0sGrzkMjDfVNUjjwXQlOA+RYjmew9xOc/zWm88U1mASieWFn8vCWMZFS1UdMtwIbA
         ubRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4V3FHl6Sp2rspEutBjNH83AvfS51jkWxQNxW2j1ppMU=;
        b=jH6riIa/tiP17o4FzLYTO+wM3ks0bF1TRrCKKSlXlJzMOE+aDF5oRTkYy+EBoc0Ob8
         UZSc0blmEPKd3Lk2geD+oE5EJ9Y2sAE8Mo7SUjYkRy1ZkVp5QVQINItVjGcUZuzfW12l
         lPEdtzjb13QuAaKfcKH6wmfGGR0FE8NooXyYkNp3B2H0/UU1bxSLEKbNgAmNUaEljYsK
         bkfCFnKwJz14B8rMNHtvJgyQnK0gOVWQTQDgYO2vedUD1a2lZ/vZ6h3gGe1Vl3gBlYdC
         62Xamu3i6VJX0WbSVhbub0VjEstomf2YscqwvxOCpDE0JtfiGcP3zHy3C+5JfZUwp2dl
         IZAA==
X-Gm-Message-State: AOAM533RAruYKOHOr57K/uap2/GRuxxiDuMjjAwwbRDW7r5Gbvc+YFX8
        BF34Y0IhHw8+4bXCW3VrLnXBbgUpLDDxAijCGTk=
X-Google-Smtp-Source: ABdhPJxMClNI3VhTzTuPg/LP/Sxa1eKhxOPBlicSYij2hBbdlTx4PNMn/auuO9yLdfrB+T0XTbYYDJmKzwhWUS8fecs=
X-Received: by 2002:a05:6638:1308:b0:32b:d5f7:62e6 with SMTP id
 r8-20020a056638130800b0032bd5f762e6mr2231414jad.52.1652954552359; Thu, 19 May
 2022 03:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
In-Reply-To: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 19 May 2022 12:01:56 +0200
Message-ID: <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC Kees and Salvatore ]

The Debian kernel-team ships a fix (4 hours young):

commit: 13e234d459c11946efba647c3daf15e03abb0d99
"sign-file: Convert API usage to support OpenSSL v3"

*untested*
Regards,
-Sedat-

[1] https://salsa.debian.org/kernel-team/linux/-/commit/13e234d459c11946efba647c3daf15e03abb0d99

On Thu, May 19, 2022 at 11:55 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> here, I am on Debian/unstable AMD64.
>
> Recently (or still) there is/was a transition to OpenSSL see below link.
>
> The warnings look like:
>
> 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> deprecated [-Wdeprecated-declarations]
> 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> deprecated [-Wdeprecated-declarations]
> 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> is deprecated [-Wdeprecated-declarations]
> 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> [-Wdeprecated-declarations]
> 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> deprecated [-Wdeprecated-declarations]
> 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> deprecated [-Wdeprecated-declarations]
> 395:certs/extract-cert.c:46:14: warning: 'ERR_get_error_line' is
> deprecated [-Wdeprecated-declarations]
> 407:certs/extract-cert.c:59:9: warning: 'ERR_get_error_line' is
> deprecated [-Wdeprecated-declarations]
> 420:certs/extract-cert.c:124:3: warning: 'ENGINE_load_builtin_engines'
> is deprecated [-Wdeprecated-declarations]
> 432:certs/extract-cert.c:126:7: warning: 'ENGINE_by_id' is deprecated
> [-Wdeprecated-declarations]
> 444:certs/extract-cert.c:128:7: warning: 'ENGINE_init' is deprecated
> [-Wdeprecated-declarations]
> 456:certs/extract-cert.c:133:9: warning: 'ENGINE_ctrl_cmd_string' is
> deprecated [-Wdeprecated-declarations]
> 468:certs/extract-cert.c:134:3: warning: 'ENGINE_ctrl_cmd' is
> deprecated [-Wdeprecated-declarations]
>
> More detailed output:
>
> 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> deprecated [-Wdeprecated-declarations]
> 190-        while ((e = ERR_get_error_line(&file, &line))) {
> 191-                    ^
> 192-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> been explicitly marked deprecated here
> 193-OSSL_DEPRECATEDIN_3_0
> 194-^
> 195-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> 'OSSL_DEPRECATEDIN_3_0'
> 196-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> 197-                                                ^
> 198-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> 'OSSL_DEPRECATED'
> 199-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> 200-                                                   ^
> 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> deprecated [-Wdeprecated-declarations]
> 202-        while (ERR_get_error_line(&file, &line)) {}
> 203-               ^
> 204-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> been explicitly marked deprecated here
> 205-OSSL_DEPRECATEDIN_3_0
> 206-^
> 207-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> 'OSSL_DEPRECATEDIN_3_0'
> 208-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> 209-                                                ^
> 210-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> 'OSSL_DEPRECATED'
> 211-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> 212-                                                   ^
> 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> is deprecated [-Wdeprecated-declarations]
> 214-                ENGINE_load_builtin_engines();
> 215-                ^
> 216-/usr/include/openssl/engine.h:358:1: note:
> 'ENGINE_load_builtin_engines' has been explicitly marked deprecated
> here
> 217-OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
> 218-^
> 219-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> 'OSSL_DEPRECATEDIN_3_0'
> 220-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> 221-                                                ^
> 222-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> 'OSSL_DEPRECATED'
> 223-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> 224-                                                   ^
> 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> [-Wdeprecated-declarations]
> 226-                e = ENGINE_by_id("pkcs11");
> 227-                    ^
> 228-/usr/include/openssl/engine.h:336:1: note: 'ENGINE_by_id' has been
> explicitly marked deprecated here
> 229-OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
> 230-^
> 231-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> 'OSSL_DEPRECATEDIN_3_0'
> 232-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> 233-                                                ^
> 234-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> 'OSSL_DEPRECATED'
> 235-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> 236-                                                   ^
> 237-scripts/sign-file.c:   ld.lld -r -o
> /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/objtool-in.o
> /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86
> /special.o /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/decode.o
> 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> 239-                if (ENGINE_init(e))
> 240-                    ^
> 241-/usr/include/openssl/engine.h:620:1: note: 'ENGINE_init' has been
> explicitly marked deprecated here
> 242-OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
> 243-^
> 244-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> 'OSSL_DEPRECATEDIN_3_0'
> 245-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> 246-                                                ^
> 247-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> 'OSSL_DEPRECATED'
> 248-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> 249-                                                   ^
> 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> deprecated [-Wdeprecated-declarations]
> 251-                        ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
> 252-                             ^
> 253-/usr/include/openssl/engine.h:478:1: note:
> 'ENGINE_ctrl_cmd_string' has been explicitly marked deprecated here
> 254-OSSL_DEPRECATEDIN_3_0
> 255-^
> 256-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> 'OSSL_DEPRECATEDIN_3_0'
> 257-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> 258-                                                ^
> 259-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> 'OSSL_DEPRECATED'
> 260-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> 261-                                                   ^
> 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> deprecated [-Wdeprecated-declarations]
> 263-                private_key = ENGINE_load_private_key(e, private_key_name,
> 264-                              ^
> 265-/usr/include/openssl/engine.h:637:1: note:
> 'ENGINE_load_private_key' has been explicitly marked deprecated here
> 266-OSSL_DEPRECATEDIN_3_0
> 267-^
> 268-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> 'OSSL_DEPRECATEDIN_3_0'
> 269-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> 270-                                                ^
> 271-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> 'OSSL_DEPRECATED'
> 272-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> 273-
>
> Relevant OpenSSL v3.0.3 header files are attached.
> My kernel-config, too.
>
> If you need further information, please let me know.
>
> Regards,
> -Sedat-
>
> [1] https://release.debian.org/transitions/html/auto-openssl.html
