Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DA4D2C68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiCIJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiCIJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:45:37 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF7151D34;
        Wed,  9 Mar 2022 01:44:39 -0800 (PST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2299i8Kf002563;
        Wed, 9 Mar 2022 18:44:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2299i8Kf002563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646819048;
        bh=hER4wDkzPDYeuX5YXTCLHWyPMXmQXlfRNI070LS7Fuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H99cnKd8zfHlSN+CKGTeyjHRQ5zlIhQClYWZ+AL63xqVFu76fzZKaBTOIQDB11s2l
         lPDoOoAGXAJZT1YUZiiKK1v1Axuy/4qYRQI+HJaOxcpLGkDnfr+WZnyOrAPv4cv+JJ
         eL4oLrYRAKoMXwbfmEG580AznAN+C8a8O1tZT36TgclPBXEQQXFf04d9phgFMjJEwa
         nJuQF7sL2MNaKwupQN49MoYOOMLimtzkYxHWo76t9lRQN3KXNomIpUAf76ZQy0mUbb
         5S+Ks3cMI1aXVueAiSvHIPzsaSZ7yC3yrxW8OCrx0jLh/tMtQQjI4aVLfpvZE4Hy6i
         lBYbwYwQO3Ujg==
X-Nifty-SrcIP: [209.85.216.43]
Received: by mail-pj1-f43.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so1813522pjb.3;
        Wed, 09 Mar 2022 01:44:08 -0800 (PST)
X-Gm-Message-State: AOAM530cMh+6NmzSZFUk5CwIhCRt75eIVrUor87z6To/6bHhBrjbsKiD
        kDOh7TPQDv0rgyu+F7OfKK8d3r61LrIQ8W/2wuc=
X-Google-Smtp-Source: ABdhPJz2fauvco4w6RuKKrHiTRo7Qd0dBbamxof+G6aateU579cidz8KSDjhBTyIyYLpGM0SBFLZPLoaR+Hvz2P0jsk=
X-Received: by 2002:a17:902:eb84:b0:151:f80e:e98b with SMTP id
 q4-20020a170902eb8400b00151f80ee98bmr10573528plg.99.1646819047532; Wed, 09
 Mar 2022 01:44:07 -0800 (PST)
MIME-Version: 1.0
References: <87v8wo25we.fsf@irisa.fr>
In-Reply-To: <87v8wo25we.fsf@irisa.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 9 Mar 2022 18:43:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNATrTGhyHSkoZSXVyJM8nZfG3RF8U=pvA7Te8Bt0iW7E7g@mail.gmail.com>
Message-ID: <CAK7LNATrTGhyHSkoZSXVyJM8nZfG3RF8U=pvA7Te8Bt0iW7E7g@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: add KCONFIG_ALLCONFIG support for tinyconfig
To:     Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Acher <mathieu.acher@irisa.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 5:40 PM Randrianaina Georges Aaron
<georges-aaron.randrianaina@irisa.fr> wrote:
>
> Since f8f0d06438e5, tinyconfig overrides KCONFIG_ALLCONFIG to include
> kernel/configs/tiny-base.config. However, this ignores user's preset if
> defined.
>
> This modification checks if the user has set KCONFIG_ALLCONFIG and if so,
> concatenates it with kernel/configs/tiny-base.config to be used as preset
> config symbols.
>
> Changes in v2:
> - Remove `<(echo)` in the cat command as it is not portable
> - Add $(srctree) in presets' path to make it compatible with O=<dir>
>
> Signed-off-by: Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
> ---
>  scripts/kconfig/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index b8ef0fb4bbef..58a677db9a73 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -102,7 +102,13 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c
>
>  PHONY += tinyconfig
>  tinyconfig:
> +ifeq ($(KCONFIG_ALLCONFIG),)
>         $(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.config $(MAKE) -f $(srctree)/Makefile allnoconfig
> +else
> +       $(Q)cat $(srctree)/$(KCONFIG_ALLCONFIG) $(srctree)/kernel/configs/tiny-base.config > $(srctree)/.tmp.config


No.  Please remove $(srctree)/ from .tmp.config

You should never ever write anything to $(srctree)
when O= is given.


$(srctree)/$(KCONFIG_ALLCONFIG) does not work well.
It works only when KCONFIG_ALLCOFIG is relative to $(srctree).
It does not work if it is absolute for example.








> +       $(Q)KCONFIG_ALLCONFIG=$(srctree)/.tmp.config $(MAKE) -f $(srctree)/Makefile allnoconfig
> +       $(Q)rm -f $(srctree)/.tmp.config
> +endif
>         $(Q)$(MAKE) -f $(srctree)/Makefile tiny.config
>
>  # CHECK: -o cache_dir=<path> working?
> --
> 2.34.1



-- 
Best Regards
Masahiro Yamada
