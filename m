Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B745B137E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIHEX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIHEXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:23:54 -0400
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FF55B1;
        Wed,  7 Sep 2022 21:23:52 -0700 (PDT)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-09.nifty.com with ESMTP id 2884KxhN021311;
        Thu, 8 Sep 2022 13:20:59 +0900
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2884FQjq022129;
        Thu, 8 Sep 2022 13:15:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2884FQjq022129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662610527;
        bh=hG2PazrVhLlnat0uCOQ2YIFXDukWCkG/oTELTZNVU3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OP+HGzr47XzbkOsimr8OEe7+JEX+eKh/NcPe4EWgpsjWSe6Lo2vVpN6+4JW8uiHF3
         AwdYBKw+meTj+oyXEuqobUqlFyRowTDcZ+G7Ovrxf+oHL95g3ewiSnkyWQfZmDNLvV
         OeaGq43g5Oatt7STxbkME7PAVEevT6rtomDmCIG2GhZR1hFfRH2wdPT5tmEAyOiII0
         8IDg5D3Sz3yR/JRJyNTdhjoRnGaQu4IfK7jSBtpKH4maXmfTP2+Vl2sYN6OuRA11kT
         +2pYJpHAyqrjtyIIYxEOrVMhiR7ALMu9E+kPtsfHV58rigHXE5Jx9xmE/rtxGAOB91
         Q3x1j9+nyY7ag==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1225219ee46so41349220fac.2;
        Wed, 07 Sep 2022 21:15:27 -0700 (PDT)
X-Gm-Message-State: ACgBeo0SwiPrWhw3BD/2N620Dfy+rnESQ8UHnBZga8PEEc07THRYepS+
        3lH+mHExG17EP6Y0BE9R3UCCp94YTklAQA5qpRc=
X-Google-Smtp-Source: AA6agR7qmE9QSqbKQ8hYPB1iPqmm5jQGeoGPz9NvoB5OwvYIIcjgFMCsoLUlhUuRSMPUfv6gpGyn6mkLqDJ++VHaYf0=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr853669oab.287.1662610526426; Wed, 07
 Sep 2022 21:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220908100646.4cb5f02e@canb.auug.org.au>
In-Reply-To: <20220908100646.4cb5f02e@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 8 Sep 2022 13:14:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzFmJjpyUciy1LRvaFo72aZcqRbzY-63ArpeszC+HfmQ@mail.gmail.com>
Message-ID: <CAK7LNARzFmJjpyUciy1LRvaFo72aZcqRbzY-63ArpeszC+HfmQ@mail.gmail.com>
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

On Thu, Sep 8, 2022 at 9:06 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> ld: vmlinux.a: member arch/powerpc/kernel/prom_init_check in archive is not an object
> make[2]: *** [scripts/Makefile.vmlinux_o:61: vmlinux.o] Error 1
> make[1]: *** [Makefile:1166: vmlinux.o] Error 2
> make: *** [Makefile:222: __sub-make] Error 2
> Command exited with non-zero status 2
>
> I don't know what caused this.
>
> I have used the kbuild tree from next-20220907 with the top 4 commits
> reverted again.
>
> --
> Cheers,
> Stephen Rothwell



Sorry, it was a mis-conversion.
I will fix it up as follows:






diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f264d9b2cb63..ad3decb9f20b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -203,7 +203,7 @@ obj-$(CONFIG_ALTIVEC)               += vector.o
 obj-$(CONFIG_PPC64)            += entry_64.o
 obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)   += prom_init.o

-obj-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)   += prom_init_check
+extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE) += prom_init_check

 quiet_cmd_prom_init_check = PROMCHK $@
       cmd_prom_init_check = $(CONFIG_SHELL) $< "$(NM)"
$(obj)/prom_init.o; touch $@





-- 
Best Regards
Masahiro Yamada
