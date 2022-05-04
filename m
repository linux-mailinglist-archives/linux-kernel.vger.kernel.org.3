Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783A1519BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbiEDJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbiEDJ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:29:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9B425C49
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:25:31 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRmsG-1nNP9M0zta-00TGVH for <linux-kernel@vger.kernel.org>; Wed, 04 May
 2022 11:25:30 +0200
Received: by mail-wr1-f42.google.com with SMTP id j15so1172425wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:25:30 -0700 (PDT)
X-Gm-Message-State: AOAM532mOYBwm2FY+eiS9Vf4I68HIxgsD5nwjT1wxa2fMbbjJoZF7MRM
        Gfi+L52xM/KuWp7JN5E3qd2kWLOz4QluayaboX0=
X-Google-Smtp-Source: ABdhPJxUrYvF7ZwgY8qESD9R2klluG7ro6Hn3afJZBZ1V9fyHe6ne3atELuxzGyH27D5YamYlyvt8DckXsyol8Y0Ock=
X-Received: by 2002:a5d:6da4:0:b0:20c:6d76:cc54 with SMTP id
 u4-20020a5d6da4000000b0020c6d76cc54mr7615575wrs.317.1651656329805; Wed, 04
 May 2022 02:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <202205041720.i8wJ8uXq-lkp@intel.com>
In-Reply-To: <202205041720.i8wJ8uXq-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 May 2022 11:25:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
Message-ID: <CAK8P3a3F3Z1NyhVcK6wN+b6Es3gqiYGee8a+pAPsaer4hhHDbQ@mail.gmail.com>
Subject: Re: time.c:undefined reference to `mach_get_rtc_pll'
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+6hTjSXhpGfXeveAzSpA8NdW02PQ7vI+5v41YGSKLyVaqMWQKi9
 r1u8EdOzmVfhTWMG9Owj2NME13lVcSJHBuzFinB7PCAkxpm0cNnh8fpWBN/IU3al7vjPQcO
 WeVocrZvxSsyHzhnVZVC6e63wiMRamY93Li8hFVW0++wsIlowFY4E7ZNowjB8HwTj+JdITP
 iVBLNqqFcYb7adMdBp57w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MjJICdzK1MI=:N+TM9EWQdUj/h2GQzBXZB5
 hG1xrFR8ibfh1eAEtBE0dbGUxzJAxjv5NWyhC5e0MsAQ06075t9ZVKh8teA3h/SYIxPE0zDx2
 N+5DJ3/hp3q3uyEXZJUhMfWoV5uEny7v13r2/hpE4tBgIzVeFsb5g5nvSBTeYS4KqoVLD4VnD
 nt71KvYP2zegq+WczBgNBdjfReHu3VnDCqpFgwxV0b26ceZab4UEm/E2sfMOTd9pE1a9zPwyC
 hvBnte71fYiz3/gjTt6eKpi+jUS/b+N+3Nl31sgwF1oIqPGNLGOk5CAI5Q6BwPSeb8PpnVmLb
 DC3afDym1pSeZHeUyge2yYi5l2rlVTWuE3rcEwAFAxbeTaggHcYyg0Pt9Qvr2vPxKAFABGdUe
 V51nLR8koPhuNwINbjiK5m4Fui3GPI/EzsvoIgG8NfFkhxfjQjizgqew3Vzcff5H2jIZgZMUW
 ioVpKz3B2SQ4Lzpqr1+sVepsFYHhy/botD7KehXSDZK0boU6+q6nyKR/rTA9kbHRAF4Ql3EUB
 De+AOnK2Mmss46UhCz/hBSx9HByaZ4s12P2G4SUB9mErcitFYkz/Is8HmHWCoQ4q25iwPAGGX
 Qzxv1FLFfOyk2vYqaeVwrL9/rYv+T3KYqxmFrEcGVLzOX1DJ9m5220NH4TMg4vkQysOV/1EyI
 NrNFSbsySEWM0Zfy3s+bDWuYAJqupq9OlIvxkDXhIWnZSCy8+X6/0P2iWQrIg8Lv0B0UrXif2
 uEXP/ALm4qZS5CKF7ALK8+ASMut6yUPYC4VBf1o7264Avv4W7xlnpCVxELNf9D0Jq3FPGApCs
 i/1Ple4+7Xm06MYea07RiiU5XT3Q3lYVmAZfhD23w2IOgChhx4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 11:14 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   107c948d1d3e61d10aee9d0f7c3d81bbee9842af
> commit: 8b22820efb35f93d98638563b0a8f4094e8ee399 m68k: m68328: remove duplicate code
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
> >> time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>

I think this is just another build failure that was hidden before my patch,
not caused by my patch.

      Arnd
