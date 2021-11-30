Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D086463F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbhK3Uey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:34:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:48656 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235647AbhK3Uet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:34:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236541669"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="236541669"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="746855127"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2021 12:31:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms9mf-000Dje-Sq; Tue, 30 Nov 2021 20:31:25 +0000
Date:   Wed, 1 Dec 2021 04:31:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/gpu/drm/radeon/radeon_kms.c:672:7: warning: variable 'vm' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202112010420.xkXHciHS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211130-233655/Zhou-Qingyang/drm-radeon-radeon_kms-Fix-a-NULL-pointer-dereference-in-radeon_driver_open_kms/20211130-231509
head:   123fb3d217e89c4388fdb08b63991bac7c324219
commit: 123fb3d217e89c4388fdb08b63991bac7c324219 drm/radeon/radeon_kms: Fix a NULL pointer dereference in radeon_driver_open_kms()
date:   5 hours ago
config: mips-randconfig-r014-20211128 (https://download.01.org/0day-ci/archive/20211201/202112010420.xkXHciHS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/123fb3d217e89c4388fdb08b63991bac7c324219
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211130-233655/Zhou-Qingyang/drm-radeon-radeon_kms-Fix-a-NULL-pointer-dereference-in-radeon_driver_open_kms/20211130-231509
        git checkout 123fb3d217e89c4388fdb08b63991bac7c324219
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/radeon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/radeon/radeon_kms.c:672:7: warning: variable 'vm' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (rdev->accel_working) {
                       ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_kms.c:705:23: note: uninitialized use occurs here
           radeon_vm_fini(rdev, vm);
                                ^~
   drivers/gpu/drm/radeon/radeon_kms.c:672:3: note: remove the 'if' if its condition is always true
                   if (rdev->accel_working) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_kms.c:664:6: warning: variable 'vm' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (rdev->family >= CHIP_CAYMAN) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_kms.c:705:23: note: uninitialized use occurs here
           radeon_vm_fini(rdev, vm);
                                ^~
   drivers/gpu/drm/radeon/radeon_kms.c:664:2: note: remove the 'if' if its condition is always true
           if (rdev->family >= CHIP_CAYMAN) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_kms.c:653:22: note: initialize the variable 'vm' to silence this warning
           struct radeon_vm *vm;
                               ^
                                = NULL
   2 warnings generated.


vim +672 drivers/gpu/drm/radeon/radeon_kms.c

771fe6b912fca54 Jerome Glisse      2009-06-05  638  
f482a1419545ded Alex Deucher       2012-07-17  639  /**
f482a1419545ded Alex Deucher       2012-07-17  640   * radeon_driver_open_kms - drm callback for open
f482a1419545ded Alex Deucher       2012-07-17  641   *
f482a1419545ded Alex Deucher       2012-07-17  642   * @dev: drm dev pointer
f482a1419545ded Alex Deucher       2012-07-17  643   * @file_priv: drm file
f482a1419545ded Alex Deucher       2012-07-17  644   *
f482a1419545ded Alex Deucher       2012-07-17  645   * On device open, init vm on cayman+ (all asics).
f482a1419545ded Alex Deucher       2012-07-17  646   * Returns 0 on success, error on failure.
f482a1419545ded Alex Deucher       2012-07-17  647   */
771fe6b912fca54 Jerome Glisse      2009-06-05  648  int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
771fe6b912fca54 Jerome Glisse      2009-06-05  649  {
721604a15b934f0 Jerome Glisse      2012-01-05  650  	struct radeon_device *rdev = dev->dev_private;
10ebc0bc09344ab Dave Airlie        2012-09-17  651  	int r;
123fb3d217e89c4 Zhou Qingyang      2021-11-30  652  	struct radeon_fpriv *fpriv;
123fb3d217e89c4 Zhou Qingyang      2021-11-30  653  	struct radeon_vm *vm;
721604a15b934f0 Jerome Glisse      2012-01-05  654  
721604a15b934f0 Jerome Glisse      2012-01-05  655  	file_priv->driver_priv = NULL;
721604a15b934f0 Jerome Glisse      2012-01-05  656  
10ebc0bc09344ab Dave Airlie        2012-09-17  657  	r = pm_runtime_get_sync(dev->dev);
9fb10671011143d Aditya Pakki       2020-06-13  658  	if (r < 0) {
9fb10671011143d Aditya Pakki       2020-06-13  659  		pm_runtime_put_autosuspend(dev->dev);
10ebc0bc09344ab Dave Airlie        2012-09-17  660  		return r;
9fb10671011143d Aditya Pakki       2020-06-13  661  	}
10ebc0bc09344ab Dave Airlie        2012-09-17  662  
721604a15b934f0 Jerome Glisse      2012-01-05  663  	/* new gpu have virtual address space support */
721604a15b934f0 Jerome Glisse      2012-01-05  664  	if (rdev->family >= CHIP_CAYMAN) {
721604a15b934f0 Jerome Glisse      2012-01-05  665  
721604a15b934f0 Jerome Glisse      2012-01-05  666  		fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
721604a15b934f0 Jerome Glisse      2012-01-05  667  		if (unlikely(!fpriv)) {
32c59dc14b72803 Alex Deucher       2016-08-31  668  			r = -ENOMEM;
32c59dc14b72803 Alex Deucher       2016-08-31  669  			goto out_suspend;
721604a15b934f0 Jerome Glisse      2012-01-05  670  		}
721604a15b934f0 Jerome Glisse      2012-01-05  671  
544143f9e01a60a Alex Deucher       2015-01-28 @672  		if (rdev->accel_working) {
cc9e67e3d7000c1 Christian König    2014-07-18  673  			vm = &fpriv->vm;
cc9e67e3d7000c1 Christian König    2014-07-18  674  			r = radeon_vm_init(rdev, vm);
74073c9dd299056 Quentin Casasnovas 2014-03-18  675  			if (r) {
123fb3d217e89c4 Zhou Qingyang      2021-11-30  676  				goto out_fpriv;
74073c9dd299056 Quentin Casasnovas 2014-03-18  677  			}
d72d43cfc5847c1 Christian König    2012-10-09  678  
f1e3dc708aaadb9 Christian König    2014-02-20  679  			r = radeon_bo_reserve(rdev->ring_tmp_bo.bo, false);
74073c9dd299056 Quentin Casasnovas 2014-03-18  680  			if (r) {
123fb3d217e89c4 Zhou Qingyang      2021-11-30  681  				goto out_vm_fini;
74073c9dd299056 Quentin Casasnovas 2014-03-18  682  			}
f1e3dc708aaadb9 Christian König    2014-02-20  683  
d72d43cfc5847c1 Christian König    2012-10-09  684  			/* map the ib pool buffer read only into
d72d43cfc5847c1 Christian König    2012-10-09  685  			 * virtual address space */
cc9e67e3d7000c1 Christian König    2014-07-18  686  			vm->ib_bo_va = radeon_vm_bo_add(rdev, vm,
d72d43cfc5847c1 Christian König    2012-10-09  687  							rdev->ring_tmp_bo.bo);
123fb3d217e89c4 Zhou Qingyang      2021-11-30  688  			if (!vm->ib_bo_va) {
123fb3d217e89c4 Zhou Qingyang      2021-11-30  689  				r = -ENOMEM;
123fb3d217e89c4 Zhou Qingyang      2021-11-30  690  				goto out_vm_fini;
123fb3d217e89c4 Zhou Qingyang      2021-11-30  691  			}
123fb3d217e89c4 Zhou Qingyang      2021-11-30  692  
cc9e67e3d7000c1 Christian König    2014-07-18  693  			r = radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
cc9e67e3d7000c1 Christian König    2014-07-18  694  						  RADEON_VA_IB_OFFSET,
d72d43cfc5847c1 Christian König    2012-10-09  695  						  RADEON_VM_PAGE_READABLE |
d72d43cfc5847c1 Christian König    2012-10-09  696  						  RADEON_VM_PAGE_SNOOPED);
721604a15b934f0 Jerome Glisse      2012-01-05  697  			if (r) {
123fb3d217e89c4 Zhou Qingyang      2021-11-30  698  				goto out_vm_fini;
721604a15b934f0 Jerome Glisse      2012-01-05  699  			}
24f47acc78b0ab5 Jérôme Glisse      2014-05-07  700  		}
721604a15b934f0 Jerome Glisse      2012-01-05  701  		file_priv->driver_priv = fpriv;
721604a15b934f0 Jerome Glisse      2012-01-05  702  	}
10ebc0bc09344ab Dave Airlie        2012-09-17  703  
123fb3d217e89c4 Zhou Qingyang      2021-11-30  704  out_vm_fini:
123fb3d217e89c4 Zhou Qingyang      2021-11-30  705  	radeon_vm_fini(rdev, vm);
123fb3d217e89c4 Zhou Qingyang      2021-11-30  706  out_fpriv:
123fb3d217e89c4 Zhou Qingyang      2021-11-30  707  	kfree(fpriv);
32c59dc14b72803 Alex Deucher       2016-08-31  708  out_suspend:
10ebc0bc09344ab Dave Airlie        2012-09-17  709  	pm_runtime_mark_last_busy(dev->dev);
10ebc0bc09344ab Dave Airlie        2012-09-17  710  	pm_runtime_put_autosuspend(dev->dev);
32c59dc14b72803 Alex Deucher       2016-08-31  711  	return r;
771fe6b912fca54 Jerome Glisse      2009-06-05  712  }
771fe6b912fca54 Jerome Glisse      2009-06-05  713  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
