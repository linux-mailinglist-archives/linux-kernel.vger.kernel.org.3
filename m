Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D93525BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377429AbiEMGnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377399AbiEMGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F62A28C6;
        Thu, 12 May 2022 23:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26960B82C44;
        Fri, 13 May 2022 06:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2587C34114;
        Fri, 13 May 2022 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652424219;
        bh=1HqJX6Cwy3Dr1kUF+YBGo33K39V6gEopOEyonxM4wtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f7JeXoIv3rgA9rK3ZEXswA24qfNvqM0anbxWAr63/9aTjaFb4xVlvST2lrPUx47oW
         EbACU/qeebjFNPEnhJRJ5i+Rr/+TdsAB9qpB2bXpNDgjoIFpUc+paPEkaWRVJfISeF
         66h6sAo2FXdGXcuDAISIiVawjgEANSSdR8WZRC0ddspPAskU1dpPIV62MxRvzVX8a5
         hrJrQ9gTb6rq+bxKIp5Uwi6GnKc2cfqLZ17fh0QAdUuNvlAPZfB+Di6SX9DpwymtFe
         Iff0iM4s2YKbdoXf6bqVALE3Wf/+Oy0wSHxmadKd3Zijh2tVhryuE/UlO/K8YVlGdg
         6LwFUjuE2iUnA==
Received: by mail-ua1-f52.google.com with SMTP id r22so2859466ual.3;
        Thu, 12 May 2022 23:43:39 -0700 (PDT)
X-Gm-Message-State: AOAM530kdXSCDIctbUhNhFveCThnzPOvkQ56GRiadjY7aYhOJrUs1u+k
        T9qtGyxcmgJqvpIfIGt5vX1NshXnzFOgqUgKGpo=
X-Google-Smtp-Source: ABdhPJwc3SpM2/nCsc7YkL8wfGoAa3LbiEmqqzQakKnJFHA8PeTQWA09Ca1o3JWyIcNHexRNMz3tVVHlHCysRBDO5xg=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr1735539uao.114.1652424218856; Thu, 12
 May 2022 23:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220512035903.2779287-1-masahiroy@kernel.org> <20220512035903.2779287-2-masahiroy@kernel.org>
In-Reply-To: <20220512035903.2779287-2-masahiroy@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 13 May 2022 14:43:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTQNQ2Y6AMrRGmPNQKGGOzTutawhOi-1hLgtXSCPfjdCA@mail.gmail.com>
Message-ID: <CAJF2gTTQNQ2Y6AMrRGmPNQKGGOzTutawhOi-1hLgtXSCPfjdCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] csky: do not add dts/ to core-y
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, approved.


On Thu, May 12, 2022 at 12:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This line was used for embedding a DT into vmlinux.
>
> Since commit c4c14c3bd177 ("csky: remove builtin-dtb Kbuild"),
> DT for csky is just a separate blob.
>
> It is covered by the generic rule in the top Makefile:
>
>   ifdef CONFIG_OF_EARLY_FLATTREE
>   all: dtbs
>   endif
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/csky/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> index 866805077636..4d72aca4069b 100644
> --- a/arch/csky/Makefile
> +++ b/arch/csky/Makefile
> @@ -69,7 +69,6 @@ libs-y += arch/csky/lib/ \
>         $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
>
>  boot := arch/csky/boot
> -core-y += $(boot)/dts/
>
>  all: zImage
>
> --
> 2.32.0
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
