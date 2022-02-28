Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82484C616E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiB1CvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiB1CvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:51:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36AA24F08
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 18:50:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE53D106F;
        Sun, 27 Feb 2022 18:50:40 -0800 (PST)
Received: from [10.163.47.185] (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352383F73D;
        Sun, 27 Feb 2022 18:50:38 -0800 (PST)
Subject: Re: [dinguyen:set_fs-2 1/1] mm/mmap.c:105:9: error: '__P000'
 undeclared here (not in a function)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
References: <202202260955.oz8w72wD-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <efce0a6e-3560-716b-bfe4-586d87f40b1f@arm.com>
Date:   Mon, 28 Feb 2022 08:20:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202202260955.oz8w72wD-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/22 7:32 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git set_fs-2
> head:   18dc1399170788b241181d48da03cf70a4139d5f
> commit: 18dc1399170788b241181d48da03cf70a4139d5f [1/1] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
> config: nios2-buildonly-randconfig-r001-20220226 (https://download.01.org/0day-ci/archive/20220226/202202260955.oz8w72wD-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=18dc1399170788b241181d48da03cf70a4139d5f
>         git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
>         git fetch --no-tags dinguyen set_fs-2
>         git checkout 18dc1399170788b241181d48da03cf70a4139d5f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/mmap.c:105:9: error: '__P000' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |         ^~~~~~
>>> mm/mmap.c:105:17: error: '__P001' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |                 ^~~~~~
>>> mm/mmap.c:105:25: error: '__P010' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |                         ^~~~~~
>>> mm/mmap.c:105:33: error: '__P011' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |                                 ^~~~~~
>>> mm/mmap.c:105:41: error: '__P100' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |                                         ^~~~~~
>>> mm/mmap.c:105:49: error: '__P101' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |                                                 ^~~~~~
>>> mm/mmap.c:105:57: error: '__P110' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |                                                         ^~~~~~
>>> mm/mmap.c:105:65: error: '__P111' undeclared here (not in a function)
>      105 |         __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>          |                                                                 ^~~~~~
>>> mm/mmap.c:106:9: error: '__S000' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |         ^~~~~~
>>> mm/mmap.c:106:17: error: '__S001' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |                 ^~~~~~
>>> mm/mmap.c:106:25: error: '__S010' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |                         ^~~~~~
>>> mm/mmap.c:106:33: error: '__S011' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |                                 ^~~~~~
>>> mm/mmap.c:106:41: error: '__S100' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |                                         ^~~~~~
>>> mm/mmap.c:106:49: error: '__S101' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |                                                 ^~~~~~
>>> mm/mmap.c:106:57: error: '__S110' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |                                                         ^~~~~~
>>> mm/mmap.c:106:65: error: '__S111' undeclared here (not in a function)
>      106 |         __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>          |    

Seems like this tree might have just applied a single patch instead of the entire
series. The branch set_fs-2 does not seem to be present anymore and the commit ID
is not reachable from any other branch either, hence will ignore this report.

https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=18dc1399170788b241181d48da03cf70a4139d5f

- Anshuman
