Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414F4516B65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383582AbiEBHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350995AbiEBHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:50:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0529CA5
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:47:23 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMH2M-1nSFV12kNC-00JGxH for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022
 09:47:21 +0200
Received: by mail-yb1-f177.google.com with SMTP id j2so24789984ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:47:21 -0700 (PDT)
X-Gm-Message-State: AOAM5318GQiVfXQ8nGFOtXWNiakMJ9wUxFReAo1wk28gsbMxdasTEg8h
        8Yq+4uApDv5egAzqczxCVj5mm4ITtOTJyIU9/Hw=
X-Google-Smtp-Source: ABdhPJzvzGqI6bWE4UdkwqeqxrL9PZ/nfcQMZR/8k8x9UyNwFVHgiYK0IglV6QwDImx9Of0P5VsaeW+hhatlkLlD9uI=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr9450273ybx.472.1651477640521; Mon, 02
 May 2022 00:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <202205020811.kEEGO8QC-lkp@intel.com> <CAK8P3a2Cq5oa8e7SAQ-mOGnytEjnOa4esr1gsfsS3ceH+A2f2g@mail.gmail.com>
 <5291f623-6f0d-4cc0-8358-6aea4e8aa667@www.fastmail.com>
In-Reply-To: <5291f623-6f0d-4cc0-8358-6aea4e8aa667@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 2 May 2022 09:47:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UL+g5_ugNYh+eUEBtOpg88qWrKnY_qzNO2WY8A1HfEg@mail.gmail.com>
Message-ID: <CAK8P3a2UL+g5_ugNYh+eUEBtOpg88qWrKnY_qzNO2WY8A1HfEg@mail.gmail.com>
Subject: Re: [asahilinux:asahi-soc/rtkit-sart-nvme 4/6] drivers/soc/apple/sart.c:284:4:
 warning: format specifies type 'unsigned long long' but the argument has type
 'phys_addr_t' (aka 'unsigned int')
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GVKRmHqV4CUqrSFTLg0Ujdewk/9WekCt05g9zWIoChyXV17VX6u
 U6V8woY5rcP4iRhJZbCA9DwfHeOZ9MACDi0b7xmZGWktEC6N0CX69Iu5bVjTT9/i1GYnKac
 CJ21Aw8pcbp3YY4aUOJjvoWRYtOqs+hEa8shcJNzJUUAPFDahCzHPNCVD3B3dScXXdHHxcz
 6ifz0XpleKQejxIcdI14g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5JOeqgQfmzI=:ruSt3c/oCkQwIIt5l5h3r8
 GEPNeyNJvj50iTjGW7y9TuXGps05LhTNGrK/XkkQZAZ5eg+dpH2XMpmiz3rv7qOvvOGML5DIL
 l1Ba+oVIs5fv7rPTOEVlcpDYl2o7gJLlVemxqbxtv2uiRWNqsqxuPpMVAi75zWZPQfEJfJfKl
 LhpCVkAQ8iS1nPFfBpQhsGsnvYOg9YsMZVp8/6i4IgLs0kiyT1b8gecnLbbezERJ/KIYGkH9l
 Tn10RhoE8vdMO4gJ65D0/PI168s9+xROlUe2shLbN77PEL1U7xryf592t9ORw4lwzYZ32WbG7
 2OswlHzwaJWNchzQQdiAJD1KXNVlJupwUQWVKyx9G0dJ7FxGm8GGHoLyu6ajmW24+zZEG33vc
 CaEnJUQjIPfqf2dXJ6REdleaOxh7FvIH+1CuYbgJOZ7Q+cQOuyUkaLY4AoZPQP2IUQzz/5fjE
 s6OOA24FKj1SqzmjIqIfZkeE3D6m4HN1+ua7g3p7mwChZzNA4/N4siwPPW/g9+TA+D1J9czxc
 BQ2/koKm8nK9ZfX2dHFbqCoFq28Glcikb9+oGCY/ylZqLrBZpJGYqCR5+v2E+bBOp9YJ3OEGX
 6KlGCC0ixig+EeAitI8Kk4aafvNopiRvfa73MHa0zxC+vGqhJAvHW7XKl7tYhbTwwpRWksusT
 gj58FBfWVE1foT6A8jQRhlXWwQSdgZi00xEI3IarL7ALF4XNdFF/Iqb/LeZVe7f1IK9U=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 9:34 AM Sven Peter <sven@svenpeter.dev> wrote:
> On Mon, May 2, 2022, at 08:39, Arnd Bergmann wrote:
> >
> > to print a phys_addr_t, you should pass the address by reference and use
> > the special "%pap" format string modifier. I'm not entirely sure if it should
> > actually be a dma_addr_t instead of a phys_addr_t. If the type gets changed,
> > the format string would become "%pad".
>
> I've been using %pa for all other prints in this file since v1 and just
> missed this one for some reason. I'm a bit confused why the bots found this last
> one only now but I'll fix it as well.

You only get a warning for 32-bit builds using 64-bit phys_addr_t,
which is fairly
rare, so you can't predict whether the bots will actually run into this.

       Arnd
