Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916354A3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbiFNBjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiFNBi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:38:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69262283
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB0561602
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E22C385A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655170737;
        bh=5K0rZDOd8EKBPVEMl6OdGLOdRdSloI6ew+DWoHxL2zM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IN1ILMep94AF990ZX/Y8NhOvwwDWsSH3Y5sIszcEzzq9jovdo9vdSbrTlnKsFtfnx
         CIOc6vEJfC3i1gE/8YPjLkoFK7XzZbtybbjbENu15zXFwlKhb8/s+KgT7NQSpG8m5u
         t0Nu/OEqtxqFJD714w10V9EdfIMrabsIwlk32pA1oEOkmaESf2vsunH4Lbna3569cY
         E2hJk/wh6e4ol8EgIccnxuzW27xSJ8qgTyQnWVKxW5rEIrR3uogMqumPwZCm3pyYvh
         qX7LLsc3jB/fKIIJS12KtJLn4MAsy5maoUOMKYXYyWK8/dVf9lrg8h748Va4cGjIE5
         6HSwXiQaVneNA==
Received: by mail-lf1-f43.google.com with SMTP id be31so11569053lfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:38:57 -0700 (PDT)
X-Gm-Message-State: AJIora9wkxOqYF8RDhviAOPkSbCLTqLRbRkBIuxkB1qyx17Hmz9EF5T3
        QXq5W+l3IKjJfE4V4hVDZh+hvNrkVrVYFxLqV98=
X-Google-Smtp-Source: AGRyM1uXt5j3oU6ftbiOVEIYRIsxTTYL6Hvqsp/kuGJlLCmuU2BinWhwymXgfFFFJmXFijd2WMkCh5zsZkfBuUksm/w=
X-Received: by 2002:a05:6512:e9c:b0:479:1fd9:1b94 with SMTP id
 bi28-20020a0565120e9c00b004791fd91b94mr1460580lfb.591.1655170735343; Mon, 13
 Jun 2022 18:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <1655117652-11166-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1655117652-11166-1-git-send-email-tangyouling@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 14 Jun 2022 09:38:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4KVssJ6+QDFAaUeuBdO3UznKV28xP8OPXU+ewL=kY7kA@mail.gmail.com>
Message-ID: <CAAhV-H4KVssJ6+QDFAaUeuBdO3UznKV28xP8OPXU+ewL=kY7kA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vmlinux.lds.S: Add missing ELF_DETAILS
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Youling,

On Mon, Jun 13, 2022 at 6:54 PM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Commit c604abc3f6e ("vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG") split
> ELF_DETAILS from STABS_DEBUG, resulting in missing ELF_DETAILS information in
> LoongArch architecture, so add it.
Looks good to me, thanks.

Huacai
>
> Fixes: c604abc3f6e ("vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG")
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/loongarch/kernel/vmlinux.lds.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index 9d508158fe1a..78311a6101a3 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -101,6 +101,7 @@ SECTIONS
>
>         STABS_DEBUG
>         DWARF_DEBUG
> +       ELF_DETAILS
>
>         .gptab.sdata : {
>                 *(.gptab.data)
> --
> 2.36.1
>
