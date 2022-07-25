Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF29557F81F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiGYCCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGYCCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:02:32 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1F55AC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:02:31 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 26P22HFd008916
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:02:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 26P22HFd008916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658714538;
        bh=mjrDu3JhNAosJ7ziREvCXUAWyc4kFyj0qGkKTNy97CM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rc0s6HPy0cVo5C9bSbM2xPt0X0ZhFo2Xn1eF0gJNL+GRqhYoD3yUwD/5pqIB3nbXi
         qYXGLTkBMLFOOcawTUdh3gcEqY6qVXccS3QTNHrKSHxvaNv+okzV5rC9v3uX4D+7nV
         r+JmuL7hMyVIUknXT4jDwVzgJzmPE3FE5cQFrJgD246OgYqQAHNQe3lDHx9NweagZP
         jlLXKGSsJlf/AuwMrrRb6CHR/RYyTmAshA6dzyCJgD8Ssy0FqXjoDGB6lhlEky/1vh
         Qs3fTZO7B+Fr9UhkkudWXG0ZOQmPjhbSXOZgE7gA2fkZKKzhT7EJYEVntweVqnqX/I
         H1wuEidZr/FuQ==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id b26so14022251wrc.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:02:18 -0700 (PDT)
X-Gm-Message-State: AJIora/YaX2U2qLaQjVRpiwkE/n9s+S3gjMHUTUcOUdYnSnpsSMsVmd1
        bSDHESqWdG/mbq9+NoMYGYsQTt4A85K1f3lpjv0=
X-Google-Smtp-Source: AGRyM1ueXYt0pCM+FSlEmorcbAm6TYU7xX+wvbfIIiV0C0V+aUZwvpNdo4dd32IcH8ysSZRa12oJzwoIWdp+69xQyiQ=
X-Received: by 2002:adf:d1e2:0:b0:21d:d40b:d816 with SMTP id
 g2-20020adfd1e2000000b0021dd40bd816mr6048091wrd.682.1658714536781; Sun, 24
 Jul 2022 19:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220616072407.2317131-1-masahiroy@kernel.org> <CAK7LNATU5ynS+Rikrd=ikfYWvBEuO+uQZ3mj-=sTLY9zHoHjMw@mail.gmail.com>
In-Reply-To: <CAK7LNATU5ynS+Rikrd=ikfYWvBEuO+uQZ3mj-=sTLY9zHoHjMw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Jul 2022 11:01:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuLq7Qgnr7oVUETriUv_HqCk0WGwffhyNL3UH_MEyVDQ@mail.gmail.com>
Message-ID: <CAK7LNATuLq7Qgnr7oVUETriUv_HqCk0WGwffhyNL3UH_MEyVDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/purgatory: hard-code obj-y in Makefile
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 12:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Jun 16, 2022 at 4:25 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > arch/x86/Kbuild guards the entire purgatory/ directory, and
> > CONFIG_KEXEC_FILE is bool type.
> >
> > $(CONFIG_KEXEC_FILE) is always 'y' when this directory is being built.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> Ping?

There is a typo.
I will send v2.



>
>
> >
> >  arch/x86/purgatory/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index ae53d54d7959..248b009c4061 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
> >  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
> >         $(call if_changed,bin2c)
> >
> > -obj-$(CONFIG_KEXEC_FILE)       += kexec-purgatory.o
> > +obj-y += kexec-purgatory.o
> > --
> > 2.32.0
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
