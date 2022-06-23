Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733CA557ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiFWPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFWPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:47:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08718393FE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655999220; x=1687535220;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rxITMK7izGB0alXb8idrXiJ48i1N6ntO4mnnFucTTUE=;
  b=M4IaGu4I9bREv4VvIIOl75KNncJYYfmDWYiXEiaa96RElFWRjq1Cs89K
   KKIhbwJ6O/Ip2RmYTiimO2qY0dtf3VG37z2saBRO2Gini5Df6ByhMTCZo
   u02T6JWJv/PjbeMlDMrfDT2ONoyhaz27o0iBOGvbNrzz8IKJKtuFVMvav
   RLEh8qFqzJQ3O9hTz7hDQI9j6Xjr1iarPTg3hHevivS5JYAtmTWeff3Pb
   4s/XukM1bfczB8WUc0H9nan1vQ/xzh3N5Vf7R+BS+F1f4B2BRQuucccm5
   5zt7uJcr9YaHigIWSyuttZwjdjLY5T3Vb7UWCMvlApvCiknlvSyBpgfei
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="367075782"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="367075782"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 08:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="678111752"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 08:46:49 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4P2e-0001Vt-OA;
        Thu, 23 Jun 2022 15:46:48 +0000
Date:   Thu, 23 Jun 2022 23:46:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_11 19/21] kernel/bpf/trampoline.c:81:31:
 sparse: sparse: non size-preserving pointer to integer cast
Message-ID: <202206232359.8QKWZqGN-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_11
head:   c807110aa605281263da02a78af57847f5c4275e
commit: a2660a85cc98b2db2577fd844985884cff0e5cae [19/21] bpf: Add support to store multiple ids in bpf_tramp_id object
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220623/202206232359.8QKWZqGN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=a2660a85cc98b2db2577fd844985884cff0e5cae
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_11
        git checkout a2660a85cc98b2db2577fd844985884cff0e5cae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/bpf/trampoline.c:16:31: sparse: sparse: symbol 'bpf_extension_verifier_ops' was not declared. Should it be static?
   kernel/bpf/trampoline.c:18:27: sparse: sparse: symbol 'bpf_extension_prog_ops' was not declared. Should it be static?
>> kernel/bpf/trampoline.c:81:31: sparse: sparse: non size-preserving pointer to integer cast

vim +81 kernel/bpf/trampoline.c

    77	
    78	static u64 bpf_tramp_id_key(struct bpf_tramp_id *id)
    79	{
    80		if (bpf_tramp_id_is_multi(id))
  > 81			return (u64) &id;
    82		else
    83			return ((u64) id->obj_id << 32) | id->id[0];
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
