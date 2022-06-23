Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A084C557778
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiFWKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFWKJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:09:33 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940449C8E;
        Thu, 23 Jun 2022 03:09:31 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 25NA94Bt030361;
        Thu, 23 Jun 2022 19:09:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25NA94Bt030361
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655978945;
        bh=VrNJeZOOoxsp333/0m3wcHIZFYPss3hVZ7DqYZoPrEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zQA+le9IcciER0KVbr4wwcg45cS/xUXk6UDnJ05NNPEGXAy6mZvYU29OYi6lOmJEZ
         dgJmSlfrN/J3ioaPTbHcRP3MoR+bi3wKC1A39Uo2werJvmHuTh+/N/DBHshfLa8h5x
         1KA0M+tYRkk+3Q/ZxW+NLhk85uUAOY73kSuCeYWHH7L5ysp8UFD+4GXrw5K3NkSPR+
         W6hjnCN2C9Ge++kHVdNZ/U3gkZpnVYBOKl210mKwOkTz2HnSRPi4mXnacffBqQEj02
         pjI2FX0cR8u0o4ODTO59clnyBCn/+T/9FmhWxTBCNy0Au3mLtcyF3iKsTMZj/rgNEJ
         g60XnIXZ1PYkQ==
X-Nifty-SrcIP: [209.85.221.44]
Received: by mail-wr1-f44.google.com with SMTP id i10so23445662wrc.0;
        Thu, 23 Jun 2022 03:09:05 -0700 (PDT)
X-Gm-Message-State: AJIora+W09s21WkSli2lBE5mN+rHZP5FXSCm3zhba9uSrCUR71XykZL8
        mR85CoELnkw2HxYWY8t9FC3eoYEAM7fRuNkVpHQ=
X-Google-Smtp-Source: AGRyM1u7Aj3TAT/slcXrcHpTGlaaLYJnoGxhHEYAeEWyxd0XvUfEyAr2bl7pqK36JG8IT4+F4pFKmCDdxplz3OpMf4c=
X-Received: by 2002:adf:e104:0:b0:21b:9938:b07a with SMTP id
 t4-20020adfe104000000b0021b9938b07amr7634574wrz.682.1655978943781; Thu, 23
 Jun 2022 03:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220613170902.1775211-1-masahiroy@kernel.org>
 <20220613170902.1775211-2-masahiroy@kernel.org> <YrMdnEB686tSGARZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <YrMdnEB686tSGARZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Jun 2022 19:08:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHTwxfNC9QJDGBiw+z4LN-wFmXsAKXOsVa_JU0K-nuUw@mail.gmail.com>
Message-ID: <CAK7LNATHTwxfNC9QJDGBiw+z4LN-wFmXsAKXOsVa_JU0K-nuUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] s390/purgatory: hard-code obj-y in Makefile
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:48 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Tue, Jun 14, 2022 at 02:09:01AM +0900, Masahiro Yamada wrote:
> > The purgatory/ directory is entirely guarded in arch/s390/Kbuild.
> > CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.
> >
> > $(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
> > this Makefile for building.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/s390/purgatory/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> > index 360ada80d20c..3e2c17ba04de 100644
> > --- a/arch/s390/purgatory/Makefile
> > +++ b/arch/s390/purgatory/Makefile
> > @@ -51,4 +51,4 @@ $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
> >  $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
> >       $(call if_changed_rule,as_o_S)
> >
> > -obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
> > +obj-y += kexec-purgatory.o
>
> Applied, thanks!
>
> BTW, it looks like x86 and riscv also need similar change.

A patch for x86 exists:

https://lore.kernel.org/all/20220616072407.2317131-1-masahiroy@kernel.org/


I will send riscv patches later.


> In addition, x86 use of CONFIG_ARCH_HAS_KEXEC_PURGATORY vs CONFIG_KEXEC_FILE
> is not consistent with other architectures (may be even incorrect?).

I thought of this when I reworked Makefiles,
but did not touch this part.


>
> > --
> > 2.32.0
> >



-- 
Best Regards
Masahiro Yamada
