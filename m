Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56DD4AA4F5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378610AbiBEAQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:16:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:22677 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbiBEAQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644020165; x=1675556165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OwHius7362OGmkrz3UVv1SxvPq5mRtgzd54EHiDqifE=;
  b=GHwUzqirctWVUbYT5tbu5lozQ+9yD297BWjKJRtIPIhLCkrVVLfLahJO
   4e9aJulCO/W9hHtRShzZV14r9XDj1SFmJ0U7cdKpmvGwnMeF8XRRrDaa2
   RiTxF0Z3tcflwxVMsdEMdSBnBxIgx0y7+r8c9EOdSQvhFAo+KTD85kdXr
   awIwfFnVK6ff/aR22pIKyvSTnzFFVQRJQEiCJyIgFwLWEUfL/zn4kJu8F
   yZUQYfeivYosS+Kj8NzGGMlWuEM+spr8GPG3gFv+dXIkyqYjIRnc/rgOp
   mQjsB0AT7O+UohpgneddcmxChsGF/HihhcpTq//WWDBwitp7aIl2g7SPL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="334862568"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="334862568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="566900289"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2022 16:16:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG8kE-000YLn-0H; Sat, 05 Feb 2022 00:16:02 +0000
Date:   Sat, 5 Feb 2022 08:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Sean O'Brien <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH 3/5] HID: Extract vivaldi hid feature mapping for use in
 hid-hammer
Message-ID: <202202050807.BvUyitVE-lkp@intel.com>
References: <20220204202021.895426-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204202021.895426-4-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I love your patch! Yet something to improve:

[auto build test ERROR on 26291c54e111ff6ba87a164d85d4a4e134b7315c]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/Input-HID-Consolidate-ChromeOS-Vivaldi-keyboard-logic/20220205-042211
base:   26291c54e111ff6ba87a164d85d4a4e134b7315c
config: x86_64-randconfig-a004-20220131 (https://download.01.org/0day-ci/archive/20220205/202202050807.BvUyitVE-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/83759eb892fd16fd0bb7ff4bb0c4baa4e7a0283e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephen-Boyd/Input-HID-Consolidate-ChromeOS-Vivaldi-keyboard-logic/20220205-042211
        git checkout 83759eb892fd16fd0bb7ff4bb0c4baa4e7a0283e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: mce_start()+0x4e: call to clear_bit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_read_aux()+0x41: call to mca_msr_reg() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check()+0x39d: call to test_bit() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x53: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   ld: drivers/input/vivaldi-keymap.o: in function `vivaldi_hid_feature_mapping':
>> drivers/input/vivaldi-keymap.c:73: undefined reference to `hid_alloc_report_buf'
>> ld: drivers/input/vivaldi-keymap.c:90: undefined reference to `hid_hw_raw_request'
>> ld: drivers/input/vivaldi-keymap.c:108: undefined reference to `hid_report_raw_event'


vim +73 drivers/input/vivaldi-keymap.c

    44	
    45	/**
    46	 * vivaldi_hid_feature_mapping - Fill out vivaldi keymap data exposed via HID
    47	 * @data: The vivaldi function keymap
    48	 * @hdev: HID device to parse
    49	 * @field: HID field to parse
    50	 * @usage: HID usage to parse
    51	 */
    52	void vivaldi_hid_feature_mapping(struct vivaldi_data *data,
    53					 struct hid_device *hdev,
    54					 struct hid_field *field,
    55					 struct hid_usage *usage)
    56	{
    57		struct hid_report *report = field->report;
    58		int fn_key;
    59		int ret;
    60		u32 report_len;
    61		u8 *report_data, *buf;
    62	
    63		if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
    64		    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
    65			return;
    66	
    67		fn_key = (usage->hid & HID_USAGE);
    68		if (fn_key < VIVALDI_MIN_FN_ROW_KEY || fn_key > VIVALDI_MAX_FN_ROW_KEY)
    69			return;
    70		if (fn_key > data->num_function_row_keys)
    71			data->num_function_row_keys = fn_key;
    72	
  > 73		report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
    74		if (!report_data)
    75			return;
    76	
    77		report_len = hid_report_len(report);
    78		if (!report->id) {
    79			/*
    80			 * hid_hw_raw_request() will stuff report ID (which will be 0)
    81			 * into the first byte of the buffer even for unnumbered
    82			 * reports, so we need to account for this to avoid getting
    83			 * -EOVERFLOW in return.
    84			 * Note that hid_alloc_report_buf() adds 7 bytes to the size
    85			 * so we can safely say that we have space for an extra byte.
    86			 */
    87			report_len++;
    88		}
    89	
  > 90		ret = hid_hw_raw_request(hdev, report->id, report_data,
    91					 report_len, HID_FEATURE_REPORT,
    92					 HID_REQ_GET_REPORT);
    93		if (ret < 0) {
    94			dev_warn(&hdev->dev, "failed to fetch feature %d\n",
    95				 field->report->id);
    96			goto out;
    97		}
    98	
    99		if (!report->id) {
   100			/*
   101			 * Undo the damage from hid_hw_raw_request() for unnumbered
   102			 * reports.
   103			 */
   104			report_data++;
   105			report_len--;
   106		}
   107	
 > 108		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
   109					   report_len, 0);
   110		if (ret) {
   111			dev_warn(&hdev->dev, "failed to report feature %d\n",
   112				 field->report->id);
   113			goto out;
   114		}
   115	
   116		data->function_row_physmap[fn_key - VIVALDI_MIN_FN_ROW_KEY] =
   117		    field->value[usage->usage_index];
   118	
   119	out:
   120		kfree(buf);
   121	}
   122	EXPORT_SYMBOL_GPL(vivaldi_hid_feature_mapping);
   123	#endif /* CONFIG_HID */
   124	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
