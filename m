Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A8C4E3988
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiCVHYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiCVHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:24:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C4104
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647933790; x=1679469790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iequToxxaQhdjkfVG1qjNqki5Rv90Ro3GMV7eguZDy4=;
  b=KlW0aUYJjcA69WxC/Sgq61jaRrBu04yffPHfG7oH0QNcsbtkUlQCufRd
   FPi8ibpNllHwcMlj/YnBLojowWIeNz3obXWnJakwvgmE708j9DCUfQNzQ
   ZlsfxHIc3knD6UoPRgcJiU+GFFbY8AfeX5uu+zI5XZKfxV5+45BvM6Snk
   ZCBMyb1faAdRZoDBJsj7dHs2prRwvsgkZLob6NrW1HT4iRwS/OEPQrdlg
   Z2Mv6lFAqIM5oFhQ9gTV1GWA9yAb5ML8uUn6XLiq/gN5mDCntTW8Tx0wG
   KQJ+m6Qew+eXYeOfRCR9Na5FgbMOHg3OtTpr34DwMqZ6v7YdLxj0P8m/D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="256568262"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="256568262"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 00:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="560249941"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2022 00:23:07 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWYrC-000IaP-S8; Tue, 22 Mar 2022 07:23:06 +0000
Date:   Tue, 22 Mar 2022 15:22:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [bpf-next:master 209/265] kernel/trace/fprobe.c:201:14: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-ID: <202203221549.JQIr40CT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
head:   f97b8b9bd630fb76c0e9e11cbf390e3d64a144d7
commit: 5b0ab78998e32564a011b14c4c7f9c81e2d42b9d [209/265] fprobe: Add exit_handler support
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220322/202203221549.JQIr40CT-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=5b0ab78998e32564a011b14c4c7f9c81e2d42b9d
        git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
        git fetch --no-tags bpf-next master
        git checkout 5b0ab78998e32564a011b14c4c7f9c81e2d42b9d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/ samples/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/trace/rethook.c:68:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/trace/rethook.c:68:9: sparse:    void ( [noderef] __rcu * )( ... )
>> kernel/trace/rethook.c:68:9: sparse:    void ( * )( ... )
--
>> kernel/trace/fprobe.c:201:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/fprobe.c:201:14: sparse:     expected struct ftrace_hash *hash
   kernel/trace/fprobe.c:201:14: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash

vim +201 kernel/trace/fprobe.c

   158	
   159	/**
   160	 * register_fprobe() - Register fprobe to ftrace by pattern.
   161	 * @fp: A fprobe data structure to be registered.
   162	 * @filter: A wildcard pattern of probed symbols.
   163	 * @notfilter: A wildcard pattern of NOT probed symbols.
   164	 *
   165	 * Register @fp to ftrace for enabling the probe on the symbols matched to @filter.
   166	 * If @notfilter is not NULL, the symbols matched the @notfilter are not probed.
   167	 *
   168	 * Return 0 if @fp is registered successfully, -errno if not.
   169	 */
   170	int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
   171	{
   172		struct ftrace_hash *hash;
   173		unsigned char *str;
   174		int ret, len;
   175	
   176		if (!fp || !filter)
   177			return -EINVAL;
   178	
   179		fprobe_init(fp);
   180	
   181		len = strlen(filter);
   182		str = kstrdup(filter, GFP_KERNEL);
   183		ret = ftrace_set_filter(&fp->ops, str, len, 0);
   184		kfree(str);
   185		if (ret)
   186			return ret;
   187	
   188		if (notfilter) {
   189			len = strlen(notfilter);
   190			str = kstrdup(notfilter, GFP_KERNEL);
   191			ret = ftrace_set_notrace(&fp->ops, str, len, 0);
   192			kfree(str);
   193			if (ret)
   194				goto out;
   195		}
   196	
   197		/* TODO:
   198		 * correctly calculate the total number of filtered symbols
   199		 * from both filter and notfilter.
   200		 */
 > 201		hash = fp->ops.local_hash.filter_hash;
   202		if (WARN_ON_ONCE(!hash))
   203			goto out;
   204	
   205		ret = fprobe_init_rethook(fp, (int)hash->count);
   206		if (!ret)
   207			ret = register_ftrace_function(&fp->ops);
   208	
   209	out:
   210		if (ret)
   211			fprobe_fail_cleanup(fp);
   212		return ret;
   213	}
   214	EXPORT_SYMBOL_GPL(register_fprobe);
   215	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
