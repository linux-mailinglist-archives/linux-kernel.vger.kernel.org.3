Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0161E5AC43F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiIDMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIDMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 08:12:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B4D30F5E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 05:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AB66B80D66
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383C4C433B5
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662293534;
        bh=bYlOQ+oznEYSMgYdAFC3p4z/L5HIm6vFaZHKk80eJDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ey1Mprimt9ZJAqPmkd3q9gGWCpJ3cL+sEdivcWOq+Tb+4F/fwaXYglnO+mlR4/ief
         5xDtD9WsNAac7eTLrIAE4kyIXHQijh6oKjoJWgMBTXdc28c/YJCwkHHhNAhROuhUgI
         Iei+WxkYs/cwUUZHBnksYIziS4JXJtpd9NR3+hCu7aC+Z2Oej1rT9lWbcmC9dOFOaE
         PQoCCopLaccX4Zj/geviwKIh35rI2qebsVhgaiRuJot34WjGaO4VTBI2dB30U0AK9c
         ZQBNoc2RcLsw90/GhZ5oz8BGj7CAFf0xh3C16YZdsALs62q6ySOtEB9Q3RMyaj+ztC
         jIAgfpfFVQ2tQ==
Received: by mail-ua1-f52.google.com with SMTP id x5so2451086uaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 05:12:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo2AvA4VoeNXzKGDvyv9/v2giUJLJ/UXXRrukg+LdeXBi8XHF0XU
        3HyHORGBCG71ZpIl7KENPlxQpOf+AfhheM6S8tA=
X-Google-Smtp-Source: AA6agR42lQq7ZWXBjF8r7BmXSYzuWcDRPqbp2Q/KMnQF1bRLALDcwFBirb/6EagY69gm5TNtQLU7yEImdLE/DLenO6g=
X-Received: by 2002:ab0:25d3:0:b0:3ae:6580:2adc with SMTP id
 y19-20020ab025d3000000b003ae65802adcmr681840uan.23.1662293533162; Sun, 04 Sep
 2022 05:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220831054017.382749-1-liyupeng@zbhlos.com>
In-Reply-To: <20220831054017.382749-1-liyupeng@zbhlos.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 4 Sep 2022 20:12:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6p44E8KuQZz31jX+Yd0qgvqGRaR2vfwdTZLBxg6bKeFQ@mail.gmail.com>
Message-ID: <CAAhV-H6p44E8KuQZz31jX+Yd0qgvqGRaR2vfwdTZLBxg6bKeFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] LoongArch: Fixed arch_remove_memory undefined build error.
To:     Yupeng Li <liyupeng@zbhlos.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Caicai <caizp2008@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to loongarch-fixes, thanks.

Huacai

On Wed, Aug 31, 2022 at 1:49 PM Yupeng Li <liyupeng@zbhlos.com> wrote:
>
> The kernel build error when unslected CONFIG_MEMORY_HOTREMOVE, the
> arch_remove_memory in mm/memory_hotplug.c was undefined.
> Removed CONFIG_MEMORY_HOTREMOVE requirement refer to the definitions
> of other platform architectures.Some build error messages like:
>
>  LD      vmlinux.o
>  MODPOST vmlinux.symvers
>  MODINFO modules.builtin.modinfo
>  GEN     modules.builtin
>  LD      .tmp_vmlinux.kallsyms1
> loongarch64-linux-gnu-ld: mm/memory_hotplug.o: in function `.L242':
> memory_hotplug.c:(.ref.text+0x930): undefined reference to `arch_remove_m=
emory'
> make: *** [Makefile:1169=EF=BC=9Avmlinux] =E9=94=99=E8=AF=AF 1
>
> Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> Signed-off-by: Caicai <caizp2008@163.com>
> ---
>  arch/loongarch/mm/init.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index 7094a68c9b83..191ed8e47895 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -142,7 +142,6 @@ int memory_add_physaddr_to_nid(u64 start)
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  #endif
>
> -#ifdef CONFIG_MEMORY_HOTREMOVE
>  void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
>  {
>         unsigned long start_pfn =3D start >> PAGE_SHIFT;
> @@ -155,7 +154,6 @@ void arch_remove_memory(u64 start, u64 size, struct v=
mem_altmap *altmap)
>         __remove_pages(start_pfn, nr_pages, altmap);
>  }
>  #endif
> -#endif
>
>  /*
>   * Align swapper_pg_dir in to 64K, allows its address to be loaded
> --
> 2.34.1
>
>
