Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8042A5313F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiEWQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbiEWQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:01:39 -0400
X-Greylist: delayed 37374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 09:01:35 PDT
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16E0186D0;
        Mon, 23 May 2022 09:01:31 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 24NG1I0J011245;
        Tue, 24 May 2022 01:01:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 24NG1I0J011245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653321678;
        bh=nzqFcuEyx/MuWRxIhkFKZ05YKWhIDvaI4AOGehk/eQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bpM6k/YREumRwR1wV+o7WygPJZgEEa/ctjJYwTEJ2ioa2gRSkcevQOL8I0abhh7Xk
         G/tWYUOtcRwjNcFKoWRKOzI1nUBzx1Y3ivuoc3ARyHb5v2h3LJB52aWS+NYVksXhHd
         Bbqrbvr1E7VxpwMgEkxJva53m7AJJUYHJGzXTt7bJ4kPtU6KVhMJPOgUcybTMksFla
         ix4527FtvqcaoqZIg3ArIW/z0u+0L5GNAs+OTkIB5yJTXG42cT/74FPkwDZWb3EgOT
         RPc3QAYRPbgCVo/VdPYIx5N+Wrot0PuGrz4Sru6a4/pEVfu6i5w4lH0o98zfzKGO4A
         izfINEMOoUHJw==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id w200so14084353pfc.10;
        Mon, 23 May 2022 09:01:18 -0700 (PDT)
X-Gm-Message-State: AOAM531kBuuFzLRS32QQX1pZBecFePtF3LTKuGXfLubjA6/aPlOXC5QH
        lvc1MbSVSyZ5NisZWR22rfbv1Hy10mjp6bvkzWk=
X-Google-Smtp-Source: ABdhPJz8T55c2giO315+2kau6VgxZ8KUP01sqeHrFD1N0OM+wHS+FuNhPvqHv8mULyzZO18CHDXB1DoEzgUCF1xv0V4=
X-Received: by 2002:a65:48c1:0:b0:3fa:74c6:3997 with SMTP id
 o1-20020a6548c1000000b003fa74c63997mr3019714pgs.352.1653321677651; Mon, 23
 May 2022 09:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220523205927.4dbeb49f@canb.auug.org.au>
In-Reply-To: <20220523205927.4dbeb49f@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 00:59:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjc5h-Ffg4Mx0--hs2C35_n_Db2yTiyzmeguH+F0mLaA@mail.gmail.com>
Message-ID: <CAK7LNAQjc5h-Ffg4Mx0--hs2C35_n_Db2yTiyzmeguH+F0mLaA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 7:59 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (sparc64
> defconfig) failed like this:
>
> make[3]: *** Deleting file 'arch/sparc/vdso/vclock_gettime.o'
> scripts/check-local-export: line 36: symbol_types[${name}]: bad array subscript
>
> Caused by commit
>
>   86e4cdec74f0 ("kbuild: check static EXPORT_SYMBOL* by script instead of modpost")
>
> I have reverted that commit for today.
>
> --
> Cheers,
> Stephen Rothwell


Thanks.
I fixed my branch.
I confirmed a successful build for sparc64 defconfig.




-- 
Best Regards
Masahiro Yamada
