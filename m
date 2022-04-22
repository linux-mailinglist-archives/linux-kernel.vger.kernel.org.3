Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1350BF30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiDVSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiDVR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:59:54 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41EDE7897;
        Fri, 22 Apr 2022 10:56:58 -0700 (PDT)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 23MHuSvD011330;
        Sat, 23 Apr 2022 02:56:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 23MHuSvD011330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650650189;
        bh=gk07vilBCiMI29TG7qTdTVlHsDhJg3HiwHT6cJ72G38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fAg5O2gdGVHY4nbbdUmmUdG5mXC8/4MQCXmNdC4ja0d+hmwZe3CxVp1hxdFqxdHhs
         Me4a4s6iWqATyZAlMExpIyN//XKR0Bg9vmUG2oztwirNLCmM8ITY6CWFUlx64FLxZo
         CTOoB8dXGkBaFnTfl8TIY/op63JtE8k5r/+MDmWGDTBJvEYg22dcrmHe/rP5HvN2u/
         m9Qu0biYqE4GYO+t57YzwIjfcQaQVYi6hSJckJDJRlyiNALH0oKKwvaZLxOEuShuP8
         FQNvQWxvt0Flh4w+ATPSy9Ml2rebSkjvv0YdOWdJbfPdyPGNrrmk3jB/fhNGlJqSsj
         rGxwAlRpFl54Q==
X-Nifty-SrcIP: [209.85.210.178]
Received: by mail-pf1-f178.google.com with SMTP id c1so2136975pfo.0;
        Fri, 22 Apr 2022 10:56:29 -0700 (PDT)
X-Gm-Message-State: AOAM5318QQehN3KDLA2mAGZksmGa4z3CPi+aADeHBtggp/NsmmApZ6BT
        64GN1oF2z3sSzVayocyehyj7Dc55QOkIWN+awTs=
X-Google-Smtp-Source: ABdhPJwd35httsCgLSN0X0xVey2bXAULqz0Uhk5NAIucoZobWBuOO55vYgY7fw+tZaguODtqvHUQz0wbbT9VmbGyrYU=
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id
 p2-20020a056a000a0200b004fdf9dd5494mr6119706pfh.68.1650650188191; Fri, 22 Apr
 2022 10:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220422090505.551472-1-ldewangan@nvidia.com>
In-Reply-To: <20220422090505.551472-1-ldewangan@nvidia.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 23 Apr 2022 02:55:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARLFQdm+2Ka=0U1sX9LXyqCRb3ohzjPmg3Lpfs-ZEbz7A@mail.gmail.com>
Message-ID: <CAK7LNARLFQdm+2Ka=0U1sX9LXyqCRb3ohzjPmg3Lpfs-ZEbz7A@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] scripts/Kbuild: Add path of fixeddep script
To:     Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 6:05 PM Laxman Dewangan <ldewangan@nvidia.com> wrote:
>
> Add path of the fixdep script from the object tree.
> This will make the path of script absolute rather than
> relative and execute the command from makefile from any
> location.



Why is this necessary?

Also, this patch does not make anything.
$(objtree)/ is still a relative path.
See the top Makefile.



>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  scripts/Kbuild.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index cdec22088423e..e07e9265829f8 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -147,7 +147,7 @@ if_changed_dep = $(if $(if-changed-cond),$(cmd_and_fixdep),@:)
>
>  cmd_and_fixdep =                                                             \
>         $(cmd);                                                              \
> -       scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
> +       $(objtree)/scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
>         rm -f $(depfile)
>
>  # Usage: $(call if_changed_rule,foo)
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
