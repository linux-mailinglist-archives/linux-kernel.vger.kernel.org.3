Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1EB58B446
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbiHFHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiHFHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:42:59 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F45E11C2F;
        Sat,  6 Aug 2022 00:42:58 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f2a4c51c45so5174081fac.9;
        Sat, 06 Aug 2022 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc;
        bh=gm6PmfQDJQW4sYrDMxD1XhD+bbbCc7CPLvJKQ3d/YUA=;
        b=nFm1VC3KyZqoM35PVnjJC5DxKdZC/EAxOULMCkmgYku12hNJHse9r+tilI7arpzEI4
         XW97kv8vll6g9DavYdBDgqRnNBRDL5yoybYUkKV3EHcWgQuIPYAB/oloj/iQ0zi7yb3Y
         WMMQouJ1RhfTC7fIVyC62peTSHMRy2+kCc8LwI3VcFZXNTrzzOzfzTYM+ey6LorLSthb
         IUQyUyJckZLyM7pLYM6HIey4/wiUGMNNMDObIG368NpCK+JKxCcJ8GaJz+DGN9gmmQj2
         OPJmjl6rYMFFrwu7kmHHhIeYtk9PrTAlgYnzyfSrHH9nZPab8827rKeJuGC7LxAHrCdi
         cfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc;
        bh=gm6PmfQDJQW4sYrDMxD1XhD+bbbCc7CPLvJKQ3d/YUA=;
        b=e1Fs6S7TW/Wz116a/IeOmyqcJ7BQWS+1zvIfkXn/UH8Km94V9EinW+Yu9NLbiFiL5c
         zKvg8MRNH+eYhserSWjVg6l2VXkrAe7u28awrz5lSdR4T7AouxBbZwDqEqQn3Z8tkcjO
         2+Z8d88V02LKhuSS2MbiJUWCNbb98JGot6Hfevw871pxN4cJKvCtI6nsFB6xvA8H58t0
         /nzdPqK5hYqJBNRI4U1/ctGqC73671qcjTQ4ACVHYB5NBYi0QOSN9yCYs/wTx5QZtL9W
         D/nfI7lvDYbQyEDtMeQl4SGUUDFerYm/ggCRr0x2G65ObjVbujCaSTKrQkDzJ7koBMso
         nHow==
X-Gm-Message-State: ACgBeo3QKWmX/QLFSTIvSPnNUdzWpi1kAyW0ri4ZTW3UKkTUuVr26xcm
        7VYCqYTDQ3KJkMs8vYAxJcdijOcMmE4mmry+T8s=
X-Google-Smtp-Source: AA6agR4Fo8ujc5fByWI5kgVAIAetbTwWMAh1ItZ7I2D+tLRyfv7bllpf/VDAeBxjnxalm+DuFixLfNMQF1TzufN+u/k=
X-Received: by 2002:a05:6870:c0d3:b0:10e:cb75:2e62 with SMTP id
 e19-20020a056870c0d300b0010ecb752e62mr8180863oad.128.1659771777435; Sat, 06
 Aug 2022 00:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
 <20220609192308.GB10732@1wt.eu> <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
 <CA+icZUUCOoE8x3Js=DYEjgyV_rz-T-M7gPZdFQu7tsKcUoA0hg@mail.gmail.com> <20220622183747.mhhlfr6aufbkyhag@alap3.anarazel.de>
In-Reply-To: <20220622183747.mhhlfr6aufbkyhag@alap3.anarazel.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Aug 2022 09:42:21 +0200
Message-ID: <CA+icZUWjnaHKmofKdGgSo3b6wuNOR_Oj=C+gU3GW9fHViYwVpQ@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Andres Freund <andres@anarazel.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, these deprecation warnings also cause perf to fail to detect libcry=
pto:
>
> test-libcrypto.c: In function =E2=80=98main=E2=80=99:
> test-libcrypto.c:11:9: error: =E2=80=98MD5_Init=E2=80=99 is deprecated: S=
ince OpenSSL 3.0 [-Werror=3Ddeprecated-declarations]
>    11 |         MD5_Init(&context);
>       |         ^~~~~~~~
> In file included from test-libcrypto.c:3:
> ...
> cc1: all warnings being treated as errors
>
>
> Perhaps it's worth applying this fix a bit more broadly?
>

Just FYI:

"perf build: Suppress openssl v3 deprecation warnings in libcrypto feature =
test"

Included in git-pull request (pending) in [2].

-Sedat-

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?=
h=3Dperf-tools-for-v6.0-2022-08-04&id=3D10fef869a58e37ec649b61eddab545f2da5=
7a79b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=
=3Dperf-tools-for-v6.0-2022-08-04
