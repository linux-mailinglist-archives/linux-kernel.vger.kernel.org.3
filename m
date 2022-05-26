Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4664534A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbiEZGm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbiEZGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:42:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43856596
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653547374; x=1685083374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rfBX3MJeO7FXdJXtV4ef/vKyw1sv1xmgt9pLbLFLblY=;
  b=CrWF6MGhemc1okZhA65Zd4u07sj+G+9sO7Zh0/1XBETL3HXcJus+O+ZI
   yDF561mZK1XXXlOWNYTe+N5DyYqXZe/w+8jCGeANRuRwfkGWrLyS88aMf
   UkQY5zxRBUL5CccX9UffEo9ZIjcU2/Qn4vVp1bzLcdF9PYCNoQXECwMM0
   e/BRjYiflKcSCej6T7g9ojfEAmgGoWCJe+BHUbzwIdsq4QDNXum3oztsm
   y8ITac8gG2hRNDvdqN1ifzQ5jf8KuII/t2t2A+vSEYpFI/diIBm0g1EhN
   UX4kSjDskuhdbG7av5QIh44oQGT6MtJFlEE/Ey09RJ/PJZcvor10ugymJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="274161874"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274161874"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 23:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="560054802"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 May 2022 23:42:53 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nu7Cu-0003fI-Ip;
        Thu, 26 May 2022 06:42:52 +0000
Date:   Thu, 26 May 2022 14:41:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Biggers <ebiggers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ebiggers:f2fs-pending 1/1] fs/f2fs/super.c:520:28: error: implicit
 declaration of function 'fscrypt_is_dummy_policy_set'; did you mean
 'fscrypt_free_dummy_policy'?
Message-ID: <202205261426.lSpXReh7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git f2fs-pending
head:   14c933f493ea41e28bbe5317af611dc01d66b489
commit: 14c933f493ea41e28bbe5317af611dc01d66b489 [1/1] f2fs: use the updated test_dummy_encryption helper functions
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220526/202205261426.lSpXReh7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=14c933f493ea41e28bbe5317af611dc01d66b489
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers f2fs-pending
        git checkout 14c933f493ea41e28bbe5317af611dc01d66b489
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/f2fs/super.c: In function 'f2fs_set_test_dummy_encryption':
>> fs/f2fs/super.c:520:28: error: implicit declaration of function 'fscrypt_is_dummy_policy_set'; did you mean 'fscrypt_free_dummy_policy'? [-Werror=implicit-function-declaration]
     520 |         if (is_remount && !fscrypt_is_dummy_policy_set(policy)) {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                            fscrypt_free_dummy_policy
>> fs/f2fs/super.c:525:15: error: implicit declaration of function 'fscrypt_parse_test_dummy_encryption'; did you mean 'fscrypt_set_test_dummy_encryption'? [-Werror=implicit-function-declaration]
     525 |         err = fscrypt_parse_test_dummy_encryption(&param, policy);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               fscrypt_set_test_dummy_encryption
>> fs/f2fs/super.c:538:15: error: implicit declaration of function 'fscrypt_add_test_dummy_key' [-Werror=implicit-function-declaration]
     538 |         err = fscrypt_add_test_dummy_key(sb, policy);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +520 fs/f2fs/super.c

   489	
   490	static int f2fs_set_test_dummy_encryption(struct super_block *sb,
   491						  const char *opt,
   492						  const substring_t *arg,
   493						  bool is_remount)
   494	{
   495		struct f2fs_sb_info *sbi = F2FS_SB(sb);
   496		struct fs_parameter param = {
   497			.type = fs_value_is_string,
   498			.string = arg->from ? arg->from : "",
   499		};
   500		struct fscrypt_dummy_policy *policy =
   501			&F2FS_OPTION(sbi).dummy_enc_policy;
   502		int err;
   503	
   504		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION)) {
   505			f2fs_warn(sbi, "test_dummy_encryption option not supported");
   506			return -EINVAL;
   507		}
   508	
   509		if (!f2fs_sb_has_encrypt(sbi)) {
   510			f2fs_err(sbi, "Encrypt feature is off");
   511			return -EINVAL;
   512		}
   513	
   514		/*
   515		 * This mount option is just for testing, and it's not worthwhile to
   516		 * implement the extra complexity (e.g. RCU protection) that would be
   517		 * needed to allow it to be set or changed during remount.  We do allow
   518		 * it to be specified during remount, but only if there is no change.
   519		 */
 > 520		if (is_remount && !fscrypt_is_dummy_policy_set(policy)) {
   521			f2fs_warn(sbi, "Can't set test_dummy_encryption on remount");
   522			return -EINVAL;
   523		}
   524	
 > 525		err = fscrypt_parse_test_dummy_encryption(&param, policy);
   526		if (err) {
   527			if (err == -EEXIST)
   528				f2fs_warn(sbi,
   529					  "Can't change test_dummy_encryption on remount");
   530			else if (err == -EINVAL)
   531				f2fs_warn(sbi, "Value of option \"%s\" is unrecognized",
   532					  opt);
   533			else
   534				f2fs_warn(sbi, "Error processing option \"%s\" [%d]",
   535					  opt, err);
   536			return -EINVAL;
   537		}
 > 538		err = fscrypt_add_test_dummy_key(sb, policy);
   539		if (err) {
   540			f2fs_warn(sbi, "Error adding test dummy encryption key [%d]",
   541				  err);
   542			return err;
   543		}
   544		f2fs_warn(sbi, "Test dummy encryption mode enabled");
   545		return 0;
   546	}
   547	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
