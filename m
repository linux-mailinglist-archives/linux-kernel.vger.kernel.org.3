Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A8A4D41F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiCJHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiCJHlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:41:15 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29271323E5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:40:14 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MS43X-1nZ7140Cwl-00TSmc for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022
 08:40:13 +0100
Received: by mail-wr1-f41.google.com with SMTP id x15so6489311wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:40:12 -0800 (PST)
X-Gm-Message-State: AOAM5338kLhmmRgcYHMOl6wlB+p1X/iMWnQtubfhCf5VnWHjVae9xHcf
        8wm6ztZEwgFR9LfanR9UKDG1py/6yPnYA0lgXKQ=
X-Google-Smtp-Source: ABdhPJy6ASVmBdPmI7FarBcjvR8m7K73FE37gpQa895a5+tJobzCZkYvsr/cC1ORStsisrKCaLtp4n3AzQZZYxNAHJo=
X-Received: by 2002:adf:f606:0:b0:203:8dff:f4ac with SMTP id
 t6-20020adff606000000b002038dfff4acmr366050wrp.12.1646898012730; Wed, 09 Mar
 2022 23:40:12 -0800 (PST)
MIME-Version: 1.0
References: <202203091741.IetDk7a7-lkp@intel.com> <20220309230950.GA89632@bhelgaas>
 <YilD68QeKpgJG1W2@dev-arch.thelio-3990X>
In-Reply-To: <YilD68QeKpgJG1W2@dev-arch.thelio-3990X>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 08:39:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0pv3WGCAywSR8QcaLBHsu4EPz+KkN8Ybbge4CwA3rHBg@mail.gmail.com>
Message-ID: <CAK8P3a0pv3WGCAywSR8QcaLBHsu4EPz+KkN8Ybbge4CwA3rHBg@mail.gmail.com>
Subject: Re: [lpieralisi-pci:pci/rcar 2/2] drivers/pci/controller/pcie-rcar-host.c:139:3:
 error: instruction requires: data-barriers
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6cCqpW4Sfz8ahYlVL8kmVC85/49EFugXZvm//14SL37ShaqUa3o
 273sPelj9kP6FoHWsPX+wRIAxA2rPnhb2kl3WalZfvaWIoFkdAwchTavpcUfKYnHoRT7dN1
 DuFMmO4ufMeJPlKO08/TdMwspcIknod/LOxjOgA8WXu7+uNIgL+vbCZ+xRabPZuawSKELUr
 4rTvg0+Bek2LO6ojEBMrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v+bUalp2lio=:XAhqgduxD+NGK/+bkfpEa6
 T+ev6+7fNA3NZSPC6KvpzyvEKBckpH/NuvnmHb4Z7RgIFwa87oUfhPl+IBup37GUBHQzGYg+X
 4VaB1jalQxI2bFb+Xg+J6UnehDaRdWiF14FX7vfmWymVvUxrOgpb4Lu3OvsC6UPQQLzlNcRKX
 rKpOG+of3qDsZ5NIeUITcSd456BEMIWkynmAoF3xoIchWc+OIzR91jUM7SeKAPzhJ+aQswGyk
 GqpVJu2qQpJ/p0JI8WGjOnzhBk8V0vLBnIt4qv7VKtSC7aY0cUArzjqFSMz63v+u3MSIhcdOF
 5abiLUio4ieWwDkfZ0Deh3eJIrQxiGca2AjYZ1hWasG73dqaF6H3BQJad1q1MT10kIdzKbFJh
 VhX3G/xYfwhfPw/PLqI6vSUJdhHSnzEZjyZWe12tc0JvtXzPJjAU6ah1OXp0Kv2clVDqoUY2K
 tJedcXSxMZJNXZ+3LTmhh6S3ICknmEEJUzu7hKS0ppR7xVjq+U63GwzF1UFpCpa9zvdWettXC
 TmPn6JNKFS2E40DBNAnzQHHuA3dcPQgms24R281uemdU2JEUx9WoCTiHGCzEtKLOoG7t5Yq7l
 tQE2OuSb/Axf3C0hi77aTdAfqXgyBr411x12b23Jjl0f79X0VS1aj4zfHYDtmUy8LXd4mIQ+Z
 GI9XHjb4fOZBJzRZNmo/qfSeT15C7CQ9z555hRzOKOyWVz4zbVKhvS//g4pzBNUyoXNk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 1:18 AM Nathan Chancellor <nathan@kernel.org> wrote:

> > To avoid this error, for now I have cherry-picked de6b5097f58b to a
> > local pci/host/rcar branch and dropped 9775965dbae5.
>
> FWIW, this is not clang specific, the same configuration blows up with
> GCC 11.2.0 as well:
>
> $ make -skj"$(nproc)" \
>        ARCH=arm \
>        CROSS_COMPILE=arm-linux-gnueabi- \
>        olddefconfig drivers/pci/controller/pcie-rcar-host.o
> /tmp/ccz8ybtm.s: Assembler messages:
> /tmp/ccz8ybtm.s:742: Error: selected processor does not support `isb' in ARM mode
> /tmp/ccz8ybtm.s:812: Error: selected processor does not support `isb' in ARM mode
> make[4]: *** [scripts/Makefile.build:288: drivers/pci/controller/pcie-rcar-host.o] Error 1
>
> $ rg CONFIG_CPU_32 .config
> 289:CONFIG_CPU_32v4=y
>
> It does not look like isb can be used with this configuration, at least
> if I understand arch/arm/include/asm/barrier.h correctly.

My first thought was to amend the #ifdef to

#if IS_ENABLED(CONFIG_ARM) && IS_ENABLED(CONFIG_ARCH_RENESAS)

However, this is still broken because you can build a kernel that
enables the Renesas ARMv7 platform along with early ARMv6 (omap2 and
imx3) that do not support "isb" either.

What I think we want to do here instead is to add a ".arch armv7-a" in the
inline assembly.

        Arnd
