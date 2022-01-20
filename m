Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403374946A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 06:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiATFEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 00:04:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:23764 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbiATFEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 00:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642655084; x=1674191084;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wH3PLEbPEPV7K65hS6rjL1rNumE79pQnmwkZdBPb70A=;
  b=TOtHRKvl11OX5y0sOxfD4HbEwAizt9d45TbOcdx84b5Lsf2+FI0rRfEo
   k5c3ilw6/ZvtFKZDRWv2KCxEvNtjR2/A2ZICpzvdKit7ccYxfqdPuxodv
   TmCrLC4rev0XcublS7mguYq0/FddwJbXYi6uFu2Usq+SCojw1LF/ebnOc
   X01mH2JSmp98wCIJF23e4Ibte2x2abehVqh91vsxuPt3QFAKI/mzXHAAn
   SaSiXeJ8DpUF85NpSvbH6TIxRLi/yLFPXYXXRM8jIK3Q6o2uYFdHr3tvo
   CucvK6nbheD23zFuEx/ylphGp0xcoHmyItm5wPjF0mGL+xxwkqT5CSS3U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="242833633"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="242833633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 21:04:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="532616840"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.169.148]) ([10.249.169.148])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 21:04:42 -0800
Subject: Re: [esmil:visionfive-5.16.y 61/80]
 drivers/net/phy/motorcomm.c:163:5: warning: no previous prototype for
 'genphy_config_init'
To:     Emil Renner Berthing <kernel@esmil.dk>,
        kernel test robot <lkp@intel.com>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202201190351.34Nj9vc7-lkp@intel.com>
 <CANBLGcy9Ka8cvgZkXC8ei1gr8V3EN0qiOKATfhyXm9nmjfQ6RA@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <d1f391fc-6939-249c-966e-8bfbb790bf70@intel.com>
Date:   Thu, 20 Jan 2022 13:04:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CANBLGcy9Ka8cvgZkXC8ei1gr8V3EN0qiOKATfhyXm9nmjfQ6RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2022 4:48 AM, Emil Renner Berthing wrote:
> On Tue, 18 Jan 2022 at 20:13, kernel test robot <lkp@intel.com> wrote:
>> tree:   https://github.com/esmil/linux visionfive-5.16.y
>> head:   eeeb46a916e77aecbe1699537a5592746f3130f6
>> commit: d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299 [61/80] net: phy: motorcomm: Support the YT8521 gigabit PHY
>> config: ia64-randconfig-r021-20220116 (https://download.01.org/0day-ci/archive/20220119/202201190351.34Nj9vc7-lkp@intel.com/config)
>> compiler: ia64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/esmil/linux/commit/d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299
>>          git remote add esmil https://github.com/esmil/linux
>>          git fetch --no-tags esmil visionfive-5.16.y
>>          git checkout d4993dd33c50b5ea0db8f5a8cdcd0dee5458b299
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/phy/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> Hi,
> 
> Thanks for the report and thanks for pointing the robot at this tree!
> 
> In the future it would be great if you could point it at the
> visionfive branch instead since that where new development should land
> first. Right now the visionfive-5.16.y branch is only "ahead" because
> 5.16.1 came out before 5.17-rc1.
> 
> Thanks,
> /Emil
> 

Hi Emil,

Thanks for the feedback, we'll ignore the branch visionfive-5.16.y.

Best Regards,
Rong Chen
