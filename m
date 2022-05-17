Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE0529DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbiEQJPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbiEQJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:14:47 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D536B49
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652778854;
        bh=hoX39PemcSFYcIE/U6fMYNXcF/lSXAXQ7ENdEkgZSZ0=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=a8IyUCEQiJWOtQWWImYLEOiwcQHAe7alvcfUaiobovs06LV1CqQk2YAUVt8ye0gO/
         tSAARVZ+Mxa/tLjK8So7Z/HmhX+2LF+OjhbchbsxWeQzdyzPGVt6N/72corLoZUQES
         gM/fhI0I+1sU9hr7YDsOQJMk6RRAHg5bKywU/zSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.29.110.13] ([143.244.37.30]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof9F-1nWwfM3TUP-00p5iP for
 <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:14:13 +0200
Message-ID: <4c9a5b02-c62f-b042-c7a4-6a6c9b2b293d@gmx.com>
Date:   Tue, 17 May 2022 09:14:12 +0000
MIME-Version: 1.0
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Autocrypt: addr=aros@gmx.com; keydata=
 xjMEYmhJvxYJKwYBBAHaRw8BAQdADk5pbZqvkTjYgJNhuhFnEhGm3wf0wlkSvA1WW6e7PUrN
 IUFydGVtIFMuIFRhc2hraW5vdiA8YXJvc0BnbXguY29tPsKPBBMWCAA3FiEEj8ke+4cCTXTh
 Yr4cMvC8tezQK8cFAmJoSb8FCQAnjQACGwMECwkIBwUVCAkKCwUWAgMBAAAKCRAy8Ly17NAr
 x2A1AP9wVrFztQcuTnO/yDzisQyZsRu8kf7zVcEhAqEOdyLiMwEA6duhPI9mrzMpGbrVbv8m
 o0qOdDlsNWLHcFO9p0qxiQnOOARiaEm/EgorBgEEAZdVAQUBAQdA+jFDQNBNlZr55n45Xdis
 baC3LHPn3V7+1FW8hJfOETIDAQgHwn4EGBYIACYWIQSPyR77hwJNdOFivhwy8Ly17NArxwUC
 YmhJvwUJACeNAAIbDAAKCRAy8Ly17NArx9uPAQDCxAWW7bF3RgiG065nEYYyIbqEziys+sPz
 5fDG+HahXAD+IVVf6Lh9DYeivQN12kSEssZhfy2/qHkmzt+69p2f7AI=
Subject: Cannot build Linux 5.17 on Fedora 36
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e4WqPQ16ARd6qDocSWnBZkkbiwupRQvKs9p2jEaUUUEeeskW05Q
 2GbhNNbo82CfNI+ctqYPxQ2THujZVPMoLOKRGp9peR9gkagD9Dv8WxRAaJUItd+IsXog808
 5ay4kBrzx2DiWrQwfh7AhXM1XpThZoE1mIug83rSVSQ0cVq2yKYkRvjZK9ZiICFaGAshZI5
 Km/KNDWfVLAoRP4wepMWg==
X-UI-Out-Filterresults: junk:10;V03:K0:Lx98bnCDId8=:1Y7ygSN4Exe3YqAq8YSndM81
 MwBaBkso7j71Os/CvtTob8iXZkWQnpqMu47LD5pQ++FxufHI8/sjjYtcrcZmeNH5y+YZ1iQDt
 TkQt4KvqK/EvN/wBrS3JGcxWa/kzL9Hzkqr1yyfPyqWRjdL5pDm1fTIElp0iHmVBFFoW5v17+
 J3AQXKskdCsrn+B8jaHBa63mVImwwlsAWACvDVNEt9awnqn77kK+arLo7s1iOma8FubdHFJYz
 zJ49sAsHmFYwD3WjsOKfQASCA4GhA7ifO2PIeNXsTuKn8irMgED8QxgeRFLgNPbK/vYOyGnJb
 OTeMW2iNszBsJ862im8RjSltsV1jdIxVPWDZsdjiiRzqG4BHnxaFM/0jj9qNKLJx14esTEqvi
 JPbxDuLzifyGD8dV4Ch6j4CakLEygeMJfjI2bcf2/FXUuTrKHfpkpeiRml+0HXE5XaUZYma3E
 zB5lTPTBsj1UwlVKxH4M7hp/050jcL9k9k8jenverhAmxRcfSyYvg5Obc0dtm9dU3xaVQYAW0
 0FEnSN+Urq7LerxjJSv+IjqeXWTYX5QYhoH5xDhgZem5qKexQZRmcDxE5S/0eI8WLobnByBbA
 GVsSQdsMtLZaPf1VTQhnu8t1phKgciEPydO472hE6KTTFg3Q9m7l/lNioFWM6+oDWCiYKUNZH
 kSgaVOfHjMlGyCQ2ZGQTUOTg3fsTpFWh0Gi2OawwblCAqzQEIpKWvMjnpUAReY8UHUqIQy1iW
 aRj2iMtC5KlJ4ImzdGvh6ygimtAp3YbRHlqBuVSK0+QLc98yDQDbtADt42v7uqzkZdxzBcrAV
 NoBERWEavW9IpENRHkxkDbztMzzSmxAyhRX1mU7W2t6qYBfCQRMfgrAqWWKO3oSxz1Lub03sk
 HJu2TE2RL6uxHsph8lPy/FkCr3u7Lr2yxzWlLoO7p5bRbhBWIWX4sMTR2NKKTxWEe5f+zai23
 hkmOFPrc8zR6qbtjkZA6QgwivNBkA9m/KSPd1bmHTnf1y1tnfmqt1yRUmjr5Ahhcy3OWW9rV6
 /B4zZiR1rXvtZYw7fJAVCNttfdfj/SI87+C/ro3uCNhb76SRDDvt5dWDAYE+0DY4lfX8A9Tls
 xq9hocNQBm5gj2krZZSvxae4XdlhTRz9GiSq8Qca6KRZ5UsPivzSe2JOAJ+g1jl/kvu1/5VMC
 oX0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cannot build vanilla Linux 5.17:

# make defconfig
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/confdata.o
   HOSTCC  scripts/kconfig/expr.o
   LEX     scripts/kconfig/lexer.lex.c
   YACC    scripts/kconfig/parser.tab.[ch]
   HOSTCC  scripts/kconfig/lexer.lex.o
   HOSTCC  scripts/kconfig/menu.o
   HOSTCC  scripts/kconfig/parser.tab.o
   HOSTCC  scripts/kconfig/preprocess.o
   HOSTCC  scripts/kconfig/symbol.o
   HOSTCC  scripts/kconfig/util.o
   HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
gold linker is not supported as it is not capable of linking the kernel
proper.
scripts/Kconfig.include:56: Sorry, this linker is not supported.
make[1]: *** [scripts/kconfig/Makefile:87: defconfig] Error 1
make: *** [Makefile:619: defconfig] Error 2

No idea what's going on. I've recently updated gcc and binutils packages.

# dnf update
Dependencies resolved.
Nothing to do.
Complete!

binutils-2.37-27.fc36.x86_64
gcc-12.1.1-1.fc36.x86_64

ls -la /etc/alternatives/ld
lrwxrwxrwx. 1 root root 15 Oct  7  2020 /etc/alternatives/ld ->
/usr/bin/ld.bfd

So, the symbolic link hasn't been changed in more than a year.

No idea what's going on. What am I missing?

Best regards,
Artem
