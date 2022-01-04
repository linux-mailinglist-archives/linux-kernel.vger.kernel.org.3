Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38D4839E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 02:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiADBfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 20:35:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:39776 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbiADBfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641260138; x=1672796138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jm40xI6i35+2hdy9sBj4OZnGI2GRhuOzIIMvMNCP2EM=;
  b=QiuhiqPC0zGtcE0RYItrwCmNMczO2ksjdejM3WYoYLGwEx+RSeLyRMtJ
   y5QJ0y0+OMz47DH0HWvBFgiHFfzdXl6nLM727FTzuDZDIowHmySDJqxmh
   hex5s9TTlr+jL4FBMAje6LUQTstbCaTd+Cs0gGUR64Je8hRKoUOOLFy/Y
   AjOzCD8rPFc/lty/e5sc3FP7I6wOqAZEKECp3SipjrZkvK7uzfMBqsm9p
   nQPtd/mNsYhUpKICF0EABJcYDKYDvH+vuzh1ZZs8aL9rmlzTWlplzaZvc
   LqhAswvdo6WbyaEQU3WzqDzWMqMBtXmqUMaHET+wAkjS/ApV3Zl1xtZT4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="239680126"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="239680126"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 17:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="512273984"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2022 17:35:19 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4YjO-000EYQ-Vf; Tue, 04 Jan 2022 01:35:18 +0000
Date:   Tue, 4 Jan 2022 09:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: drivers/usb/cdns3/cdnsp-debug.h:185:6: warning: variable 'ret' set
 but not used
Message-ID: <202201040916.GRGFrGv1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 118b2a3237cf499727649b1c018dd2f1d329af08 usb: cdnsp: Add tracepoints for CDNSP driver
date:   1 year ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220104/202201040916.GRGFrGv1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 104a827ea6de0cbe0f5faef4407552ede31d165c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=118b2a3237cf499727649b1c018dd2f1d329af08
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 118b2a3237cf499727649b1c018dd2f1d329af08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/ drivers/net/ethernet/intel/ice/ drivers/usb/cdns3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/cdns3/cdnsp-ring.c:64:
   In file included from drivers/usb/cdns3/cdnsp-trace.h:27:
>> drivers/usb/cdns3/cdnsp-debug.h:185:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           int ret = 0;
               ^
   1 warning generated.
--
   In file included from drivers/usb/cdns3/cdnsp-gadget.c:26:
   In file included from drivers/usb/cdns3/cdnsp-trace.h:27:
>> drivers/usb/cdns3/cdnsp-debug.h:185:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           int ret = 0;
               ^
   drivers/usb/cdns3/cdnsp-gadget.c:1236:6: warning: variable 'temp_64' set but not used [-Wunused-but-set-variable]
           u64 temp_64;
               ^
   2 warnings generated.
--
   In file included from drivers/usb/cdns3/cdnsp-trace.c:12:
   In file included from drivers/usb/cdns3/cdnsp-trace.h:27:
>> drivers/usb/cdns3/cdnsp-debug.h:185:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
           int ret = 0;
               ^
   In file included from drivers/usb/cdns3/cdnsp-trace.c:12:
   In file included from drivers/usb/cdns3/cdnsp-trace.h:840:
   include/trace/define_trace.h:95:10: fatal error: './cdnsp-trace.h' file not found
   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:90:32: note: expanded from macro 'TRACE_INCLUDE'
   # define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:87:34: note: expanded from macro '__TRACE_INCLUDE'
   # define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stringify.h:10:27: note: expanded from macro '__stringify'
   #define __stringify(x...)       __stringify_1(x)
                                   ^~~~~~~~~~~~~~~~
   include/linux/stringify.h:9:29: note: expanded from macro '__stringify_1'
   #define __stringify_1(x...)     #x
                                   ^~
   <scratch space>:156:1: note: expanded from here
   "./cdnsp-trace.h"
   ^~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/ret +185 drivers/usb/cdns3/cdnsp-debug.h

   178	
   179	static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
   180						   u32 field1, u32 field2, u32 field3)
   181	{
   182		int ep_id = TRB_TO_EP_INDEX(field3) - 1;
   183		int type = TRB_FIELD_TO_TYPE(field3);
   184		unsigned int ep_num;
 > 185		int ret = 0;
   186		u32 temp;
   187	
   188		ep_num = DIV_ROUND_UP(ep_id, 2);
   189	
   190		switch (type) {
   191		case TRB_LINK:
   192			ret += snprintf(str, size,
   193					"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
   194					field1, field0, GET_INTR_TARGET(field2),
   195					cdnsp_trb_type_string(type),
   196					field3 & TRB_IOC ? 'I' : 'i',
   197					field3 & TRB_CHAIN ? 'C' : 'c',
   198					field3 & TRB_TC ? 'T' : 't',
   199					field3 & TRB_CYCLE ? 'C' : 'c');
   200			break;
   201		case TRB_TRANSFER:
   202		case TRB_COMPLETION:
   203		case TRB_PORT_STATUS:
   204		case TRB_HC_EVENT:
   205			ret += snprintf(str, size,
   206					"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
   207					" len %ld slot %ld flags %c:%c",
   208					ep_num, ep_id % 2 ? "out" : "in",
   209					TRB_TO_EP_INDEX(field3),
   210					cdnsp_trb_type_string(type), field1, field0,
   211					cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
   212					EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
   213					field3 & EVENT_DATA ? 'E' : 'e',
   214					field3 & TRB_CYCLE ? 'C' : 'c');
   215			break;
   216		case TRB_MFINDEX_WRAP:
   217			ret += snprintf(str, size, "%s: flags %c",
   218					cdnsp_trb_type_string(type),
   219					field3 & TRB_CYCLE ? 'C' : 'c');
   220			break;
   221		case TRB_SETUP:
   222			ret += snprintf(str, size,
   223					"type '%s' bRequestType %02x bRequest %02x "
   224					"wValue %02x%02x wIndex %02x%02x wLength %d "
   225					"length %ld TD size %ld intr %ld Setup ID %ld "
   226					"flags %c:%c:%c",
   227					cdnsp_trb_type_string(type),
   228					field0 & 0xff,
   229					(field0 & 0xff00) >> 8,
   230					(field0 & 0xff000000) >> 24,
   231					(field0 & 0xff0000) >> 16,
   232					(field1 & 0xff00) >> 8,
   233					field1 & 0xff,
   234					(field1 & 0xff000000) >> 16 |
   235					(field1 & 0xff0000) >> 16,
   236					TRB_LEN(field2), GET_TD_SIZE(field2),
   237					GET_INTR_TARGET(field2),
   238					TRB_SETUPID_TO_TYPE(field3),
   239					field3 & TRB_IDT ? 'D' : 'd',
   240					field3 & TRB_IOC ? 'I' : 'i',
   241					field3 & TRB_CYCLE ? 'C' : 'c');
   242			break;
   243		case TRB_DATA:
   244			ret += snprintf(str, size,
   245					"type '%s' Buffer %08x%08x length %ld TD size %ld "
   246					"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
   247					cdnsp_trb_type_string(type),
   248					field1, field0, TRB_LEN(field2),
   249					GET_TD_SIZE(field2),
   250					GET_INTR_TARGET(field2),
   251					field3 & TRB_IDT ? 'D' : 'i',
   252					field3 & TRB_IOC ? 'I' : 'i',
   253					field3 & TRB_CHAIN ? 'C' : 'c',
   254					field3 & TRB_NO_SNOOP ? 'S' : 's',
   255					field3 & TRB_ISP ? 'I' : 'i',
   256					field3 & TRB_ENT ? 'E' : 'e',
   257					field3 & TRB_CYCLE ? 'C' : 'c');
   258			break;
   259		case TRB_STATUS:
   260			ret += snprintf(str, size,
   261					"Buffer %08x%08x length %ld TD size %ld intr"
   262					"%ld type '%s' flags %c:%c:%c:%c",
   263					field1, field0, TRB_LEN(field2),
   264					GET_TD_SIZE(field2),
   265					GET_INTR_TARGET(field2),
   266					cdnsp_trb_type_string(type),
   267					field3 & TRB_IOC ? 'I' : 'i',
   268					field3 & TRB_CHAIN ? 'C' : 'c',
   269					field3 & TRB_ENT ? 'E' : 'e',
   270					field3 & TRB_CYCLE ? 'C' : 'c');
   271			break;
   272		case TRB_NORMAL:
   273		case TRB_ISOC:
   274		case TRB_EVENT_DATA:
   275		case TRB_TR_NOOP:
   276			ret += snprintf(str, size,
   277					"type '%s' Buffer %08x%08x length %ld "
   278					"TD size %ld intr %ld "
   279					"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
   280					cdnsp_trb_type_string(type),
   281					field1, field0, TRB_LEN(field2),
   282					GET_TD_SIZE(field2),
   283					GET_INTR_TARGET(field2),
   284					field3 & TRB_BEI ? 'B' : 'b',
   285					field3 & TRB_IDT ? 'T' : 't',
   286					field3 & TRB_IOC ? 'I' : 'i',
   287					field3 & TRB_CHAIN ? 'C' : 'c',
   288					field3 & TRB_NO_SNOOP ? 'S' : 's',
   289					field3 & TRB_ISP ? 'I' : 'i',
   290					field3 & TRB_ENT ? 'E' : 'e',
   291					field3 & TRB_CYCLE ? 'C' : 'c',
   292					!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
   293			break;
   294		case TRB_CMD_NOOP:
   295		case TRB_ENABLE_SLOT:
   296			ret += snprintf(str, size, "%s: flags %c",
   297					cdnsp_trb_type_string(type),
   298					field3 & TRB_CYCLE ? 'C' : 'c');
   299			break;
   300		case TRB_DISABLE_SLOT:
   301			ret += snprintf(str, size, "%s: slot %ld flags %c",
   302					cdnsp_trb_type_string(type),
   303					TRB_TO_SLOT_ID(field3),
   304					field3 & TRB_CYCLE ? 'C' : 'c');
   305			break;
   306		case TRB_ADDR_DEV:
   307			ret += snprintf(str, size,
   308					"%s: ctx %08x%08x slot %ld flags %c:%c",
   309					cdnsp_trb_type_string(type), field1, field0,
   310					TRB_TO_SLOT_ID(field3),
   311					field3 & TRB_BSR ? 'B' : 'b',
   312					field3 & TRB_CYCLE ? 'C' : 'c');
   313			break;
   314		case TRB_CONFIG_EP:
   315			ret += snprintf(str, size,
   316					"%s: ctx %08x%08x slot %ld flags %c:%c",
   317					cdnsp_trb_type_string(type), field1, field0,
   318					TRB_TO_SLOT_ID(field3),
   319					field3 & TRB_DC ? 'D' : 'd',
   320					field3 & TRB_CYCLE ? 'C' : 'c');
   321			break;
   322		case TRB_EVAL_CONTEXT:
   323			ret += snprintf(str, size,
   324					"%s: ctx %08x%08x slot %ld flags %c",
   325					cdnsp_trb_type_string(type), field1, field0,
   326					TRB_TO_SLOT_ID(field3),
   327					field3 & TRB_CYCLE ? 'C' : 'c');
   328			break;
   329		case TRB_RESET_EP:
   330		case TRB_HALT_ENDPOINT:
   331		case TRB_FLUSH_ENDPOINT:
   332			ret += snprintf(str, size,
   333					"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
   334					cdnsp_trb_type_string(type),
   335					ep_num, ep_id % 2 ? "out" : "in",
   336					TRB_TO_EP_INDEX(field3), field1, field0,
   337					TRB_TO_SLOT_ID(field3),
   338					field3 & TRB_CYCLE ? 'C' : 'c');
   339			break;
   340		case TRB_STOP_RING:
   341			ret += snprintf(str, size,
   342					"%s: ep%d%s(%d) slot %ld sp %d flags %c",
   343					cdnsp_trb_type_string(type),
   344					ep_num, ep_id % 2 ? "out" : "in",
   345					TRB_TO_EP_INDEX(field3),
   346					TRB_TO_SLOT_ID(field3),
   347					TRB_TO_SUSPEND_PORT(field3),
   348					field3 & TRB_CYCLE ? 'C' : 'c');
   349			break;
   350		case TRB_SET_DEQ:
   351			ret += snprintf(str, size,
   352					"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
   353					cdnsp_trb_type_string(type),
   354					ep_num, ep_id % 2 ? "out" : "in",
   355					TRB_TO_EP_INDEX(field3), field1, field0,
   356					TRB_TO_STREAM_ID(field2),
   357					TRB_TO_SLOT_ID(field3),
   358					field3 & TRB_CYCLE ? 'C' : 'c');
   359			break;
   360		case TRB_RESET_DEV:
   361			ret += snprintf(str, size, "%s: slot %ld flags %c",
   362					cdnsp_trb_type_string(type),
   363					TRB_TO_SLOT_ID(field3),
   364					field3 & TRB_CYCLE ? 'C' : 'c');
   365			break;
   366		case TRB_ENDPOINT_NRDY:
   367			temp  = TRB_TO_HOST_STREAM(field2);
   368	
   369			ret += snprintf(str, size,
   370					"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
   371					cdnsp_trb_type_string(type),
   372					ep_num, ep_id % 2 ? "out" : "in",
   373					TRB_TO_EP_INDEX(field3), temp,
   374					temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
   375					temp == STREAM_REJECTED ? "(REJECTED)" : "",
   376					TRB_TO_DEV_STREAM(field0),
   377					field3 & TRB_STAT ? 'S' : 's',
   378					field3 & TRB_CYCLE ? 'C' : 'c');
   379			break;
   380		default:
   381			ret += snprintf(str, size,
   382					"type '%s' -> raw %08x %08x %08x %08x",
   383					cdnsp_trb_type_string(type),
   384					field0, field1, field2, field3);
   385		}
   386	
   387		return str;
   388	}
   389	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
