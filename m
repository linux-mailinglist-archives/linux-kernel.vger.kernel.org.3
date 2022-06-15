Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AE454CAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357412AbiFOOLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFOOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:11:40 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08312443C6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:11:38 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMGZS-1oKfK30jEk-00JH7d for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022
 16:11:37 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-30fdbe7467cso62674057b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:11:37 -0700 (PDT)
X-Gm-Message-State: AJIora+wgUSE+WDb4UV56O/0IqKH/Q5pdi/0ik3gz5O7QWz15RDxCucD
        EtnIvo9A+vI+S/HANSZh3RLBcc/BW7spifolA20=
X-Google-Smtp-Source: AGRyM1vBDQKdEDubvQV9wU9Cy5NzYrd8xTnJ7sc9hg2rSEm1jso9QJej+BNPIXwj6f44jZiRi5f1Syb9OZoTJxIJ5Ug=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr12139024ywk.209.1655302296016; Wed, 15
 Jun 2022 07:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <202206091828.eNkyL2EI-lkp@intel.com>
In-Reply-To: <202206091828.eNkyL2EI-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jun 2022 16:11:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Mu0MDRJU=he=gVxGKQYwzr1wePLKdgN37yLPSqm1iuQ@mail.gmail.com>
Message-ID: <CAK8P3a3Mu0MDRJU=he=gVxGKQYwzr1wePLKdgN37yLPSqm1iuQ@mail.gmail.com>
Subject: Re: drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error:
 enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_data'
 is not an integer constant
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Td4hP1DQsiifmGM3t9Pt5wjjk+EeEqvLvS9jTJWucIVcmJRJF32
 ZttJQLTc13ga0ZAQEeqtk1au2gj6G4sz/HrlyaJguQLpRp5hlMNEeeP9IL5iNXyK6YY8KDg
 8Dcb9XGxzwr6zuk5ewVEnpDqY5ocHQmvq5zKH/zW/DCul43cvnfd+jTephTmFOi0csgQ01C
 U4bhEKXFLICmHpaX7B2CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PDoA5K7rNV8=:sqcOuZD3LUxJnXMGWxKjqg
 Cb/NK59A6ewY/yt59IsOvJhOG0c/YdA02XbqNVdqgVeInLEPdQ2zTz7Q1b9tKIieZfFQ19VV5
 1FwvUTJwAaaywLVy8UyqEINm0BhnDDheQVbbLXBqR214aulFzZUJynjKjoBVPtjIt8knhyerw
 8fDrRXaji3YNe/JE0BseDBHPG343jPBU6d/4Wvk/M2TU1Q2OBCImqhINqj3gBEry0eWxTxURX
 NLqqqUS/t02j6NyLkpOMQrmouFZpoI35z9LyZm8jzIELe00sL9pNVIEtTJyOwDmW8cV+zfNVc
 2siCpJxDUFxhKZHsuuGzli5Ebv1YINEBm2yZQuIwGp1v5CdxQ10M7TbGVL5W4/EI5sROcb6Co
 0KjFcaahTMr9Akjqn0NmM2yPHf8Dq47DtgrmFetRi7VA9YhtARF4tYDBRegdXWq/blqq3IsJF
 N1Rwp1rrTMOIgIXO35YlJb9cMogdgIyCJOg41Fk8M84UExbw4xZBRfi3J2+4aI27oChnJjqle
 brnAYFx8A7c6ODAmYAHXupjNmjrtxwK+iLQBPtq/xjwrp921f/QsW4HyTUjtTv/eawRxfzSP7
 bP2uf1g7yN3qEyxdIR0vN8gsBDP2F4I4/RnlCyFQ0Xc2Lr0ZN1lcqRi7i9knFl0a6dB//l1T1
 HQCcyUOjKBXPpzb2GSSdPa4al4gkJ7xKmPG841n2gqkefTtgUrgYDP7Q5CY4Knn9ui4UQ7uDT
 f9oPogrDUgN8H8eGN/rrVs7R/iiR0OBoD7wGm2yAeb/ShFAJARGnEtyrb45gzN6+z+aPtIdVf
 DUWSHNVrYOX3U1l/H8ZKaGc9qtGetFLxtSjTkfuCbzJ34Ipns6ksPmZitJ2fV5mW23+4hYK9g
 KME8v01nfFGwizTnQmQQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 12:25 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
> commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform

This is not really related to my commit but it does disappear before
this one when bisecting.

>    In file included from drivers/net/ethernet/intel/i40e/i40e_adminq.h:9,
>                     from drivers/net/ethernet/intel/i40e/i40e_type.h:10,
>                     from drivers/net/ethernet/intel/i40e/i40e.h:40,
>                     from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
> >> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
>      301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
>          |                                       ^
>    drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
>     1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
>          | ^~~~~~~~~~~~~~~~~~~~~

The bug is that 'i40e_aqc_cloud_filters_element_data' and some other
structures in the
same file are broken when building an ARM kernel without CONFIG_AEABI, which has
unusual struct packing rules and triggers the static assertion.

It's clearly a bug, but nobody is going to run this driver on an OABI
kernel, so I think
the options are:

- add "__packed __aligned(4)" to each of these structure definitions
- make the driver depend on !(ARM && AEABI) in Kconfig
- ask lkp to stop testing CONFIG_AEABI=n kernels in randconfig builds
  and ignore the problem along with others like it

         Arnd
