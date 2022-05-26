Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA2534A34
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 07:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbiEZFYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 01:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiEZFYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 01:24:19 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524CA5AAC;
        Wed, 25 May 2022 22:24:16 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id b11so970017qvv.4;
        Wed, 25 May 2022 22:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHO6zM29Kcg3RuIDmSGj1k3u9xjpChjCh4IML1ge/VM=;
        b=A8ggUJBTgjIruHVO2AGSGC50BJpzccp2JqngUhzLy/tfmWgfIWRDLNwWLNmHNLYw+a
         hKb8cIblIrrNzbnAl119oFOfmfo5t2kdizwA1SlLIjgcFJ7jsc6CrNpVjgBlAqArbR44
         bXjDqv3OxphYAQ6HqZVfzo53iG7r6lvHTReeaUNgitl55aMyMk4PouDkSQISzkbPMYxB
         h3S5KeMYr1TVF4dv5eI3uZaBzydeG7LWtBgw2mTL7nAaKUeYBS+ESjl1DS7OJD0OC3eK
         CiiGt9mQQTk8/w8c4ZYb/3+Yh0lU4wF5tNoQHCwzRHhZckh4OhBEGVMBm6M+I2eTanpy
         pi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHO6zM29Kcg3RuIDmSGj1k3u9xjpChjCh4IML1ge/VM=;
        b=uOgdrXwfJby1HuWAXqM9EMprDZaCUoPeev4TuJ0pNS9HkTzxtMyMMQzg/yJo6Av7hg
         KejWhdYJL7IhWFKI10aKOXbIXMY1GmzbEL1dHb5BMtvcWmulbP+gxfj5lw+0FLgkbmoa
         V5+G2rAMo+8hDcZp2p5GKUEg+Eni+vZVVyd5Fs/JQ0v1Y+4rms6HVOzio/jjJ4x4sHRf
         DHp1LY1ClxuESEPfStVAaR9JmQd0NNnLOHoggAeWEQYlMuVoVUiqbrbHtuTFrUmQsPV9
         2ozCWR/1WUmMC1wbbx9kiiorh8nbA7L/py2qiD37n8PnPAnrvMlTDUQRCD3BGj61v23I
         Slqw==
X-Gm-Message-State: AOAM530ZFIQg/HNTP0eOokVR6H+xAJIJNtifsV67u8C3aVwhRXUCdkfl
        aTs15BeXMo4p9GrC7oItdlHwiWxjPgtNwePBZAYh8NJ3kCw=
X-Google-Smtp-Source: ABdhPJwb6UvvGofVw7KIoM/B1pA9VRC/+Ovrxd0sIsDmlMbHYWwyso9BrACMyTItqwM3HaImR8+DQK7ZIYa45LflQpk=
X-Received: by 2002:ad4:5945:0:b0:45a:ff69:47c4 with SMTP id
 eo5-20020ad45945000000b0045aff6947c4mr28706059qvb.86.1653542655510; Wed, 25
 May 2022 22:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <1653478195-21095-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1653478195-21095-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 26 May 2022 07:24:04 +0200
Message-ID: <CAMhs-H_5kHmvG5F=KZaDMzQ8VbSQfg_qqVnzCMuntpH9YU+V4Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: RALINK: Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 8:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> kernel test robot reports a build error used with clang compiler and
> mips-randconfig [1]:
>
>     ld.lld: error: undefined symbol: pci_remap_iospace
>
> we can see the following configs in the mips-randconfig file:
>
>     CONFIG_RALINK=y
>     CONFIG_SOC_MT7620=y
>     CONFIG_PCI_DRIVERS_LEGACY=y
>     CONFIG_PCI=y
>
> CONFIG_RALINK is set, so pci_remap_iospace is defined in the related
> arch/mips/include/asm/mach-ralink/spaces.h header file:
>
>     #define pci_remap_iospace pci_remap_iospace
>
> CONFIG_PCI is set, so pci_remap_iospace() in drivers/pci/pci.c is not
> built due to pci_remap_iospace is defined under CONFIG_RALINK.
>
>     #ifndef pci_remap_iospace
>     int pci_remap_iospace(const struct resource *res, ...)
>
>     $ objdump -d drivers/pci/pci.o | grep pci_remap_iospace
>     00004cc8 <devm_pci_remap_iospace>:
>         4d18:   10400008        beqz    v0,4d3c <devm_pci_remap_iospace+0x74>
>         4d2c:   1040000c        beqz    v0,4d60 <devm_pci_remap_iospace+0x98>
>         4d70:   1000fff3        b       4d40 <devm_pci_remap_iospace+0x78>
>
> In addition, CONFIG_PCI_DRIVERS_GENERIC is not set, so pci_remap_iospace()
> in arch/mips/pci/pci-generic.c is not built too.
>
>     #ifdef pci_remap_iospace
>     int pci_remap_iospace(const struct resource *res, ...)
>
> For the above reasons, undefined reference pci_remap_iospace() looks like
> reasonable.
>
> Here are simple steps to reproduce used with gcc and defconfig:
>
>     cd mips.git
>     make vocore2_defconfig # set RALINK, SOC_MT7620, PCI_DRIVERS_LEGACY
>     make menuconfig        # set PCI
>     make
>
> there exists the following build error:
>
>       LD      vmlinux.o
>       MODPOST vmlinux.symvers
>       MODINFO modules.builtin.modinfo
>       GEN     modules.builtin
>       LD      .tmp_vmlinux.kallsyms1
>     drivers/pci/pci.o: In function `devm_pci_remap_iospace':
>     pci.c:(.text+0x4d24): undefined reference to `pci_remap_iospace'
>     Makefile:1158: recipe for target 'vmlinux' failed
>     make: *** [vmlinux] Error 1
>
> Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC can fix the build
> error, with this patch, no build error remains. This patch is similar with
> commit e538e8649892 ("MIPS: asm: pci: define arch-specific
> 'pci_remap_iospace()' dependent on 'CONFIG_PCI_DRIVERS_GENERIC'").
>
> [1] https://lore.kernel.org/lkml/202205251247.nQ5cxSV6-lkp@intel.com/
>
> Fixes: 09d97da660ff ("MIPS: Only define pci_remap_iospace() for Ralink")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/include/asm/mach-ralink/spaces.h | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
