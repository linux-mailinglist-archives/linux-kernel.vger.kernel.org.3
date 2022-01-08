Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4824884B7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiAHQwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:52:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:56791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbiAHQwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641660723; x=1673196723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eUJlnbyiL0brCmVkMgqdpHPCsfeEROen/LTYKPKlMrw=;
  b=gzaohknyPQx9d79kTr8Us+tz5XyqU3EKVh1eFp6z6Aha+ky/7J5g07YU
   pwa9mfsTvXjm41wI2p9HQU7Xa0CkbTHJHZ0UE3/MWUd4cE9ygr6smsHVm
   jICot4GImkOkGeECADs/gEY04uTssoYUifEHvfo0wpwh1WvaN316iLxIW
   p1iOeZ/RJj/a9zNvMHyyLX57t+4uI87Bu+0yJk0xc1STtw40Z43BF14sa
   Rqk6wcziNjBsloCtZFM/RpDyK3LSGkqmMRyAVB9S6KW1UngkSuts6Cif+
   1V1DjPH58zLyg18Fj9sf9ytds7mFUtXu/9QjAc7tw9WZbEwBNUfJGCWER
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230367223"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="230367223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 08:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473671877"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 08:52:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6Ewj-0000py-1l; Sat, 08 Jan 2022 16:52:01 +0000
Date:   Sun, 9 Jan 2022 00:51:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1674/2375] net/sunrpc/debugfs.c:153:1:
 warning: no previous prototype for function 'rpc_clnt_debugfs_register'
Message-ID: <202201090028.5dzQpVUn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: f32060e9ad90e9cdf7249e6aabfbb5a0bfc08ab7 [1674/2375] headers/deps: net/sunrpc: Optimize <linux/sunrpc/types.h>
config: x86_64-randconfig-a006-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090028.5dzQpVUn-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f32060e9ad90e9cdf7249e6aabfbb5a0bfc08ab7
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f32060e9ad90e9cdf7249e6aabfbb5a0bfc08ab7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/sunrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sunrpc/debugfs.c:153:1: warning: no previous prototype for function 'rpc_clnt_debugfs_register' [-Wmissing-prototypes]
   rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
   ^
   net/sunrpc/debugfs.c:152:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
>> net/sunrpc/debugfs.c:174:1: warning: no previous prototype for function 'rpc_clnt_debugfs_unregister' [-Wmissing-prototypes]
   rpc_clnt_debugfs_unregister(struct rpc_clnt *clnt)
   ^
   net/sunrpc/debugfs.c:173:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
>> net/sunrpc/debugfs.c:227:1: warning: no previous prototype for function 'rpc_xprt_debugfs_register' [-Wmissing-prototypes]
   rpc_xprt_debugfs_register(struct rpc_xprt *xprt)
   ^
   net/sunrpc/debugfs.c:226:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
>> net/sunrpc/debugfs.c:248:1: warning: no previous prototype for function 'rpc_xprt_debugfs_unregister' [-Wmissing-prototypes]
   rpc_xprt_debugfs_unregister(struct rpc_xprt *xprt)
   ^
   net/sunrpc/debugfs.c:247:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
>> net/sunrpc/debugfs.c:280:1: warning: no previous prototype for function 'sunrpc_debugfs_exit' [-Wmissing-prototypes]
   sunrpc_debugfs_exit(void)
   ^
   net/sunrpc/debugfs.c:279:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __exit
   ^
   static 
>> net/sunrpc/debugfs.c:289:1: warning: no previous prototype for function 'sunrpc_debugfs_init' [-Wmissing-prototypes]
   sunrpc_debugfs_init(void)
   ^
   net/sunrpc/debugfs.c:288:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init
   ^
   static 
   6 warnings generated.
--
>> net/sunrpc/sysctl.c:47:1: warning: no previous prototype for function 'rpc_register_sysctl' [-Wmissing-prototypes]
   rpc_register_sysctl(void)
   ^
   net/sunrpc/sysctl.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
>> net/sunrpc/sysctl.c:54:1: warning: no previous prototype for function 'rpc_unregister_sysctl' [-Wmissing-prototypes]
   rpc_unregister_sysctl(void)
   ^
   net/sunrpc/sysctl.c:53:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
   2 warnings generated.


vim +/rpc_clnt_debugfs_register +153 net/sunrpc/debugfs.c

2f34b8bfae19a2 NeilBrown          2019-05-30  151  
f9c72d10d6fbf9 Jeff Layton        2015-03-31  152  void
b4b9d2ccf0be61 Jeff Layton        2014-11-26 @153  rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
b4b9d2ccf0be61 Jeff Layton        2014-11-26  154  {
f9c72d10d6fbf9 Jeff Layton        2015-03-31  155  	int len;
2f34b8bfae19a2 NeilBrown          2019-05-30  156  	char name[9]; /* enough for 8 hex digits + NULL */
2f34b8bfae19a2 NeilBrown          2019-05-30  157  	int xprtnum = 0;
b4b9d2ccf0be61 Jeff Layton        2014-11-26  158  
b4b9d2ccf0be61 Jeff Layton        2014-11-26  159  	len = snprintf(name, sizeof(name), "%x", clnt->cl_clid);
b4b9d2ccf0be61 Jeff Layton        2014-11-26  160  	if (len >= sizeof(name))
f9c72d10d6fbf9 Jeff Layton        2015-03-31  161  		return;
b4b9d2ccf0be61 Jeff Layton        2014-11-26  162  
b4b9d2ccf0be61 Jeff Layton        2014-11-26  163  	/* make the per-client dir */
b4b9d2ccf0be61 Jeff Layton        2014-11-26  164  	clnt->cl_debugfs = debugfs_create_dir(name, rpc_clnt_dir);
b4b9d2ccf0be61 Jeff Layton        2014-11-26  165  
b4b9d2ccf0be61 Jeff Layton        2014-11-26  166  	/* make tasks file */
0a0762c6c604bb Greg Kroah-Hartman 2019-06-12  167  	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
0a0762c6c604bb Greg Kroah-Hartman 2019-06-12  168  			    &tasks_fops);
388f0c776781fe Jeff Layton        2014-11-26  169  
6860c981b96723 Linus Torvalds     2019-07-18  170  	rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum);
388f0c776781fe Jeff Layton        2014-11-26  171  }
388f0c776781fe Jeff Layton        2014-11-26  172  
388f0c776781fe Jeff Layton        2014-11-26  173  void
388f0c776781fe Jeff Layton        2014-11-26 @174  rpc_clnt_debugfs_unregister(struct rpc_clnt *clnt)
388f0c776781fe Jeff Layton        2014-11-26  175  {
b4b9d2ccf0be61 Jeff Layton        2014-11-26  176  	debugfs_remove_recursive(clnt->cl_debugfs);
b4b9d2ccf0be61 Jeff Layton        2014-11-26  177  	clnt->cl_debugfs = NULL;
388f0c776781fe Jeff Layton        2014-11-26  178  }
388f0c776781fe Jeff Layton        2014-11-26  179  
388f0c776781fe Jeff Layton        2014-11-26  180  static int
388f0c776781fe Jeff Layton        2014-11-26  181  xprt_info_show(struct seq_file *f, void *v)
388f0c776781fe Jeff Layton        2014-11-26  182  {
388f0c776781fe Jeff Layton        2014-11-26  183  	struct rpc_xprt *xprt = f->private;
388f0c776781fe Jeff Layton        2014-11-26  184  
388f0c776781fe Jeff Layton        2014-11-26  185  	seq_printf(f, "netid: %s\n", xprt->address_strings[RPC_DISPLAY_NETID]);
388f0c776781fe Jeff Layton        2014-11-26  186  	seq_printf(f, "addr:  %s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
388f0c776781fe Jeff Layton        2014-11-26  187  	seq_printf(f, "port:  %s\n", xprt->address_strings[RPC_DISPLAY_PORT]);
388f0c776781fe Jeff Layton        2014-11-26  188  	seq_printf(f, "state: 0x%lx\n", xprt->state);
388f0c776781fe Jeff Layton        2014-11-26  189  	return 0;
388f0c776781fe Jeff Layton        2014-11-26  190  }
388f0c776781fe Jeff Layton        2014-11-26  191  
388f0c776781fe Jeff Layton        2014-11-26  192  static int
388f0c776781fe Jeff Layton        2014-11-26  193  xprt_info_open(struct inode *inode, struct file *filp)
388f0c776781fe Jeff Layton        2014-11-26  194  {
388f0c776781fe Jeff Layton        2014-11-26  195  	int ret;
388f0c776781fe Jeff Layton        2014-11-26  196  	struct rpc_xprt *xprt = inode->i_private;
388f0c776781fe Jeff Layton        2014-11-26  197  
388f0c776781fe Jeff Layton        2014-11-26  198  	ret = single_open(filp, xprt_info_show, xprt);
388f0c776781fe Jeff Layton        2014-11-26  199  
388f0c776781fe Jeff Layton        2014-11-26  200  	if (!ret) {
388f0c776781fe Jeff Layton        2014-11-26  201  		if (!xprt_get(xprt)) {
388f0c776781fe Jeff Layton        2014-11-26  202  			single_release(inode, filp);
388f0c776781fe Jeff Layton        2014-11-26  203  			ret = -EINVAL;
388f0c776781fe Jeff Layton        2014-11-26  204  		}
388f0c776781fe Jeff Layton        2014-11-26  205  	}
388f0c776781fe Jeff Layton        2014-11-26  206  	return ret;
388f0c776781fe Jeff Layton        2014-11-26  207  }
388f0c776781fe Jeff Layton        2014-11-26  208  
388f0c776781fe Jeff Layton        2014-11-26  209  static int
388f0c776781fe Jeff Layton        2014-11-26  210  xprt_info_release(struct inode *inode, struct file *filp)
388f0c776781fe Jeff Layton        2014-11-26  211  {
388f0c776781fe Jeff Layton        2014-11-26  212  	struct rpc_xprt *xprt = inode->i_private;
388f0c776781fe Jeff Layton        2014-11-26  213  
388f0c776781fe Jeff Layton        2014-11-26  214  	xprt_put(xprt);
388f0c776781fe Jeff Layton        2014-11-26  215  	return single_release(inode, filp);
388f0c776781fe Jeff Layton        2014-11-26  216  }
388f0c776781fe Jeff Layton        2014-11-26  217  
388f0c776781fe Jeff Layton        2014-11-26  218  static const struct file_operations xprt_info_fops = {
388f0c776781fe Jeff Layton        2014-11-26  219  	.owner		= THIS_MODULE,
388f0c776781fe Jeff Layton        2014-11-26  220  	.open		= xprt_info_open,
388f0c776781fe Jeff Layton        2014-11-26  221  	.read		= seq_read,
388f0c776781fe Jeff Layton        2014-11-26  222  	.llseek		= seq_lseek,
388f0c776781fe Jeff Layton        2014-11-26  223  	.release	= xprt_info_release,
388f0c776781fe Jeff Layton        2014-11-26  224  };
388f0c776781fe Jeff Layton        2014-11-26  225  
f9c72d10d6fbf9 Jeff Layton        2015-03-31  226  void
388f0c776781fe Jeff Layton        2014-11-26 @227  rpc_xprt_debugfs_register(struct rpc_xprt *xprt)
388f0c776781fe Jeff Layton        2014-11-26  228  {
388f0c776781fe Jeff Layton        2014-11-26  229  	int len, id;
388f0c776781fe Jeff Layton        2014-11-26  230  	static atomic_t	cur_id;
388f0c776781fe Jeff Layton        2014-11-26  231  	char		name[9]; /* 8 hex digits + NULL term */
388f0c776781fe Jeff Layton        2014-11-26  232  
388f0c776781fe Jeff Layton        2014-11-26  233  	id = (unsigned int)atomic_inc_return(&cur_id);
388f0c776781fe Jeff Layton        2014-11-26  234  
388f0c776781fe Jeff Layton        2014-11-26  235  	len = snprintf(name, sizeof(name), "%x", id);
388f0c776781fe Jeff Layton        2014-11-26  236  	if (len >= sizeof(name))
f9c72d10d6fbf9 Jeff Layton        2015-03-31  237  		return;
388f0c776781fe Jeff Layton        2014-11-26  238  
388f0c776781fe Jeff Layton        2014-11-26  239  	/* make the per-client dir */
388f0c776781fe Jeff Layton        2014-11-26  240  	xprt->debugfs = debugfs_create_dir(name, rpc_xprt_dir);
388f0c776781fe Jeff Layton        2014-11-26  241  
388f0c776781fe Jeff Layton        2014-11-26  242  	/* make tasks file */
0a0762c6c604bb Greg Kroah-Hartman 2019-06-12  243  	debugfs_create_file("info", S_IFREG | 0400, xprt->debugfs, xprt,
0a0762c6c604bb Greg Kroah-Hartman 2019-06-12  244  			    &xprt_info_fops);
b4b9d2ccf0be61 Jeff Layton        2014-11-26  245  }
b4b9d2ccf0be61 Jeff Layton        2014-11-26  246  
b4b9d2ccf0be61 Jeff Layton        2014-11-26  247  void
388f0c776781fe Jeff Layton        2014-11-26 @248  rpc_xprt_debugfs_unregister(struct rpc_xprt *xprt)
b4b9d2ccf0be61 Jeff Layton        2014-11-26  249  {
388f0c776781fe Jeff Layton        2014-11-26  250  	debugfs_remove_recursive(xprt->debugfs);
388f0c776781fe Jeff Layton        2014-11-26  251  	xprt->debugfs = NULL;
b4b9d2ccf0be61 Jeff Layton        2014-11-26  252  }
b4b9d2ccf0be61 Jeff Layton        2014-11-26  253  
a4ae308143961b Chuck Lever        2021-08-05  254  #if IS_ENABLED(CONFIG_FAIL_SUNRPC)
a4ae308143961b Chuck Lever        2021-08-05  255  struct fail_sunrpc_attr fail_sunrpc = {
a4ae308143961b Chuck Lever        2021-08-05  256  	.attr			= FAULT_ATTR_INITIALIZER,
a4ae308143961b Chuck Lever        2021-08-05  257  };
a4ae308143961b Chuck Lever        2021-08-05  258  EXPORT_SYMBOL_GPL(fail_sunrpc);
4a06825839889c Chuck Lever        2015-05-11  259  
a4ae308143961b Chuck Lever        2021-08-05  260  static void fail_sunrpc_init(void)
4a06825839889c Chuck Lever        2015-05-11  261  {
a4ae308143961b Chuck Lever        2021-08-05  262  	struct dentry *dir;
4a06825839889c Chuck Lever        2015-05-11  263  
a4ae308143961b Chuck Lever        2021-08-05  264  	dir = fault_create_debugfs_attr("fail_sunrpc", NULL,
a4ae308143961b Chuck Lever        2021-08-05  265  					&fail_sunrpc.attr);
4a06825839889c Chuck Lever        2015-05-11  266  
a4ae308143961b Chuck Lever        2021-08-05  267  	debugfs_create_bool("ignore-client-disconnect", S_IFREG | 0600, dir,
a4ae308143961b Chuck Lever        2021-08-05  268  			    &fail_sunrpc.ignore_client_disconnect);
3a1261805940d0 Chuck Lever        2021-08-03  269  
3a1261805940d0 Chuck Lever        2021-08-03  270  	debugfs_create_bool("ignore-server-disconnect", S_IFREG | 0600, dir,
3a1261805940d0 Chuck Lever        2021-08-03  271  			    &fail_sunrpc.ignore_server_disconnect);
4a06825839889c Chuck Lever        2015-05-11  272  }
a4ae308143961b Chuck Lever        2021-08-05  273  #else
a4ae308143961b Chuck Lever        2021-08-05  274  static void fail_sunrpc_init(void)
4a06825839889c Chuck Lever        2015-05-11  275  {
4a06825839889c Chuck Lever        2015-05-11  276  }
c782af250083f6 Chuck Lever        2021-08-03  277  #endif
c782af250083f6 Chuck Lever        2021-08-03  278  
b4b9d2ccf0be61 Jeff Layton        2014-11-26  279  void __exit
b4b9d2ccf0be61 Jeff Layton        2014-11-26 @280  sunrpc_debugfs_exit(void)
b4b9d2ccf0be61 Jeff Layton        2014-11-26  281  {
b4b9d2ccf0be61 Jeff Layton        2014-11-26  282  	debugfs_remove_recursive(topdir);
f9c72d10d6fbf9 Jeff Layton        2015-03-31  283  	topdir = NULL;
f9c72d10d6fbf9 Jeff Layton        2015-03-31  284  	rpc_clnt_dir = NULL;
f9c72d10d6fbf9 Jeff Layton        2015-03-31  285  	rpc_xprt_dir = NULL;
b4b9d2ccf0be61 Jeff Layton        2014-11-26  286  }
b4b9d2ccf0be61 Jeff Layton        2014-11-26  287  
f9c72d10d6fbf9 Jeff Layton        2015-03-31  288  void __init
b4b9d2ccf0be61 Jeff Layton        2014-11-26 @289  sunrpc_debugfs_init(void)

:::::: The code at line 153 was first introduced by commit
:::::: b4b9d2ccf0be61c69213f6ae4e33377c05194ef4 sunrpc: add debugfs file for displaying client rpc_task queue

:::::: TO: Jeff Layton <jlayton@primarydata.com>
:::::: CC: Trond Myklebust <trond.myklebust@primarydata.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
