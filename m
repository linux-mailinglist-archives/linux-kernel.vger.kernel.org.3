Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619158EC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiHJM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiHJM4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:56:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFD60519
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660136210; x=1691672210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Y5z0ZDyydKnej9IdSZAQHbHgCINGNRafiCXrqPAudc=;
  b=V4IdcGPPAXGUjziOyoR2K6/LQy0UhX+V0ZaEWb2heDldXTWeYyxOtpnu
   j042FubKYmWeLW4fOsfGD0be92tL4fDGFBvxYDn5Ma8Trw4QBv0CSy612
   9uo7Ap0AoSaTJEcWCwmGWXaTyBamfiAdEtx320bWEb1TsE5i4DcSo3rdj
   6pWhd15dCMIxC4zx4WJoZFANIGlmSss1v46Wrk4ujZlZzTjL/545IvIGj
   qE3znCItPG3SwtQI8oTgJY1P1X5rKG3zWMD1cDGruOZ6Z3aq5z+fqc3hP
   gSLAkWkNArAMTK7PoXNFFULYh4Uu7F+qPzMz/Ogq92dBVUxTj8b6zA50v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="377364386"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="377364386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 05:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="581221963"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2022 05:56:48 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLlGS-0000HI-0O;
        Wed, 10 Aug 2022 12:56:48 +0000
Date:   Wed, 10 Aug 2022 20:56:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:accel 1/2] drivers/accelerators/accel_sysfs.c:66:5:
 warning: no previous prototype for 'accel_sysfs_init'
Message-ID: <202208102011.HntMqTCc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git accel
head:   7cd6e545486f8ead2f046747a9557f62e8bbfff3
commit: ddc47a3f6a4387c32ae88c644a65529533f28d96 [1/2] accel: initial commit
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220810/202208102011.HntMqTCc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=ddc47a3f6a4387c32ae88c644a65529533f28d96
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay accel
        git checkout ddc47a3f6a4387c32ae88c644a65529533f28d96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/accelerators/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/accelerators/accel_sysfs.c:66:5: warning: no previous prototype for 'accel_sysfs_init' [-Wmissing-prototypes]
      66 | int accel_sysfs_init(void)
         |     ^~~~~~~~~~~~~~~~
>> drivers/accelerators/accel_sysfs.c:91:6: warning: no previous prototype for 'accel_sysfs_destroy' [-Wmissing-prototypes]
      91 | void accel_sysfs_destroy(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/accelerators/accel_sysfs.c:105:16: warning: no previous prototype for 'accel_sysfs_minor_alloc' [-Wmissing-prototypes]
     105 | struct device *accel_sysfs_minor_alloc(struct accel_minor *minor)
         |                ^~~~~~~~~~~~~~~~~~~~~~~


vim +/accel_sysfs_init +66 drivers/accelerators/accel_sysfs.c

    55	
    56	/**
    57	 * accel_sysfs_init - initialize sysfs helpers
    58	 *
    59	 * This is used to create the ACCEL class, which is the implicit parent of any
    60	 * other top-level ACCEL sysfs objects.
    61	 *
    62	 * You must call accel_sysfs_destroy() to release the allocated resources.
    63	 *
    64	 * Return: 0 on success, negative error code on failure.
    65	 */
  > 66	int accel_sysfs_init(void)
    67	{
    68		int err;
    69	
    70		accel_class = class_create(THIS_MODULE, "accel");
    71		if (IS_ERR(accel_class))
    72			return PTR_ERR(accel_class);
    73	
    74		err = class_create_file(accel_class, &class_attr_version.attr);
    75		if (err) {
    76			class_destroy(accel_class);
    77			accel_class = NULL;
    78			return err;
    79		}
    80	
    81		accel_class->devnode = accel_devnode;
    82	
    83		return 0;
    84	}
    85	
    86	/**
    87	 * accel_sysfs_destroy - destroys ACCEL class
    88	 *
    89	 * Destroy the ACCEL device class.
    90	 */
  > 91	void accel_sysfs_destroy(void)
    92	{
    93		if (IS_ERR_OR_NULL(accel_class))
    94			return;
    95		class_remove_file(accel_class, &class_attr_version.attr);
    96		class_destroy(accel_class);
    97		accel_class = NULL;
    98	}
    99	
   100	static void accel_sysfs_release(struct device *dev)
   101	{
   102		kfree(dev);
   103	}
   104	
 > 105	struct device *accel_sysfs_minor_alloc(struct accel_minor *minor)
   106	{
   107		const char *minor_str;
   108		struct device *kdev;
   109		int r;
   110	
   111		if (minor->type == ACCEL_MINOR_CONTROL)
   112			minor_str = "ac_ControlD%d";
   113		else
   114			minor_str = "ac%d";
   115	
   116		kdev = kzalloc(sizeof(*kdev), GFP_KERNEL);
   117		if (!kdev)
   118			return ERR_PTR(-ENOMEM);
   119	
   120		device_initialize(kdev);
   121		kdev->devt = MKDEV(ACCEL_MAJOR, minor->index);
   122		kdev->class = accel_class;
   123		kdev->type = &accel_sysfs_device_minor;
   124		kdev->parent = minor->dev->dev;
   125		kdev->release = accel_sysfs_release;
   126		dev_set_drvdata(kdev, minor);
   127	
   128		r = dev_set_name(kdev, minor_str, minor->index);
   129		if (r < 0)
   130			goto err_free;
   131	
   132		return kdev;
   133	
   134	err_free:
   135		put_device(kdev);
   136		return ERR_PTR(r);
   137	}
   138	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
