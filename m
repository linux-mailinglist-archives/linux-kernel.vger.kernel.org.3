Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97495365AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiE0QGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354408AbiE0QFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:05:44 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9645149158;
        Fri, 27 May 2022 09:05:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i74so5093274ioa.4;
        Fri, 27 May 2022 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=niIMDzYnGPpPHioLH5FDnM74wPJ4Xv2r6klFhTL9flU=;
        b=ZGUQEW/meK1edqcD7auFoYHUD7PR6PMF0mSeIaw2fPQ4mv1gEk9d0Y0Q1Lc9MN8kw5
         vVM0G1AA2gD8T+lA1ubEGan7u54CdGwGUh5eTkByF3fFg/feU9l7CLTKzt55RqHylkhQ
         7h/29Y9XkjU0TCFCT2JfwH6XkZAhaNDlS1EZzyoRANz0coifKiOR/FQRyzL7NHGv67QP
         FP8lhXZoSUyOJKnbH+abd7Sz6EjQHIDP3LW+OmPrkYs4KdGN4Emhawu++9fZ2KpqQrOJ
         5sRmWdTKYxJmxEZ/uy+uOOhKGzVEguLzbOBaT2It8ZSnIKSEF5AB/j992lUkXPqZORkC
         s5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=niIMDzYnGPpPHioLH5FDnM74wPJ4Xv2r6klFhTL9flU=;
        b=gBFdRZSTn2R21wA52UM09m7m8lIMl2buQMNhE88fNxhtI5olAIaJUw+wbtp8TWZMD4
         3cfgwK9YVdiA0oZb/m0whVR9v/tJo1CkJwOj7802mtgDYD9ZLBg476lB+nymCPYVg1q8
         ER0sKdVAFi6kUEEtr3CMh0W8+FILWNQlCljnaN+vUiVVLMpXKWMCcIIvY1n/NppYdZbY
         5o4ch5pxijIdCLumgqQeuMvmVfwPiairoJs1+J9UHxLahR+a3OHxZ6xpZEkzSSK8kabx
         K1Th5SFBU0nTFRE8mnNf+qUthjIrgxvdOVHZ0cF8NknZLiSYO/n1IQsjRVgTDeodowyx
         fFCA==
X-Gm-Message-State: AOAM532OQ6Wp4mIxz/+FkqBFgECNRgBI7lqEIoyKMefYFZ3KUyXunkGH
        42sczoEYJLx/5+DvnHyolLXJnOn113sTeH//fsq9yRgGgKSMaA==
X-Google-Smtp-Source: ABdhPJy3GGJEmBsLauhy6BM+8kVyOSc1PYqod8TWTIy8zmR3xhLmWR/pe8pG7pkEgdxu6Vuikrylvtk2qfbvkPw8ZaU=
X-Received: by 2002:a05:6638:14cb:b0:32e:cf97:4ac with SMTP id
 l11-20020a05663814cb00b0032ecf9704acmr13656444jak.80.1653667542084; Fri, 27
 May 2022 09:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com> <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
In-Reply-To: <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 27 May 2022 18:05:03 +0200
Message-ID: <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Kees Cook <keescook@chromium.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: multipart/mixed; boundary="0000000000006c596d05e0007af6"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006c596d05e0007af6
Content-Type: text/plain; charset="UTF-8"

On Fri, May 27, 2022 at 9:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, May 24, 2022 at 9:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, May 19, 2022 at 12:01 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > [ CC Kees and Salvatore ]
> > >
> > > The Debian kernel-team ships a fix (4 hours young):
> > >
> > > commit: 13e234d459c11946efba647c3daf15e03abb0d99
> > > "sign-file: Convert API usage to support OpenSSL v3"
> > >
> > > *untested*
> >
> > @Kees:
> >
> > Any updates on the part of certs/extract-cert.c?
> >
>
> [ CC Tasmiya Nalatwad ]
>
> There are several more reports on this issue (see [3]).
>
> I did a quick test with Kees' patch from [2] and my attached patch
> "extract-cert: Suppress warnings with OpenSSL v3 API".
>
> Now, I see no more warnings due to OpenSSL v3 API:
>
> $ egrep 'sign-file|extract-cert'
> ../build-log_5.18.0-2-amd64-clang14-lto.txt
> 176:  clang -Wp,-MMD,scripts/.sign-file.d -Wall -Wmissing-prototypes
> -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11
> -Wdeclaration-after-statement         -o scripts/sign-file
> scripts/sign-file.c   -lcrypto
> 2053:  clang -Wp,-MMD,certs/.extract-cert.d -Wall -Wmissing-prototypes
> -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11
> -Wdeclaration-after-statement       -Wno-deprecated-declarations   -o
> certs/extract-cert certs/extract-cert.c   -lcrypto
> 2068:  certs/extract-cert "" certs/x509_certificate_list
> 2069:  certs/extract-cert "" certs/signing_key.x509
>
> config-5.18-dileks: LLVM-14 + CONFIG_LTO_CLANG_THIN=y
>
> -Sedat-
>
> [1] https://marc.info/?l=linux-keyrings&m=165330697801670&w=2
> [2] https://salsa.debian.org/kernel-team/linux/-/commit/13e234d459c11946efba647c3daf15e03abb0d99
> [3] https://marc.info/?l=linux-keyrings&m=165330697801670&w=2
>

[ CC James Bottomley ]

[PATCH] extract-cert: Force build against OpenSSL API Compat v1.1.x

...works as well.

-Sedat-

> > >
> > > On Thu, May 19, 2022 at 11:55 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > here, I am on Debian/unstable AMD64.
> > > >
> > > > Recently (or still) there is/was a transition to OpenSSL see below link.
> > > >
> > > > The warnings look like:
> > > >
> > > > 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> > > > is deprecated [-Wdeprecated-declarations]
> > > > 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> > > > [-Wdeprecated-declarations]
> > > > 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> > > > 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 395:certs/extract-cert.c:46:14: warning: 'ERR_get_error_line' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 407:certs/extract-cert.c:59:9: warning: 'ERR_get_error_line' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 420:certs/extract-cert.c:124:3: warning: 'ENGINE_load_builtin_engines'
> > > > is deprecated [-Wdeprecated-declarations]
> > > > 432:certs/extract-cert.c:126:7: warning: 'ENGINE_by_id' is deprecated
> > > > [-Wdeprecated-declarations]
> > > > 444:certs/extract-cert.c:128:7: warning: 'ENGINE_init' is deprecated
> > > > [-Wdeprecated-declarations]
> > > > 456:certs/extract-cert.c:133:9: warning: 'ENGINE_ctrl_cmd_string' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 468:certs/extract-cert.c:134:3: warning: 'ENGINE_ctrl_cmd' is
> > > > deprecated [-Wdeprecated-declarations]
> > > >
> > > > More detailed output:
> > > >
> > > > 189:scripts/sign-file.c:89:14: warning: 'ERR_get_error_line' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 190-        while ((e = ERR_get_error_line(&file, &line))) {
> > > > 191-                    ^
> > > > 192-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> > > > been explicitly marked deprecated here
> > > > 193-OSSL_DEPRECATEDIN_3_0
> > > > 194-^
> > > > 195-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > 196-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > 197-                                                ^
> > > > 198-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > 'OSSL_DEPRECATED'
> > > > 199-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > 200-                                                   ^
> > > > 201:scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 202-        while (ERR_get_error_line(&file, &line)) {}
> > > > 203-               ^
> > > > 204-/usr/include/openssl/err.h:410:1: note: 'ERR_get_error_line' has
> > > > been explicitly marked deprecated here
> > > > 205-OSSL_DEPRECATEDIN_3_0
> > > > 206-^
> > > > 207-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > 208-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > 209-                                                ^
> > > > 210-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > 'OSSL_DEPRECATED'
> > > > 211-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > 212-                                                   ^
> > > > 213:scripts/sign-file.c:142:3: warning: 'ENGINE_load_builtin_engines'
> > > > is deprecated [-Wdeprecated-declarations]
> > > > 214-                ENGINE_load_builtin_engines();
> > > > 215-                ^
> > > > 216-/usr/include/openssl/engine.h:358:1: note:
> > > > 'ENGINE_load_builtin_engines' has been explicitly marked deprecated
> > > > here
> > > > 217-OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
> > > > 218-^
> > > > 219-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > 220-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > 221-                                                ^
> > > > 222-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > 'OSSL_DEPRECATED'
> > > > 223-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > 224-                                                   ^
> > > > 225:scripts/sign-file.c:144:7: warning: 'ENGINE_by_id' is deprecated
> > > > [-Wdeprecated-declarations]
> > > > 226-                e = ENGINE_by_id("pkcs11");
> > > > 227-                    ^
> > > > 228-/usr/include/openssl/engine.h:336:1: note: 'ENGINE_by_id' has been
> > > > explicitly marked deprecated here
> > > > 229-OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
> > > > 230-^
> > > > 231-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > 232-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > 233-                                                ^
> > > > 234-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > 'OSSL_DEPRECATED'
> > > > 235-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > 236-                                                   ^
> > > > 237-scripts/sign-file.c:   ld.lld -r -o
> > > > /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/objtool-in.o
> > > > /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86
> > > > /special.o /home/dileks/src/linux-kernel/git/tools/objtool/arch/x86/decode.o
> > > > 238:146:7: warning: 'ENGINE_init' is deprecated [-Wdeprecated-declarations]
> > > > 239-                if (ENGINE_init(e))
> > > > 240-                    ^
> > > > 241-/usr/include/openssl/engine.h:620:1: note: 'ENGINE_init' has been
> > > > explicitly marked deprecated here
> > > > 242-OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
> > > > 243-^
> > > > 244-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > 245-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > 246-                                                ^
> > > > 247-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > 'OSSL_DEPRECATED'
> > > > 248-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > 249-                                                   ^
> > > > 250:scripts/sign-file.c:151:9: warning: 'ENGINE_ctrl_cmd_string' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 251-                        ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
> > > > 252-                             ^
> > > > 253-/usr/include/openssl/engine.h:478:1: note:
> > > > 'ENGINE_ctrl_cmd_string' has been explicitly marked deprecated here
> > > > 254-OSSL_DEPRECATEDIN_3_0
> > > > 255-^
> > > > 256-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > 257-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > 258-                                                ^
> > > > 259-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > 'OSSL_DEPRECATED'
> > > > 260-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > 261-                                                   ^
> > > > 262:scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is
> > > > deprecated [-Wdeprecated-declarations]
> > > > 263-                private_key = ENGINE_load_private_key(e, private_key_name,
> > > > 264-                              ^
> > > > 265-/usr/include/openssl/engine.h:637:1: note:
> > > > 'ENGINE_load_private_key' has been explicitly marked deprecated here
> > > > 266-OSSL_DEPRECATEDIN_3_0
> > > > 267-^
> > > > 268-/usr/include/openssl/macros.h:182:49: note: expanded from macro
> > > > 'OSSL_DEPRECATEDIN_3_0'
> > > > 269-#   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
> > > > 270-                                                ^
> > > > 271-/usr/include/openssl/macros.h:62:52: note: expanded from macro
> > > > 'OSSL_DEPRECATED'
> > > > 272-#     define OSSL_DEPRECATED(since) __attribute__((deprecated))
> > > > 273-
> > > >
> > > > Relevant OpenSSL v3.0.3 header files are attached.
> > > > My kernel-config, too.
> > > >
> > > > If you need further information, please let me know.
> > > >
> > > > Regards,
> > > > -Sedat-
> > > >
> > > > [1] https://release.debian.org/transitions/html/auto-openssl.html

--0000000000006c596d05e0007af6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-extract-cert-Force-build-against-OpenSSL-API-Compat-.patch"
Content-Disposition: attachment; 
	filename="0001-extract-cert-Force-build-against-OpenSSL-API-Compat-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l3omxg0x0>
X-Attachment-Id: f_l3omxg0x0

RnJvbSA2MTdlMGNlMDExN2JmMjk3YmU4Y2E0ZWUxMzJjZGZmMDNkYzM0NDQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBGcmksIDI3IE1heSAyMDIyIDE3OjQzOjI5ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZXh0
cmFjdC1jZXJ0OiBGb3JjZSBidWlsZCBhZ2FpbnN0IE9wZW5TU0wgQVBJIENvbXBhdCB2MS4xLngK
ClN1cHByZXNzIC1XZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnMgd2FybmluZ3Mgd2hlbiBidWlsZGlu
ZyBhZ2FpbnN0IE9wZW5TU0wgdjMuMC54LgoKVGVzdGVkIHdpdGggTExWTSB2ZXJzaW9uIDE0LjAu
NCBhbmQgT3BlblNTTCB2My4wLjMgb24gRGViaWFuL3Vuc3RhYmxlIEFNRDY0LgoKU3VnZ2VzdGVk
LWJ5OiBKYW1lcyBCb3R0b21sZXkgPEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5j
b20+ClNpZ25lZC1vZmYtYnk6IFNlZGF0IERpbGVrIDxzZWRhdC5kaWxla0BnbWFpbC5jb20+Ci0t
LQogY2VydHMvTWFrZWZpbGUgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL2NlcnRzL01ha2VmaWxlIGIvY2VydHMvTWFrZWZpbGUKaW5kZXggZDg0NDNj
ZmIxYzQwLi5iMTRiYmQwNjc0YzQgMTAwNjQ0Ci0tLSBhL2NlcnRzL01ha2VmaWxlCisrKyBiL2Nl
cnRzL01ha2VmaWxlCkBAIC03NSw0ICs3NSw1IEBAIHRhcmdldHMgKz0geDUwOV9yZXZvY2F0aW9u
X2xpc3QKIGhvc3Rwcm9ncyA6PSBleHRyYWN0LWNlcnQKIAogSE9TVENGTEFHU19leHRyYWN0LWNl
cnQubyA9ICQoc2hlbGwgcGtnLWNvbmZpZyAtLWNmbGFncyBsaWJjcnlwdG8gMj4gL2Rldi9udWxs
KQorSE9TVENGTEFHU19leHRyYWN0LWNlcnQubyArPSAtRE9QRU5TU0xfQVBJX0NPTVBBVD0weDEw
MTAwMDAwTAogSE9TVExETElCU19leHRyYWN0LWNlcnQgPSAkKHNoZWxsIHBrZy1jb25maWcgLS1s
aWJzIGxpYmNyeXB0byAyPiAvZGV2L251bGwgfHwgZWNobyAtbGNyeXB0bykKLS0gCjIuMzYuMQoK
--0000000000006c596d05e0007af6--
