Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BF48885B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 09:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiAIIcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 03:32:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:49579 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbiAIIcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 03:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641717151; x=1673253151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8FXxiDM7PfIIkGMXLIsY6fZMmHSA2WtnfzWrXgDKfhg=;
  b=Npd3oDZ6Y9ELNHoTxIZOMOwW7nooNmzyqyNoyp+FaSut1sFjK3/Khj1o
   yb3ixd8OSi8RiOW8u7TPKHb4GSSBnUrOz3ox2piJ9Khg+0g5dXLD1hSBQ
   1+Q6ZffT3l6lOLl2/M7mwmm8gOLkMud8dUMiLda+1OYo0foJCQ9um7+Zb
   2BelhJfD/qcmO5nQPgyDr7dyA59FnvyF0fkz4glDiKNSnGVnQWwQ6qUPY
   BANLxKKZOkiAVmJhJTxSKpJkiGJoj+53I4mCo3WAy0dtAlbJZWPqzGoxT
   eOYLa3yKASQ4dpwGs0NM0PFkNBoczAZY2V/P/R4g7SELfZip7np2hodCJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="242868390"
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="242868390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 00:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="527905448"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2022 00:32:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6Tcq-0001TE-7W; Sun, 09 Jan 2022 08:32:28 +0000
Date:   Sun, 9 Jan 2022 16:32:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 24/32]
 kernel/trace/trace_events_trigger.c:1009:26: warning: variable 'trigger_ops'
 is uninitialized when used here
Message-ID: <202201091641.idUaU4Jg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/ftrace/core
head:   00a2223605e07cff7df94f5eb49ef5e281dada59
commit: 52f2994bd006dcc3ffb94fd3efa4494513b82646 [24/32] tracing: Have existing event_command.parse() implementations use helpers
config: arm-randconfig-r032-20220109 (https://download.01.org/0day-ci/archive/20220109/202201091641.idUaU4Jg-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/52f2994bd006dcc3ffb94fd3efa4494513b82646
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/ftrace/core
        git checkout 52f2994bd006dcc3ffb94fd3efa4494513b82646
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_events_trigger.c:1009:26: warning: variable 'trigger_ops' is uninitialized when used here [-Wuninitialized]
                   cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
                                          ^~~~~~~~~~~
   kernel/trace/trace_events_trigger.c:992:39: note: initialize the variable 'trigger_ops' to silence this warning
           struct event_trigger_ops *trigger_ops;
                                                ^
                                                 = NULL
   1 warning generated.
--
>> kernel/trace/trace_events_hist.c:6253:26: warning: variable 'trigger_ops' is uninitialized when used here [-Wuninitialized]
                   cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
                                          ^~~~~~~~~~~
   kernel/trace/trace_events_hist.c:6158:39: note: initialize the variable 'trigger_ops' to silence this warning
           struct event_trigger_ops *trigger_ops;
                                                ^
                                                 = NULL
   1 warning generated.


vim +/trigger_ops +1009 kernel/trace/trace_events_trigger.c

f5bcc5c959c0d4 Tom Zanussi              2021-12-14   965  
f5bcc5c959c0d4 Tom Zanussi              2021-12-14   966  /*
f5bcc5c959c0d4 Tom Zanussi              2021-12-14   967   * End event trigger parsing helper functions.
f5bcc5c959c0d4 Tom Zanussi              2021-12-14   968   */
f5bcc5c959c0d4 Tom Zanussi              2021-12-14   969  
2a2df321158817 Tom Zanussi              2013-10-24   970  /**
4dfe5dff80a4a8 Tom Zanussi              2021-12-14   971   * event_trigger_parse - Generic event_command @parse implementation
2a2df321158817 Tom Zanussi              2013-10-24   972   * @cmd_ops: The command ops, used for trigger registration
7f1d2f8210195c Steven Rostedt (Red Hat  2015-05-05   973)  * @file: The trace_event_file associated with the event
2a2df321158817 Tom Zanussi              2013-10-24   974   * @glob: The raw string used to register the trigger
2a2df321158817 Tom Zanussi              2013-10-24   975   * @cmd: The cmd portion of the string used to register the trigger
52f2994bd006dc Tom Zanussi              2021-12-14   976   * @param_and_filter: The param and filter portion of the string used to register the trigger
2a2df321158817 Tom Zanussi              2013-10-24   977   *
2a2df321158817 Tom Zanussi              2013-10-24   978   * Common implementation for event command parsing and trigger
2a2df321158817 Tom Zanussi              2013-10-24   979   * instantiation.
2a2df321158817 Tom Zanussi              2013-10-24   980   *
4dfe5dff80a4a8 Tom Zanussi              2021-12-14   981   * Usually used directly as the @parse method in event command
2a2df321158817 Tom Zanussi              2013-10-24   982   * implementations.
2a2df321158817 Tom Zanussi              2013-10-24   983   *
2a2df321158817 Tom Zanussi              2013-10-24   984   * Return: 0 on success, errno otherwise
2a2df321158817 Tom Zanussi              2013-10-24   985   */
2a2df321158817 Tom Zanussi              2013-10-24   986  static int
4dfe5dff80a4a8 Tom Zanussi              2021-12-14   987  event_trigger_parse(struct event_command *cmd_ops,
7f1d2f8210195c Steven Rostedt (Red Hat  2015-05-05   988) 		    struct trace_event_file *file,
52f2994bd006dc Tom Zanussi              2021-12-14   989  		    char *glob, char *cmd, char *param_and_filter)
2a2df321158817 Tom Zanussi              2013-10-24   990  {
2a2df321158817 Tom Zanussi              2013-10-24   991  	struct event_trigger_data *trigger_data;
2a2df321158817 Tom Zanussi              2013-10-24   992  	struct event_trigger_ops *trigger_ops;
52f2994bd006dc Tom Zanussi              2021-12-14   993  	char *param, *filter;
52f2994bd006dc Tom Zanussi              2021-12-14   994  	bool remove;
2a2df321158817 Tom Zanussi              2013-10-24   995  	int ret;
2a2df321158817 Tom Zanussi              2013-10-24   996  
52f2994bd006dc Tom Zanussi              2021-12-14   997  	remove = event_trigger_check_remove(glob);
2a2df321158817 Tom Zanussi              2013-10-24   998  
52f2994bd006dc Tom Zanussi              2021-12-14   999  	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, false);
52f2994bd006dc Tom Zanussi              2021-12-14  1000  	if (ret)
52f2994bd006dc Tom Zanussi              2021-12-14  1001  		return ret;
2a2df321158817 Tom Zanussi              2013-10-24  1002  
2a2df321158817 Tom Zanussi              2013-10-24  1003  	ret = -ENOMEM;
52f2994bd006dc Tom Zanussi              2021-12-14  1004  	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, file);
2a2df321158817 Tom Zanussi              2013-10-24  1005  	if (!trigger_data)
2a2df321158817 Tom Zanussi              2013-10-24  1006  		goto out;
2a2df321158817 Tom Zanussi              2013-10-24  1007  
52f2994bd006dc Tom Zanussi              2021-12-14  1008  	if (remove) {
2a2df321158817 Tom Zanussi              2013-10-24 @1009  		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
2a2df321158817 Tom Zanussi              2013-10-24  1010  		kfree(trigger_data);
2a2df321158817 Tom Zanussi              2013-10-24  1011  		ret = 0;
2a2df321158817 Tom Zanussi              2013-10-24  1012  		goto out;
2a2df321158817 Tom Zanussi              2013-10-24  1013  	}
2a2df321158817 Tom Zanussi              2013-10-24  1014  
52f2994bd006dc Tom Zanussi              2021-12-14  1015  	ret = event_trigger_parse_num(param, trigger_data);
2a2df321158817 Tom Zanussi              2013-10-24  1016  	if (ret)
2a2df321158817 Tom Zanussi              2013-10-24  1017  		goto out_free;
2a2df321158817 Tom Zanussi              2013-10-24  1018  
52f2994bd006dc Tom Zanussi              2021-12-14  1019  	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
2a2df321158817 Tom Zanussi              2013-10-24  1020  	if (ret < 0)
2a2df321158817 Tom Zanussi              2013-10-24  1021  		goto out_free;
2a2df321158817 Tom Zanussi              2013-10-24  1022  
1863c387259b62 Steven Rostedt (VMware   2018-07-24  1023) 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
1863c387259b62 Steven Rostedt (VMware   2018-07-24  1024) 	event_trigger_init(trigger_ops, trigger_data);
52f2994bd006dc Tom Zanussi              2021-12-14  1025  
52f2994bd006dc Tom Zanussi              2021-12-14  1026  	ret = event_trigger_register(cmd_ops, file, glob, cmd, param, trigger_data, NULL);
52f2994bd006dc Tom Zanussi              2021-12-14  1027  	if (ret)
52f2994bd006dc Tom Zanussi              2021-12-14  1028  		goto out_free;
1863c387259b62 Steven Rostedt (VMware   2018-07-24  1029) 
1863c387259b62 Steven Rostedt (VMware   2018-07-24  1030) 	/* Down the counter of trigger_data or free it if not used anymore */
1863c387259b62 Steven Rostedt (VMware   2018-07-24  1031) 	event_trigger_free(trigger_ops, trigger_data);
2a2df321158817 Tom Zanussi              2013-10-24  1032   out:
2a2df321158817 Tom Zanussi              2013-10-24  1033  	return ret;
2a2df321158817 Tom Zanussi              2013-10-24  1034   out_free:
52f2994bd006dc Tom Zanussi              2021-12-14  1035  	event_trigger_reset_filter(cmd_ops, trigger_data);
2a2df321158817 Tom Zanussi              2013-10-24  1036  	kfree(trigger_data);
2a2df321158817 Tom Zanussi              2013-10-24  1037  	goto out;
2a2df321158817 Tom Zanussi              2013-10-24  1038  }
2a2df321158817 Tom Zanussi              2013-10-24  1039  

:::::: The code at line 1009 was first introduced by commit
:::::: 2a2df321158817811c5dc206dce808e0aa9f6d89 tracing: Add 'traceon' and 'traceoff' event trigger commands

:::::: TO: Tom Zanussi <tom.zanussi@linux.intel.com>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
