Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01E4E9DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbiC1RoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241277AbiC1RoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:44:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4764BE4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648489345;
        bh=hALfZm+7u5wG4Gk0GOZM9IFFoUVeMWeOU+c2qaXA7Y8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Jea1mmCDSGEchxzPkPfKmYxi4He1t1l1eGYpSzfwXtRNzVJ3vM4/qrPqgd9o12gKQ
         sn0wsGypoRxWswjdQvkE4ZTU+SSh+H5jUz6Gi2SLP0c1OczQzYblf3iRGdTjYPnfbm
         UPBp2jVMFCZ9vL0SZqjvxVX5M2mmZCaKzXtrv758=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.86]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1o1G4v1dge-0121v9; Mon, 28
 Mar 2022 19:42:25 +0200
Message-ID: <f9407abf-23cf-d539-b7de-2f1e3c589559@gmx.de>
Date:   Mon, 28 Mar 2022 19:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [deller-parisc:for-next 11/14] kernel/irq/cpuhotplug.c:155:6:
 warning: no previous prototype for 'irq_migrate_all_off_this_cpu'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202203290038.b6TKcGbv-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202203290038.b6TKcGbv-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kpde6xC0xalvtU//EPFQaY+sNDf/p0igb5twFId+G/15m2L1WpG
 DWynANkLt02QQxszWhaayZyTW+A++W5RaUEpNjjNdveLbHq6MxR1vs15EM5nqOhdUSjERFa
 jY3RzajwFPpY8xSwgNt2t+U9yFtQXjHoTdkMIZxVFY7+v/HtRGTxR9SjNTlxDmg0OSRYIai
 Ukqwbdbjgn21XqsLggImw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rbabh3kivLs=:rUj67NzeSMarr7mtZLKopG
 xiZJxB9l/iFf/2BZCr3cVVzk9OblebcQhMYUZ+V4gQNaF/sACkPFYDNQfjldy9ifYhCFVadw2
 Ihta9kttw20UX0VDijenkEOC5IJSS9QNP6ebq8o/2exY91TMw4prb9/LNnbjf6Cbe7Tf6h/qh
 NNtXZu9shLrQkhi/pedGnUre+/xvjqRIzBQrnAnk4rcnB87gEnbjB/uMwmJF0bT97S79pbyO6
 PfALepk46HVqeYyrISlNKK5A54sJkgV8jADk+sIuylJRWWNG8dvDIBw4JIc5lYaQd1Q2RBB70
 St4aBULfbLs/z87678jdIZRV3QqY4/quteQE+MvBUNW/j5PuwGn+i+uY8QPlJt3oM7NdMcEPs
 6A9EuPHeT9vc+8oQMDxKH3DnMqGNAt04sbz8XRg8KWuOoCFKeJol+8m/zAGu/95yCtU5QfLvH
 R9JpsK+k0Lyl+4s8LX9ToQQFH2pPPLqT+aDX4tBSjYwizLnymFMOHItyiI4aig6Vv1cKgZxvh
 mUaaKk4o9eDk4sIH6E421HjIdEYEnbxrm/K6Pwz20R0+56rF00V/3fzbkS+SdAUDmBV/nc/e5
 csvWY+Y0mo/2k9NbZABR3YVPuLfZKOkZxvVNMqP6dULvrvedXxbl4MCyt+iMEK6/ojCGFc0Vp
 H+rqLmd3yu38uxD5bUsRg+pjy8sscoJKvtl6Ftu8a91V9uidKM5sZhcXo62TNNMhJ4gmxrMUX
 WID2wG+4zCmfqMqjtkP+8hPrcuzSISbkI0uyB5PIkKWQbMhbElagr669I0VVoKZucMIMKLECu
 IwnhAQv4fTk5q1MCkrCJJVo7J0ZWYxsY7Cw+vXUO5QhlScO6VtHZqy+DCtx/h0t/aeyH04vvE
 fLWYQ7AtSsDaUWZR9I+jCblykaSkkW1GY4g3f7kWIFkx7tew7Ot8dk3tfmxAx1hNlrkvPiUbW
 xXzPZxPpZyHHwm1lXvbS/3wrc30WQebeE16aBQ0GbiB6P0G+dZUeqJelPuncBDRJaueSq/5ue
 YbKU1/k9XThfNnRootYWJlHCH2pzaF8MWvbW7aN1ZmUp9f98dUAivxLJdP8G6/kXwq8M64jsm
 fUlt+HBD1WEH7A=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 18:50, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-li=
nux.git for-next
> head:   d2d1f1e2e989e1f0369d6c991fec7cd3843979a3
> commit: 1d02434051997d499ed9b4fe29fb2992f93f5345 [11/14] parisc: Impleme=
nt __cpu_die() and __cpu_disable() for CPU hotplugging
> config: parisc-randconfig-r004-20220327 (https://download.01.org/0day-ci=
/archive/20220329/202203290038.b6TKcGbv-lkp@intel.com/config)
> compiler: hppa64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-=
linux.git/commit/?id=3D1d02434051997d499ed9b4fe29fb2992f93f5345
>         git remote add deller-parisc https://git.kernel.org/pub/scm/linu=
x/kernel/git/deller/parisc-linux.git
>         git fetch --no-tags deller-parisc for-next
>         git checkout 1d02434051997d499ed9b4fe29fb2992f93f5345
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dparisc64 SHELL=3D/bin/bash kernel/irq/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>>> kernel/irq/cpuhotplug.c:155:6: warning: no previous prototype for 'irq=
_migrate_all_off_this_cpu' [-Wmissing-prototypes]
>      155 | void irq_migrate_all_off_this_cpu(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/uapi/linux/posix_types.h:5,
>                     from include/uapi/linux/types.h:14,
>                     from include/linux/types.h:6,
>                     from include/linux/limits.h:6,
>                     from include/linux/kernel.h:16,
>                     from include/linux/interrupt.h:6,
>                     from kernel/irq/cpuhotplug.c:12:
>>> include/linux/stddef.h:8:16: error: expected identifier or '(' before =
'void'
>        8 | #define NULL ((void *)0)
>          |                ^~~~
>    include/linux/irq.h:620:41: note: in expansion of macro 'NULL'
>      620 | # define irq_affinity_online_cpu        NULL
>          |                                         ^~~~
>    kernel/irq/cpuhotplug.c:218:5: note: in expansion of macro 'irq_affin=
ity_online_cpu'
>      218 | int irq_affinity_online_cpu(unsigned int cpu)

fixed.
Thanks!
Helge
