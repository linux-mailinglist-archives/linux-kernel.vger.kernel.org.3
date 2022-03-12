Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A44D6FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiCLPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiCLPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:16:08 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F47164D0A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:15:01 -0800 (PST)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMY9X-1nkSFY3QrX-00JaWK for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022
 16:14:59 +0100
Received: by mail-wr1-f43.google.com with SMTP id k24so17224249wrd.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:14:59 -0800 (PST)
X-Gm-Message-State: AOAM530GEC4KCc9BCa+y416e4O6E6trGeVfb5I2vHzZkqgXnD9aeK3Bg
        F6kuZ2k8A9wx+mHUg1Hh5DSNW+1qr7mN5K5jMU0=
X-Google-Smtp-Source: ABdhPJyudNhlBw0tJ/5WiGDJFYjX12l0wCUN2bOmsgWFosBDsHKvJZwSa1kPAnzw505pxWzkf4bs+raIpnaju7rp2+E=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr11482464wrh.407.1647098099508; Sat, 12
 Mar 2022 07:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <202203122119.szjgiy49-lkp@intel.com>
In-Reply-To: <202203122119.szjgiy49-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 12 Mar 2022 16:14:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Ma2A4nirocELT2c4dtNsdg9tGn5Dzzpbz4tRDEzO5aA@mail.gmail.com>
Message-ID: <CAK8P3a0Ma2A4nirocELT2c4dtNsdg9tGn5Dzzpbz4tRDEzO5aA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] arch: arm: mach-hpe: Introduce the HPE GXP architecture
To:     kernel test robot <lkp@intel.com>
Cc:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>, kbuild-all@lists.01.org,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GcbEpyQDOTugHTCnzxXC4g1pK8vyg43jovUmYiCPGImVi0JtcOb
 A5tfB6Zv3yU5P7hJCWiRhPy7hl34xfczdYkjI0WCqziRwUF6TNvG7rKVwBWZa/W80B1SdJk
 S4d47WArMcxE0kTpx69SiUNG4B7N5W4wnqZDof7ncLQbH93NZ+6cMB49B1JPQENUQvX3Phk
 9P1MhVfR/k74oQ2eTh0uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L+RnyB3GTd0=:t1yo5tuM1AjQmlVR5aMis5
 7C1QIJMjv/jV5ALivzoNpss0UCdMqcc2eZJ0ZPzv1NyxO9+9s3H+dWoQJcMHnnbjOqeT0AQSN
 q0f2nnigfjSAN453ACl0BRkT+iF3z1OFZv4fWJMdj641k26HngqewHoK1Xu3X4S5054porWNj
 8AqBMdjXHWdPlr1h1AVvrAVn64a4bQDb86Mhs7S2rD3bXa8Zi3WReMtwXf6HZkWbaO26gtxbX
 DxUXyB50MsQLKu+XwPNEUOWXha9mJnQlgJ4DBMPHLJ3zwIhxxGzcn3ZdR5O2byhT9O4E1CwcN
 t+gVOBqYAxtiLO+F1MCtBrgu65tnvhpkqfnirwGUZ9DleVg8vo9xpy6lUje9FdIIvVMPXxxEn
 0vXVgpfq8GBKoOrV2MfnaHkNbEo5hMNN5iG3MpMp4X0FSV3CIQCk73C8fGwzuyFXh5Wdwm6Mh
 oKIdvBvRmy3AmGOBY0Z9AWAHe4GfSJd+90kT0d13vnsixMVdiPloy3tg8YyV3ua/z17qWsxoi
 t1xumaDdaJURe2KPzAVDn2Z8XPWa87cbgsHFE3RnSVef/DdzWHXqhsE0Pv1QoNREW5zRwlqbT
 swlsNAMTRsjw/fdrm8/BT1FBflQ0ArcTITjMkdthK8k8/dFjYNIVRFMrEgSoguS6ljw6MC/jw
 ZbshXV+8WEWbZSfxmf30eZj/cZ6QSRfTca/K/u+4I8mC3+DP+Mowa/mVEuLTbVN6W2mM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 2:27 PM kernel test robot <lkp@intel.com> wrote:

>
> All error/warnings (new ones prefixed by >>):
>
> >> cc1: warning: arch/arm/mach-hpe/include: No such file or directory [-Wmissing-include-dirs]

You need to make CONFIG_ARCH_HPE depend on CONFIG_ARCH_MULTI_V7, otherwise
it becomes possible to select this for non-multiplatform configs that expect
an include directory below the platform.

       Arnd
