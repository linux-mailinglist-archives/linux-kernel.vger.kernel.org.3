Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648EE54765C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiFKQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiFKQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:13:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCDD3A199
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654964003; x=1686500003;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z+2A82oSq6ecsMu+o3oeRM1Du1Le9TaCuspirF24Mbw=;
  b=Sr4mrJNRp1fLe9BpSE2oKoMFPt9Ph8cvdV4xHgXar/HVKtxFD+K9C+eF
   62pnLIQjvA5xceArSfczPN2RX8fCLqFnK7qgJrzPPZ8xHOT33EcL+nKlL
   xnrjXydejQEJ+AeNs2sjOCGSd8l2Ttc/icuf2EnmIyVe16/k48JoAddsD
   XGQTDcAcke6ENn5xTahmyxsU0pgbFvoyrRwmVfLBhUE+SCyMRjJLGfeD4
   0E2CRqCzAZj2ArDdtVuvJVTSKOAB1F5eNFacwVAqNUT2Y/YyRI0/RHCg8
   8RgWcc7pLJC/pSPFEbTwnbXl89HhL9SrWhNiBvWPn2Ke2PcpwjxHEbUAQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258339402"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="258339402"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 09:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="534510057"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2022 09:13:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o03jk-000J3j-Br;
        Sat, 11 Jun 2022 16:13:20 +0000
Date:   Sun, 12 Jun 2022 00:12:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Subject: [daveh-devel:testme 2/2] drivers/of/kexec.c:126:5: warning: no
 previous prototype for 'ima_get_kexec_buffer'
Message-ID: <202206120045.FwSlNqBY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git testme
head:   a217a1ebac788fd28ccf79499e9e12e5519d70b7
commit: a217a1ebac788fd28ccf79499e9e12e5519d70b7 [2/2] x86/kexec: Carry forward IMA measurement log on kexec
config: parisc-randconfig-r023-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120045.FwSlNqBY-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/?id=a217a1ebac788fd28ccf79499e9e12e5519d70b7
        git remote add daveh-devel https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git
        git fetch --no-tags daveh-devel testme
        git checkout a217a1ebac788fd28ccf79499e9e12e5519d70b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/of/kexec.c:126:5: warning: no previous prototype for 'ima_get_kexec_buffer' [-Wmissing-prototypes]
     126 | int ima_get_kexec_buffer(void **addr, size_t *size)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/of/kexec.c:153:5: warning: no previous prototype for 'ima_free_kexec_buffer' [-Wmissing-prototypes]
     153 | int ima_free_kexec_buffer(void)
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/ima_get_kexec_buffer +126 drivers/of/kexec.c

fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  118  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  119  /**
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  120   * ima_get_kexec_buffer - get IMA buffer from the previous kernel
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  121   * @addr:	On successful return, set to point to the buffer contents.
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  122   * @size:	On successful return, set to the buffer size.
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  123   *
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  124   * Return: 0 on success, negative errno on error.
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  125   */
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21 @126  int ima_get_kexec_buffer(void **addr, size_t *size)
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  127  {
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  128  	int ret, len;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  129  	unsigned long tmp_addr;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  130  	size_t tmp_size;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  131  	const void *prop;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  132  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  133  	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  134  		return -ENOTSUPP;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  135  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  136  	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  137  	if (!prop)
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  138  		return -ENOENT;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  139  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  140  	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  141  	if (ret)
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  142  		return ret;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  143  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  144  	*addr = __va(tmp_addr);
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  145  	*size = tmp_size;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  146  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  147  	return 0;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  148  }
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  149  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  150  /**
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  151   * ima_free_kexec_buffer - free memory used by the IMA buffer
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  152   */
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21 @153  int ima_free_kexec_buffer(void)
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  154  {
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  155  	int ret;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  156  	unsigned long addr;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  157  	size_t size;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  158  	struct property *prop;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  159  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  160  	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  161  		return -ENOTSUPP;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  162  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  163  	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  164  	if (!prop)
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  165  		return -ENOENT;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  166  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  167  	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  168  	if (ret)
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  169  		return ret;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  170  
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  171  	ret = of_remove_property(of_chosen, prop);
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  172  	if (ret)
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  173  		return ret;
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  174  
3ecc68349bbab6 Mike Rapoport           2021-11-05  175  	return memblock_phys_free(addr, size);
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  176  }
fee3ff99bc6760 Lakshmi Ramasubramanian 2021-02-21  177  

:::::: The code at line 126 was first introduced by commit
:::::: fee3ff99bc67604fba77f19da0106f3ec52b1956 powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c

:::::: TO: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
:::::: CC: Rob Herring <robh@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
