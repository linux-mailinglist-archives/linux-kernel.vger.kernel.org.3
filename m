Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD50B50EC96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiDYXey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiDYXew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:34:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F726A06A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650929506; x=1682465506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0lhndJjDn/HqgkGA/clNmjLMRbgedTdtPzE+IXmrLsA=;
  b=ZSullI0b5ugojomUjr5LBHDfrIf1jPrxuPVTuEdmSBvToKDCtxhe9bPp
   RHi4ccvNd+Tzp9Ge+NpXKocNOYyWE58MK3V1APnw8rOPhRTk09LtgPUUW
   Uch16Ofu+D2F7qf9+0GXi+S2bsq3l1IKLOY5Dl9+hSiMAv3eP3ld1E+Gp
   vQcNktkEOmxiRTw9yleSMqGtnFMGlYz9ZwCM9J8ZZdfhAo1H6C/7ZQrQn
   sDqfMzrxmXDixDINJbEnQXr5vSrFHchEErRGa0mJ5J35pGVcqMs+grPml
   5r2iWvV/Hv2aDwZ37gNYAT8bSXX5sAhiMrZnemEswZ7kH80UDRpCwYZct
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290534265"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290534265"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 16:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="616729829"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2022 16:31:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj8BE-000308-K4;
        Mon, 25 Apr 2022 23:31:44 +0000
Date:   Tue, 26 Apr 2022 07:30:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/iavf/iavf_fdir.c:340:5: warning: format
 specifies type 'unsigned short' but the argument has type 'int'
Message-ID: <202204260715.M6oOAjgw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haiyue,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d615b5416f8a1afeb82d13b238f8152c572d59c0
commit: 527691bf0682d7ddcca77fc17dabd2fa090572ff iavf: Support IPv4 Flow Director filters
date:   1 year, 1 month ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220426/202204260715.M6oOAjgw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=527691bf0682d7ddcca77fc17dabd2fa090572ff
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 527691bf0682d7ddcca77fc17dabd2fa090572ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/ethernet/intel/iavf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/iavf/iavf_fdir.c:340:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(fltr->ip_data.dst_port),
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:118:33: note: expanded from macro 'dev_info'
           _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/iavf/iavf_fdir.c:341:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(fltr->ip_data.src_port));
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:118:33: note: expanded from macro 'dev_info'
           _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +340 drivers/net/ethernet/intel/iavf/iavf_fdir.c

   316	
   317	/**
   318	 * iavf_print_fdir_fltr
   319	 * @adapter: adapter structure
   320	 * @fltr: Flow Director filter to print
   321	 *
   322	 * Print the Flow Director filter
   323	 **/
   324	void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr)
   325	{
   326		const char *proto = iavf_fdir_flow_proto_name(fltr->flow_type);
   327	
   328		if (!proto)
   329			return;
   330	
   331		switch (fltr->flow_type) {
   332		case IAVF_FDIR_FLOW_IPV4_TCP:
   333		case IAVF_FDIR_FLOW_IPV4_UDP:
   334		case IAVF_FDIR_FLOW_IPV4_SCTP:
   335			dev_info(&adapter->pdev->dev, "Rule ID: %u dst_ip: %pI4 src_ip %pI4 %s: dst_port %hu src_port %hu\n",
   336				 fltr->loc,
   337				 &fltr->ip_data.v4_addrs.dst_ip,
   338				 &fltr->ip_data.v4_addrs.src_ip,
   339				 proto,
 > 340				 ntohs(fltr->ip_data.dst_port),
   341				 ntohs(fltr->ip_data.src_port));
   342			break;
   343		case IAVF_FDIR_FLOW_IPV4_AH:
   344		case IAVF_FDIR_FLOW_IPV4_ESP:
   345			dev_info(&adapter->pdev->dev, "Rule ID: %u dst_ip: %pI4 src_ip %pI4 %s: SPI %u\n",
   346				 fltr->loc,
   347				 &fltr->ip_data.v4_addrs.dst_ip,
   348				 &fltr->ip_data.v4_addrs.src_ip,
   349				 proto,
   350				 ntohl(fltr->ip_data.spi));
   351			break;
   352		case IAVF_FDIR_FLOW_IPV4_OTHER:
   353			dev_info(&adapter->pdev->dev, "Rule ID: %u dst_ip: %pI4 src_ip %pI4 proto: %u L4_bytes: 0x%x\n",
   354				 fltr->loc,
   355				 &fltr->ip_data.v4_addrs.dst_ip,
   356				 &fltr->ip_data.v4_addrs.src_ip,
   357				 fltr->ip_data.proto,
   358				 ntohl(fltr->ip_data.l4_header));
   359			break;
   360		default:
   361			break;
   362		}
   363	}
   364	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
