Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DC5A04D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiHXXoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHXXn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:43:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB17F11F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661384636; x=1692920636;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5JSha+aKJzOjucXhnTBEdqAuhvfknuGNhuc9Esd3yIA=;
  b=bFx09EIzXc5rgP7cG//QbdNQOSEyjN4pxFaaQYgvNTLxR9vCVNqQrT3w
   BU0+zhH1cKDS4NwF0hrcSbeHHYHhTU5bC2uwyyAqWBJ2W9hVqDTNGhYbA
   YAOxiJJfc1AaU4wS37g5fxQPF9Xu0f/w3fxAuBD7+U/8YrR7DWErDIHv5
   GK+bXvWC2yeAg20IiosO17XlayrIc7JgiO5aL2SL0Sru7JPs/1YEduJFU
   Jupho2qO5ldOeWLCry0pTM1nJbRctpdFmRXdI/7kSPwdN2+kV8i9nG9BS
   t7T5XmHgJPMOVXb6eQp71WcS1afMxFgKRjK+ZRSUkjmXs981NYvu4TxCz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355828331"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="355828331"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="643041806"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Aug 2022 16:43:55 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR02M-0001Ov-1P;
        Wed, 24 Aug 2022 23:43:54 +0000
Date:   Thu, 25 Aug 2022 07:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/fscache-fixes 1/4]
 security/selinux/hooks.c:2772:45: warning: variable 'root_isec' set but not
 used
Message-ID: <202208250749.ugs8aIcf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/fscache-fixes
head:   900828ab172a767a0819d99718dcceb778be0d63
commit: de284e31dcfda8ae7b56eaef89efe60be34ecdf9 [1/4] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220825/202208250749.ugs8aIcf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/de284e31dcfda8ae7b56eaef89efe60be34ecdf9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/fscache-fixes
        git checkout de284e31dcfda8ae7b56eaef89efe60be34ecdf9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash security/selinux/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   security/selinux/hooks.c: In function 'selinux_fs_context_init':
>> security/selinux/hooks.c:2772:45: warning: variable 'root_isec' set but not used [-Wunused-but-set-variable]
    2772 |         const struct inode_security_struct *root_isec;
         |                                             ^~~~~~~~~


vim +/root_isec +2772 security/selinux/hooks.c

  2767	
  2768	static int selinux_fs_context_init(struct fs_context *fc,
  2769					   struct dentry *reference)
  2770	{
  2771		const struct superblock_security_struct *sbsec;
> 2772		const struct inode_security_struct *root_isec;
  2773		struct selinux_mnt_opts *opts;
  2774	
  2775		if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
  2776			opts = kzalloc(sizeof(*opts), GFP_KERNEL);
  2777			if (!opts)
  2778				return -ENOMEM;
  2779	
  2780			root_isec = backing_inode_security(reference->d_sb->s_root);
  2781			sbsec = selinux_superblock(reference->d_sb);
  2782			if (sbsec->flags & FSCONTEXT_MNT)
  2783				opts->fscontext_sid	= sbsec->sid;
  2784			if (sbsec->flags & CONTEXT_MNT)
  2785				opts->context_sid	= sbsec->mntpoint_sid;
  2786			if (sbsec->flags & DEFCONTEXT_MNT)
  2787				opts->defcontext_sid	= sbsec->def_sid;
  2788			fc->security = opts;
  2789		}
  2790	
  2791		return 0;
  2792	}
  2793	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
