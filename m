Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B7573D47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiGMThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGMThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:37:46 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBAB2B1AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:37:45 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z3so7312799ilz.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gyhic3YuQiWkPXDh0dmo06Ni34a0PcNp5aOOqF+1Mjw=;
        b=VIw/8Z+9ZhhO4bJAqBbvaM7zPVvdy1IQgZGCRmgtr5Aq26ZvIlE7Z67BWWe5q9ByUy
         V2esw9YZX71visThXT4lgTc1w/CfK5vK6nI7D7pbIg7y0W/aIakF/9GH7aYce4BztRMp
         f3i1ov6YWHKM68q3hwvBOz5oE/YTGQwuqzNe6IE/Kk0F3R9uv1pifGMVqnTaYDYpKSz5
         9rCGfqnUD1pph/DE6WJ407G3VUa8zJw/5X0+jez+ldOEKo48vBeEzapyFafBwSmEn1ty
         3EXzz2XXnflms4RvIv70Rl7gpIUWyZHiSuA/e/QoJzNIfQPhvrBuSp127QKWZxJdxql+
         F/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gyhic3YuQiWkPXDh0dmo06Ni34a0PcNp5aOOqF+1Mjw=;
        b=gXDz0kAQC/e+LDSWR0smdeH5y5f5B595Mx343anNIyk4TkmOhOsKYmiOywCo5A29J5
         8wJL11Wp9Ql2Vm61brmoeSxOBEHBE1Z/qGNo3q9+L9Gw5ukdbTBejcKueUZC9Vus7ujf
         2xGr34JJ48B9heswsbMTzPQZ1SCNYnZ0X0GPm4VpbcO/ababkyOLUWhk8lc3QYKuDsqK
         V76GhFEx+WRTdefH2yUxIaPTN3WGDi7MzqvKI1ARj3Kx9Ca3FZgqujLOwEGlwZOmQ/Iz
         3064TK1uZu9EaDwZ7o/DOhMwXWMu6K+fYEKlIfShyj2Vl9gCIOdhOxpAWA7WC/EeDNeS
         0Q8Q==
X-Gm-Message-State: AJIora+5ZAyQLBrGzY72XGRfUboAP/IRljpzEN5vG9JSG7PR5EEzmwsC
        0J5yibgEP3GAEogslPMq7zr6kWn84khXmb6zZ+LYegmQ9xMDcA==
X-Google-Smtp-Source: AGRyM1tSM88aI26QD2eN5zKANOb2j7OphvM37pvnVUc6F5wy/zwYA2RWDnkIqVZyuaBVnpzte3Mowk1flf8HDLFRBSI=
X-Received: by 2002:a05:6e02:194b:b0:2dc:a05f:d911 with SMTP id
 x11-20020a056e02194b00b002dca05fd911mr2755279ilu.92.1657741064394; Wed, 13
 Jul 2022 12:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
In-Reply-To: <Ys1g8PH4M2W7Z50U@sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 14 Jul 2022 01:07:32 +0530
Message-ID: <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
To:     Mark Brown <broonie@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 at 17:24, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 12, 2022 at 03:27:09PM +0530, Naresh Kamboju wrote:
>
> > FVP boot failed with linux next 20220712.
>
> I can't reproduce this, including with your kernel binary, which
> suggests that this an issue with your FVP usage and firmware.
>
> > Boot log:
> > Starting kernel ...
> >
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
> > [    0.000000] Linux version 5.19.0-rc6-next-20220711
>
> How are you invoking the FVP, what firmware are you using and how is it
> configured?
>
> > [    0.500709] kernel BUG at arch/arm64/kernel/traps.c:497!
>
> This is an undefined instruction, my first thought there would be that
> you have some feature enabled for the kernel which requires enablement
> at EL3 but your EL3 firmware is not configured to enable it.

Thanks for investigating the reported issue and providing details.
We will do the needful to update / configure EL3 firmware.


>
> > [    0.503562]  el1_undef+0x30/0x60
> > [    0.503709]  el1h_64_sync_handler+0x84/0xd0
> > [    0.503811]  el1h_64_sync+0x64/0x68
> > [    0.503909]  net_sysctl_init+0x8/0x7c
>
> This is where the undef came from.

Here I am providing the available data.
Let me know what I am missing here, so that I will update my setup.
Thanks in advance.

Fast Models 11.17.21 (Feb 16 2022)

https://storage.tuxboot.com/fvp-aemva/tf-bl1.bin
https://storage.tuxboot.com/fvp-aemva/fvp-base-revc.dtb
https://storage.tuxboot.com/fvp-aemva/fip-uboot.bin
https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/Image.gz
https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/modules.tar.xz


docker run
  --rm
  --interactive
  --tty
  --hostname lava
  --name tuxrun-r4_1075p-lava-1
  --volume /var/lib/lava/dispatcher/tmp/tuxrun-r4_1075p-1/url-repo-action-3=
h1oa_zl/url_repo/https___storage.tuxboot.com_test-definitions_2022.01.tar:/=
tuxrun-r4_1075p-lava-1/https___storage.tuxboot.com_test-definitions_2022.01=
.tar
  --volume /var/lib/lava/dispatcher/tmp/tuxrun-r4_1075p-1/fvp-deploy-w_qt5q=
gt/bl1/tf-bl1.bin:/tuxrun-r4_1075p-lava-1/tf-bl1.bin
  --volume /var/lib/lava/dispatcher/tmp/tuxrun-r4_1075p-1/fvp-deploy-w_qt5q=
gt/dtb/fvp-base-revc.dtb:/tuxrun-r4_1075p-lava-1/fvp-base-revc.dtb
  --volume /var/lib/lava/dispatcher/tmp/tuxrun-r4_1075p-1/fvp-deploy-w_qt5q=
gt/fip/fip-uboot.bin:/tuxrun-r4_1075p-lava-1/fip-uboot.bin
  --volume /var/lib/lava/dispatcher/tmp/tuxrun-r4_1075p-1/fvp-deploy-w_qt5q=
gt/kernel/Image:/tuxrun-r4_1075p-lava-1/Image
  --volume /var/lib/lava/dispatcher/tmp/tuxrun-r4_1075p-1/fvp-deploy-w_qt5q=
gt/rootfs/https___storage.lkft.org_rootfs_oe-sumo_20220219_juno_rpb-console=
-image-lkft-juno-20220219023239.rootfs.ext4:/tuxrun-r4_1075p-lava-1/https__=
_storage.lkft.org_rootfs_oe-sumo_20220219_juno_rpb-console-image-lkft-juno-=
20220219023239.rootfs.ext4
  --volume /var/lib/lava/dispatcher/tmp/tuxrun-r4_1075p-1/fvp-deploy-w_qt5q=
gt/rootfs.modules/modules.tar:/tuxrun-r4_1075p-lava-1/modules.tar
fvp:aemva-11.17.21



/opt/model/FVP_AEMvA/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA
  --plugin /opt/model/FVP_AEMvA/plugins/Linux64_GCC-9.3/ScalableVectorExten=
sion.so
  --data cluster0.cpu0=3D/tuxrun-r4_1075p-lava-1/fvp-base-revc.dtb@0x860000=
00
  --data cluster0.cpu0=3D/tuxrun-r4_1075p-lava-1/Image@0x80080000
   -C pctl.startup=3D0.0.0.0
   -C bp.secure_memory=3D0
   -C cluster0.NUM_CORES=3D4
   -C cluster1.NUM_CORES=3D4
   -C cache_state_modelled=3D0
   -C bp.smsc_91c111.enabled=3Dtrue
   -C bp.pl011_uart0.untimed_fifos=3D1
   -C bp.pl011_uart0.unbuffered_output=3D1
   -C bp.secureflashloader.fname=3D'/tuxrun-r4_1075p-lava-1/tf-bl1.bin'
   -C bp.flashloader0.fname=3D'/tuxrun-r4_1075p-lava-1/fip-uboot.bin'
   -C bp.ve_sysregs.mmbSiteDefault=3D0
   -C bp.ve_sysregs.exit_on_shutdown=3D1
   -C bp.virtioblockdevice.image_path=3D'/tuxrun-r4_1075p-lava-1/https___st=
orage.lkft.org_rootfs_oe-sumo_20220219_juno_rpb-console-image-lkft-juno-202=
20219023239.rootfs.ext4'
   -C pci.pcidevice0.bus=3D0xFF
   -C pci.pcidevice1.bus=3D0xFF
   -C cluster0.has_large_system_ext=3D1
   -C cluster1.has_large_system_ext=3D1
   -C cluster0.has_16k_granule=3D1
   -C cluster1.has_16k_granule=3D1
   -C cluster0.has_branch_target_exception=3D1
   -C cluster1.has_branch_target_exception=3D1
   -C cluster0.has_rndr=3D1
   -C cluster1.has_rndr=3D1
   -C cluster0.has_arm_v8-1=3D1
   -C cluster1.has_arm_v8-1=3D1
   -C cluster0.has_arm_v8-2=3D1
   -C cluster1.has_arm_v8-2=3D1
   -C cluster0.has_arm_v8-3=3D1
   -C cluster1.has_arm_v8-3=3D1
   -C cluster0.has_arm_v8-4=3D1
   -C cluster1.has_arm_v8-4=3D1
   -C cluster0.has_arm_v8-5=3D1
   -C cluster1.has_arm_v8-5=3D1
   -C cluster0.has_arm_v8-6=3D1
   -C cluster1.has_arm_v8-6=3D1

- Naresh
