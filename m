Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1E5097E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385004AbiDUGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384987AbiDUGnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:43:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800213F93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523253; x=1682059253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zzYLF3L2UBp1WVQzawlBKo4XIU0z21RVr6PpRDqRFzE=;
  b=Yp9w15Fe20H3ezUALs9RONwAMq0Ks7RbazjCbLHdqt1M7jkSN2V3rQ6t
   lxooy86NnFD8VzRm5ugKGMnH138W5femt9afhMuxyi/jk+sG5ROh3xge4
   o22HUG3yr7JQAvQzRwLMvp/kgSZa+Q1/qof3jWmZiE5wE+5E/1OWVEKJq
   5QZ5C6i6QNizR2sR1AQ8/lXdPgf8+ImuwPwHxMlrY0uX5mRjnP84rEreM
   O+l3B+jq3Gst14puf7Fq4Bg/w34zYbIqwaFuTO4fWEi+zmzDAG4+n8OSG
   AG9TExOZM4G1JnUijW9z1y9WM4tsaon4e6bawmZBJ/L9ZowjqnZBJrif2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327160559"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="327160559"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="805383626"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2022 23:40:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQUj-0007xz-J6;
        Thu, 21 Apr 2022 06:40:49 +0000
Date:   Thu, 21 Apr 2022 14:40:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2334/2579]
 drivers/media/platform/nxp/fsl-viu.c:1319:35: error: invalid use of
 undefined type 'struct vm_area_struct'
Message-ID: <202204202237.YDWys8yN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: b27bd62c031289808bdd5bc641923e4e1ef02a5d [2334/2579] headers/deps: modules: Optimize <linux/buildid.h> dependencies, remove <linux/mm_types.h> inclusion
config: sparc64-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220420/202204202237.YDWys8yN-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b27bd62c031289808bdd5bc641923e4e1ef02a5d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b27bd62c031289808bdd5bc641923e4e1ef02a5d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/media/platform/nxp/ kernel/ sound/soc/qcom/qdsp6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/media/platform/nxp/fsl-viu.c: In function 'vidioc_s_fbuf':
   drivers/media/platform/nxp/fsl-viu.c:813:14: error: implicit declaration of function 'capable'; did you mean 'adi_capable'? [-Werror=implicit-function-declaration]
     813 |         if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RAWIO))
         |              ^~~~~~~
         |              adi_capable
   drivers/media/platform/nxp/fsl-viu.c:813:22: error: 'CAP_SYS_ADMIN' undeclared (first use in this function)
     813 |         if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RAWIO))
         |                      ^~~~~~~~~~~~~
   drivers/media/platform/nxp/fsl-viu.c:813:22: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/platform/nxp/fsl-viu.c:813:49: error: 'CAP_SYS_RAWIO' undeclared (first use in this function)
     813 |         if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RAWIO))
         |                                                 ^~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask_types.h:12,
                    from include/linux/cpumask.h:5,
                    from include/linux/smp_api.h:12,
                    from include/linux/lockdep_api.h:27,
                    from include/linux/timer.h:5,
                    from drivers/media/platform/nxp/fsl-viu.c:12:
   drivers/media/platform/nxp/fsl-viu.c: In function 'viu_mmap':
>> drivers/media/platform/nxp/fsl-viu.c:1319:35: error: invalid use of undefined type 'struct vm_area_struct'
    1319 |                 (unsigned long)vma->vm_start,
         |                                   ^~
   include/linux/printk.h:416:33: note: in definition of macro 'printk_index_wrap'
     416 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   drivers/media/platform/nxp/fsl-viu.c:53:25: note: in expansion of macro 'printk'
      53 |                         printk(KERN_DEBUG "viu: " fmt , ## arg);        \
         |                         ^~~~~~
   drivers/media/platform/nxp/fsl-viu.c:1318:9: note: in expansion of macro 'dprintk'
    1318 |         dprintk(1, "vma start=0x%08lx, size=%ld, ret=%d\n",
         |         ^~~~~~~
   drivers/media/platform/nxp/fsl-viu.c:1320:35: error: invalid use of undefined type 'struct vm_area_struct'
    1320 |                 (unsigned long)vma->vm_end-(unsigned long)vma->vm_start,
         |                                   ^~
   include/linux/printk.h:416:33: note: in definition of macro 'printk_index_wrap'
     416 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   drivers/media/platform/nxp/fsl-viu.c:53:25: note: in expansion of macro 'printk'
      53 |                         printk(KERN_DEBUG "viu: " fmt , ## arg);        \
         |                         ^~~~~~
   drivers/media/platform/nxp/fsl-viu.c:1318:9: note: in expansion of macro 'dprintk'
    1318 |         dprintk(1, "vma start=0x%08lx, size=%ld, ret=%d\n",
         |         ^~~~~~~
   drivers/media/platform/nxp/fsl-viu.c:1320:62: error: invalid use of undefined type 'struct vm_area_struct'
    1320 |                 (unsigned long)vma->vm_end-(unsigned long)vma->vm_start,
         |                                                              ^~
   include/linux/printk.h:416:33: note: in definition of macro 'printk_index_wrap'
     416 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   drivers/media/platform/nxp/fsl-viu.c:53:25: note: in expansion of macro 'printk'
      53 |                         printk(KERN_DEBUG "viu: " fmt , ## arg);        \
         |                         ^~~~~~
   drivers/media/platform/nxp/fsl-viu.c:1318:9: note: in expansion of macro 'dprintk'
    1318 |         dprintk(1, "vma start=0x%08lx, size=%ld, ret=%d\n",
         |         ^~~~~~~
   cc1: some warnings being treated as errors
--
>> sound/soc/qcom/qdsp6/q6dsp-common.c:65:1: warning: data definition has no type or storage class
      65 | EXPORT_SYMBOL_GPL(q6dsp_map_channels);
         | ^~~~~~~~~~~~~~~~~
>> sound/soc/qcom/qdsp6/q6dsp-common.c:65:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
>> sound/soc/qcom/qdsp6/q6dsp-common.c:65:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors


vim +1319 drivers/media/platform/nxp/fsl-viu.c

95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1304  
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1305  static int viu_mmap(struct file *file, struct vm_area_struct *vma)
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1306  {
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1307  	struct viu_fh *fh = file->private_data;
87cb0278c9872a drivers/media/video/fsl-viu.c    Hans Verkuil          2012-06-23  1308  	struct viu_dev *dev = fh->dev;
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1309  	int ret;
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1310  
2d78a19c8c6c6d drivers/media/platform/fsl-viu.c Mauro Carvalho Chehab 2018-04-06  1311  	dprintk(1, "mmap called, vma=%p\n", vma);
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1312  
87cb0278c9872a drivers/media/video/fsl-viu.c    Hans Verkuil          2012-06-23  1313  	if (mutex_lock_interruptible(&dev->lock))
87cb0278c9872a drivers/media/video/fsl-viu.c    Hans Verkuil          2012-06-23  1314  		return -ERESTARTSYS;
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1315  	ret = videobuf_mmap_mapper(&fh->vb_vidq, vma);
87cb0278c9872a drivers/media/video/fsl-viu.c    Hans Verkuil          2012-06-23  1316  	mutex_unlock(&dev->lock);
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1317  
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1318  	dprintk(1, "vma start=0x%08lx, size=%ld, ret=%d\n",
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02 @1319  		(unsigned long)vma->vm_start,
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1320  		(unsigned long)vma->vm_end-(unsigned long)vma->vm_start,
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1321  		ret);
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1322  
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1323  	return ret;
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1324  }
95c5d605ca6fd6 drivers/media/video/fsl-viu.c    Anatolij Gustschin    2010-07-02  1325  

:::::: The code at line 1319 was first introduced by commit
:::::: 95c5d605ca6fd6ab5ab0f6d097ff97d5aa2f9235 V4L/DVB: v4l: Add MPC5121e VIU video capture driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
