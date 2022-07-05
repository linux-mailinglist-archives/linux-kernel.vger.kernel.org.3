Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D96566F34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiGENaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiGENaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:30:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AF4578E;
        Tue,  5 Jul 2022 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657025502; x=1688561502;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zZ9kSIwpfSMKUXpyfeQrdAkf/rdUOV3WkmiPoqtFBuQ=;
  b=VB3g3rIf4JwrvxzD3O657wAYq7Fci2KOyPE7t6hfB7toICHnHlVSn/Yq
   p9KFgXPLSBwNZ9CbJJ9OwHme/dRA7o53q4yYyMpH0l4nM5dMvkt4HJAJs
   enODaWPyZ32GHC1aMouK0Kxahr2LMd0m1NW2NB/1YuKSH55nkNMrH4ReJ
   ktRbab9wqOuwxjfmWFQj2j2tHeMREksmYW+oPth3KyEI8ZkoK+QH3gZ5g
   lzPpYotEpXR8Xbu/bBQEPS7lgeW1NS/MOFmFjFlYdej4HdjWDIlblbJUQ
   o1gYKd4XDD6EX6Eq7rys+ezYPKQzDJMyII5xSZ368/iijjSjdtWzRwzPo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369666747"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="369666747"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="660545802"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2022 05:50:48 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8i0u-000J5d-AG;
        Tue, 05 Jul 2022 12:50:48 +0000
Date:   Tue, 5 Jul 2022 20:50:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 313/442] htmldocs:
 Documentation/ABI/testing/sysfs-firmware-tdx:2: WARNING: Unexpected
 indentation.
Message-ID: <202207052017.miU9soWY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8af973ebaf30642129fc1ca63f155a469f9615ed
commit: 38171b7e61218ed34ba38f00c6503ffa3ee1a806 [313/442] x86/virt/tdx: Export TDX keyid number and status of TDX module via sysfs
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
