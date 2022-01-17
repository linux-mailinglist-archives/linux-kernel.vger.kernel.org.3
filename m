Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82E49009B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiAQDg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:36:59 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:10320 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiAQDg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642390617; x=1673926617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bj9WMkmjtrT6QiuclCEkl72aeTgEetnOQdSVXuGcalk=;
  b=b9CM7HT76Xs3GO44Us/cZLqnd/8dGkZocQGHDp0WqRJ85c7xWP8WFSzk
   azDtirI9NjqO1D5oANi06p45l8VP8qSFhtNvZBsS/u4cSL971YUDJ7NSw
   1mquoRVrCg0zTGKgwZSyAxSMMj5erYK0MsA61l3U11bUxoMSFA4mHNO1/
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 19:36:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 19:36:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 19:36:56 -0800
Received: from [10.50.45.28] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 16 Jan
 2022 19:36:52 -0800
Message-ID: <c441e4f1-02e6-058e-3d53-549afc9d960b@quicinc.com>
Date:   Mon, 17 Jan 2022 09:06:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv7 5/5] asm-generic/io: Add logging support for MMIO
 accessors
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <kbuild-all@lists.01.org>, gregkh <gregkh@linuxfoundation.org>,
        <quic_psodagud@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <8085e36ca19787ae111e4cfbb5c555e65bd34be6.1642233364.git.quic_saipraka@quicinc.com>
 <202201160019.hrsMYj6V-lkp@intel.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <202201160019.hrsMYj6V-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/2022 10:03 PM, kernel test robot wrote:
> Hi Sai,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on next-20220115]
> [cannot apply to arm64/for-next/core arnd-asm-generic/master arm-perf/for-next/perf linus/master v5.16 v5.16-rc8 v5.16-rc7 v5.16]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Sai-Prakash-Ranjan/lib-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20220115-211708
> base:    bd8d9cef2a7932e688ca267ea1adf5ea6557c777
> config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220116/202201160019.hrsMYj6V-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/0757812bba83a756f73ce1a84c86ded3e276cd0f
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Sai-Prakash-Ranjan/lib-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20220115-211708
>          git checkout 0757812bba83a756f73ce1a84c86ded3e276cd0f
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from arch/nios2/include/asm/io.h:41,
>                      from include/linux/io.h:13,
>                      from arch/nios2/include/asm/pgtable.h:18,
>                      from include/linux/pgtable.h:6,
>                      from arch/nios2/kernel/nios2_ksyms.c:11:
>     include/asm-generic/io.h: In function 'readb':
>>> include/asm-generic/io.h:181:32: error: '_THIS_IP_' undeclared (first use in this function)
>       181 |         log_read_mmio(8, addr, _THIS_IP_);
>           |                                ^~~~~~~~~
>     include/asm-generic/io.h:181:32: note: each undeclared identifier is reported only once for each function it appears in
>     include/asm-generic/io.h: In function 'readw':
>     include/asm-generic/io.h:196:33: error: '_THIS_IP_' undeclared (first use in this function)
>       196 |         log_read_mmio(16, addr, _THIS_IP_);
>           |                                 ^~~~~~~~~
>     include/asm-generic/io.h: In function 'readl':
>     include/asm-generic/io.h:211:33: error: '_THIS_IP_' undeclared (first use in this function)
>       211 |         log_read_mmio(32, addr, _THIS_IP_);
>           |                                 ^~~~~~~~~
>     include/asm-generic/io.h: In function 'writeb':
>     include/asm-generic/io.h:241:40: error: '_THIS_IP_' undeclared (first use in this function)
>       241 |         log_write_mmio(value, 8, addr, _THIS_IP_);
>           |                                        ^~~~~~~~~
>     include/asm-generic/io.h: In function 'writew':
>     include/asm-generic/io.h:253:41: error: '_THIS_IP_' undeclared (first use in this function)
>       253 |         log_write_mmio(value, 16, addr, _THIS_IP_);
>           |                                         ^~~~~~~~~
>     include/asm-generic/io.h: In function 'writel':
>     include/asm-generic/io.h:265:41: error: '_THIS_IP_' undeclared (first use in this function)
>       265 |         log_write_mmio(value, 32, addr, _THIS_IP_);
>           |                                         ^~~~~~~~~

Hmm I need to include <linux/instruction_pointer.h> for this, although 
arm64 build doesn't
throw this warning. Now posted v8 with this fix - 
https://lore.kernel.org/lkml/cover.1642309054.git.quic_saipraka@quicinc.com/

>
> vim +/_THIS_IP_ +181 include/asm-generic/io.h
>
>     169	
>     170	/*
>     171	 * {read,write}{b,w,l,q}() access little endian memory and return result in
>     172	 * native endianness.
>     173	 */
>     174	
>     175	#ifndef readb
>     176	#define readb readb
>     177	static inline u8 readb(const volatile void __iomem *addr)
>     178	{
>     179		u8 val;
>     180	
>   > 181		log_read_mmio(8, addr, _THIS_IP_);
>     182		__io_br();
>     183		val = __raw_readb(addr);
>     184		__io_ar(val);
>     185		log_post_read_mmio(val, 8, addr, _THIS_IP_);
>     186		return val;
>     187	}
>     188	#endif
>     189	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
