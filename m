Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA21596DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiHQLi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiHQLiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:38:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C432874E20;
        Wed, 17 Aug 2022 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660736299; x=1692272299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rk5b1/vS2TOWo50OW5vC6JiByaq3rTM4UCKtmeA+9Us=;
  b=emQcwScMxXcdbyPqNc8Mgly6zqleGdp91ZmoKr+XQo/CIW2x7IWvH+PS
   8saJo1nDzRNZdWqeuLZ9Ul2nDRuSD0lYl85pWAEXwv8EDZH++6P8oj/yW
   A41QP43kMo0Xp3Cq143XSHTG3MkLbFVv4j+3c0XeJklxU2lXU23O+Bwcc
   I7CwhkzlUzarWSgGF+eG6uf+LVS7FHZMHm+WNxW7fdzwHrm6KWSBks4zh
   6GmZh9uE75rsn6M1nWwQNSnX7ioxEqa8pMO3yZSZQbMpAK8/OaZIWviMR
   np+Z7n6pNV+wL8KgHZNysmZngZoBtrwRcHmEn549o9W+T9xA5tduwCGPI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378761986"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378761986"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 04:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="935327300"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 04:38:17 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOHNJ-0000s0-19;
        Wed, 17 Aug 2022 11:38:17 +0000
Date:   Wed, 17 Aug 2022 19:37:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 204/308] htmldocs:
 Documentation/ABI/testing/sysfs-firmware-tdx:2: WARNING: Unexpected
 indentation.
Message-ID: <202208171918.9a38xuei-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   85c097fdd1667a842a9e75d8f658fc16bd72981a
commit: 12cafff9983dad1d20f872655c7248c6dfaffb8e [204/308] x86/virt/tdx: Export TDX keyid number and status of TDX module via sysfs
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-firmware-tdx:2: WARNING: Unexpected indentation.
>> Documentation/ABI/testing/sysfs-firmware-tdx:2: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/ABI/testing/sysfs-firmware-tdx:2: WARNING: Malformed table.
>> Documentation/ABI/testing/sysfs-firmware-tdx:22: WARNING: Blank line required after table.
>> Documentation/ABI/testing/sysfs-firmware-tdx:22: WARNING: Definition list ends without a blank line; unexpected unindent.
>> Documentation/ABI/testing/sysfs-firmware-tdx:1: WARNING: undefined label: abi_sys_firmware_tdx_tdx_module (if the link has no caption the label must precede a section header)

vim +2 Documentation/ABI/testing/sysfs-firmware-tdx

   > 1	What:           /sys/firmware/tdx/
   > 2	Date:           March 2022
     3	KernelVersion:  5.17
     4	Contact:        Isaku Yamahata <isaku.yamahata@intel.com>, kvm@vger.kernel.org
     5	Description:
     6	                Intel's Trust Domain Extensions (TDX) protect guest VMs from
     7	                malicious hosts and some physical attacks.  This directory
     8	                represents the entry point directory for the TDX.
     9	
    10	                the TDX requires the TDX firmware to load into an isolated
    11	                memory region.  It requires a two-step loading process.  It uses
    12	                the first phase firmware loader (a.k.a NP-SEAMLDR) that loads
    13	                the next loader and the second phase firmware loader(a.k.a
    14	                P-SEAMLDR) that loads the TDX firmware(a.k.a the "TDX module").
    15	                =============== ================================================
    16	                keyid_num       the number of SEAM keyid as an hexadecimal
    17	                                number with the "0x" prefix.
    18	                =============== ================================================
    19	Users:          libvirt
    20	
    21	What:           /sys/firmware/tdx/tdx_module/
  > 22	Date:           March 2022

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
