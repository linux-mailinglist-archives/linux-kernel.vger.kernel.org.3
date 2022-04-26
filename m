Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D95107BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbiDZS7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiDZS7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:59:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BAE180EC2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:56:21 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqZE0-1oEPat2Xse-00mfWt for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022
 20:56:19 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f7ca2ce255so93321197b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:56:19 -0700 (PDT)
X-Gm-Message-State: AOAM530WorSDb1UsbT85ZIRY+VxET+zsQQeEsGxpy8H0UarZFuleHSFe
        svYKmlBp1tGw9yi2RMMhuz20EkI98ZCGyJx0fIM=
X-Google-Smtp-Source: ABdhPJybgZUqgMpOK2T9H7xh37uH1Nx8oagA1RYi0h2aSuwy+vDDrluQLSK3yjDmYw3s35MsRHQQ4F+UjNwqIwgPkRY=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr23748703ywk.209.1650999378258; Tue, 26
 Apr 2022 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 20:56:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ZUfpWiHh6yeAy3fFP8k5BcE8crkis7Savxhdym1e-FQ@mail.gmail.com>
Message-ID: <CAK8P3a2ZUfpWiHh6yeAy3fFP8k5BcE8crkis7Savxhdym1e-FQ@mail.gmail.com>
Subject: Re: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings
 by 34% tree-wide
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z7Y0NAE21Ov/j71fNP0k5m/YR0ufPzhpN7B6oSHXq1pyIn7tLAY
 C1c8AXV7PIKRVl6Z6hFpvpRoVjvJkm+KYaOzTnVil3yUExLGb3OeBy7qeYaql4NNIBotWsb
 nFuuZ1ukgqMBV3RCC7mO1Q7/MmpFODkhDbziP8c2KbBZ3E94GQmul1tqHWNjOVlfEpHVZ7N
 Eb4fsmOVsZ40uZpYxgAKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2fo1Pc45XcA=:TJQdQTagcVe0VoUbcjW70i
 Oo+zqqhwhDflY+DS+jnG+y/0Tb13ndvRbiEuTnYdt7kYzZZGtlRwHKKLoYoU3QzWQ6FlLTAMq
 ljuURNQupMS4Tee39sQf4qINWvLGfCPWQSBOlJV8Wx/aTC9ZVdc/LcoJJaWQi5MBXoYudZGYQ
 HJbobfHXnUkVWtTbz6yBcpO2K9CkRhq0BmN+2DD7HCYOMoyaBmA+6qRYEeJ5dFnop8zcRtuJe
 Uxr5Z8oXd4KwCjDR8bT9vXxCjE486FGH/CMZWMsGl+QAHBjoPvIrJ9JL+0VFnWwKDf9ThDc7w
 KDPpWxpHowmwc2ABEFCk/jMT2kWe5/pMgvYAK8D4OGp77h/+1WHX69hx9ACb3jTokfpZbC5Kf
 xMTR4Fickr4/WPpyYQMWDQNNPOVXqrbgyHbEuKErtIDBK8ip8s1Mj5OgSShOAjea0ruYVheEG
 MUZCZ2ylT0k25krBurV2R7XPnt4eHeMjGS5kmKNC3Kf6pF2Tdu6BwJA9rwtIqLFEF4kgh2ncN
 BMRQxvt2VYN3MPXItDRl7FzftScFGuu6BfrI5/+EZrmQFFFowS/yC+/psIxF4JRpBODYyxDRb
 zzYJgZJbU5A1QEdrNrqhjbJtm5eLaIlj8ZpXhDqzBFPltHNmNPs66/4zpM50hBpsVA04jGZA0
 +stj5QB7Zb4QMfs4Y8WwYIx4++MSc/mdeMi8IsrU3C78snjPfUZY9v3q8moxCiawwdqg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 6:16 PM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:

> +__diag_push();
> +__diag_ignore(GCC, 8, "-Wtype-limits",
> +             "GENMASK(size - 1, 0) yields 'comparison of unsigned expression in < 0 is always false' which is OK");
> +

Are you sure gcc-8 is the correct version to check for? If older
versions had this
already, you may have to add the magic bits in the compiler-gcc.h header.

Otherwise, this looks sensible to me.

      Arnd
