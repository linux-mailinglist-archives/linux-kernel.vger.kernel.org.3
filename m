Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9F563E0A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 05:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGBDfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 23:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 23:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FE2124D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 20:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E53761DAF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 03:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B852AC385A2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 03:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656732911;
        bh=cr+pl9WXz8AfqvA6EUHll+681tdUpcUa3Wq5zN4bllM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CuodT9iDQyFYwBDo7CIHJPz+zH3F+URJ+LyYtp6rpPZYoiJFIN3Isgybb+Bwzd9wG
         w8N/pUG8EMh6gDFGelW/RuBlRbZ0gdrvqzQRhCPs8ReaN6JWQf3pyjLM8A8yZ/Avw7
         HjkdR7dxY4AxsGMpenGEDOM3ysbkFTZcttX4+GiD7oQM9guqmVintDUNnPgf1wrDGw
         xbAQTg/iXnGdQEaNTs128Ytc+VihPdhRF4JDZbUDYBggm8eBXk+65FeFYG7Er+eR9I
         RdlqPndK+50bFbC8HBywWG5ArVsP7VlyIVmP/seX3XfgQJU+t8J54pT26CAwS3aq8n
         21BfOnLOxNAZQ==
Received: by mail-vs1-f43.google.com with SMTP id h7so3969565vsr.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 20:35:11 -0700 (PDT)
X-Gm-Message-State: AJIora98Pj6gopNPq51v7lPpEcvGFriHpFkRJWnijhnUzs9vRjmrcAlH
        oYRRR3UuROf7bLsgWkbKSvptZ5WDmM6dfbvX2Go=
X-Google-Smtp-Source: AGRyM1uIvtdoLeVzTh0ozSY1rfVTd2hvkORArGgiPetinY3NPXClaAXqHKeJ25xrBhiAnVC0pUG0ltxZat3Gf5RtjWw=
X-Received: by 2002:a67:6fc3:0:b0:356:18:32ba with SMTP id k186-20020a676fc3000000b00356001832bamr13047716vsc.43.1656732910679;
 Fri, 01 Jul 2022 20:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220701144946.2528972-1-linux@roeck-us.net>
In-Reply-To: <20220701144946.2528972-1-linux@roeck-us.net>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 2 Jul 2022 11:34:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H60k06-JO1jEwbOkW2O+QUaF7vCbGXO0EPjJ81kdU14FQ@mail.gmail.com>
Message-ID: <CAAhV-H60k06-JO1jEwbOkW2O+QUaF7vCbGXO0EPjJ81kdU14FQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] LoongArch: Fix build errors
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     WANG Xuerui <kernel@xen0n.name>, Guo Ren <guoren@kernel.org>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guenter,

On Fri, Jul 1, 2022 at 10:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> A number of build errors is seen when trying to build loongarch:allnoconfig
> or loongarch:tinyconfig. This patch series tries to fix the observed
> errors.
Thank you very much for your patches. From my point of view, the first
patch is good, but we usually include <linux/xxx> before <asm/yyy>;
the second patch is not so good, and I think the correct way is modify
the cflags for vdso [1]; and the third patch can be dropped at this
time, until our kernel is bootable.

[1] https://lore.kernel.org/loongarch/20220623044715.2072428-1-chenhuacai@loongson.cn/T/#u

Huacai
>
> ----------------------------------------------------------------
> Guenter Roeck (3):
>       LoongArch: page.h: Add missing include file
>       LoongArch: Do not include file from toolchain
>       LoongArch: Always select EFI
>
>  arch/loongarch/Kconfig                 |  6 ++----
>  arch/loongarch/include/asm/loongarch.h | 23 +++++++++++------------
>  arch/loongarch/include/asm/page.h      |  1 +
>  3 files changed, 14 insertions(+), 16 deletions(-)
