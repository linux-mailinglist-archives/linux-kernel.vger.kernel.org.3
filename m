Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B73466230
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbhLBLW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:22:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:49128 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357291AbhLBLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:22:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="217379880"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="217379880"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="460423673"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2021 03:18:29 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msk6e-000GFH-Ta; Thu, 02 Dec 2021 11:18:28 +0000
Date:   Thu, 2 Dec 2021 19:18:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [t-kristo-pm:usi-5.16-rfc-v3-bpf 17/24] drivers/hid/hid-bpf.c:376:6:
 warning: variable 'parser' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202112021938.1gSUOhoI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v3-bpf
head:   d0f251812c57f49830816624bec858500e4e14c2
commit: e4c4cfe6fd7edf4bdd3bbd2e408759db9b02290e [17/24] HID: bpf: compile fix for bpf_hid_foreach_rdesc_item
config: x86_64-randconfig-a001-20211202 (https://download.01.org/0day-ci/archive/20211202/202112021938.1gSUOhoI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b553297ef3ee4dc2119d5429adf3072e90fac38)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/t-kristo/linux-pm/commit/e4c4cfe6fd7edf4bdd3bbd2e408759db9b02290e
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v3-bpf
        git checkout e4c4cfe6fd7edf4bdd3bbd2e408759db9b02290e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/hid-bpf.c:141:5: warning: no previous prototype for function 'hid_bpf_prog_detach' [-Wmissing-prototypes]
   int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
       ^
   drivers/hid/hid-bpf.c:141:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
   ^
   static 
   drivers/hid/hid-bpf.c:229:24: warning: no previous prototype for function 'hid_bpf_add_report' [-Wmissing-prototypes]
   struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
                          ^
   drivers/hid/hid-bpf.c:229:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
   ^
   static 
   drivers/hid/hid-bpf.c:257:6: warning: no previous prototype for function 'hid_bpf_free_reports' [-Wmissing-prototypes]
   void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
        ^
   drivers/hid/hid-bpf.c:257:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
   ^
   static 
   drivers/hid/hid-bpf.c:321:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case HID_MAIN_ITEM_TAG_END_COLLECTION:
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/hid.h:96:42: note: expanded from macro 'HID_MAIN_ITEM_TAG_END_COLLECTION'
   #define HID_MAIN_ITEM_TAG_END_COLLECTION        12
                                                   ^~
   drivers/hid/hid-bpf.c:338:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/hid/hid-bpf.c:318:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case HID_MAIN_ITEM_TAG_BEGIN_COLLECTION:
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/hid.h:95:44: note: expanded from macro 'HID_MAIN_ITEM_TAG_BEGIN_COLLECTION'
   #define HID_MAIN_ITEM_TAG_BEGIN_COLLECTION      10
                                                   ^~
   drivers/hid/hid-bpf.c:338:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/hid/hid-bpf.c:311:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
>> drivers/hid/hid-bpf.c:376:6: warning: variable 'parser' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!parser_and_data) {
               ^~~~~~~~~~~~~~~~
   drivers/hid/hid-bpf.c:427:8: note: uninitialized use occurs here
           kfree(parser->collection_stack);
                 ^~~~~~
   drivers/hid/hid-bpf.c:376:2: note: remove the 'if' if its condition is always false
           if (!parser_and_data) {
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-bpf.c:355:27: note: initialize the variable 'parser' to silence this warning
           struct hid_parser *parser;
                                    ^
                                     = NULL
   6 warnings generated.


vim +376 drivers/hid/hid-bpf.c

db3fbbad76f8105 Benjamin Tissoires 2021-10-13  350  
e4c4cfe6fd7edf4 Tero Kristo        2021-11-25  351  BPF_CALL_4(bpf_hid_foreach_rdesc_item, void*, ctx, bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  352  {
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  353  	struct hid_bpf_ctx *bpf_ctx = ctx;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  354  	struct hid_bpf_parser_and_data *parser_and_data;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  355  	struct hid_parser *parser;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  356  	struct hid_bpf_parser *callback_data;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  357  	struct hid_item item;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  358  	u8 *data_copy, *start, *end, *next;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  359  	u64 cur_index;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  360  	u64 ret = 0;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  361  	u32 num_elems = 0;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  362  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  363  	static int (*dispatch_type[])(struct hid_parser *parser,
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  364  				      struct hid_item *item) = {
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  365  		hid_bpf_parser_main,
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  366  		hid_parser_global,
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  367  		hid_parser_local,
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  368  		hid_parser_reserved
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  369  	};
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  370  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  371  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  372  	if (flags != 0)
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  373  		return -EINVAL;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  374  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  375  	parser_and_data = vzalloc(sizeof(*parser_and_data));
db3fbbad76f8105 Benjamin Tissoires 2021-10-13 @376  	if (!parser_and_data) {
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  377  		ret = -ENOMEM;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  378  		goto exit;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  379  	}
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  380  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  381  	parser = &parser_and_data->parser;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  382  	callback_data = &parser_and_data->callback_data;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  383  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  384  	parser->device = bpf_ctx->hdev;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  385  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  386  	data_copy = kmemdup(bpf_ctx->event.data, HID_BPF_MAX_BUFFER_SIZE, GFP_KERNEL);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  387  	if (!data_copy) {
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  388  		ret = -ENOMEM;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  389  		goto exit;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  390  	}
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  391  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  392  	start = data_copy;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  393  	end = start + bpf_ctx->event.size;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  394  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  395  	while((next = hid_rdesc_fetch_item(start, end, &item)) != NULL) {
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  396  		cur_index = start - data_copy;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  397  		num_elems++;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  398  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  399  		dispatch_type[item.type](parser, &item);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  400  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  401  		hid_bpf_store_bpf_parser(callback_data, &item, parser);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  402  
e4c4cfe6fd7edf4 Tero Kristo        2021-11-25  403  		ret = callback_fn((u64)(long)ctx, (u64)(long)callback_data,
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  404  				  (u64)(long)&cur_index,
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  405  				  (u64)(long)callback_ctx, 0);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  406  		/* return value: 0 - continue, 1 - stop and return */
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  407  		if (ret)
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  408  			break;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  409  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  410  		/* Reset the local parser environment on main items */
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  411  		if (item.type == HID_ITEM_TYPE_MAIN)
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  412  			memset(&parser->local, 0, sizeof(parser->local));
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  413  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  414  		/* clear item content */
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  415  		memset(&item, 0, sizeof(item));
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  416  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  417  		start = next;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  418  	}
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  419  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  420  	hid_bpf_free_reports(parser_and_data);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  421  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  422  	kfree(data_copy);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  423  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  424  	ret = num_elems;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  425  
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  426   exit:
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  427  	kfree(parser->collection_stack);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  428  	vfree(parser_and_data);
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  429  	return ret;
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  430  }
db3fbbad76f8105 Benjamin Tissoires 2021-10-13  431  

:::::: The code at line 376 was first introduced by commit
:::::: db3fbbad76f810554bcb2c098f8c9beb02724702 HID: bpf: add a helper to parse a given report descriptor

:::::: TO: Benjamin Tissoires <benjamin.tissoires@redhat.com>
:::::: CC: Tero Kristo <tero.kristo@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
