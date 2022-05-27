Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4395362F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353167AbiE0Moq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353211AbiE0MoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:44:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303E6389;
        Fri, 27 May 2022 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653655376; x=1685191376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RBf+BVce7/Id2br5aNIEC3LrdxmWWWm7Yn0rzxyk54w=;
  b=QiaJlbFwvrWW+u65DqT9mPhsfSk2LDwIAId/665aBYatg6ErY8yju9AG
   lzAAsduU5HrJmo8baB/O42E8lcscJWONTZ4Nni+MU60E2uPLiUXb/lLU4
   1orNEzN/dlucSVgSuIWTX3CRbmfUMAXhaWsi2DWbchZ7uk+b1HEUpZG99
   C9w0NGrMclcqyJJlJ5685RxBacb82auEsu7OpSkuR56eo4bBHmKLXmSRM
   izrUsfM6gh9N3yR5Jv+RHeQUkDkLwYWVzduZK4JJ5DkyBHRrXIt/W2jum
   cDg9xowYdRagK+nSedvHaEJwvcFEDaduTsYxsgPsC9lodyGublHXvVk1s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="272042475"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="272042475"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 05:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="528104020"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2022 05:42:53 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuZIq-0004kQ-TI;
        Fri, 27 May 2022 12:42:52 +0000
Date:   Fri, 27 May 2022 20:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolai Kondrashov <spbnick@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-doc@vger.kernel.org
Subject: drivers/hid/hid-uclogic-params.c:48: warning: This comment starts
 with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202205272033.XFYlYj8k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: a228809fa6f39c3fa46ac6b929024686750f7a09 HID: uclogic: Move param printing to a function
date:   2 weeks ago
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220527/202205272033.XFYlYj8k-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a228809fa6f39c3fa46ac6b929024686750f7a09
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a228809fa6f39c3fa46ac6b929024686750f7a09
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-uclogic-params.c:48: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
   drivers/hid/hid-uclogic-params.c:80: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dump tablet interface frame parameters with hid_dbg(), indented with two
   drivers/hid/hid-uclogic-params.c:105: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dump tablet interface parameters with hid_dbg().


vim +48 drivers/hid/hid-uclogic-params.c

    46	
    47	/**
  > 48	 * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
    49	 *
    50	 * @hdev:	The HID device the pen parameters describe.
    51	 * @pen:	The pen parameters to dump.
    52	 */
    53	static void uclogic_params_pen_hid_dbg(const struct hid_device *hdev,
    54						const struct uclogic_params_pen *pen)
    55	{
    56		size_t i;
    57	
    58		hid_dbg(hdev, "\t.usage_invalid = %s\n",
    59			(pen->usage_invalid ? "true" : "false"));
    60		hid_dbg(hdev, "\t.desc_ptr = %p\n", pen->desc_ptr);
    61		hid_dbg(hdev, "\t.desc_size = %u\n", pen->desc_size);
    62		hid_dbg(hdev, "\t.id = %u\n", pen->id);
    63		hid_dbg(hdev, "\t.subreport_list = {\n");
    64		for (i = 0; i < ARRAY_SIZE(pen->subreport_list); i++) {
    65			hid_dbg(hdev, "\t\t{0x%02hhx, %hhu}%s\n",
    66				pen->subreport_list[i].value,
    67				pen->subreport_list[i].id,
    68				i < (ARRAY_SIZE(pen->subreport_list) - 1) ? "," : "");
    69		}
    70		hid_dbg(hdev, "\t}\n");
    71		hid_dbg(hdev, "\t.inrange = %s\n",
    72			uclogic_params_pen_inrange_to_str(pen->inrange));
    73		hid_dbg(hdev, "\t.fragmented_hires = %s\n",
    74			(pen->fragmented_hires ? "true" : "false"));
    75		hid_dbg(hdev, "\t.tilt_y_flipped = %s\n",
    76			(pen->tilt_y_flipped ? "true" : "false"));
    77	}
    78	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
