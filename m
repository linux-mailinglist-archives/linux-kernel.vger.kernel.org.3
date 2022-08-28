Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DEC5A3DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiH1OPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiH1OPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED213E84
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CBAA60F9F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2012C43470
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661696147;
        bh=F8Rzx597evTrKV+vnDZAGsL1yBRhZNPv/ubmR5QIItQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GYQWRpTlQQydmzfMIJd52PHL7WewEnlRmLXmF/ME3rKNdgaWIfkbZnfBJaetCrPYb
         oyJXyddLIRcz9aDEWX/F5vCS8ko7dc3Cx7MykCmzpkAvVMP1sbHQLWpe97jvzzUVPH
         SiTlvylR+SWEX3Xrvl753wmz3YfELXnOnUnMlhKM7m3iOIe/QJrDzcm9CKBmwWpL9J
         YTXrXFaucyQo1FlJ7HP9nmpad02MmWn+Fgb0coCYE4o1du4ZcuVsXCo0F/oL41QoxL
         3e7zokHqgssVINSHaY+ctV9momiaAwKvml0a/NQQ3to/Pm/2i8ffD7LJ7e/YLMDgGW
         LjsA1ipeGtj9A==
Received: by mail-ua1-f47.google.com with SMTP id a18so42379uak.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:15:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo3g7DGbIXgedcbYRmmxNtVTnfbPVdqteZ9gMkyJeT+l3aLWFLXf
        MpSu8mSiaukFBH3g60PY/EdZGxcr9yL1BZdTJ24=
X-Google-Smtp-Source: AA6agR7e0WdTCaQoFePPh5prwSYiB3W4LOJTV9kd8n4LxfAAH2LlJFMk3MSNZGRwvCHEm7DQRDPdGOY6zGQRdIkorGo=
X-Received: by 2002:ab0:4565:0:b0:395:b672:508 with SMTP id
 r92-20020ab04565000000b00395b6720508mr2190652uar.63.1661696146782; Sun, 28
 Aug 2022 07:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220827175436.156464-1-xry111@xry111.site> <20220827175436.156464-2-xry111@xry111.site>
In-Reply-To: <20220827175436.156464-2-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 28 Aug 2022 22:15:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7-MNd9WsnB3r2kxRN7LveixGwQZ=qTVHB_XvW+uU9q4Q@mail.gmail.com>
Message-ID: <CAAhV-H7-MNd9WsnB3r2kxRN7LveixGwQZ=qTVHB_XvW+uU9q4Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] LoongArch: Add CONFIG_CC_HAS_EXPLICIT_RELOCS
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Sun, Aug 28, 2022 at 1:55 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> GNU as >= 2.40 and GCC >= 13 will support using explicit relocation
> hints in the assembly code, instead of la.* macros.  The usage of
> explicit relocation hints can improve code generation so it's enabled
> by default by GCC >= 13.  We need to adapt the kernel for this change,
> introduce CONFIG_CC_HAS_EXPLICIT_RELOCS so we can use it in later
> patches.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 810096bbf853..e7cfd451024b 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -203,6 +203,9 @@ config SCHED_OMIT_FRAME_POINTER
>         bool
>         default y
>
> +config CC_HAS_EXPLICIT_RELOCS
> +       def_bool $(cc-option,-mexplicit-relocs) && $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
Is it possible that we only change the Makefile and not touch Kconfig?



Huacai
> +
>  menu "Kernel type and options"
>
>  source "kernel/Kconfig.hz"
> --
> 2.37.0
>
>
