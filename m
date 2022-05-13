Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50978525BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357147AbiEMGnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiEMGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:43:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2631C5DAB;
        Thu, 12 May 2022 23:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 336CAB82C43;
        Fri, 13 May 2022 06:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38D3C34100;
        Fri, 13 May 2022 06:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652424200;
        bh=TxlGt0AFmpGozu26aRKgdWx3k34puDXhbsLK/i7N0Y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C099qPUBkk8tHv+DNgNLnhNRm8MFQdzztTJyxb9Gx55C1l3iGBmL6lTjdYPltVNvH
         vlFD0nixAHAWgq2tRBgiQEj30f+DwfGQnPWAPP5+AN64LZ/EAayfmuPPnJaATPqlUf
         0WLeSO2sI/Fei2mW3ixYy1tlNJR33RcGeM+yK1svzal73Wsvu/PsGeL/nSt7O0ld39
         Lpzj4PqjsLI40LQfzwXIYN+8HZX8oASRHta8DuvtsT5kiozcZha8UOXGv8aTEZNAda
         sCraFQam4Mw7/shv5wpsiwo7uDZk7Q905qTPgE82Vozgqirsm3/tmgGQE62aF2DFFf
         cxbyVjUzVVtEQ==
Received: by mail-vs1-f42.google.com with SMTP id t85so7465237vst.4;
        Thu, 12 May 2022 23:43:20 -0700 (PDT)
X-Gm-Message-State: AOAM5322itrQ/VsI5JBkgPneJQXyGrI8Sbddpu/aLX3zV1asnh14raCt
        X2kk4iaRipdubD9SdFTu0fmKzGJ+iAkfc0gnk1Y=
X-Google-Smtp-Source: ABdhPJxRVifJK3rkgK3p76i+pWpdyxBis1naS7NqX/hno3cVCs/2en5hvHan5bg+MW3SDsBbe+QsTLzgzXH0n5EYMKQ=
X-Received: by 2002:a05:6102:390b:b0:32d:5fc3:bd2c with SMTP id
 e11-20020a056102390b00b0032d5fc3bd2cmr1386985vsu.51.1652424199545; Thu, 12
 May 2022 23:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220512035903.2779287-1-masahiroy@kernel.org>
In-Reply-To: <20220512035903.2779287-1-masahiroy@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 13 May 2022 14:43:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT6jGGW2CNU9Mo7u_3210od_HUk=ufqL2-RxEDH9313HQ@mail.gmail.com>
Message-ID: <CAJF2gTT6jGGW2CNU9Mo7u_3210od_HUk=ufqL2-RxEDH9313HQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] csky: remove unused $(dtb-y) from arch/csky/boot/Makefile
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
> arch/csky/boot/Makefile does not build DTB.
> arch/csky/boot/dts/Makefile does.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/csky/boot/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/csky/boot/Makefile b/arch/csky/boot/Makefile
> index dbc9b1bd72f0..c3cfde28f8e6 100644
> --- a/arch/csky/boot/Makefile
> +++ b/arch/csky/boot/Makefile
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  targets := Image zImage uImage
> -targets += $(dtb-y)
>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> --
> 2.32.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
