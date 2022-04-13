Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2F4FF2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiDMI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiDMI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:57:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF324BBA2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:55:12 -0700 (PDT)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA88C-1np25l0ISQ-00BaHm for <linux-kernel@vger.kernel.org>; Wed, 13 Apr
 2022 10:55:11 +0200
Received: by mail-wm1-f45.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso3460352wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:55:10 -0700 (PDT)
X-Gm-Message-State: AOAM531nsx0ERhAxvFYsgVKLFvJGLWqFeIhmYeOyxoCZ1l9JBsZtk++w
        nn2TgSiNVT6YB3nWkVr+K0j4Y8Yow5yEbPoSBMc=
X-Google-Smtp-Source: ABdhPJwGOxXnwAe0zLRYJW/Mkzy9vUjKvmhq91HGxD8xM8MHGsPUkXa+7uyXlFo5RJKX5OVxsbbFhus6XHtjLx6Jyq4=
X-Received: by 2002:a7b:ce15:0:b0:38e:b7b0:79be with SMTP id
 m21-20020a7bce15000000b0038eb7b079bemr7548985wmc.71.1649840110692; Wed, 13
 Apr 2022 01:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <202204130751.lUeRF1y2-lkp@intel.com>
In-Reply-To: <202204130751.lUeRF1y2-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Apr 2022 10:54:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ow9EpNAyTU9n6zC8Rmw71vJ6oaRSCHmd1qU9Z_c3RuA@mail.gmail.com>
Message-ID: <CAK8P3a3ow9EpNAyTU9n6zC8Rmw71vJ6oaRSCHmd1qU9Z_c3RuA@mail.gmail.com>
Subject: Re: [linux-stable-rc:queue/5.4 7091/9999] drivers/staging/comedi/drivers/comedi_isadma.c:25:17:
 error: implicit declaration of function 'claim_dma_lock'
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:j7mSVpkw6YW8tEOxQrDhrByv1R0F+ASO2LTemeZXnzlMgy18jLF
 FKkT5g/caWWwnK2C/2N3/DugYcb4Tagj+AmWx8TaZx0OvMsBUJEL2yX0s6Gq8bkR/iigrpG
 TDdiSx84nDD4uP+U2f5ksogyXIRIsr29/dDMeF2VjLONBMT0rqjxmxfqKaPy5hm0ncM1SFj
 U7bUtF1OF5WbWE2IiikVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iOFx2Cj2QA=:cl+gErzp7n1DWvSlk1Txo6
 pb65td5jwwOJbMMBdXuEqogLJqw77dAiTRJ91k/FzThmI/RUE63sx2TUJZ3Fkq9JFnEMxA/qC
 8KxNcqz5AmjOqGqYoDiDf4eNrF0p7c+K9iYaFECbpbQ6fzgBeezaGSeChl50DDKQQj2rFqV/r
 +cVfSfZuOpLLqszpba4dk+TiRQqNSB8KIwXnfRK2IxaqMwnNMTYKyO0Q87EKk7qIyC1Ej5n6d
 TCak2X+Tac8BA9f067d14j/lSuggovsTjqszLwtTKeKEN9otEMdsL6YNNvIcAPe0KZJlOyX9O
 4UjtF6Gfm85Tp30u/+b0jxNpf7bN1faUt3Utycsx/y9viBV2yDrcTW+x8n/VX4MEmL0Zew/VX
 nG0VB3Af/qGbzJ0ZXMoS/wefB63xj7fq2xqI6R8/7kLCo3Z0LsMtxoB9+SP+Z/yuJT5+uV8aW
 DZcx6dl9e+HxLopE5C6zsDDftP317imdUWbPLeUG7uXyuKwF4965toSr6hI5Q3cPzLKz9xrev
 iT8sQZwvZchQd3Gnwx7eurbU1mKtR3zfacW5rSO7e2hlpJktSP9oabmObCtEK/2QgmymQ9uhl
 H9OiGyNr+otj8lSSho2M3V3KWlr6V6vEAZzzVq3YRmSjZnnEaAZHitZ/bggmNa1W4DTauGc9E
 GY9y7IyV79AvcUshPyrnzOINklVrMVKXSNXuM2mk0qL0pFA9SGKBFiXu0fYAVq3zUlvM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 1:07 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
> head:   9185989d84b918f49f720061cedc29c8ed039797
> commit: 53a72858bcae7eaa7df8d167dbf60682d70f82a6 [7091/9999] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
> config: m68k-randconfig-r011-20220412 (https://download.01.org/0day-ci/archive/20220413/202204130751.lUeRF1y2-lkp@intel.com/config)
>

I've seen a couple of reports for this now, in a few other drivers.
The intention of
my old patch was to limit the use of the set_dma_addr() etc interface
for coldfire,
because they are not implemented on the other MMU-less m68k platform
(dragonball), which caused build failures there.

However, changing the dependency to COLDFIRE means that we now build
the drivers that need this on /other/ machines that don't have the complete
API. In particular, coldfire-v4 with MMU is now able to select the COMEDI
ISA drivers that fail to build because a different part of the API
(claim_dma_lock())
is defined in asm/floppy.h on m68k instead of asm/dma.h as it is on the
other architectures.

I don't actually see any driver on coldfire using the ISA DMA API any more at
all, so I wonder if we should just drop the symbol entirely, and perhaps remove
the definitions for coldfire as well. These are the drivers I found
using the DMA
API:

$ git grep -wl set_dma_mode\\\|request_dma drivers/ sound/
drivers/ata/pata_icside.c
drivers/comedi/drivers/comedi_isadma.c
drivers/mmc/host/wbsd.c
drivers/net/appletalk/ltpc.c
drivers/net/ethernet/3com/3c515.c
drivers/net/ethernet/amd/lance.c
drivers/net/ethernet/amd/ni65.c
drivers/net/ethernet/cirrus/cs89x0.c
drivers/net/hamradio/dmascc.c
drivers/net/wan/cosa.c
drivers/net/wan/hostess_sv11.c
drivers/net/wan/sealevel.c
drivers/net/wan/z85230.c
drivers/parport/parport_pc.c
drivers/pnp/resource.c
drivers/scsi/aha1542.c
drivers/scsi/arm/cumana_2.c
drivers/scsi/arm/eesox.c
drivers/scsi/arm/powertec.c
drivers/scsi/mpt3sas/mpt3sas_base.c
drivers/scsi/mpt3sas/mpt3sas_base.h
drivers/scsi/qla1280.c
drivers/scsi/qla1280.h
drivers/scsi/qla4xxx/ql4_def.h
drivers/scsi/qla4xxx/ql4_mbx.c
drivers/scsi/qla4xxx/ql4_os.c
drivers/usb/gadget/udc/net2272.c
drivers/usb/musb/musb_cppi41.c
drivers/video/fbdev/pvr2fb.c
sound/core/isadma.c
sound/isa/es1688/es1688_lib.c
sound/isa/gus/gus_main.c
sound/soc/au1x/dma.c

Greg (Ungerer), do you see any of these that are used on Coldfire?
I can rule out most of them, but there are a few that are unclear to me.

        Arnd
