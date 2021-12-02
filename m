Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45703465F16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355957AbhLBIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:06:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:65225 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241125AbhLBIGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:06:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="322899139"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="322899139"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:03:33 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="597059742"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:03:29 -0800
Message-ID: <1eba3a99-9861-084d-34d8-9da060b1e6b3@intel.com>
Date:   Thu, 2 Dec 2021 16:03:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [kbuild-all] Re: [ardb:for-kernelci 25/25]
 arch/arm/kernel/traps.c:865:17: warning: no previous prototype for function
 'handle_bad_stack'
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202111250918.ErFZktQF-lkp@intel.com>
 <CAMj1kXHrRYagSVniSetHdG15rkQS+fm4zVOtN=Zda3W0QaEoJA@mail.gmail.com>
 <a03e765d-c22a-3bd8-8d94-36966b91dc2c@intel.com>
 <CAMj1kXFKYX+XsojJGzYZryHht=CV-7-R+aNXaSO9zabunXYNqg@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <CAMj1kXFKYX+XsojJGzYZryHht=CV-7-R+aNXaSO9zabunXYNqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/21 15:53, Ard Biesheuvel wrote:
> On Thu, 2 Dec 2021 at 08:34, Rong Chen <rong.a.chen@intel.com> wrote:
>>
>>
>> On 11/30/21 21:12, Ard Biesheuvel wrote:
>>> On Thu, 25 Nov 2021 at 02:35, kernel test robot <lkp@intel.com> wrote:
>>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
>>>> head:   5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
>>>> commit: 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1 [25/25] ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
>>>> config: arm-randconfig-r024-20211124 (https://download.01.org/0day-ci/archive/20211125/202111250918.ErFZktQF-lkp@intel.com/config)
>>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
>>>> reproduce (this is a W=1 build):
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # install arm cross compiling tool for clang build
>>>>           # apt-get install binutils-arm-linux-gnueabi
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
>>>>           git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
>>>>           git fetch --no-tags ardb for-kernelci
>>>>           git checkout 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
>>>>           # save the config file to linux build tree
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>> This is yet another false positive. asmlinkage routines don't need a
>>> prototype because they are called from assembler. This is not going to
>>> get fixed, so please don't report this error anymore.
>> Hi Ard,
>>
>> Sorry for the noise, we'll ignore the warnings in the future.
>>
> Thanks! And if at all possible, please extend this to all routines
> marked as asmlinkage?
>

got it, thanks for your reminding.

Best Regards,
Rong Chen
