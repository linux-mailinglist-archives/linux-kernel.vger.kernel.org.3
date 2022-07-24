Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42357F5A9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiGXPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGXPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:12:54 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4C10FC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:12:52 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 26OFCTLe022149
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:12:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 26OFCTLe022149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658675550;
        bh=HGsWCFN3BHe6uNlHDIT4Yctp2cqY3p09Pa/AjDwfL2Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eeHTr87m0iPkx+9cA2VY98qO6+uK3vaBAXolWOKry/MroKxBtpcVgU0SG7Ngsf+ra
         JWyj5ztW8R75NxVZJ4xxB8q+T7pqE2dWCCEpPQi+jHKtRh1gK0JwrTGp/aoyHc4Avu
         UNAgJbyEGuAoLvdp/R2HkNfObUpuaDYcT5YkOSpbcAzVjl0E3CEzkeHEXhF1fobcTx
         +J+yLDJOceZOrCU1y6fcNbrjKCiVoFjDmUYphszQSeil6NmgKFeCwmY5ct5guiTxhW
         yHHP0UKOUiCNlCW3UCOXPeefA2ieZGX9Ldpjte4WuffBbaryxbGGfOGzmUcT/bb2za
         UldyeaUgNuX7A==
X-Nifty-SrcIP: [209.85.128.43]
Received: by mail-wm1-f43.google.com with SMTP id id17so5392005wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:12:30 -0700 (PDT)
X-Gm-Message-State: AJIora/FSMeV8PGiMDUEbVqxy8WKackzu9ftR/BbvZBGrne7ebs+XMJX
        l8L/8zOcnksbgPsob32GhamPAyW4e4vIOHrcwCk=
X-Google-Smtp-Source: AGRyM1s4czIVF2XXqbr6X1iQkpb6hXmbEEbVLET9J+VXOIV/P8hvwm8QayTCLt5SbBuomZYULtP6eQBayx0w+BgLP7s=
X-Received: by 2002:a05:600c:a18e:b0:3a3:10ef:672a with SMTP id
 id14-20020a05600ca18e00b003a310ef672amr17859821wmb.14.1658675548437; Sun, 24
 Jul 2022 08:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220616072407.2317131-1-masahiroy@kernel.org>
In-Reply-To: <20220616072407.2317131-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Jul 2022 00:11:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATU5ynS+Rikrd=ikfYWvBEuO+uQZ3mj-=sTLY9zHoHjMw@mail.gmail.com>
Message-ID: <CAK7LNATU5ynS+Rikrd=ikfYWvBEuO+uQZ3mj-=sTLY9zHoHjMw@mail.gmail.com>
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

On Thu, Jun 16, 2022 at 4:25 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> arch/x86/Kbuild guards the entire purgatory/ directory, and
> CONFIG_KEXEC_FILE is bool type.
>
> $(CONFIG_KEXEC_FILE) is always 'y' when this directory is being built.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Ping?


>
>  arch/x86/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index ae53d54d7959..248b009c4061 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
>         $(call if_changed,bin2c)
>
> -obj-$(CONFIG_KEXEC_FILE)       += kexec-purgatory.o
> +obj-y += kexec-purgatory.o
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
