Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF11489057
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbiAJGrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:47:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:21417 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239072AbiAJGrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641797236; x=1673333236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R6LmB55wgbGqHhK46ozA8x/JQtKBmVzkJUMPqDQA/lc=;
  b=aQpy1oHj9VduUeRLt4YrZt1xEiBurq5pI20H69di8quMTh1zKga+4qEH
   oyzhCyY5COAcAJMldKeey5HCWhjSMADhMnx0m41u+Av/MItBRitFFOAsM
   6t9VW6A2wdL7LrkvSN+q7jQMOLgxcr+Jar30ZuljUU6u+l4e+Bcpw4qOM
   26GRkEbfIpF2j7O2O9fIve829F2nR8hrSYyYmxL5qEGucc0aQZ2ozFZLj
   3Ca040WkKHCdPtU2qNeOZA0Rgw98d7MAxOSWCfc62NWQp1R1vONsPQNSx
   wcr6b3ZEVZujqU+6yAKoJXRu3+smqpt28AbKGh8VVItSG3KvxaGP8mtnp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="240714841"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="240714841"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 22:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="514567398"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2022 22:47:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6oSS-0002Kf-Rv; Mon, 10 Jan 2022 06:47:08 +0000
Date:   Mon, 10 Jan 2022 14:46:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [zanussi-trace:ftrace/cleanup-hist-func-v6 6/6]
 kernel/trace/trace_events_hist.c:5465:33: error: passing argument 2 of
 'data->ops->print' from incompatible pointer type
Message-ID: <202201101406.OGPbIpgd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v6
head:   256da8e5e9f9c780ad20f13893ac356b9265f8f9
commit: 256da8e5e9f9c780ad20f13893ac356b9265f8f9 [6/6] tracing: Remove redundant trigger_ops params
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220110/202201101406.OGPbIpgd-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git/commit/?id=256da8e5e9f9c780ad20f13893ac356b9265f8f9
        git remote add zanussi-trace https://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git
        git fetch --no-tags zanussi-trace ftrace/cleanup-hist-func-v6
        git checkout 256da8e5e9f9c780ad20f13893ac356b9265f8f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/trace_events_hist.c: In function 'hist_trigger_debug_show':
>> kernel/trace/trace_events_hist.c:5465:33: error: passing argument 2 of 'data->ops->print' from incompatible pointer type [-Werror=incompatible-pointer-types]
    5465 |         data->ops->print(m, data->ops, data);
         |                             ~~~~^~~~~
         |                                 |
         |                                 struct event_trigger_ops *
   kernel/trace/trace_events_hist.c:5465:33: note: expected 'struct event_trigger_data *' but argument is of type 'struct event_trigger_ops *'
>> kernel/trace/trace_events_hist.c:5465:9: error: too many arguments to function 'data->ops->print'
    5465 |         data->ops->print(m, data->ops, data);
         |         ^~~~
   cc1: some warnings being treated as errors


vim +5465 kernel/trace/trace_events_hist.c

2d19bd79ae6509 Tom Zanussi 2020-04-03  5454  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5455  static void hist_trigger_debug_show(struct seq_file *m,
2d19bd79ae6509 Tom Zanussi 2020-04-03  5456  				    struct event_trigger_data *data, int n)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5457  {
2d19bd79ae6509 Tom Zanussi 2020-04-03  5458  	struct hist_trigger_data *hist_data;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5459  	int i, ret;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5460  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5461  	if (n > 0)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5462  		seq_puts(m, "\n\n");
2d19bd79ae6509 Tom Zanussi 2020-04-03  5463  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5464  	seq_puts(m, "# event histogram\n#\n# trigger info: ");
2d19bd79ae6509 Tom Zanussi 2020-04-03 @5465  	data->ops->print(m, data->ops, data);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5466  	seq_puts(m, "#\n\n");
2d19bd79ae6509 Tom Zanussi 2020-04-03  5467  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5468  	hist_data = data->private_data;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5469  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5470  	seq_printf(m, "hist_data: %p\n\n", hist_data);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5471  	seq_printf(m, "  n_vals: %u\n", hist_data->n_vals);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5472  	seq_printf(m, "  n_keys: %u\n", hist_data->n_keys);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5473  	seq_printf(m, "  n_fields: %u\n", hist_data->n_fields);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5474  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5475  	seq_puts(m, "\n  val fields:\n\n");
2d19bd79ae6509 Tom Zanussi 2020-04-03  5476  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5477  	seq_puts(m, "    hist_data->fields[0]:\n");
2d19bd79ae6509 Tom Zanussi 2020-04-03  5478  	ret = hist_field_debug_show(m, hist_data->fields[0],
2d19bd79ae6509 Tom Zanussi 2020-04-03  5479  				    HIST_FIELD_FL_HITCOUNT);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5480  	if (ret)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5481  		return;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5482  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5483  	for (i = 1; i < hist_data->n_vals; i++) {
2d19bd79ae6509 Tom Zanussi 2020-04-03  5484  		seq_printf(m, "\n    hist_data->fields[%d]:\n", i);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5485  		ret = hist_field_debug_show(m, hist_data->fields[i], 0);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5486  		if (ret)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5487  			return;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5488  	}
2d19bd79ae6509 Tom Zanussi 2020-04-03  5489  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5490  	seq_puts(m, "\n  key fields:\n");
2d19bd79ae6509 Tom Zanussi 2020-04-03  5491  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5492  	for (i = hist_data->n_vals; i < hist_data->n_fields; i++) {
2d19bd79ae6509 Tom Zanussi 2020-04-03  5493  		seq_printf(m, "\n    hist_data->fields[%d]:\n", i);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5494  		ret = hist_field_debug_show(m, hist_data->fields[i],
2d19bd79ae6509 Tom Zanussi 2020-04-03  5495  					    HIST_FIELD_FL_KEY);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5496  		if (ret)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5497  			return;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5498  	}
2d19bd79ae6509 Tom Zanussi 2020-04-03  5499  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5500  	if (hist_data->n_var_refs)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5501  		seq_puts(m, "\n  variable reference fields:\n");
2d19bd79ae6509 Tom Zanussi 2020-04-03  5502  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5503  	for (i = 0; i < hist_data->n_var_refs; i++) {
2d19bd79ae6509 Tom Zanussi 2020-04-03  5504  		seq_printf(m, "\n    hist_data->var_refs[%d]:\n", i);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5505  		ret = hist_field_debug_show(m, hist_data->var_refs[i],
2d19bd79ae6509 Tom Zanussi 2020-04-03  5506  					    HIST_FIELD_FL_VAR_REF);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5507  		if (ret)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5508  			return;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5509  	}
2d19bd79ae6509 Tom Zanussi 2020-04-03  5510  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5511  	if (hist_data->n_field_vars)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5512  		seq_puts(m, "\n  field variables:\n");
2d19bd79ae6509 Tom Zanussi 2020-04-03  5513  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5514  	for (i = 0; i < hist_data->n_field_vars; i++) {
2d19bd79ae6509 Tom Zanussi 2020-04-03  5515  		ret = field_var_debug_show(m, hist_data->field_vars[i], i, false);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5516  		if (ret)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5517  			return;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5518  	}
2d19bd79ae6509 Tom Zanussi 2020-04-03  5519  
2d19bd79ae6509 Tom Zanussi 2020-04-03  5520  	ret = hist_actions_debug_show(m, hist_data);
2d19bd79ae6509 Tom Zanussi 2020-04-03  5521  	if (ret)
2d19bd79ae6509 Tom Zanussi 2020-04-03  5522  		return;
2d19bd79ae6509 Tom Zanussi 2020-04-03  5523  }
2d19bd79ae6509 Tom Zanussi 2020-04-03  5524  

:::::: The code at line 5465 was first introduced by commit
:::::: 2d19bd79ae6509858582a9cade739c2e9a4fdca8 tracing: Add hist_debug trace event files for histogram debugging

:::::: TO: Tom Zanussi <zanussi@kernel.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
