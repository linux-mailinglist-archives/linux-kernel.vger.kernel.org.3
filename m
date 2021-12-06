Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1146AB2B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352833AbhLFWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhLFWFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:05:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77294C061746;
        Mon,  6 Dec 2021 14:02:08 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 137so9267239wma.1;
        Mon, 06 Dec 2021 14:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u9Fmisi3SrDLjIml42mAuJxwyIDnThC6fs7s/n4dNFo=;
        b=Nquxc4aubMHq1itG8oeazi4Qbxvzd5x3l6YafC+/YfRFIn3VkBW5DXwJWgOOwMvJK6
         XFl3SOovR5YbjhPuPVxddNPVX0RM3WoDDlTTNoBk3mZ8s6hbSgsnQHGeoQ8EL6uqbx4L
         4rfzKp/AaXJXx9sDDYELXJZH3sFc7PNn+mpZldpiO3FYwqB3Dz9feGUF2e8qRANlzFG1
         Sr8YgTwNh/iN0ZyDo0DqcVub9r5xwezNqbHVJWSNUVVA3PKmPS1liC0hX5vAH7btFC62
         5zMO8YV4EkU/Wrw9K1P7esEuy9K2zdjLBLi9kuXvsP4nYvUXNnYvxG+KoB/+sCRV9yWf
         9H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=u9Fmisi3SrDLjIml42mAuJxwyIDnThC6fs7s/n4dNFo=;
        b=CjWS4WalgXPVNdyH64dIRXpWvGaM85pyAr6GchFxLBiyFUnhlGLG0onXMvtsTw4/4Z
         oQEL6t21sRF7gjWkPO8cEUnV7fS94jiAvuPlz3DOiDMQXgfz/NghtTGSGTnAh6xSxWas
         a5rU94xLbk/KOIAvCunqqWzs/k8XZA8QDK427C4SxTCKVXckK0JjgNpy51yBLuhWh4LB
         J5dbCQ+LXQxVVroVdl8gamSAoDidD5uD8OFsJvt+BS7A9UFAZleWUWL4iLAXSHgsltel
         OJQTXCBl2YRAC5O8JbDm7gxUA56m9GuIaIPr6g24hVa1ugKD8mohimLd1Ly3442P0S9Z
         mPgw==
X-Gm-Message-State: AOAM532pWrKNnPhL+qF2O2bTAEQ6li2KDOW9+KHoKiPXSrGZHpX+dBkV
        gyutAMfGeJpKlv88ur4aGEDKM4pYmvAQtQ==
X-Google-Smtp-Source: ABdhPJwXCWUa6vf+7I6Z2YfKzrbw3daSTjk+WrzD9/Gmy77bzmFaxshhKHLl44ZUHFmokCU/OGPyJA==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr1582090wmb.87.1638828126974;
        Mon, 06 Dec 2021 14:02:06 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id v6sm619630wmh.8.2021.12.06.14.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:02:06 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 6 Dec 2021 23:02:05 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Makefile: CC_IMPLICIT_FALLTHROUGH passed quoted as argument to
 gcc
Message-ID: <Ya6IXWBGkN1iZI1b@eldamar.lan>
References: <YatpectAYsWnmPy2@eldamar.lan>
 <CAHk-=whTTWUyL5j5_-UeRT6k9VcJM_VOfjiKuU2NBJkxhbnXpw@mail.gmail.com>
 <CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com>
 <202112061128.6B670358@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112061128.6B670358@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 06, 2021 at 11:53:41AM -0800, Kees Cook wrote:
> On Sun, Dec 05, 2021 at 02:54:05AM +0900, Masahiro Yamada wrote:
> > On Sun, Dec 5, 2021 at 1:53 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Sat, Dec 4, 2021 at 5:13 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
> > > >
> > > > Andreas suggested to replace the
> > > >
> > > > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> > > >
> > > > with
> > > >
> > > > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst "%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))
> > >
> > > Ugh. I think the external build environment is a bit broken, but
> > > whatever. The above is ugly but I guess it works.
> > >
> > > Another alternative would be to make the Kconfig strings simply not
> > > have '"' as part of them.
> > >
> > > When you do
> > >
> > >     a = "hello"
> > >     print $a
> > >
> > > in any normal language, you generally wouldn't expect it to print the
> > > quotes, it should just print the bare word.
> > >
> > > But that's what the Kconfig string language basically does in this
> > > case. And I guess several users expect and take advantage of that ;(
> > >
> > > Masahiro? Comments?
> > 
> > Yes, you get to the point.
> > 
> > In fact, this is in my TODO list for a while
> > (and this is the reason I was doing prerequisite Kconfig refactoring
> > in the previous development cycle).
> > I will try to find some spare time to complete this work.
> > 
> > 
> > 
> > Kconfig generates two similar files,
> > 
> >  -   .config
> >  -   include/config/auto.conf
> > 
> > Changing the format of the .config is presumably problematic
> > since it is the saved user configuration as well.
> > 
> > It is possible (and more reasonable) to change include/config/auto.conf
> > so strings are not quoted.
> > 
> > In Makefiles, quotations are just normal characters; they have no
> > special functionality.
> > 
> > So, in Makefile context, it is more handy to do
> > 
> >      CONFIG_X=foo bar
> > 
> > instead of
> > 
> >     CONFIG_X="foo bar"
> > 
> > 
> > 
> > One problem is include/config/auto.conf is included not only by Makefiles
> > but also by shell scripts.
> > 
> > 
> > In shell context, the right hand side must be quoted
> > in case the value contains spaces.
> > 
> >    CONFIG_X="foo bar"
> > 
> > 
> > 
> > My plan is to fix
> >   scripts/link-vmlinux.sh
> >   scripts/gen_autoksyms.sh
> > etc. to not directly include the auto.conf.
> > Later, change Kconfig to generate the auto.conf without "".
> > 
> > 
> > 
> > In the meantime,
> > 
> > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst
> > "%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))
> > 
> >  or if you prefer slightly shorter form,
> > 
> > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
> > 
> > will be a workaround.
> 
> It'll be nice to get this fixed. There are a few places where there is
> a test for a compiler flag in Kconfig, and then the option is repeated
> in the Makefile, due to the above quoting issues. For example:
> 
> arch/arm64/Kconfig:
> 	config CC_HAS_BRANCH_PROT_PAC_RET
> 	     # GCC 9 or later, clang 8 or later
> 	     def_bool $(cc-option,-mbranch-protection=pac-ret+leaf)
> 
> arch/arm64/Makefile:
> 	branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
> 
> 
> I like the $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%) solution: it's short.

Does the following look correct, as well from formal style/commit
description? I have not yet done many contributions directly.

Regards,
Salvatore

From c2d01ea3ee1c7cc539468bba5b25522245d513de Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Mon, 6 Dec 2021 21:42:01 +0100
Subject: [PATCH] Makefile: Do not quote value for
 CONFIG_CC_IMPLICIT_FALLTHROUGH

Andreas reported that a specific build environment for an external
module, being a bit broken, does pass CC_IMPLICIT_FALLTHROUGH quoted as
argument to gcc, causing an error

	gcc-11: error: "-Wimplicit-fallthrough=5": linker input file not found: No such file or directory

Until this is more generally fixed as outlined in [1], by fixing
scripts/link-vmlinux.sh, scripts/gen_autoksyms.sh, etc to not directly
include the include/config/auto.conf, and in a second step, change
Kconfig to generate the auto.conf without "", workaround the issue by
explicitly unquoting CC_IMPLICIT_FALLTHROUGH.

 [1] https://lore.kernel.org/linux-kbuild/CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com/

Reported-by: Andreas Beckmann <anbe@debian.org>
Link: https://bugs.debian.org/1001083
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8e35d7804fef..ef967a26bcd3 100644
--- a/Makefile
+++ b/Makefile
@@ -789,7 +789,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 KBUILD_CFLAGS += $(stackp-flags-y)
 
 KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
-KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
+KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
-- 
2.34.1

