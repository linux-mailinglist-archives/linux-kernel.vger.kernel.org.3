Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA857F4A0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiGXKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 06:06:38 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40A11A13;
        Sun, 24 Jul 2022 03:06:36 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 26OA6Kqo024887;
        Sun, 24 Jul 2022 19:06:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 26OA6Kqo024887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658657181;
        bh=ArebNEWiyjerFvTtY4cbYP6+/ARuF+wI8lvKM3c8Ws0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rw1/mJbjHGOqJ8piBUzYTE5AmYioPS2H/v+DGTKXmzXS8F6IsDyelETSoc67KO9ED
         8v2Ccu7hALvASelX5RPbgOCE8SrkjjQTyVN7HSRuqj39QL0ILz36GQltNU2bWeytTF
         qQ026lnX4U4w9WVwsZ3cWCQsZOCWXoc1lTnfmqQ9UC2/LvFs+uppavZxKHtDXLkE5h
         sLOFtnk3xamfGZTrY3WRVserRMy3r23E6Ik8YBK9kitaU+tRWilzGb1EJMU0VBprLb
         um3BKZrn7vqIuP5IerWdd6IBWfvsCHYqpHh+8iZAB9c4jLXLg+ap8Pyn9wqxHo6B/4
         rJ5fvufBq3imA==
X-Nifty-SrcIP: [209.85.128.49]
Received: by mail-wm1-f49.google.com with SMTP id b6so5126750wmq.5;
        Sun, 24 Jul 2022 03:06:21 -0700 (PDT)
X-Gm-Message-State: AJIora+I7i40ABE2njYmkmBEPErJei+kFOmHxP8enpyK+f8mKrCAR884
        F3o0E+8g2qRZB/CfBCnv8qUjKJwbiRbpnwWAiyI=
X-Google-Smtp-Source: AGRyM1ul/uKtQPMxDxp7ik972LQ/WFlF/J8K/iAYTjT9dlnh/JN/kfVcae7x7/j+xaUbScgaV0ec9q7oPFfjHPKuDys=
X-Received: by 2002:a05:600c:a42:b0:39c:9086:8a34 with SMTP id
 c2-20020a05600c0a4200b0039c90868a34mr18134146wmq.169.1658657179509; Sun, 24
 Jul 2022 03:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220720173749.7487-1-rdunlap@infradead.org>
In-Reply-To: <20220720173749.7487-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 24 Jul 2022 19:05:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5uc5Ypw2MaukjbQbf9gXh0QpnhUpps7kNAeEbkF12og@mail.gmail.com>
Message-ID: <CAK7LNAR5uc5Ypw2MaukjbQbf9gXh0QpnhUpps7kNAeEbkF12og@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Qt5: tell the user which packages are required
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 2:38 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Along with saying "Please install Qt5 ...", tell exactly which
> parts of Qt5 are needed. This is useful when parts of Qt5 are
> installed but some of the required pieces are missing, and it
> eliminates the need for the user to find the shell script and
> the line in it that provide that information.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org

Applied to linux-kbuild.
Thanks.

> ---
>  scripts/kconfig/qconf-cfg.sh |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/scripts/kconfig/qconf-cfg.sh
> +++ b/scripts/kconfig/qconf-cfg.sh
> @@ -20,5 +20,6 @@ fi
>  echo >&2 "*"
>  echo >&2 "* Could not find Qt5 via ${HOSTPKG_CONFIG}."
>  echo >&2 "* Please install Qt5 and make sure it's in PKG_CONFIG_PATH"
> +echo >&2 "* You need $PKG"
>  echo >&2 "*"
>  exit 1



-- 
Best Regards
Masahiro Yamada
