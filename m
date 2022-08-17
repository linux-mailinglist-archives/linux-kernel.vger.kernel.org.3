Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74AF596C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiHQJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiHQJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:57:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2DB80B5C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660730214; x=1692266214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=88KRpA7BDZEUkMcTOHc24LzJLZovX56BzPHobKmNqCc=;
  b=El/IPF+WYUK4lMf0Oi8TRedVPQ7kd2aF6x5I+0lz3v6iplHBJmg7CYf1
   OTfaIdgvFyVupN2vFVl2RCMY/raeoxsiH4th41WX5HbuDcl0/23IsL41b
   V7dyFmztk5me3jNVgI/Ckg93lcpCQY0R2zbuOZzPQ29kKaVjqLdlU+x+m
   ZLiFnd283IYTNxaBaozr8x8R6F/sCfG///OtFRGXuH0EGECBBnea4bX8Z
   iAr9HKIggd96BPXeVKUZ7MRIu9gRcBY4gImRditbkltIKT4eAcJH3A0HZ
   vaEw4ZaSKmu7dYWgFwY1UrS0sV9shNSv8Tr9mhCxOcLu1rsTNCNMIe/Zh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293729231"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293729231"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 02:56:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667543842"
Received: from rongch2-desk.sh.intel.com (HELO localhost) ([10.239.159.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 02:56:51 -0700
Date:   Wed, 17 Aug 2022 17:56:49 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: [intel-tdx:guest-filter 1/28] drivers/usb/core/sysfs.c:1164:31:
 warning: unused variable 'intf'
Message-ID: <Yvy7YbZ1MxqSPiJ5@rongch2-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-filter
head:   c8ae661a124d107ccb71713b70010f1bf237b7a2
commit: 43ef78fa0be78320a27a01cee80aeb3e235ab426 [1/28] driver core: Move the "authorized" attribute from USB/Thunderbolt to core
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220817/202208170707.wGu4vJaH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/43ef78fa0be78320a27a01cee80aeb3e235ab426
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-filter
        git checkout 43ef78fa0be78320a27a01cee80aeb3e235ab426
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/core/sysfs.c: In function 'interface_authorized_show':
>> drivers/usb/core/sysfs.c:1164:31: warning: unused variable 'intf' [-Wunused-variable]
    1164 |         struct usb_interface *intf = to_usb_interface(dev);
         |                               ^~~~


vim +/intf +1164 drivers/usb/core/sysfs.c

49e7cc84a86784 Sarah Sharp                2008-10-06  1156  
310d2b4124c073 Stefan Koch                2015-08-25  1157  /*
310d2b4124c073 Stefan Koch                2015-08-25  1158   * interface_authorized_show - show authorization status of an USB interface
310d2b4124c073 Stefan Koch                2015-08-25  1159   * 1 is authorized, 0 is deauthorized
310d2b4124c073 Stefan Koch                2015-08-25  1160   */
310d2b4124c073 Stefan Koch                2015-08-25  1161  static ssize_t interface_authorized_show(struct device *dev,
310d2b4124c073 Stefan Koch                2015-08-25  1162  		struct device_attribute *attr, char *buf)
310d2b4124c073 Stefan Koch                2015-08-25  1163  {
310d2b4124c073 Stefan Koch                2015-08-25 @1164  	struct usb_interface *intf = to_usb_interface(dev);
310d2b4124c073 Stefan Koch                2015-08-25  1165  
43ef78fa0be783 Kuppuswamy Sathyanarayanan 2021-08-14  1166  	return sysfs_emit(buf, "%u\n", dev->authorized);
310d2b4124c073 Stefan Koch                2015-08-25  1167  }
310d2b4124c073 Stefan Koch                2015-08-25  1168  

:::::: The code at line 1164 was first introduced by commit
:::::: 310d2b4124c073a2057ef9d952d4d938e9b1dfd9 usb: interface authorization: SysFS part of USB interface authorization

:::::: TO: Stefan Koch <stefan.koch10@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

