Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACF947E0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbhLWJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:23:49 -0500
Received: from 10.mo576.mail-out.ovh.net ([46.105.73.241]:59697 "EHLO
        10.mo576.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbhLWJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:23:49 -0500
X-Greylist: delayed 1802 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2021 04:23:48 EST
Received: from player762.ha.ovh.net (unknown [10.109.138.180])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id A4761240BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:48:22 +0000 (UTC)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player762.ha.ovh.net (Postfix) with ESMTPSA id D55F1259D81AC;
        Thu, 23 Dec 2021 08:48:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R001d4729cd0-16f6-476f-b75c-fcf1799bac4b,
                    F8CB8CBF602DC8C83A84A692D7DC258C8FD1F5FC) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <646b67ae-92e3-dc46-62bf-0f18a008d0bd@milecki.pl>
Date:   Thu, 23 Dec 2021 09:48:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: drivers/pinctrl/bcm/pinctrl-ns.c:286:10: error: passing 'const
 char *const *const' to parameter of type 'const char **' discards qualifiers
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202112230616.y4Aa2Lyi-lkp@intel.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <202112230616.y4Aa2Lyi-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4023403319252331483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtjedguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepudehveevgedvteeghfduhefgieeuhfejgfejhfetgfehtdegjeeluefgfeffueetnecuffhomhgrihhnpehgihhthhhusgdrtghomhdptddurdhorhhgpdhgihhthhhusghushgvrhgtohhnthgvnhhtrdgtohhmnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeivddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 23:55, kernel test robot wrote:
> tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211222-144502/Rafa-Mi-ecki/pinctrl-bcm-ns-use-generic-groups-functions-helpers/20211117-064419
> head:   da7c70cdea1466b4234a30658ee2b5383545a629
> commit: da7c70cdea1466b4234a30658ee2b5383545a629 pinctrl: bcm: ns: use generic groups & functions helpers
> date:   16 hours ago
> config: riscv-randconfig-r042-20211222 (https://download.01.org/0day-ci/archive/20211223/202112230616.y4Aa2Lyi-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install riscv cross compiling tool for clang build
>          # apt-get install binutils-riscv64-linux-gnu
>          # https://github.com/0day-ci/linux/commit/da7c70cdea1466b4234a30658ee2b5383545a629
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review UPDATE-20211222-144502/Rafa-Mi-ecki/pinctrl-bcm-ns-use-generic-groups-functions-helpers/20211117-064419
>          git checkout da7c70cdea1466b4234a30658ee2b5383545a629
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/pinctrl/bcm/pinctrl-ns.c:286:10: error: passing 'const char *const *const' to parameter of type 'const char **' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                                                 function->groups,
>                                                 ^~~~~~~~~~~~~~~~
>     drivers/pinctrl/bcm/../pinmux.h:153:18: note: passing argument to parameter 'groups' here
>                                     const char **groups,
>                                                  ^
>     1 error generated.

You are testing this patch against wrong tree. See message in my commit:

V3: Don't drop "const" from "ns_pinctrl_function" @groups. It's possible
     thanks to the commit bd0aae66c482 ("pinctrl: add one more "const" for
     generic function groups").
     This patch depends on above commit for that reason.
