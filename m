Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70017537867
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiE3Iyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiE3Ixx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:53:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AF7CB70
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653900783; x=1685436783;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=F1zZaD9pmXbd3mYt25x7qc88DmH1k0luONBgEixrLZE=;
  b=YXHtE15hM8nfbhy+kzqeAaGZKTMpmEj15ghxNZNLLPCZUo1RiF7StQkh
   KQGAsTdi6ffBOws/1cKAsIveUigb8Yr5KZDnvEG1EI/TyeOCbV2q/Juo6
   fy9Dh/jOrVVgnLec5ZLGfMEf6zsCiy+gDuNkWtREHj9NiH/+da2oAHOwz
   wKIPv++OOnZlzTvQv+lLmJ58k29G2oqPSrVFefBeVsno3t2B3+SMDuIeb
   mAKO3igQ0cXIqL5WA63YnFxZV5lXcjuS8oRBAHU19LVP1lR2+xUP46/60
   taWiaU0FC5aTDjqyfMGzCBbftY+uLXqQwy+I+wNeYl+9lc+DVl7ktM0+b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="273756845"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="273756845"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 01:52:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="605086342"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.170]) ([10.255.31.170])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 01:52:22 -0700
Subject: Re: [kbuild-all] Re: llvm-objcopy: error: invalid output format:
 'elf64-s390'
To:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202205290045.gOvUOkt3-lkp@intel.com>
 <YpJMIz/QjDW5IQGr@dev-arch.thelio-3990X>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <fd819888-844f-1a76-fee2-02e89faee090@intel.com>
Date:   Mon, 30 May 2022 16:52:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YpJMIz/QjDW5IQGr@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2022 12:21 AM, Nathan Chancellor wrote:
> On Sun, May 29, 2022 at 12:04:48AM +0800, kernel test robot wrote:
>> Hi Heiko,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
>> commit: adda746629b4a3950f313bc645fa0e54daee871c s390/purgatory: workaround llvm's IAS limitations
>> date:   11 days ago
>> config: s390-randconfig-c005-20220527 (https://download.01.org/0day-ci/archive/20220529/202205290045.gOvUOkt3-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install s390 cross compiling tool for clang build
>>          # apt-get install binutils-s390x-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adda746629b4a3950f313bc645fa0e54daee871c
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout adda746629b4a3950f313bc645fa0e54daee871c
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> llvm-objcopy: error: invalid output format: 'elf64-s390'
> 
> This is expected, as llvm-objcopy needs support for s390:
> https://github.com/ClangBuiltLinux/linux/issues/1530
> 
> Please use GNU objcopy for the time being by explicitly providing
> OBJCOPY=${CROSS_COMPILE}objcopy to make.

Hi Nathan,

Thanks for your reminding, will update it.

Best Regards,
Rong Chen

> 
> Cheers,
> Nathan
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
