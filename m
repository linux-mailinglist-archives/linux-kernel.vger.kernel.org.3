Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2AA53ECBE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiFFRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFFRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:09:17 -0400
X-Greylist: delayed 198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 09:57:11 PDT
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE0E64;
        Mon,  6 Jun 2022 09:57:11 -0700 (PDT)
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-05.nifty.com with ESMTP id 256GoaT7003088;
        Tue, 7 Jun 2022 01:50:36 +0900
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 256Go78p015542;
        Tue, 7 Jun 2022 01:50:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 256Go78p015542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654534207;
        bh=JczM4pY/KqVyXbgBAdJHth13hYHYPz2AUgD+NORgP88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cAA51L+u6zio7BDf+AdzTL9IFahNNoK+IiMW9NRdKxUe5ulchRLVG+jZitDOo7hCF
         sdUTF5rd30GYnQMqlnwteZvMnK/XrFclvTkM6QcStqmQK68Y5HUF3OpFB68sWa4BpB
         ALQSELRdNsP11YD82PkkK7hzoStrvAW73FTUx0zD7fgBvgVmETvRc0CitfBaezA/r8
         pfWFIMh7qyTRR687u78y9ER6r6FcuIwRbO4uk7DRBrpf5KTvbHJw7HpEdEBjO3HY/V
         HhsA3iMg3t8XZm5JVkk2IUarrT2h5lIJx/j2M6StoLXlrjfkbRGh2eonb7xGSnIKrY
         nuOqr164blPnw==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso12099561pjb.0;
        Mon, 06 Jun 2022 09:50:07 -0700 (PDT)
X-Gm-Message-State: AOAM531dL2bC7wLFd4aneYQtoCWquitJXp10p6Hz45neUApa37+DETRS
        YledxK2+T2Jf4sWZ3t3PiAmb5ZMk9Qf+gBfYP18=
X-Google-Smtp-Source: ABdhPJyatm0uoax8ecbzLyDvchHcD4De61uzjEguhfJ0F6MA1SImvv9cNdnotdQnMjAPMkpOUCkaUUJZRyJxjCLVyU0=
X-Received: by 2002:a17:902:f687:b0:167:58bb:c43f with SMTP id
 l7-20020a170902f68700b0016758bbc43fmr15048539plg.136.1654534206608; Mon, 06
 Jun 2022 09:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
In-Reply-To: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Jun 2022 01:49:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-0kQOvt=7TNn0osf9JO5hZhSp9PaFFBsSx++2Pevc9g@mail.gmail.com>
Message-ID: <CAK7LNAS-0kQOvt=7TNn0osf9JO5hZhSp9PaFFBsSx++2Pevc9g@mail.gmail.com>
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 9:32 PM David Howells <dhowells@redhat.com> wrote:
>
> There's a rule in certs/Makefile for which the command begins with eight
> spaces.  This results in:
>
>         ../certs/Makefile:21: FORCE prerequisite is missing
>         ../certs/Makefile:21: *** missing separator.  Stop.
>
> Fix this by turning the spaces into a tab.
>
> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are vali=
d")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: keyrings@vger.kernel.org


Not only 8-space indentation, but also:

  - config_filename does not exist
  - $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX) is always empty
  - $(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) is always empty


> ---
>
>  certs/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/certs/Makefile b/certs/Makefile
> index bb904f90f139..cb1a9da3fc58 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -18,7 +18,7 @@ CFLAGS_blacklist_hashes.o +=3D -I$(srctree)
>
>  targets +=3D blacklist_hashes_checked
>  $(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)=
$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk F=
ORCE
> -       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_=
LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
> +       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_=
LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_hashes.o
>  else
>  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_nohashes.o
>
>


--
Best Regards
Masahiro Yamada
