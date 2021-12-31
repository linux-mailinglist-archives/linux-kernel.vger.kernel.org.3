Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0348258B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhLaSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 13:40:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:32447 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhLaSkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 13:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640976011; x=1672512011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i4uYOErvRuvFDVWYo1iht0NarJIwmWWFMe42e8U0gHY=;
  b=ZpHcChQCm3u5ZvCu8iyaFqDAwBpNXpAuncRg6/yi3K8fI50idgE5R/i1
   PQbzvuEbb1trPIUtqk3mvqIxz5agoUy8fPToYIMY38JjTeEX1HS4bRmUm
   i0+jO0s24KzVwtVs8O7zWTPML+QIw7wiqjxEueaZ7aD2uI5Wf8GTEQ018
   7m5VymHBVKa6jXOmRW9xbPtjtluXMxvRfxO6NUYX6Qyy4pI3e+tlEAfDt
   2+8sen0AA1giMmQwZQm2zUd+Qbnv/wbP3twa5CL/efvios0uJ9z9LRXii
   S3ELknPCg2dvfeuXTk24/E8sq9f0O1vH4yr9KBLxUD2ozE8jYQMrv6iK0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="228658846"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="228658846"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 10:40:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="687550961"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Dec 2021 10:40:09 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Moy-000Bal-OS; Fri, 31 Dec 2021 18:40:08 +0000
Date:   Sat, 1 Jan 2022 02:40:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [driver-core:debugfs_cleanup 5/5]
 drivers/base/firmware_loader/main.c:811:1: error: redefinition of
 'request_firmware'
Message-ID: <202201010250.AR5OyFBm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git debugfs_cleanup
head:   a04bbe0a2c7e98669e11a47f94e53dd8228bbeba
commit: a04bbe0a2c7e98669e11a47f94e53dd8228bbeba [5/5] firmware: remove old CONFIG_FW_LOADER_MODULE test
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220101/202201010250.AR5OyFBm-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=a04bbe0a2c7e98669e11a47f94e53dd8228bbeba
        git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
        git fetch --no-tags driver-core debugfs_cleanup
        git checkout a04bbe0a2c7e98669e11a47f94e53dd8228bbeba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/base/firmware_loader/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/firmware_loader/main.c:811:1: error: redefinition of 'request_firmware'
     811 | request_firmware(const struct firmware **firmware_p, const char *name,
         | ^~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:58:19: note: previous definition of 'request_firmware' with type 'int(const struct firmware **, const char *, struct device *)'
      58 | static inline int request_firmware(const struct firmware **fw,
         |                   ^~~~~~~~~~~~~~~~
>> drivers/base/firmware_loader/main.c:838:5: error: redefinition of 'firmware_request_nowarn'
     838 | int firmware_request_nowarn(const struct firmware **firmware, const char *name,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:65:19: note: previous definition of 'firmware_request_nowarn' with type 'int(const struct firmware **, const char *, struct device *)'
      65 | static inline int firmware_request_nowarn(const struct firmware **fw,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/firmware_loader/main.c:863:5: error: redefinition of 'request_firmware_direct'
     863 | int request_firmware_direct(const struct firmware **firmware_p,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:91:19: note: previous definition of 'request_firmware_direct' with type 'int(const struct firmware **, const char *, struct device *)'
      91 | static inline int request_firmware_direct(const struct firmware **fw,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/firmware_loader/main.c:887:5: error: redefinition of 'firmware_request_platform'
     887 | int firmware_request_platform(const struct firmware **firmware,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:72:19: note: previous definition of 'firmware_request_platform' with type 'int(const struct firmware **, const char *, struct device *)'
      72 | static inline int firmware_request_platform(const struct firmware **fw,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/firmware_loader/main.c:941:1: error: redefinition of 'request_firmware_into_buf'
     941 | request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:98:19: note: previous definition of 'request_firmware_into_buf' with type 'int(const struct firmware **, const char *, struct device *, void *, size_t)' {aka 'int(const struct firmware **, const char *, struct device *, void *, unsigned int)'}
      98 | static inline int request_firmware_into_buf(const struct firmware **firmware_p,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/firmware_loader/main.c:970:1: error: redefinition of 'request_partial_firmware_into_buf'
     970 | request_partial_firmware_into_buf(const struct firmware **firmware_p,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:104:19: note: previous definition of 'request_partial_firmware_into_buf' with type 'int(const struct firmware **, const char *, struct device *, void *, size_t,  size_t)' {aka 'int(const struct firmware **, const char *, struct device *, void *, unsigned int,  unsigned int)'}
     104 | static inline int request_partial_firmware_into_buf
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/firmware_loader/main.c:992:6: error: redefinition of 'release_firmware'
     992 | void release_firmware(const struct firmware *fw)
         |      ^~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:87:20: note: previous definition of 'release_firmware' with type 'void(const struct firmware *)'
      87 | static inline void release_firmware(const struct firmware *fw)
         |                    ^~~~~~~~~~~~~~~~
>> drivers/base/firmware_loader/main.c:1054:1: error: redefinition of 'request_firmware_nowait'
    1054 | request_firmware_nowait(
         | ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/main.c:26:
   include/linux/firmware.h:79:19: note: previous definition of 'request_firmware_nowait' with type 'int(struct module *, bool,  const char *, struct device *, gfp_t,  void *, void (*)(const struct firmware *, void *))' {aka 'int(struct module *, _Bool,  const char *, struct device *, unsigned int,  void *, void (*)(const struct firmware *, void *))'}
      79 | static inline int request_firmware_nowait(
         |                   ^~~~~~~~~~~~~~~~~~~~~~~


vim +/request_firmware +811 drivers/base/firmware_loader/main.c

4e0c92d015235d drivers/base/firmware_class.c       Takashi Iwai      2013-01-31   789  
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   790  /**
c35f9cbb1df8f1 drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   791   * request_firmware() - send firmware request and wait for it
eb8e317998e55d drivers/base/firmware_class.c       Randy Dunlap      2005-10-30   792   * @firmware_p: pointer to firmware image
eb8e317998e55d drivers/base/firmware_class.c       Randy Dunlap      2005-10-30   793   * @name: name of firmware file
eb8e317998e55d drivers/base/firmware_class.c       Randy Dunlap      2005-10-30   794   * @device: device for which firmware is being loaded
eb8e317998e55d drivers/base/firmware_class.c       Randy Dunlap      2005-10-30   795   *
eb8e317998e55d drivers/base/firmware_class.c       Randy Dunlap      2005-10-30   796   *      @firmware_p will be used to return a firmware image by the name
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   797   *      of @name for device @device.
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   798   *
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   799   *      Should be called from user context where sleeping is allowed.
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   800   *
312c004d36ce6c drivers/base/firmware_class.c       Kay Sievers       2005-11-16   801   *      @name will be used as $FIRMWARE in the uevent environment and
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   802   *      should be distinctive enough not to be confused with any other
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   803   *      firmware image for this or any other device.
0cfc1e1e7b5347 drivers/base/firmware_class.c       Ming Lei          2012-08-04   804   *
0cfc1e1e7b5347 drivers/base/firmware_class.c       Ming Lei          2012-08-04   805   *	Caller must hold the reference count of @device.
6a927857d89065 drivers/base/firmware_class.c       Ming Lei          2012-11-03   806   *
6a927857d89065 drivers/base/firmware_class.c       Ming Lei          2012-11-03   807   *	The function can be called safely inside device's suspend and
6a927857d89065 drivers/base/firmware_class.c       Ming Lei          2012-11-03   808   *	resume callback.
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   809   **/
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   810  int
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06  @811  request_firmware(const struct firmware **firmware_p, const char *name,
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   812  		 struct device *device)
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   813  {
d6c8aa3906d5d0 drivers/base/firmware_class.c       Ming Lei          2013-06-06   814  	int ret;
d6c8aa3906d5d0 drivers/base/firmware_class.c       Ming Lei          2013-06-06   815  
d6c8aa3906d5d0 drivers/base/firmware_class.c       Ming Lei          2013-06-06   816  	/* Need to pin this module until return */
d6c8aa3906d5d0 drivers/base/firmware_class.c       Ming Lei          2013-06-06   817  	__module_get(THIS_MODULE);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   818  	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
3f72271233943c drivers/base/firmware_class.c       Luis R. Rodriguez 2017-11-20   819  				FW_OPT_UEVENT);
d6c8aa3906d5d0 drivers/base/firmware_class.c       Ming Lei          2013-06-06   820  	module_put(THIS_MODULE);
d6c8aa3906d5d0 drivers/base/firmware_class.c       Ming Lei          2013-06-06   821  	return ret;
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   822  }
f494513ff1b3f6 drivers/base/firmware_class.c       Daniel Mack       2013-05-23   823  EXPORT_SYMBOL(request_firmware);
6e3eaab02028c4 drivers/base/firmware_class.c       Abhay Salunke     2005-09-06   824  
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   825  /**
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   826   * firmware_request_nowarn() - request for an optional fw module
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   827   * @firmware: pointer to firmware image
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   828   * @name: name of firmware file
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   829   * @device: device for which firmware is being loaded
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   830   *
2fce60be06ca68 drivers/base/firmware_loader/main.c Wolfram Sang      2020-07-03   831   * This function is similar in behaviour to request_firmware(), except it
2fce60be06ca68 drivers/base/firmware_loader/main.c Wolfram Sang      2020-07-03   832   * doesn't produce warning messages when the file is not found. The sysfs
2fce60be06ca68 drivers/base/firmware_loader/main.c Wolfram Sang      2020-07-03   833   * fallback mechanism is enabled if direct filesystem lookup fails. However,
2fce60be06ca68 drivers/base/firmware_loader/main.c Wolfram Sang      2020-07-03   834   * failures to find the firmware file with it are still suppressed. It is
2fce60be06ca68 drivers/base/firmware_loader/main.c Wolfram Sang      2020-07-03   835   * therefore up to the driver to check for the return value of this call and to
2fce60be06ca68 drivers/base/firmware_loader/main.c Wolfram Sang      2020-07-03   836   * decide when to inform the users of errors.
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   837   **/
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10  @838  int firmware_request_nowarn(const struct firmware **firmware, const char *name,
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   839  			    struct device *device)
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   840  {
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   841  	int ret;
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   842  
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   843  	/* Need to pin this module until return */
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   844  	__module_get(THIS_MODULE);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   845  	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   846  				FW_OPT_UEVENT | FW_OPT_NO_WARN);
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   847  	module_put(THIS_MODULE);
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   848  	return ret;
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   849  }
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   850  EXPORT_SYMBOL_GPL(firmware_request_nowarn);
7dcc01343e483e drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   851  
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   852  /**
c35f9cbb1df8f1 drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   853   * request_firmware_direct() - load firmware directly without usermode helper
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   854   * @firmware_p: pointer to firmware image
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   855   * @name: name of firmware file
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   856   * @device: device for which firmware is being loaded
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   857   *
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   858   * This function works pretty much like request_firmware(), but this doesn't
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   859   * fall back to usermode helper even if the firmware couldn't be loaded
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   860   * directly from fs.  Hence it's useful for loading optional firmwares, which
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   861   * aren't always present, without extra long timeouts of udev.
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   862   **/
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02  @863  int request_firmware_direct(const struct firmware **firmware_p,
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   864  			    const char *name, struct device *device)
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   865  {
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   866  	int ret;
ea31003ccb2d68 drivers/base/firmware_class.c       Andrei Oprea      2015-03-08   867  
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   868  	__module_get(THIS_MODULE);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   869  	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
3f72271233943c drivers/base/firmware_class.c       Luis R. Rodriguez 2017-11-20   870  				FW_OPT_UEVENT | FW_OPT_NO_WARN |
85db1cde825344 drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   871  				FW_OPT_NOFALLBACK_SYSFS);
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   872  	module_put(THIS_MODULE);
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   873  	return ret;
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   874  }
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   875  EXPORT_SYMBOL_GPL(request_firmware_direct);
bba3a87e982ad5 drivers/base/firmware_class.c       Takashi Iwai      2013-12-02   876  
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   877  /**
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   878   * firmware_request_platform() - request firmware with platform-fw fallback
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   879   * @firmware: pointer to firmware image
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   880   * @name: name of firmware file
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   881   * @device: device for which firmware is being loaded
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   882   *
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   883   * This function is similar in behaviour to request_firmware, except that if
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   884   * direct filesystem lookup fails, it will fallback to looking for a copy of the
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   885   * requested firmware embedded in the platform's main (e.g. UEFI) firmware.
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   886   **/
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15  @887  int firmware_request_platform(const struct firmware **firmware,
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   888  			      const char *name, struct device *device)
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   889  {
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   890  	int ret;
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   891  
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   892  	/* Need to pin this module until return */
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   893  	__module_get(THIS_MODULE);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   894  	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   895  				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   896  	module_put(THIS_MODULE);
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   897  	return ret;
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   898  }
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   899  EXPORT_SYMBOL_GPL(firmware_request_platform);
e4c2c0ff00ecaf drivers/base/firmware_loader/main.c Hans de Goede     2020-01-15   900  
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   901  /**
c35f9cbb1df8f1 drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   902   * firmware_request_cache() - cache firmware for suspend so resume can use it
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   903   * @name: name of firmware file
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   904   * @device: device for which firmware should be cached for
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   905   *
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   906   * There are some devices with an optimization that enables the device to not
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   907   * require loading firmware on system reboot. This optimization may still
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   908   * require the firmware present on resume from suspend. This routine can be
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   909   * used to ensure the firmware is present on resume from suspend in these
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   910   * situations. This helper is not compatible with drivers which use
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   911   * request_firmware_into_buf() or request_firmware_nowait() with no uevent set.
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   912   **/
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   913  int firmware_request_cache(struct device *device, const char *name)
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   914  {
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   915  	int ret;
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   916  
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   917  	mutex_lock(&fw_lock);
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   918  	ret = fw_add_devm_name(device, name);
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   919  	mutex_unlock(&fw_lock);
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   920  
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   921  	return ret;
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   922  }
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   923  EXPORT_SYMBOL_GPL(firmware_request_cache);
5d42c96e1cf98b drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-21   924  
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   925  /**
c35f9cbb1df8f1 drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   926   * request_firmware_into_buf() - load firmware into a previously allocated buffer
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   927   * @firmware_p: pointer to firmware image
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   928   * @name: name of firmware file
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   929   * @device: device for which firmware is being loaded and DMA region allocated
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   930   * @buf: address of buffer to load firmware into
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   931   * @size: size of buffer
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   932   *
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   933   * This function works pretty much like request_firmware(), but it doesn't
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   934   * allocate a buffer to hold the firmware data. Instead, the firmware
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   935   * is loaded directly into the buffer pointed to by @buf and the @firmware_p
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   936   * data member is pointed at @buf.
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   937   *
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   938   * This function doesn't cache firmware either.
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   939   */
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   940  int
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02  @941  request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   942  			  struct device *device, void *buf, size_t size)
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   943  {
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   944  	int ret;
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   945  
995e8695f65db7 drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-10   946  	if (fw_cache_is_setup(device, name))
995e8695f65db7 drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-10   947  		return -EOPNOTSUPP;
995e8695f65db7 drivers/base/firmware_loader/main.c Luis R. Rodriguez 2018-03-10   948  
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   949  	__module_get(THIS_MODULE);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   950  	ret = _request_firmware(firmware_p, name, device, buf, size, 0,
3f72271233943c drivers/base/firmware_class.c       Luis R. Rodriguez 2017-11-20   951  				FW_OPT_UEVENT | FW_OPT_NOCACHE);
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   952  	module_put(THIS_MODULE);
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   953  	return ret;
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   954  }
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   955  EXPORT_SYMBOL(request_firmware_into_buf);
a098ecd2fa7db8 drivers/base/firmware_class.c       Stephen Boyd      2016-08-02   956  
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   957  /**
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   958   * request_partial_firmware_into_buf() - load partial firmware into a previously allocated buffer
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   959   * @firmware_p: pointer to firmware image
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   960   * @name: name of firmware file
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   961   * @device: device for which firmware is being loaded and DMA region allocated
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   962   * @buf: address of buffer to load firmware into
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   963   * @size: size of buffer
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   964   * @offset: offset into file to read
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   965   *
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   966   * This function works pretty much like request_firmware_into_buf except
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   967   * it allows a partial read of the file.
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   968   */
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   969  int
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02  @970  request_partial_firmware_into_buf(const struct firmware **firmware_p,
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   971  				  const char *name, struct device *device,
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   972  				  void *buf, size_t size, size_t offset)
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   973  {
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   974  	int ret;
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   975  
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   976  	if (fw_cache_is_setup(device, name))
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   977  		return -EOPNOTSUPP;
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   978  
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   979  	__module_get(THIS_MODULE);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   980  	ret = _request_firmware(firmware_p, name, device, buf, size, offset,
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   981  				FW_OPT_UEVENT | FW_OPT_NOCACHE |
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   982  				FW_OPT_PARTIAL);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   983  	module_put(THIS_MODULE);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   984  	return ret;
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   985  }
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   986  EXPORT_SYMBOL(request_partial_firmware_into_buf);
59cdb23ca2dfef drivers/base/firmware_loader/main.c Scott Branden     2020-10-02   987  
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16   988  /**
c35f9cbb1df8f1 drivers/base/firmware_loader/main.c Andres Rodriguez  2018-05-10   989   * release_firmware() - release the resource associated with a firmware image
eb8e317998e55d drivers/base/firmware_class.c       Randy Dunlap      2005-10-30   990   * @fw: firmware resource to release
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16   991   **/
bcb9bd18e397ea drivers/base/firmware_class.c       Dmitry Torokhov   2010-03-13  @992  void release_firmware(const struct firmware *fw)
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16   993  {
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16   994  	if (fw) {
48d09e97876bed drivers/base/firmware_loader/main.c Luis Chamberlain  2021-10-21   995  		if (!firmware_is_builtin(fw))
dd336c554d8926 drivers/base/firmware_class.c       David Woodhouse   2010-05-02   996  			firmware_free_data(fw);
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16   997  		kfree(fw);
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16   998  	}
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16   999  }
f494513ff1b3f6 drivers/base/firmware_class.c       Daniel Mack       2013-05-23  1000  EXPORT_SYMBOL(release_firmware);
^1da177e4c3f41 drivers/base/firmware_class.c       Linus Torvalds    2005-04-16  1001  

:::::: The code at line 811 was first introduced by commit
:::::: 6e3eaab02028c4087a92711b20abb9e72cc803a7 [PATCH] modified firmware_class.c to support no hotplug

:::::: TO: Abhay Salunke <Abhay_Salunke@dell.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
