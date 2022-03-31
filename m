Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A74ED4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiCaHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiCaHod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:44:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C739D0818
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648712566; x=1680248566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qM8HavtmUHgTlrTuJPa/+3aSr4mF5TpOyE5MwNCN6MM=;
  b=gX1Oz7pXeby8+QlvJgipr4O/can5gTUgOFMJRa3wWjzaAiXcJQq913zH
   x2xNhkS9ZhbQHaVQZFHTLP0Z5o0JZaYS4kNDwK7yRG0vsJKJJO8c5w6eK
   ZOA1M33pscX3nQTux54mna9y1Ai/JNmYnMeUdxgDe9XfYS+EybwWGyW89
   k/LSJyt01li9yi39Z7g6tQLND+LRWgTOk6bVAHnsh0lyOCBUFsMcYHByz
   551Pk6TwWvAejsFto+ZH2jKEi+cXD0s5pnP5FTJdcdmc0+Rg4HhgnqcpO
   C1B7RbupPdrZlr2lHElKx3ThwBjjJgb62o4CjA+XGz1E5gntSTYHoXxHM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247245681"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247245681"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 00:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="720341864"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 00:42:43 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZpS7-00003z-07;
        Thu, 31 Mar 2022 07:42:43 +0000
Date:   Thu, 31 Mar 2022 15:42:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16
 degrades to integer
Message-ID: <202203311536.W1IL3Too-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: a97b693c3712f040c5802f32b2d685352e08cefa uaccess: fix nios2 and microblaze get_user_8()
date:   5 weeks ago
config: microblaze-randconfig-s032-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311536.W1IL3Too-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a97b693c3712f040c5802f32b2d685352e08cefa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a97b693c3712f040c5802f32b2d685352e08cefa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16 degrades to integer
>> drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/proc.c:150:17: sparse: sparse: cast to restricted __le16
>> drivers/pci/proc.c:159:17: sparse: sparse: restricted __le32 degrades to integer
>> drivers/pci/proc.c:159:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/pci/proc.c:159:17: sparse: sparse: cast to restricted __le32
   drivers/pci/proc.c:168:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/proc.c:168:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/proc.c:168:17: sparse: sparse: cast to restricted __le16

vim +150 drivers/pci/proc.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  112  
3c78bc61f5ef3b Ryan Desfosses  2014-04-18  113  static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
3c78bc61f5ef3b Ryan Desfosses  2014-04-18  114  				  size_t nbytes, loff_t *ppos)
^1da177e4c3f41 Linus Torvalds  2005-04-16  115  {
496ad9aa8ef448 Al Viro         2013-01-23  116  	struct inode *ino = file_inode(file);
359745d78351c6 Muchun Song     2022-01-21  117  	struct pci_dev *dev = pde_data(ino);
^1da177e4c3f41 Linus Torvalds  2005-04-16  118  	int pos = *ppos;
d9dda78bad8795 Al Viro         2013-03-31  119  	int size = dev->cfg_size;
eb627e17727ebe Matthew Garrett 2019-08-19  120  	int cnt, ret;
eb627e17727ebe Matthew Garrett 2019-08-19  121  
eb627e17727ebe Matthew Garrett 2019-08-19  122  	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
eb627e17727ebe Matthew Garrett 2019-08-19  123  	if (ret)
eb627e17727ebe Matthew Garrett 2019-08-19  124  		return ret;
^1da177e4c3f41 Linus Torvalds  2005-04-16  125  
^1da177e4c3f41 Linus Torvalds  2005-04-16  126  	if (pos >= size)
^1da177e4c3f41 Linus Torvalds  2005-04-16  127  		return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  128  	if (nbytes >= size)
^1da177e4c3f41 Linus Torvalds  2005-04-16  129  		nbytes = size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  130  	if (pos + nbytes > size)
^1da177e4c3f41 Linus Torvalds  2005-04-16  131  		nbytes = size - pos;
^1da177e4c3f41 Linus Torvalds  2005-04-16  132  	cnt = nbytes;
^1da177e4c3f41 Linus Torvalds  2005-04-16  133  
96d4f267e40f95 Linus Torvalds  2019-01-03  134  	if (!access_ok(buf, cnt))
^1da177e4c3f41 Linus Torvalds  2005-04-16  135  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  136  
b3c32c4f9565f9 Huang Ying      2012-10-25  137  	pci_config_pm_runtime_get(dev);
b3c32c4f9565f9 Huang Ying      2012-10-25  138  
^1da177e4c3f41 Linus Torvalds  2005-04-16  139  	if ((pos & 1) && cnt) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  140  		unsigned char val;
^1da177e4c3f41 Linus Torvalds  2005-04-16  141  		__get_user(val, buf);
e04b0ea2e0f9c1 Brian King      2005-09-27  142  		pci_user_write_config_byte(dev, pos, val);
^1da177e4c3f41 Linus Torvalds  2005-04-16  143  		buf++;
^1da177e4c3f41 Linus Torvalds  2005-04-16  144  		pos++;
^1da177e4c3f41 Linus Torvalds  2005-04-16  145  		cnt--;
^1da177e4c3f41 Linus Torvalds  2005-04-16  146  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  147  
^1da177e4c3f41 Linus Torvalds  2005-04-16  148  	if ((pos & 3) && cnt > 2) {
f17a077e61b627 Harvey Harrison 2008-07-22  149  		__le16 val;
f17a077e61b627 Harvey Harrison 2008-07-22 @150  		__get_user(val, (__le16 __user *) buf);
e04b0ea2e0f9c1 Brian King      2005-09-27  151  		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
^1da177e4c3f41 Linus Torvalds  2005-04-16  152  		buf += 2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  153  		pos += 2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  154  		cnt -= 2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  155  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  156  
^1da177e4c3f41 Linus Torvalds  2005-04-16  157  	while (cnt >= 4) {
f17a077e61b627 Harvey Harrison 2008-07-22  158  		__le32 val;
f17a077e61b627 Harvey Harrison 2008-07-22 @159  		__get_user(val, (__le32 __user *) buf);
e04b0ea2e0f9c1 Brian King      2005-09-27  160  		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
^1da177e4c3f41 Linus Torvalds  2005-04-16  161  		buf += 4;
^1da177e4c3f41 Linus Torvalds  2005-04-16  162  		pos += 4;
^1da177e4c3f41 Linus Torvalds  2005-04-16  163  		cnt -= 4;
^1da177e4c3f41 Linus Torvalds  2005-04-16  164  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  165  
^1da177e4c3f41 Linus Torvalds  2005-04-16  166  	if (cnt >= 2) {
f17a077e61b627 Harvey Harrison 2008-07-22  167  		__le16 val;
f17a077e61b627 Harvey Harrison 2008-07-22  168  		__get_user(val, (__le16 __user *) buf);
e04b0ea2e0f9c1 Brian King      2005-09-27  169  		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
^1da177e4c3f41 Linus Torvalds  2005-04-16  170  		buf += 2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  171  		pos += 2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  172  		cnt -= 2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  173  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  174  
^1da177e4c3f41 Linus Torvalds  2005-04-16  175  	if (cnt) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  176  		unsigned char val;
^1da177e4c3f41 Linus Torvalds  2005-04-16  177  		__get_user(val, buf);
e04b0ea2e0f9c1 Brian King      2005-09-27  178  		pci_user_write_config_byte(dev, pos, val);
^1da177e4c3f41 Linus Torvalds  2005-04-16  179  		buf++;
^1da177e4c3f41 Linus Torvalds  2005-04-16  180  		pos++;
^1da177e4c3f41 Linus Torvalds  2005-04-16  181  		cnt--;
^1da177e4c3f41 Linus Torvalds  2005-04-16  182  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  183  
b3c32c4f9565f9 Huang Ying      2012-10-25  184  	pci_config_pm_runtime_put(dev);
b3c32c4f9565f9 Huang Ying      2012-10-25  185  
^1da177e4c3f41 Linus Torvalds  2005-04-16  186  	*ppos = pos;
d9dda78bad8795 Al Viro         2013-03-31  187  	i_size_write(ino, dev->cfg_size);
^1da177e4c3f41 Linus Torvalds  2005-04-16  188  	return nbytes;
^1da177e4c3f41 Linus Torvalds  2005-04-16  189  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  190  

:::::: The code at line 150 was first introduced by commit
:::::: f17a077e61b627e58db5926bc474cf308318dad9 PCI: fixup sparse endianness warnings in proc.c

:::::: TO: Harvey Harrison <harvey.harrison@gmail.com>
:::::: CC: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
