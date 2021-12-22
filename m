Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089DA47CF26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhLVJYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:24:44 -0500
Received: from 6.mo575.mail-out.ovh.net ([46.105.63.100]:35331 "EHLO
        6.mo575.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhLVJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:24:41 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2021 04:24:40 EST
Received: from player772.ha.ovh.net (unknown [10.108.1.112])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 0500723F0B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:09:13 +0000 (UTC)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id E2E6325B3C7F0;
        Wed, 22 Dec 2021 09:09:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G00232c7baf0-d1aa-4c4d-8318-c2f0578df4a3,
                    4D88ED99DEC4E8A5F70677C20256D8F202EDB5AA) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <d964196c-4a81-c0ae-b32c-cf2b298fdaa6@milecki.pl>
Date:   Wed, 22 Dec 2021 10:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: drivers/pinctrl/bcm/pinctrl-ns.c:286:53: warning: passing
 argument 3 of 'pinmux_generic_add_function' discards 'const' qualifier from
 pointer target type
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202112221651.gLNfcGwH-lkp@intel.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <202112221651.gLNfcGwH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16949578675295792091
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddthedgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepteejueefgeeutddutdfgveeivedtgeegvdeileejhfekleeigfdvueefhfekieeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdptddurdhorhhgpdhgihhthhhusghushgvrhgtohhnthgvnhhtrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 09:55, kernel test robot wrote:
> tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211222-144502/Rafa-Mi-ecki/pinctrl-bcm-ns-use-generic-groups-functions-helpers/20211117-064419
> head:   da7c70cdea1466b4234a30658ee2b5383545a629
> commit: da7c70cdea1466b4234a30658ee2b5383545a629 pinctrl: bcm: ns: use generic groups & functions helpers
> date:   2 hours ago
> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112221651.gLNfcGwH-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/da7c70cdea1466b4234a30658ee2b5383545a629
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review UPDATE-20211222-144502/Rafa-Mi-ecki/pinctrl-bcm-ns-use-generic-groups-functions-helpers/20211117-064419
>          git checkout da7c70cdea1466b4234a30658ee2b5383545a629
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/pinctrl/bcm/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/pinctrl/bcm/pinctrl-ns.c: In function 'ns_pinctrl_probe':
>>> drivers/pinctrl/bcm/pinctrl-ns.c:286:53: warning: passing argument 3 of 'pinmux_generic_add_function' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>       286 |                                             function->groups,
>           |                                             ~~~~~~~~^~~~~~~~
>     In file included from drivers/pinctrl/bcm/pinctrl-ns.c:18:
>     drivers/pinctrl/bcm/../pinmux.h:153:46: note: expected 'const char **' but argument is of type 'const char * const*'
>       153 |                                 const char **groups,
>           |                                 ~~~~~~~~~~~~~^~~~~~

This patch targets following git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=for-next

As stated in the commit message it depends on the:
bd0aae66c482 ("pinctrl: add one more "const" for function groups")
