Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3451DBED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442830AbiEFPap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442827AbiEFPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:30:42 -0400
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 08:26:59 PDT
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8468984;
        Fri,  6 May 2022 08:26:58 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 246FQflB011870;
        Sat, 7 May 2022 00:26:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 246FQflB011870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651850801;
        bh=LmXHJc7oS/PdyQsdT4vljgxE8B3aIXzCpMb9Ra3kshk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Stmbmn59ldEy+GBFGp+8r7kSYvon0E/wzy4D0iQ2lRVtg6hEUJgtNxNTQFKMaDQrm
         m+SMgUTchbK3NpBkyG1hcqzKzK1WtHSuzytHZLUZqeZzWWP5vn/C9S4O2NH7ZNZ1/m
         xCUnkPrtXhLsinFXJ8I1nRFZC/3BB5Teis5AbuFIwsO/aGi68B7uS/PhGNoS5/e6uz
         OFI3Wdt+dPH+c3jfVNYaJ+ldbu9rgQXAUVVVj+FbKnBWlMarjgEa/+B0dsu8HkcQiM
         nl1Li5jPfifDYYUYsU4VkdTVJGkdbZb3AWkOoy+75h1dasEyUTJcN6i+8qIIs0+LBV
         upgA55hQ194kA==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so7187250pjf.0;
        Fri, 06 May 2022 08:26:41 -0700 (PDT)
X-Gm-Message-State: AOAM532n7NYPX+uVMAYhWhnrQOJOOdBz5uxc+gFDA2TfNeKqgORh2n5R
        KYPg+Yi+KeGHHVwVoXF6KnJw5Gv9Okzhua97oP4=
X-Google-Smtp-Source: ABdhPJylpUvnnvUM3y2luvBKZgMp7DeP8Xi0cYmH+fbBhmGmj3nClkerUgf9xMXdQcoZ/35a/cKoEYyH4aK7EMOT7pg=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr4681022pjy.77.1651850800724; Fri, 06
 May 2022 08:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220501130749.1123387-1-masahiroy@kernel.org> <YnT3GtU975OsXVuN@gondor.apana.org.au>
In-Reply-To: <YnT3GtU975OsXVuN@gondor.apana.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 7 May 2022 00:25:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASkQ_14NYu7K_eEOG4boBMpKEXyrOzDJMOjcT5paC7E1A@mail.gmail.com>
Message-ID: <CAK7LNASkQ_14NYu7K_eEOG4boBMpKEXyrOzDJMOjcT5paC7E1A@mail.gmail.com>
Subject: Re: [PATCH] crypto: vmx - Align the short log with Makefile cleanups
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,



On Fri, May 6, 2022 at 7:23 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sun, May 01, 2022 at 10:07:49PM +0900, Masahiro Yamada wrote:
> > I notieced the log is not properly aligned:
> >
> >   PERL drivers/crypto/vmx/aesp8-ppc.S
> >   CC [M]  fs/xfs/xfs_reflink.o
> >   PERL drivers/crypto/vmx/ghashp8-ppc.S
> >   CC [M]  drivers/crypto/vmx/aes.o
> >
> > Add some spaces after 'PERL'.
> >
> > While I was here, I cleaned up the Makefile:
> >
> >  - Merge the two similar rules
> >
> >  - Remove redundant 'clean-files' (Having 'targets' is enough)
> >
> >  - Move the flavour into the build command
> >
> > This still avoids the build failures fixed by commit 4ee812f6143d
> > ("crypto: vmx - Avoid weird build failures").
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  drivers/crypto/vmx/Makefile | 17 +++--------------
> >  1 file changed, 3 insertions(+), 14 deletions(-)
>
> Patch applied.  Thanks.


Sorry, I just noticed the 0day bot had reported the error.

I sent v2.    (CONFIG_LITTLE_ENDIAN  --> CONFIG_CPU_LITTLE_ENDIAN)

https://lore.kernel.org/lkml/20220506150820.1310802-1-masahiroy@kernel.org/


Could you replace it, or fix it up, please?





--
Best Regards
Masahiro Yamada
