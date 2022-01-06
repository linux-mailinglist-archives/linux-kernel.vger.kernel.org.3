Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E973485CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbiAFADp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245713AbiAFADh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:03:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C5C061245;
        Wed,  5 Jan 2022 16:03:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81EC2619B2;
        Thu,  6 Jan 2022 00:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8364C36AEB;
        Thu,  6 Jan 2022 00:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427416;
        bh=To/H3NokkHFtvWoYEsZUlwbam8b8aQ4ZguL5QsrFWD8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Su/KlbJ7ag469KjwxTh0oFlyISEe6/xOxBYgXvM7pvwzXBGS8fLV2dZ8QXSOjxjoZ
         AmgYbUKj4VtL0WQVv4mIW/i53B21G1R1oPwcbWMp4QeOfdgV9pqS5Tj0NvX5hV4mdw
         BqQ9CpB57fT2/zDfcqVIRtqYdYUusc9moTqM7CturLpCs67D5a8zMzddor9v1qONtH
         RdlMSNngV9Nu1h2PQDebZVOf93Y/Ptp+yd2yKTjOgxaO+rbTBhbXSyTX7Kz2ZHE9al
         EbE6UYIen8sabd6r40k/BxnlxfWoVa6xHAyuDnhRN4iCkQHL9KxfiGYLdNA1Zgnijb
         Wjhs3IZy9bA7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202112210805.wI87zJw0-lkp@intel.com>
References: <1640018638-19436-6-git-send-email-tdas@codeaurora.org> <202112210805.wI87zJw0-lkp@intel.com>
Subject: Re: [PATCH v2 5/5] clk: qcom: lpass: Add support for LPASS clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
To:     Michael Turquette =?utf-8?q?=C2=A0?= <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        kernel test robot <lkp@intel.com>
Date:   Wed, 05 Jan 2022 16:03:34 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106000335.D8364C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernel test robot (2021-12-20 17:02:06)
> Hi Taniya,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on clk/clk-next]
> [also build test WARNING on robh/for-next linus/master v5.16-rc6 next-202=
11220]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Taniya-Das/Add-support-f=
or-LPASS-Core-and-Audio-Clock-for-SC7280/20211221-004818
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk=
-next
> config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/2021=
1221/202112210805.wI87zJw0-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/fec640fab5ec498e79475ec=
d4b15bc95035a76b1
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Taniya-Das/Add-support-for-LPASS=
-Core-and-Audio-Clock-for-SC7280/20211221-004818
>         git checkout fec640fab5ec498e79475ecd4b15bc95035a76b1
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cro=
ss O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash drivers/clk/qcom/
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/clk/qcom/lpassaudiocc-sc7280.c:39:9: warning: this decimal con=
stant is unsigned only in ISO C90
>       39 |         { 595200000, 3600000000, 0 },

This should be easy to fix.

>          |         ^
>    In file included from include/uapi/linux/posix_types.h:5,
>                     from include/uapi/linux/types.h:14,
>                     from include/linux/types.h:6,
>                     from include/linux/of.h:14,
>                     from include/linux/clk-provider.h:9,
>                     from drivers/clk/qcom/lpassaudiocc-sc7280.c:6:
>    drivers/clk/qcom/lpassaudiocc-sc7280.c: In function 'lpass_audio_cc_sc=
7280_probe':
>    include/linux/stddef.h:8:14: error: called object is not a function or=
 function pointer
>        8 | #define NULL ((void *)0)
>          |              ^
>    include/linux/pm_clock.h:82:25: note: in expansion of macro 'NULL'
>       82 | #define pm_clk_suspend  NULL

This one looks like the driver needs some #ifdef CONFIG_PM somewhere.

>          |                         ^~~~
>    drivers/clk/qcom/lpassaudiocc-sc7280.c:740:9: note: in expansion of ma=
cro 'pm_clk_suspend'
>      740 |         pm_clk_suspend(&pdev->dev);
>          |         ^~~~~~~~~~~~~~
>    drivers/clk/qcom/lpassaudiocc-sc7280.c: In function 'lpass_aon_cc_sc72=
80_probe':
>    include/linux/stddef.h:8:14: error: called object is not a function or=
 function pointer
>        8 | #define NULL ((void *)0)
>          |              ^
>    include/linux/pm_clock.h:82:25: note: in expansion of macro 'NULL'
>       82 | #define pm_clk_suspend  NULL
>          |                         ^~~~
>    drivers/clk/qcom/lpassaudiocc-sc7280.c:798:9: note: in expansion of ma=
cro 'pm_clk_suspend'
>      798 |         pm_clk_suspend(&pdev->dev);
>          |         ^~~~~~~~~~~~~~
>=20
>=20
> vim +39 drivers/clk/qcom/lpassaudiocc-sc7280.c
>=20
>     37 =20
>     38  static const struct pll_vco zonda_vco[] =3D {
>   > 39          { 595200000, 3600000000, 0 },
>     40  };
>     41 =20
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
