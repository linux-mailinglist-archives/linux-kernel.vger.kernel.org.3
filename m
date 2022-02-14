Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064BF4B41F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiBNG0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:26:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiBNG0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:26:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87B4E389
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644819987; x=1676355987;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7Akr3Iy1pNjvSaXu2WwFVteZikXJ6PrIHYN14dG1kFs=;
  b=MN3KKhh/DDjn5SfYIgvw594RrZgmakeWvMSok0j8QRzXVRnM2Jh5dlfK
   4R0uphFawWIM8wtkHOBSofNU3kQ6zCSLlatcYHa5UEIKAM0LsFJJpyOMg
   VgHddIN0WEeowJvfdgfrW+z87kI0Qt0jHS5mqtzofjDh5bi8TUpg6kPOq
   ncxxAFlUA6bE/I/tEUA6wWgrFInm0tCUrcsJjXR2ZpfB5AOOHZrc54S5S
   vgBtheiMBzGeEROhcQswJBPMB9CFPcWeTjIFlh2eygwslkMXtLEPSJzQc
   EGMha2RCbj535gTOsS+jM/M/EgasMtRYlN6D/0l6c7HVoysfXR5eiTXYW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="237434945"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="237434945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:26:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="527924127"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.201]) ([10.255.30.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:26:25 -0800
Subject: Re: [kbuild-all] Re: include/linux/build_bug.h:78:41: error: static
 assertion failed: "offsetof(struct page, mapping) == offsetof(struct folio,
 mapping)"
To:     Wei Yang <richard.weiyang@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202202131932.diaqTbxo-lkp@intel.com>
 <20220214000500.4ao6vrh4l33donqz@master>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <25632145-1c75-edc3-3efa-4c0bf8574678@intel.com>
Date:   Mon, 14 Feb 2022 14:26:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220214000500.4ao6vrh4l33donqz@master>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2022 8:05 AM, Wei Yang wrote:
> On Sun, Feb 13, 2022 at 07:51:34PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
>> commit: 536f4217ced62b671bd759f6b549621a5654a70f mm: page->mapping folio->mapping should have the same offset
>> date:   2 weeks ago
>> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131932.diaqTbxo-lkp@intel.com/config)
>> compiler: hppa64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=536f4217ced62b671bd759f6b549621a5654a70f
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 536f4217ced62b671bd759f6b549621a5654a70f
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>       18 |         if (!(word & (~0ul << 32))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       20 |                 word <<= 32;
>>          |                      ^~~
>>    include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
>>          |                            ^~
>>    In file included from arch/parisc/include/asm/bitops.h:201,
>>                     from include/linux/bitops.h:33,
>>                     from include/linux/kernel.h:22,
>>                     from arch/parisc/include/asm/bug.h:5,
>>                     from include/linux/bug.h:5,
>>                     from include/linux/thread_info.h:13,
>>                     from include/asm-generic/preempt.h:5,
>>                     from ./arch/parisc/include/generated/asm/preempt.h:1,
>>                     from include/linux/preempt.h:78,
>>                     from include/linux/rcupdate.h:27,
>>                     from include/linux/rculist.h:11,
>>                     from include/linux/pid.h:5,
>>                     from include/linux/sched.h:14,
>>                     from arch/parisc/kernel/asm-offsets.c:18:
>>    include/asm-generic/bitops/__fls.h: In function '__fls':
>>    include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       18 |         if (!(word & (~0ul << 32))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       20 |                 word <<= 32;
>>          |                      ^~~
>>    include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>>          |                            ^~
>>    include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
>>          |                            ^~
>>    In file included from arch/parisc/include/asm/processor.h:18,
>>                     from arch/parisc/include/asm/thread_info.h:6,
>>                     from include/linux/thread_info.h:60,
>>                     from include/asm-generic/preempt.h:5,
>>                     from ./arch/parisc/include/generated/asm/preempt.h:1,
>>                     from include/linux/preempt.h:78,
>>                     from include/linux/rcupdate.h:27,
>>                     from include/linux/rculist.h:11,
>>                     from include/linux/pid.h:5,
>>                     from include/linux/sched.h:14,
>>                     from arch/parisc/kernel/asm-offsets.c:18:
>>    arch/parisc/include/asm/pdc.h: At top level:
>>    arch/parisc/include/asm/pdc.h:77:24: warning: 'struct pdc_memory_table' declared inside parameter list will not be visible outside of this definition or declaration
>>       77 |                 struct pdc_memory_table *tbl, unsigned long entries);
>>          |                        ^~~~~~~~~~~~~~~~
>>    arch/parisc/include/asm/pdc.h:76:30: warning: 'struct pdc_memory_table_raddr' declared inside parameter list will not be visible outside of this definition or declaration
>>       76 | int pdc_mem_mem_table(struct pdc_memory_table_raddr *r_addr,
>>          |                              ^~~~~~~~~~~~~~~~~~~~~~
>>    In file included from include/linux/compiler_types.h:65,
>>                     from <command-line>:
>>    include/linux/smp.h:34:33: error: requested alignment '20' is not a positive power of 2
>>       34 |         __aligned(sizeof(struct __call_single_data));
>>          |                                 ^~~~~~~~~~~~~~~~~~
>>    include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
>>       33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
>>          |                                                                    ^
>>    In file included from include/linux/container_of.h:5,
>>                     from include/linux/list.h:5,
>>                     from include/linux/rculist.h:10,
>>                     from include/linux/pid.h:5,
>>                     from include/linux/sched.h:14,
>>                     from arch/parisc/kernel/asm-offsets.c:18:
>>    include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, lru) == offsetof(struct folio, lru)"
>>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>          |                                         ^~~~~~~~~~~~~~
>>    include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>>          |                                  ^~~~~~~~~~~~~~~
>>    include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>>      261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>>          |         ^~~~~~~~~~~~~
>>    include/linux/mm_types.h:263:1: note: in expansion of macro 'FOLIO_MATCH'
>>      263 | FOLIO_MATCH(lru, lru);
> 
> Sounds each FOLIO_MATCH() gets an compile error?
> 
> Compile on my machine looks good to me. How this happens?
> 

Hi Wei,

Sorry for the inconvenience, it's a false positive, the problem is
that ARCH=parisc was used to build the 64 bit kernel.

Best Regards,
Rong Chen
