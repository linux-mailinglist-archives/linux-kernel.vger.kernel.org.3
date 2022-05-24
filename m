Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2398C5331A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbiEXTOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbiEXTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:14:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8D5EBEC;
        Tue, 24 May 2022 12:14:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 2so9488754iou.5;
        Tue, 24 May 2022 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Q4PbAGgy/EEp8A8G2Df0NnYKeJLXOrfA0y/iY8AyNZ8=;
        b=H1lcHbCjc53VxXFo4/gneCT+dqmMMJadq8sH448Ze+pPwqj8Hb6MVj8Q6t21mp6X+3
         AgIhlrWU4PxM8HQUFN2Nx+y505jB/FpvO+86ZHXqz9NgcY2kZ7Bwk6QIqmgDiI929a7k
         gQPEKLNLPFkMqulxGKR2Rd3F0mP0QN6wxhANxxhvjY1NQ09PuMTELsrRFLtVqFVK49RM
         TldlOI50L1APzrIFq6Su69wsQ4ILD3ExZnykHgF1uKw6uKwP5aeHsaPjJ6AT76t5Of1L
         4XBCKZ8JNx8X6trT5yCQ0caZhVo4nY2GVrHf0n3C9t+gNoI8N4iX3YvI15RWjwLiv4pP
         Ecyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Q4PbAGgy/EEp8A8G2Df0NnYKeJLXOrfA0y/iY8AyNZ8=;
        b=OiPhdVDkoo94Q8HlcgAg+k0w9mDto2HghsimaIvRVUrJk4ih5ByyIIyX5wBueUML4i
         TwQnFoShS8fv2yj5m8DOaHtIum6T1DHgScPA1Iai5DLOVpxHpFsQJ2T2/CE1NBTtQzAN
         aCwSdk+TFB+gfONgLbrlgcxE/XLCNQAzglAB4TdGniHreP4rqMhhxFLBMEDEDfHCA9wT
         Xev6tmUJPEk1lFXJ9Xk/g6bcU+iGsdZChBuufA8vZBT/L9KhGXalInYzoqLvQMSHr5Ly
         Zqp2kIZ4oMY4BxCseKApCao4HPJygrn2Ur2jF0vmCL9XdyVySH919qoo6ES6wzEezbgS
         Vdtw==
X-Gm-Message-State: AOAM5321SDA1x9EienbGJGMORh5l0fUb4ORZ+itCSJORd1JfRynLvkSc
        a63t7MMt90qAKI3Sj3SSIR7Cdy3HwVfB+rqmU5c8gxDxyF4W9g==
X-Google-Smtp-Source: ABdhPJx4eaPDpI48UhW0021618hMu9tKyVzxbrsQTAGSLCXvILv/xcYzByMcJ1zJqEmOov6+JkgpkQH8uymupY6tvcU=
X-Received: by 2002:a05:6638:25d3:b0:32e:e5ee:496c with SMTP id
 u19-20020a05663825d300b0032ee5ee496cmr2525941jat.52.1653419642892; Tue, 24
 May 2022 12:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
In-Reply-To: <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 24 May 2022 21:13:26 +0200
Message-ID: <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Kees Cook <keescook@chromium.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>
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

On Thu, May 19, 2022 at 12:01 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> [ CC Kees and Salvatore ]
>
> The Debian kernel-team ships a fix (4 hours young):
>
> commit: 13e234d459c11946efba647c3daf15e03abb0d99
> "sign-file: Convert API usage to support OpenSSL v3"
>
> *untested*

@Kees:

Any updates on the part of certs/extract-cert.c?

-Sedat-

> [1] https://salsa.debian.org/kernel-team/linux/-/commit/13e234d459c11946efba647c3daf15e03abb0d99
>
> On Thu, May 19, 2022 at 11:55 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi,
> >
> > here, I am on Debian/unstable AMD64.
> >
> > Recently (or still) there is/was a transition to OpenSSL see below link.
> >
> > The warnings look like:
> >
> > 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> > deprecated [-Wdeprecated-declarations]
> > 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> > deprecated [-Wdeprecated-declarations]
> > 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> > is deprecated [-Wdeprecated-declarations]
> > 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> > [-Wdeprecated-declarations]
> > 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> > 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> > deprecated [-Wdeprecated-declarations]
> > 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> > deprecated [-Wdeprecated-declarations]
> > 395:certs/extract-cert.c:46:14: warning: 'ERR_get_error_line' is
> > deprecated [-Wdeprecated-declarations]
> > 407:certs/extract-cert.c:59:9: warning: 'ERR_get_error_line' is
> > deprecated [-Wdeprecated-declarations]
> > 420:certs/extract-cert.c:124:3: warning: 'ENGINE_load_builtin_engines'
> > is deprecated [-Wdeprecated-declarations]
> > 432:certs/extract-cert.c:126:7: warning: 'ENGINE_by_id' is deprecated
> > [-Wdeprecated-declarations]
> > 444:certs/extract-cert.c:128:7: warning: 'ENGINE_init' is deprecated
> > [-Wdeprecated-declarations]
> > 456:certs/extract-cert.c:133:9: warning: 'ENGINE_ctrl_cmd_string' is
> > deprecated [-Wdeprecated-declarations]
> > 468:certs/extract-cert.c:134:3: warning: 'ENGINE_ctrl_cmd' is
> > deprecated [-Wdeprecated-declarations]
> >
> > More detailed output:
> >
> > 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> > deprecated [-Wdeprecated-declarations]
> > 190-        while ((e = ERR_get_error_line(&file, &line))) {
> > 191-                    ^
> > 192-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> > been explicitly marked deprecated here
> > 193-OSSL_DEPRECATEDIN_3_0
> > 194-^
> > 195-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > 'OSSL_DEPRECATEDIN_3_0'
> > 196-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > 197-                                                ^
> > 198-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > 'OSSL_DEPRECATED'
> > 199-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > 200-                                                   ^
> > 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> > deprecated [-Wdeprecated-declarations]
> > 202-        while (ERR_get_error_line(&file, &line)) {}
> > 203-               ^
> > 204-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> > been explicitly marked deprecated here
> > 205-OSSL_DEPRECATEDIN_3_0
> > 206-^
> > 207-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > 'OSSL_DEPRECATEDIN_3_0'
> > 208-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > 209-                                                ^
> > 210-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > 'OSSL_DEPRECATED'
> > 211-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > 212-                                                   ^
> > 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> > is deprecated [-Wdeprecated-declarations]
> > 214-                ENGINE_load_builtin_engines();
> > 215-                ^
> > 216-/usr/include/openssl/engine.h:358:1: note:
> > 'ENGINE_load_builtin_engines' has been explicitly marked deprecated
> > here
> > 217-OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
> > 218-^
> > 219-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > 'OSSL_DEPRECATEDIN_3_0'
> > 220-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > 221-                                                ^
> > 222-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > 'OSSL_DEPRECATED'
> > 223-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > 224-                                                   ^
> > 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> > [-Wdeprecated-declarations]
> > 226-                e = ENGINE_by_id("pkcs11");
> > 227-                    ^
> > 228-/usr/include/openssl/engine.h:336:1: note: 'ENGINE_by_id' has been
> > explicitly marked deprecated here
> > 229-OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
> > 230-^
> > 231-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > 'OSSL_DEPRECATEDIN_3_0'
> > 232-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > 233-                                                ^
> > 234-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > 'OSSL_DEPRECATED'
> > 235-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > 236-                                                   ^
> > 237-scripts/sign-file.c:   ld.lld -r -o
> > /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/objtool-in.o
> > /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86
> > /special.o /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/decode.o
> > 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> > 239-                if (ENGINE_init(e))
> > 240-                    ^
> > 241-/usr/include/openssl/engine.h:620:1: note: 'ENGINE_init' has been
> > explicitly marked deprecated here
> > 242-OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
> > 243-^
> > 244-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > 'OSSL_DEPRECATEDIN_3_0'
> > 245-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > 246-                                                ^
> > 247-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > 'OSSL_DEPRECATED'
> > 248-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > 249-                                                   ^
> > 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> > deprecated [-Wdeprecated-declarations]
> > 251-                        ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
> > 252-                             ^
> > 253-/usr/include/openssl/engine.h:478:1: note:
> > 'ENGINE_ctrl_cmd_string' has been explicitly marked deprecated here
> > 254-OSSL_DEPRECATEDIN_3_0
> > 255-^
> > 256-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > 'OSSL_DEPRECATEDIN_3_0'
> > 257-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > 258-                                                ^
> > 259-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > 'OSSL_DEPRECATED'
> > 260-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > 261-                                                   ^
> > 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> > deprecated [-Wdeprecated-declarations]
> > 263-                private_key = ENGINE_load_private_key(e, private_key_name,
> > 264-                              ^
> > 265-/usr/include/openssl/engine.h:637:1: note:
> > 'ENGINE_load_private_key' has been explicitly marked deprecated here
> > 266-OSSL_DEPRECATEDIN_3_0
> > 267-^
> > 268-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > 'OSSL_DEPRECATEDIN_3_0'
> > 269-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > 270-                                                ^
> > 271-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > 'OSSL_DEPRECATED'
> > 272-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > 273-
> >
> > Relevant OpenSSL v3.0.3 header files are attached.
> > My kernel-config, too.
> >
> > If you need further information, please let me know.
> >
> > Regards,
> > -Sedat-
> >
> > [1] https://release.debian.org/transitions/html/auto-openssl.html
