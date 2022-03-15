Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D394D91F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbiCOBFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbiCOBFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:05:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA51186EA;
        Mon, 14 Mar 2022 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306269; x=1678842269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZNYQ7heN8BZ4EC7hZMx6llfWJHtr84HIFJSjDVxDUx0=;
  b=MQeHdsy8UEdK9IM9/RJg8Il8+3w+oKM+O8tcuZaJ9XhtZv/hh6bjRg1u
   RjZwuTmsGc8M2zRIN8Sb9Q76Uum/42rG1u67/DQo1TbMDhM7uRtNEfbXV
   DooBfl8LSwfp9j0FtezyX7Aqoujb3EY2XkwziItpb3Pt4U+QVwLVUUpdk
   IqZoaHEOvS/RLEf7NoWmcRmRM9K8ZUHwgg/fm8yv+R44w99dcujHToHbw
   IB2r1O0foqotJtBLST4a2tqcHQgjPWrEHKrh0lHQCFzRlTXDGf6YlBa5v
   xoBh/ekgPJgbP7mIeQOdUvkwwrHpQhcm9iKDYxgc8eAdvkQ/15/FbcEXN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253744814"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="253744814"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="690026465"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2022 18:04:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTvbu-000AOe-Iw; Tue, 15 Mar 2022 01:04:26 +0000
Date:   Tue, 15 Mar 2022 09:03:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kbuild-all@lists.01.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: Correct log level of several messages
Message-ID: <202203150933.HeolPUBM-lkp@intel.com>
References: <20220314195728.119160-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314195728.119160-1-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next v5.17-rc8 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Paul-Menzel/scsi-3w-sas-Correct-log-level-of-several-messages/20220315-035918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: x86_64-randconfig-a004-20220314 (https://download.01.org/0day-ci/archive/20220315/202203150933.HeolPUBM-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/8d5baa500eb6500560660c4c5c355f9556cc4a51
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Paul-Menzel/scsi-3w-sas-Correct-log-level-of-several-messages/20220315-035918
        git checkout 8d5baa500eb6500560660c4c5c355f9556cc4a51
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/scsi/3w-sas.c:53:
   drivers/scsi/3w-sas.c: In function 'twl_fill_sense':
>> drivers/scsi/3w-sas.c:876:11: error: 'KERN_ERROR' undeclared (first use in this function); did you mean 'KERN_ERR'?
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |           ^~~~~~~~~~
   include/linux/printk.h:370:28: note: in definition of macro '__printk_index_emit'
     370 |   if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                            ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:876:4: note: in expansion of macro 'printk'
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   drivers/scsi/3w-sas.c:876:11: note: each undeclared identifier is reported only once for each function it appears in
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |           ^~~~~~~~~~
   include/linux/printk.h:370:28: note: in definition of macro '__printk_index_emit'
     370 |   if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                            ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:876:4: note: in expansion of macro 'printk'
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
>> drivers/scsi/3w-sas.c:876:22: error: expected ')' before string constant
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:370:28: note: in definition of macro '__printk_index_emit'
     370 |   if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                            ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:876:4: note: in expansion of macro 'printk'
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/scsi/3w-sas.c:53:
>> drivers/scsi/3w-sas.c:876:22: error: expected ')' before string constant
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:379:33: note: in definition of macro '__printk_index_emit'
     379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                 ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:876:4: note: in expansion of macro 'printk'
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
>> drivers/scsi/3w-sas.c:876:22: error: expected ')' before string constant
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                          ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:876:4: note: in expansion of macro 'printk'
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   include/linux/printk.h:379:41: note: to match this '('
     379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                         ^
   include/linux/printk.h:417:3: note: in expansion of macro '__printk_index_emit'
     417 |   __printk_index_emit(_fmt, NULL, NULL);   \
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:876:4: note: in expansion of macro 'printk'
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
>> drivers/scsi/3w-sas.c:876:22: error: expected ')' before string constant
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   drivers/scsi/3w-sas.c:876:4: note: in expansion of macro 'printk'
     876 |    printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/scsi/3w-sas.c:53:
   drivers/scsi/3w-sas.c:883:22: error: expected ')' before string constant
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:370:28: note: in definition of macro '__printk_index_emit'
     370 |   if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
         |                            ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:883:4: note: in expansion of macro 'printk'
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/scsi/3w-sas.c:53:
   drivers/scsi/3w-sas.c:883:22: error: expected ')' before string constant
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:379:33: note: in definition of macro '__printk_index_emit'
     379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                 ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:883:4: note: in expansion of macro 'printk'
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   drivers/scsi/3w-sas.c:883:22: error: expected ')' before string constant
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:379:42: note: in definition of macro '__printk_index_emit'
     379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                          ^~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:883:4: note: in expansion of macro 'printk'
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   include/linux/printk.h:379:41: note: to match this '('
     379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                         ^
   include/linux/printk.h:417:3: note: in expansion of macro '__printk_index_emit'
     417 |   __printk_index_emit(_fmt, NULL, NULL);   \
         |   ^~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   drivers/scsi/3w-sas.c:883:4: note: in expansion of macro 'printk'
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
   drivers/scsi/3w-sas.c:883:22: error: expected ')' before string constant
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   drivers/scsi/3w-sas.c:883:4: note: in expansion of macro 'printk'
     883 |    printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
         |    ^~~~~~
>> drivers/scsi/3w-sas.c:864:8: warning: variable 'error_str' set but not used [-Wunused-but-set-variable]
     864 |  char *error_str;
         |        ^~~~~~~~~


vim +876 drivers/scsi/3w-sas.c

   857	
   858	/* This function passes sense data from firmware to scsi layer */
   859	static int twl_fill_sense(TW_Device_Extension *tw_dev, int i, int request_id, int copy_sense, int print_host)
   860	{
   861		TW_Command_Apache_Header *header;
   862		TW_Command_Full *full_command_packet;
   863		unsigned short error;
 > 864		char *error_str;
   865	
   866		header = tw_dev->sense_buffer_virt[i];
   867		full_command_packet = tw_dev->command_packet_virt[request_id];
   868	
   869		/* Get embedded firmware error string */
   870		error_str = &(header->err_specific_desc[strlen(header->err_specific_desc) + 1]);
   871	
   872		/* Don't print error for Logical unit not supported during rollcall */
   873		error = le16_to_cpu(header->status_block.error);
   874		if ((error != TW_ERROR_LOGICAL_UNIT_NOT_SUPPORTED) && (error != TW_ERROR_UNIT_OFFLINE) && (error != TW_ERROR_INVALID_FIELD_IN_CDB)) {
   875			if (print_host)
 > 876				printk(KERN_ERROR "3w-sas: scsi%d: ERROR: (0x%02X:0x%04X): %s:%s.\n",
   877				       tw_dev->host->host_no,
   878				       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
   879				       header->status_block.error,
   880				       error_str,
   881				       header->err_specific_desc);
   882			else
   883				printk(KERN_ERROR "3w-sas: ERROR: (0x%02X:0x%04X): %s:%s.\n",
   884				       TW_MESSAGE_SOURCE_CONTROLLER_ERROR,
   885				       header->status_block.error,
   886				       error_str,
   887				       header->err_specific_desc);
   888		}
   889	
   890		if (copy_sense) {
   891			memcpy(tw_dev->srb[request_id]->sense_buffer, header->sense_data, TW_SENSE_DATA_LENGTH);
   892			tw_dev->srb[request_id]->result = (full_command_packet->command.newcommand.status << 1);
   893			goto out;
   894		}
   895	out:
   896		return 1;
   897	} /* End twl_fill_sense() */
   898	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
