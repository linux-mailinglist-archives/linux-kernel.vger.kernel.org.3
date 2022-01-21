Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5EF495807
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378339AbiAUB5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:57:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:10749 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240569AbiAUB5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642730269; x=1674266269;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P4a2Ub95CwiYsFsN7IiIuQAoriVEfsXHdqmpGT64NXc=;
  b=P/xM0IVCUacUXRJboxy9xJ0cdLx0nDReMk+K0JEtRFMu9D21qf2hpMvn
   CheJEMNHc/iD3LQzSfiyNw2UrIuNl3O5tKV5dW9MzV8lWrVteMn8yhmVx
   tLY8qTirMqZ0N4GSEjRv+4CzvdYbH6bQTQXtJ0XRtE5+/4Oi3qu32SnRK
   En3reUkzeNJsFNv41sGxoxYY86wLsVPaL64gOkCvBzar//PSSVcP3/8/x
   qbkx589BQttUOHlCEvMuwtPnv2Abezh+gL2Zot0kKViGc92puMateHqqV
   77wLBW8iQk6HvtA4zXUNCvUPPpb0lH7op7kn9w6qHYw4jlWUIjTiole40
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245756564"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="245756564"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 17:57:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="626555052"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.244]) ([10.255.29.244])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 17:57:47 -0800
Subject: Re: [kbuild-all] Re: Error:
 arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax error
To:     Maxim Kochetkov <fido_max@inbox.ru>,
        kernel test robot <lkp@intel.com>,
        Maxim Kiselev <bigunclemax@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202201140142.ayjm3jMQ-lkp@intel.com>
 <465667bc-039e-7acb-69df-82ab811f767c@inbox.ru>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <f58c01c5-2275-d163-39ce-d8dd90bdb0ef@intel.com>
Date:   Fri, 21 Jan 2022 09:57:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <465667bc-039e-7acb-69df-82ab811f767c@inbox.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/2022 3:22 AM, Maxim Kochetkov wrote:
> 
> 
> On 13.01.2022 20:53, kernel test robot wrote:
>> tree:   
>> https://github.com/0day-ci/linux/commits/UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411 
>>
>> head:   50f019b2ff409796f96cd749ecd816ff18575d8b
>> commit: 50f019b2ff409796f96cd749ecd816ff18575d8b powerpc: dts: 
>> t1040rdb: fix ports names for Seville Ethernet switch
>> date:   2 days ago
>> config: powerpc-allyesconfig 
>> (https://download.01.org/0day-ci/archive/20220114/202201140142.ayjm3jMQ-lkp@intel.com/config) 
>>
>> compiler: powerpc-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://github.com/0day-ci/linux/commit/50f019b2ff409796f96cd749ecd816ff18575d8b 
>>
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411 
>>
>>          git checkout 50f019b2ff409796f96cd749ecd816ff18575d8b
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
>> make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> Error: arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax error
>>     FATAL ERROR: Unable to parse input tree
> This is very strange error. Submitted patch doesn't touch string 112.
> String 112 is #include "t1040si-post.dtsi"
> 

Hi Maxim,

The error should be triggered by the new file 
arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts:

Error: ../arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax error
FATAL ERROR: Unable to parse input tree
   HDRINST usr/include/linux/usb/audio.h
   HDRINST usr/include/linux/unix_diag.h
   HDRINST usr/include/linux/unistd.h
   DTC     arch/powerpc/boot/dts/mucmc52.dtb
make[3]: *** [../scripts/Makefile.lib:346: 
arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dtb] Error 1

Best Regards,
Rong Chen
