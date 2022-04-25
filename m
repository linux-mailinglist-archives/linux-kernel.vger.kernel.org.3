Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80350DD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiDYKJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbiDYKI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:08:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83EED35AAE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:05:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F211FB;
        Mon, 25 Apr 2022 03:05:18 -0700 (PDT)
Received: from [10.57.10.156] (unknown [10.57.10.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88D7A3F73B;
        Mon, 25 Apr 2022 03:05:16 -0700 (PDT)
Message-ID: <e4e9b003-e212-6b53-093b-755ecdc67813@arm.com>
Date:   Mon, 25 Apr 2022 11:05:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arch_topology: Trace the update thermal pressure
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com
References: <20220419164801.29078-1-lukasz.luba@arm.com>
 <202204201654.vcszVDGb-lkp@intel.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <202204201654.vcszVDGb-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 09:34, kernel test robot wrote:
> Hi Lukasz,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on driver-core/driver-core-testing]
> [also build test ERROR on rostedt-trace/for-next linus/master linux/master v5.18-rc3 next-20220419]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/arch_topology-Trace-the-update-thermal-pressure/20220420-005845
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3123109284176b1532874591f7c81f3837bbdc17
> config: riscv-randconfig-c024-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201654.vcszVDGb-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/aeff700a88be6a7469acfc312155bd213f76de95
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Lukasz-Luba/arch_topology-Trace-the-update-thermal-pressure/20220420-005845
>          git checkout aeff700a88be6a7469acfc312155bd213f76de95
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     riscv64-linux-ld: drivers/base/arch_topology.o: in function `.L18':
>>> arch_topology.c:(.text+0x136): undefined reference to `__traceiter_thermal_pressure_update'
>     riscv64-linux-ld: drivers/base/arch_topology.o: in function `.L20':
>>> arch_topology.c:(.text+0x168): undefined reference to `__tracepoint_thermal_pressure_update'
>>> riscv64-linux-ld: arch_topology.c:(.text+0x16c): undefined reference to `__tracepoint_thermal_pressure_update'
>     riscv64-linux-ld: drivers/base/arch_topology.o: in function `.L0 ':
>>> arch_topology.c:(__jump_table+0x8): undefined reference to `__tracepoint_thermal_pressure_update'
> 

I've reproduced this issue and experimented with a few solutions.
that config file doesn't set CONFIG_THERMAL, where normally we have
in thermal_core.c the:
   24 #define CREATE_TRACE_POINTS
   25 #include <trace/events/thermal.h>

(similar mechanism we have for thermal_power_allocator.h and IPA.)

We normally test w/ this config, but I'll also start checking the build
w/o thermal subsystem.

I cannot add those two lines in the arch_topology.c since it complains
about multiple definitions for many entries.

Thus, I'll create a separate header thermal_pressure.h to put it in the
arch_topology.c.

I'll also export the symbol as suggested by Steve, so some potential
cpufreq modules could just us it from there.

I'll also re-visit the trace events that we have in thermal subsystem,
since they are not exported but some modules might would like
to use (some of) them...

Regards,
Lukasz
