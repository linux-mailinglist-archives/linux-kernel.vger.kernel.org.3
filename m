Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A193508D23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380511AbiDTQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356606AbiDTQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:25:34 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53EA3BBD5;
        Wed, 20 Apr 2022 09:22:46 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 23KGMIkk021847;
        Thu, 21 Apr 2022 01:22:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 23KGMIkk021847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650471738;
        bh=hSghgo28tPshWHNBgXBTOoNSxfSj/hgMHHaeBYkSOZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BC+K4G/1+4nemFxSWG2kY9O8RSMyj0UKoZNCbe5tKXa8dasZviAYWyJjXsgwpZi0p
         RvVb1ur0pHuFz+AXxjZdP24kFHPQxOORaB+R7lv4jrxa2gqt1sYJaVR2jy2jcPfAFU
         Qwgh7D0wU3F/9FYk82lsJ6CRgWMiXnETL0EpywSFYenrob2drGD4cxvGxqXb/XxcnQ
         1SbYJ8xwLLdsJkwZUS4HcGvLSBbyWAmwZ71tQkWGB9g6/ZLloCrnmrhnj1vuA7Hyre
         ce3tFYnPfklrunZoV79dBc21fneeaIm4ubzt5SRbTFwPnE0D1SOmCS4MZe/IbO64bX
         R/jGRwEq4U3nw==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so2500872pjb.1;
        Wed, 20 Apr 2022 09:22:18 -0700 (PDT)
X-Gm-Message-State: AOAM532zb10IaETVnzDAX3e/Zt7Z4Yw/0TV9Hv/Nk7A4BqqZEc7/aMZN
        JlJoDpzprk0Ode3MagdW4WvR/Mvq6oyCt8IGrn8=
X-Google-Smtp-Source: ABdhPJy0Dc33juoX85l4KZAZfbiiAUSwWwAlIq+RNjSLUNzgmCNiy2O324oO/W8qyAzJM7doeMV6xHGqUbuSB+5C3sc=
X-Received: by 2002:a17:90a:b396:b0:1cd:44cc:15a9 with SMTP id
 e22-20020a17090ab39600b001cd44cc15a9mr5262160pjr.77.1650471737669; Wed, 20
 Apr 2022 09:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220419063009.25352-1-jslaby@suse.cz>
In-Reply-To: <20220419063009.25352-1-jslaby@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 21 Apr 2022 01:21:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKyaXAnZSM_ob-rZR_8ALdW+jugoN8uJ3RB+4jKObVkA@mail.gmail.com>
Message-ID: <CAK7LNAQKyaXAnZSM_ob-rZR_8ALdW+jugoN8uJ3RB+4jKObVkA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: dummy-tools, add pahole
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Apr 19, 2022 at 3:30 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> CONFIG_PAHOLE_VERSION is a part of a config since the commit below. And
> when multiple people update the config, this value constantly changes.
> Even if they use dummy scripts.
>
> To fix this, add a pahole dummy script returning v99.99. (This is
> translated into 9999 later in the process.)
>
> Thereafter, this script can be invoked easily for example as:
> make PAHOLE=scripts/dummy-tools/pahole oldconfig

Applied to linux-kbuild.
Thanks.


> Fixes: 613fe1692377 (kbuild: Add CONFIG_PAHOLE_VERSION)
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> [v2] don't touch Makefile, add only the pahole script
>
>  scripts/dummy-tools/pahole | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100755 scripts/dummy-tools/pahole
>
> diff --git a/scripts/dummy-tools/pahole b/scripts/dummy-tools/pahole
> new file mode 100755
> index 000000000000..53501a36fa71
> --- /dev/null
> +++ b/scripts/dummy-tools/pahole
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +echo v99.99
> --
> 2.35.3
>


-- 
Best Regards
Masahiro Yamada
