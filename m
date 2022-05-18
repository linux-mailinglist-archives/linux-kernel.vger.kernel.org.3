Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79B52B446
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiERHwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiERHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:52:40 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E72C1D315;
        Wed, 18 May 2022 00:52:39 -0700 (PDT)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MacjC-1nKep525V4-00c9eU; Wed, 18 May 2022 09:52:37 +0200
Received: by mail-yb1-f172.google.com with SMTP id i11so2284619ybq.9;
        Wed, 18 May 2022 00:52:37 -0700 (PDT)
X-Gm-Message-State: AOAM5310E/qHKgRwu6pCfA5aDN3GZjyYZYU1aadiAN0pr2M465Snsz+j
        dpBIorVb7X+JhP/rDxC6UImIXR5/MniFOoLcS7A=
X-Google-Smtp-Source: ABdhPJw/C4Wp2+lD/LeOurnHShFuhY2DtohuPYVV6u7+PgmQYQQI/BkFuP71sEIcZsVIId0pYZQ/YQF1du1xWbey4uo=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr26122159ybx.472.1652860356229; Wed, 18
 May 2022 00:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220516100401.7639-1-ojeda@kernel.org>
In-Reply-To: <20220516100401.7639-1-ojeda@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 08:52:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Z5qBQWUbPNEHhPDNX0XC8CQk+dUtC9K_=N3AXK2uHHA@mail.gmail.com>
Message-ID: <CAK8P3a3Z5qBQWUbPNEHhPDNX0XC8CQk+dUtC9K_=N3AXK2uHHA@mail.gmail.com>
Subject: Re: [PATCH v1] binder: convert `BINDER_*` ioctl `#define`s into an `enum`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RvNaoVhsKy/bl7e01yVRZPNCHTSzNVxkQOTa4CHsOxQi6cBmBV0
 irMG0JmXc+HPgBJW2MXiBdOUioHMkAQOg7IVQgcqxWCyTInWE0ff4gTEWRubbxoesfnLyhO
 2wskqRDsZSY/66JT5cHW6lXYns2RNPvH0GLcHonUYMcer7qLlCVoC+q9TEOjQAxpIhkSB+Q
 LEEtocEIBpC0KlG3GySJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vIIedTA3yxI=:oenWVqKVw4BcMnowOKp8gM
 2JwizoidJg2/5NaZgl1B4goOUE8OZJh8d5+Ib4/RfVLrRou1rR5Ua7N/6JKKK0+MtzMyZcXe9
 fs/IAtB2GMkyF4OLRhxfhelg+tGgguPWy9Efn+51vr4IGjeR0pGskrlhvesxEYqtX5qq8fIbP
 ecYVsCW2UjJY2CDDowaF0c3dfg/QjTrRRgvcQRz4LiJch4/8UsUbNowpgCP/gy1vii9rBKnGu
 pmlXhav04vKpLHfdCMjSNkgMpgI//6zGh7QwepojufJ495e7C51vP5sOth3D2Vrl6ck2L2ruh
 8jwWTDsQ5+bxDuOfzZGHKVjEfwVIzoVOk7wmtP94QrqMe8VOutXrJWDypJlShCjfK6txhmjRS
 Sm/kAPLPpX+rXzKclRsCmpcMtku3ZoTnxDFYXMGN6Fw/KLRXI9cDoFsXXtre++aI8V9F81tYo
 +cX3WPpyKyVSdcUGu+D6/mER37LIneTa3nMCsr+iC6Am2rzDWzWPurrvhrdIrA8q4K+hVFsuH
 utVuf827AjStLn4T6PDlNCtZ1Y8hlO4zRgSdomuUt5qPupxM+Fpu2JEp3jll9iyjOel236vVT
 wD4JhWFJHo69+8s39Oj6PDBnt3YfAQ44dN0YV+cadlZB2u1NdVn7EaaH+dwXE6O1JEnsYtNLp
 l7NX75H9UCiMjaqD3tLVGrHcYfHUvBBFg05NVx4LFlZINiIDiF9u9iC8cIuvXhyq/9peifwoO
 WDw3jkN8eQnXZJwL5sHKI00w1UhWHOTAVa0twfkmsgPuBiVx3PWBRmozSClsE8MVSUNq/9yrd
 s5aRhP3CIxiUXk3GqrZG4+6xk8D4XAYTfkgEhogYhj/c7m6RUnv2Jv8FMuxZAUZt+pECI9+Qk
 kEXNzfVNYCqT4dyvXQKg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:04 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> -#define BINDER_WRITE_READ              _IOWR('b', 1, struct binder_write_read)
> -#define BINDER_SET_IDLE_TIMEOUT                _IOW('b', 3, __s64)
> -#define BINDER_SET_MAX_THREADS         _IOW('b', 5, __u32)
> -#define BINDER_SET_IDLE_PRIORITY       _IOW('b', 6, __s32)
> -#define BINDER_SET_CONTEXT_MGR         _IOW('b', 7, __s32)
> -#define BINDER_THREAD_EXIT             _IOW('b', 8, __s32)
> -#define BINDER_VERSION                 _IOWR('b', 9, struct binder_version)
> -#define BINDER_GET_NODE_DEBUG_INFO     _IOWR('b', 11, struct binder_node_debug_info)
> -#define BINDER_GET_NODE_INFO_FOR_REF   _IOWR('b', 12, struct binder_node_info_for_ref)
> -#define BINDER_SET_CONTEXT_MGR_EXT     _IOW('b', 13, struct flat_binder_object)
> -#define BINDER_FREEZE                  _IOW('b', 14, struct binder_freeze_info)
> -#define BINDER_GET_FROZEN_INFO         _IOWR('b', 15, struct binder_frozen_status_info)
> -#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION    _IOW('b', 16, __u32)
> +enum {
> +       BINDER_WRITE_READ                       = _IOWR('b', 1, struct binder_write_read),
> +       BINDER_SET_IDLE_TIMEOUT                 = _IOW('b', 3, __s64),
> +       BINDER_SET_MAX_THREADS                  = _IOW('b', 5, __u32),
> +       BINDER_SET_IDLE_PRIORITY                = _IOW('b', 6, __s32),
> +       BINDER_SET_CONTEXT_MGR                  = _IOW('b', 7, __s32),
> +       BINDER_THREAD_EXIT                      = _IOW('b', 8, __s32),
> +       BINDER_VERSION                          = _IOWR('b', 9, struct binder_version),

I wonder if that breaks any tools that extract ioctl command number definitions
from kernel headers. I see one other header using enum, but everything else
has the #define. The main user of ioctl command definitions that comes to
mind is 'strace', but I don't know where they get the numbers from.

It's probably not a big deal as long as it's limited to binder, but it
may become
more of a problem if we do this for more subsystems over time.

         Arnd
