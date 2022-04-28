Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC225132C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbiD1Lpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiD1Lp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:45:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355666CAA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651146134; x=1682682134;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MtXFmFdBA/Xh7A2EwjwjZhk6gds/vNt8CxM9cTpwiRk=;
  b=kpOBeSr7dLlxM8j5munzlU2GalO2jf/J96yEkih5VOsd15f6W0QDcdXo
   G4O3Cjfp34GfFJT56RLph79NrgL7Q9it9C5nFozL4oKiiixBkn8edEky/
   A4xeFFIxeFdHSNPAstAOZZxdPMaDFA9cVsBDfBIpI2j1AFkfG8ly4a6PP
   G4dL/xZ2hSok0xyUJ7CKzF2SbC7OEUaqV+rToNVVHZVEXRaBMqV+uRPxo
   u4JUfNwSE5tZdr5AT3ad7yGf9bNxc2E3REjxuaiYRs94ka8pBl06moJA/
   6kNSA+g06TvO6qvWGbm916e0yfCGdz+z3CGEgVTFC8d2yAg673EqCm1Nd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266422477"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="266422477"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:42:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="731422048"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.248]) ([10.255.31.248])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:42:11 -0700
Subject: Re: [hnaz-mm:master 34/291] WARNING: modpost:
 vmlinux.o(.data+0x234bc8): Section mismatch in reference from the variable
 fc2580_driver to the function .init.text:set_reset_devices()
To:     David Hildenbrand <david@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202204241241.dnUrBBvT-lkp@intel.com>
 <1d67fd1c-29d8-d5a6-4d36-17fd238385cd@redhat.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <65cb0f22-c924-2347-fcfa-3cb1175a690c@intel.com>
Date:   Thu, 28 Apr 2022 19:42:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1d67fd1c-29d8-d5a6-4d36-17fd238385cd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2022 4:04 PM, David Hildenbrand wrote:
> On 24.04.22 06:21, kernel test robot wrote:
>> tree:   https://github.com/hnaz/linux-mm master
>> head:   ba42854fa9997614e0ffdbc35b082df3ba6e59da
>> commit: 477a4d0f1f38e738d1a50d5005b79aca719c30bc [34/291] mm/hugetlb: take src_mm->write_protect_seq in copy_hugetlb_page_range()
>> config: riscv-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220424/202204241241.dnUrBBvT-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install riscv cross compiling tool for clang build
>>          # apt-get install binutils-riscv64-linux-gnu
>>          # https://github.com/hnaz/linux-mm/commit/477a4d0f1f38e738d1a50d5005b79aca719c30bc
>>          git remote add hnaz-mm https://github.com/hnaz/linux-mm
>>          git fetch --no-tags hnaz-mm master
>>          git checkout 477a4d0f1f38e738d1a50d5005b79aca719c30bc
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> WARNING: modpost: vmlinux.o(.data+0x234bc8): Section mismatch in reference from the variable fc2580_driver to the function .init.text:set_reset_devices()
>> The variable fc2580_driver references
>> the function __init set_reset_devices()
>> If the reference is valid then annotate the
>> variable with or __refdata (see linux/init.h) or name the variable:
> 
> I don't see my patch causing that. Seems unrelated.
> 


Hi David,

Please ignore this report, similar warnings can be found on parent 
commit too:

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x13e3592): Section mismatch in 
reference from the function usbhid_find_interface() to the variable 
.init.text:.LBB0_1
<< WARNING: modpost: vmlinux.o(.text+0x13e3596): Section mismatch in 
reference from the function usbhid_find_interface() to the function 
.init.text:set_reset_devices()

Best Regards,
Rong Chen
