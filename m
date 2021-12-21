Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0313047BB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhLUHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:30:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:33391 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhLUHau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640071849; x=1671607849;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aNw7wUyzOfaI6OGIJaF2V/APfPsypmdT13AL78dm+AI=;
  b=CsPsU/ahjUlhV0tGKqSXf07IJyOU6tqJw2jRei6I7VuQXPpMB32cQmdK
   MBV+/7wC8yyHkQs7KKWmu9bHu3fOWuBkWjA75C8hLo11Pl0iRCVzSxEys
   lqBUyfeukHyNMIWE/NKCe4tav2FU23z0/l26OZQww0bsDuW/LMOD+b5+h
   BsXXhjljuQh2f38ZQWjlk6lTStwk6gllsTN2T1UD4mOUxTGzDMb19UgZq
   WoioQ2x4fTo6907e9FxNRJhiZzKAXlBWwKj+pEk4TWtWSkojZ62H0BFX3
   Q0jz+2p2vL4FdzEvcP+V2bzyzGOzZqOr15ejUWIZWKV8pnLDjGknl5pm0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="239089803"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="239089803"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="613376880"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 20 Dec 2021 23:30:48 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzZbj-0008p6-Ps; Tue, 21 Dec 2021 07:30:47 +0000
Date:   Tue, 21 Dec 2021 15:30:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Rui <ray.huang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rui:amd-pstate-dev-v6 6/14] drivers/acpi/cppc_acpi.c:835: undefined
 reference to `init_freq_invariance_cppc'
Message-ID: <202112211548.IPdIhNzu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git amd-pstate-dev-v6
head:   866b93666b8eda290cd2ba77dc62032d12cbe658
commit: 3b66518485fd57f60b2f9fce4e291529558547c5 [6/14] cpufreq: amd-pstate: introduce a new AMD P-State driver to support future processors
config: x86_64-randconfig-p001-20211220 (https://download.01.org/0day-ci/archive/20211221/202112211548.IPdIhNzu-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/commit/?id=3b66518485fd57f60b2f9fce4e291529558547c5
        git remote add rui https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git
        git fetch --no-tags rui amd-pstate-dev-v6
        git checkout 3b66518485fd57f60b2f9fce4e291529558547c5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: kvm_spurious_fault()+0x19: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive()+0x29: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __rdgsbase_inactive()+0x26: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret()+0x84: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug()+0x4c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi()+0xaa: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler()+0x3e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter()+0x45: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit()+0x3c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x38: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x38: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x38: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit()+0x2b: call to ftrace_likely_update() leaves .noinstr.text section
   ld: drivers/acpi/cppc_acpi.o: in function `acpi_cppc_processor_probe':
>> drivers/acpi/cppc_acpi.c:835: undefined reference to `init_freq_invariance_cppc'


vim +835 drivers/acpi/cppc_acpi.c

41ea667227bad5c Nathan Fontenot     2020-11-12  655  
337aadff8e4567e Ashwin Chaugule     2015-10-02  656  /**
337aadff8e4567e Ashwin Chaugule     2015-10-02  657   * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
603fadf33604a2e Bjorn Helgaas       2019-03-25  658   * @pr: Ptr to acpi_processor containing this CPU's logical ID.
337aadff8e4567e Ashwin Chaugule     2015-10-02  659   *
337aadff8e4567e Ashwin Chaugule     2015-10-02  660   *	Return: 0 for success or negative value for err.
337aadff8e4567e Ashwin Chaugule     2015-10-02  661   */
337aadff8e4567e Ashwin Chaugule     2015-10-02  662  int acpi_cppc_processor_probe(struct acpi_processor *pr)
337aadff8e4567e Ashwin Chaugule     2015-10-02  663  {
337aadff8e4567e Ashwin Chaugule     2015-10-02  664  	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
337aadff8e4567e Ashwin Chaugule     2015-10-02  665  	union acpi_object *out_obj, *cpc_obj;
337aadff8e4567e Ashwin Chaugule     2015-10-02  666  	struct cpc_desc *cpc_ptr;
337aadff8e4567e Ashwin Chaugule     2015-10-02  667  	struct cpc_reg *gas_t;
158c998ea44ba30 Ashwin Chaugule     2016-08-16  668  	struct device *cpu_dev;
337aadff8e4567e Ashwin Chaugule     2015-10-02  669  	acpi_handle handle = pr->handle;
337aadff8e4567e Ashwin Chaugule     2015-10-02  670  	unsigned int num_ent, i, cpc_rev;
85b1407bf6d2f4a George Cherian      2017-10-11  671  	int pcc_subspace_id = -1;
337aadff8e4567e Ashwin Chaugule     2015-10-02  672  	acpi_status status;
337aadff8e4567e Ashwin Chaugule     2015-10-02  673  	int ret = -EFAULT;
337aadff8e4567e Ashwin Chaugule     2015-10-02  674  
603fadf33604a2e Bjorn Helgaas       2019-03-25  675  	/* Parse the ACPI _CPC table for this CPU. */
337aadff8e4567e Ashwin Chaugule     2015-10-02  676  	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
337aadff8e4567e Ashwin Chaugule     2015-10-02  677  			ACPI_TYPE_PACKAGE);
337aadff8e4567e Ashwin Chaugule     2015-10-02  678  	if (ACPI_FAILURE(status)) {
337aadff8e4567e Ashwin Chaugule     2015-10-02  679  		ret = -ENODEV;
337aadff8e4567e Ashwin Chaugule     2015-10-02  680  		goto out_buf_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  681  	}
337aadff8e4567e Ashwin Chaugule     2015-10-02  682  
337aadff8e4567e Ashwin Chaugule     2015-10-02  683  	out_obj = (union acpi_object *) output.pointer;
337aadff8e4567e Ashwin Chaugule     2015-10-02  684  
337aadff8e4567e Ashwin Chaugule     2015-10-02  685  	cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
337aadff8e4567e Ashwin Chaugule     2015-10-02  686  	if (!cpc_ptr) {
337aadff8e4567e Ashwin Chaugule     2015-10-02  687  		ret = -ENOMEM;
337aadff8e4567e Ashwin Chaugule     2015-10-02  688  		goto out_buf_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  689  	}
337aadff8e4567e Ashwin Chaugule     2015-10-02  690  
337aadff8e4567e Ashwin Chaugule     2015-10-02  691  	/* First entry is NumEntries. */
337aadff8e4567e Ashwin Chaugule     2015-10-02  692  	cpc_obj = &out_obj->package.elements[0];
337aadff8e4567e Ashwin Chaugule     2015-10-02  693  	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
337aadff8e4567e Ashwin Chaugule     2015-10-02  694  		num_ent = cpc_obj->integer.value;
337aadff8e4567e Ashwin Chaugule     2015-10-02  695  	} else {
337aadff8e4567e Ashwin Chaugule     2015-10-02  696  		pr_debug("Unexpected entry type(%d) for NumEntries\n",
337aadff8e4567e Ashwin Chaugule     2015-10-02  697  				cpc_obj->type);
337aadff8e4567e Ashwin Chaugule     2015-10-02  698  		goto out_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  699  	}
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  700  	cpc_ptr->num_entries = num_ent;
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  701  
337aadff8e4567e Ashwin Chaugule     2015-10-02  702  	/* Second entry should be revision. */
337aadff8e4567e Ashwin Chaugule     2015-10-02  703  	cpc_obj = &out_obj->package.elements[1];
337aadff8e4567e Ashwin Chaugule     2015-10-02  704  	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
337aadff8e4567e Ashwin Chaugule     2015-10-02  705  		cpc_rev = cpc_obj->integer.value;
337aadff8e4567e Ashwin Chaugule     2015-10-02  706  	} else {
337aadff8e4567e Ashwin Chaugule     2015-10-02  707  		pr_debug("Unexpected entry type(%d) for Revision\n",
337aadff8e4567e Ashwin Chaugule     2015-10-02  708  				cpc_obj->type);
337aadff8e4567e Ashwin Chaugule     2015-10-02  709  		goto out_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  710  	}
4773e77cdc9b3af Prashanth Prakash   2018-04-04  711  	cpc_ptr->version = cpc_rev;
337aadff8e4567e Ashwin Chaugule     2015-10-02  712  
4773e77cdc9b3af Prashanth Prakash   2018-04-04  713  	if (!is_cppc_supported(cpc_rev, num_ent))
337aadff8e4567e Ashwin Chaugule     2015-10-02  714  		goto out_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  715  
337aadff8e4567e Ashwin Chaugule     2015-10-02  716  	/* Iterate through remaining entries in _CPC */
337aadff8e4567e Ashwin Chaugule     2015-10-02  717  	for (i = 2; i < num_ent; i++) {
337aadff8e4567e Ashwin Chaugule     2015-10-02  718  		cpc_obj = &out_obj->package.elements[i];
337aadff8e4567e Ashwin Chaugule     2015-10-02  719  
337aadff8e4567e Ashwin Chaugule     2015-10-02  720  		if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
337aadff8e4567e Ashwin Chaugule     2015-10-02  721  			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
337aadff8e4567e Ashwin Chaugule     2015-10-02  722  			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = cpc_obj->integer.value;
337aadff8e4567e Ashwin Chaugule     2015-10-02  723  		} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
337aadff8e4567e Ashwin Chaugule     2015-10-02  724  			gas_t = (struct cpc_reg *)
337aadff8e4567e Ashwin Chaugule     2015-10-02  725  				cpc_obj->buffer.pointer;
337aadff8e4567e Ashwin Chaugule     2015-10-02  726  
337aadff8e4567e Ashwin Chaugule     2015-10-02  727  			/*
337aadff8e4567e Ashwin Chaugule     2015-10-02  728  			 * The PCC Subspace index is encoded inside
337aadff8e4567e Ashwin Chaugule     2015-10-02  729  			 * the CPC table entries. The same PCC index
337aadff8e4567e Ashwin Chaugule     2015-10-02  730  			 * will be used for all the PCC entries,
337aadff8e4567e Ashwin Chaugule     2015-10-02  731  			 * so extract it only once.
337aadff8e4567e Ashwin Chaugule     2015-10-02  732  			 */
337aadff8e4567e Ashwin Chaugule     2015-10-02  733  			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
85b1407bf6d2f4a George Cherian      2017-10-11  734  				if (pcc_subspace_id < 0) {
85b1407bf6d2f4a George Cherian      2017-10-11  735  					pcc_subspace_id = gas_t->access_width;
85b1407bf6d2f4a George Cherian      2017-10-11  736  					if (pcc_data_alloc(pcc_subspace_id))
85b1407bf6d2f4a George Cherian      2017-10-11  737  						goto out_free;
85b1407bf6d2f4a George Cherian      2017-10-11  738  				} else if (pcc_subspace_id != gas_t->access_width) {
337aadff8e4567e Ashwin Chaugule     2015-10-02  739  					pr_debug("Mismatched PCC ids.\n");
337aadff8e4567e Ashwin Chaugule     2015-10-02  740  					goto out_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  741  				}
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  742  			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  743  				if (gas_t->address) {
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  744  					void __iomem *addr;
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  745  
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  746  					addr = ioremap(gas_t->address, gas_t->bit_width/8);
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  747  					if (!addr)
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  748  						goto out_free;
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  749  					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  750  				}
5b7602759293620 Steven Noonan       2021-10-27  751  			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
5b7602759293620 Steven Noonan       2021-10-27  752  				if (gas_t->access_width < 1 || gas_t->access_width > 3) {
5b7602759293620 Steven Noonan       2021-10-27  753  					/*
5b7602759293620 Steven Noonan       2021-10-27  754  					 * 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit.
5b7602759293620 Steven Noonan       2021-10-27  755  					 * SystemIO doesn't implement 64-bit
5b7602759293620 Steven Noonan       2021-10-27  756  					 * registers.
5b7602759293620 Steven Noonan       2021-10-27  757  					 */
5b7602759293620 Steven Noonan       2021-10-27  758  					pr_debug("Invalid access width %d for SystemIO register\n",
5b7602759293620 Steven Noonan       2021-10-27  759  						gas_t->access_width);
5b7602759293620 Steven Noonan       2021-10-27  760  					goto out_free;
5b7602759293620 Steven Noonan       2021-10-27  761  				}
5b7602759293620 Steven Noonan       2021-10-27  762  				if (gas_t->address & OVER_16BTS_MASK) {
5b7602759293620 Steven Noonan       2021-10-27  763  					/* SystemIO registers use 16-bit integer addresses */
5b7602759293620 Steven Noonan       2021-10-27  764  					pr_debug("Invalid IO port %llu for SystemIO register\n",
5b7602759293620 Steven Noonan       2021-10-27  765  						gas_t->address);
5b7602759293620 Steven Noonan       2021-10-27  766  					goto out_free;
5b7602759293620 Steven Noonan       2021-10-27  767  				}
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  768  			} else {
a6cbcdd5ab5f242 Srinivas Pandruvada 2016-09-01  769  				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
5b7602759293620 Steven Noonan       2021-10-27  770  					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
337aadff8e4567e Ashwin Chaugule     2015-10-02  771  					pr_debug("Unsupported register type: %d\n", gas_t->space_id);
337aadff8e4567e Ashwin Chaugule     2015-10-02  772  					goto out_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  773  				}
a6cbcdd5ab5f242 Srinivas Pandruvada 2016-09-01  774  			}
337aadff8e4567e Ashwin Chaugule     2015-10-02  775  
337aadff8e4567e Ashwin Chaugule     2015-10-02  776  			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
337aadff8e4567e Ashwin Chaugule     2015-10-02  777  			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
337aadff8e4567e Ashwin Chaugule     2015-10-02  778  		} else {
337aadff8e4567e Ashwin Chaugule     2015-10-02  779  			pr_debug("Err in entry:%d in CPC table of CPU:%d\n", i, pr->id);
337aadff8e4567e Ashwin Chaugule     2015-10-02  780  			goto out_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  781  		}
337aadff8e4567e Ashwin Chaugule     2015-10-02  782  	}
85b1407bf6d2f4a George Cherian      2017-10-11  783  	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
4773e77cdc9b3af Prashanth Prakash   2018-04-04  784  
4773e77cdc9b3af Prashanth Prakash   2018-04-04  785  	/*
4773e77cdc9b3af Prashanth Prakash   2018-04-04  786  	 * Initialize the remaining cpc_regs as unsupported.
4773e77cdc9b3af Prashanth Prakash   2018-04-04  787  	 * Example: In case FW exposes CPPC v2, the below loop will initialize
4773e77cdc9b3af Prashanth Prakash   2018-04-04  788  	 * LOWEST_FREQ and NOMINAL_FREQ regs as unsupported
4773e77cdc9b3af Prashanth Prakash   2018-04-04  789  	 */
4773e77cdc9b3af Prashanth Prakash   2018-04-04  790  	for (i = num_ent - 2; i < MAX_CPC_REG_ENT; i++) {
4773e77cdc9b3af Prashanth Prakash   2018-04-04  791  		cpc_ptr->cpc_regs[i].type = ACPI_TYPE_INTEGER;
4773e77cdc9b3af Prashanth Prakash   2018-04-04  792  		cpc_ptr->cpc_regs[i].cpc_entry.int_value = 0;
4773e77cdc9b3af Prashanth Prakash   2018-04-04  793  	}
4773e77cdc9b3af Prashanth Prakash   2018-04-04  794  
4773e77cdc9b3af Prashanth Prakash   2018-04-04  795  
337aadff8e4567e Ashwin Chaugule     2015-10-02  796  	/* Store CPU Logical ID */
337aadff8e4567e Ashwin Chaugule     2015-10-02  797  	cpc_ptr->cpu_id = pr->id;
337aadff8e4567e Ashwin Chaugule     2015-10-02  798  
337aadff8e4567e Ashwin Chaugule     2015-10-02  799  	/* Parse PSD data for this CPU */
337aadff8e4567e Ashwin Chaugule     2015-10-02  800  	ret = acpi_get_psd(cpc_ptr, handle);
337aadff8e4567e Ashwin Chaugule     2015-10-02  801  	if (ret)
337aadff8e4567e Ashwin Chaugule     2015-10-02  802  		goto out_free;
337aadff8e4567e Ashwin Chaugule     2015-10-02  803  
603fadf33604a2e Bjorn Helgaas       2019-03-25  804  	/* Register PCC channel once for all PCC subspace ID. */
85b1407bf6d2f4a George Cherian      2017-10-11  805  	if (pcc_subspace_id >= 0 && !pcc_data[pcc_subspace_id]->pcc_channel_acquired) {
85b1407bf6d2f4a George Cherian      2017-10-11  806  		ret = register_pcc_channel(pcc_subspace_id);
337aadff8e4567e Ashwin Chaugule     2015-10-02  807  		if (ret)
337aadff8e4567e Ashwin Chaugule     2015-10-02  808  			goto out_free;
8482ef8c6e684a1 Prakash, Prashanth  2016-08-16  809  
85b1407bf6d2f4a George Cherian      2017-10-11  810  		init_rwsem(&pcc_data[pcc_subspace_id]->pcc_lock);
85b1407bf6d2f4a George Cherian      2017-10-11  811  		init_waitqueue_head(&pcc_data[pcc_subspace_id]->pcc_write_wait_q);
337aadff8e4567e Ashwin Chaugule     2015-10-02  812  	}
337aadff8e4567e Ashwin Chaugule     2015-10-02  813  
337aadff8e4567e Ashwin Chaugule     2015-10-02  814  	/* Everything looks okay */
337aadff8e4567e Ashwin Chaugule     2015-10-02  815  	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
337aadff8e4567e Ashwin Chaugule     2015-10-02  816  
158c998ea44ba30 Ashwin Chaugule     2016-08-16  817  	/* Add per logical CPU nodes for reading its feedback counters. */
158c998ea44ba30 Ashwin Chaugule     2016-08-16  818  	cpu_dev = get_cpu_device(pr->id);
501634759d55a5b Dan Carpenter       2016-11-30  819  	if (!cpu_dev) {
501634759d55a5b Dan Carpenter       2016-11-30  820  		ret = -EINVAL;
158c998ea44ba30 Ashwin Chaugule     2016-08-16  821  		goto out_free;
501634759d55a5b Dan Carpenter       2016-11-30  822  	}
158c998ea44ba30 Ashwin Chaugule     2016-08-16  823  
603fadf33604a2e Bjorn Helgaas       2019-03-25  824  	/* Plug PSD data into this CPU's CPC descriptor. */
28076483afac9dd Rafael J. Wysocki   2016-12-10  825  	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
28076483afac9dd Rafael J. Wysocki   2016-12-10  826  
158c998ea44ba30 Ashwin Chaugule     2016-08-16  827  	ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
158c998ea44ba30 Ashwin Chaugule     2016-08-16  828  			"acpi_cppc");
28076483afac9dd Rafael J. Wysocki   2016-12-10  829  	if (ret) {
28076483afac9dd Rafael J. Wysocki   2016-12-10  830  		per_cpu(cpc_desc_ptr, pr->id) = NULL;
4d8be4bc94f74bb Qiushi Wu           2020-05-27  831  		kobject_put(&cpc_ptr->kobj);
158c998ea44ba30 Ashwin Chaugule     2016-08-16  832  		goto out_free;
28076483afac9dd Rafael J. Wysocki   2016-12-10  833  	}
158c998ea44ba30 Ashwin Chaugule     2016-08-16  834  
41ea667227bad5c Nathan Fontenot     2020-11-12 @835  	init_freq_invariance_cppc();
41ea667227bad5c Nathan Fontenot     2020-11-12  836  
337aadff8e4567e Ashwin Chaugule     2015-10-02  837  	kfree(output.pointer);
337aadff8e4567e Ashwin Chaugule     2015-10-02  838  	return 0;
337aadff8e4567e Ashwin Chaugule     2015-10-02  839  
337aadff8e4567e Ashwin Chaugule     2015-10-02  840  out_free:
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  841  	/* Free all the mapped sys mem areas for this CPU */
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  842  	for (i = 2; i < cpc_ptr->num_entries; i++) {
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  843  		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  844  
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  845  		if (addr)
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  846  			iounmap(addr);
5bbb86aa4b8d843 Ashwin Chaugule     2016-08-16  847  	}
337aadff8e4567e Ashwin Chaugule     2015-10-02  848  	kfree(cpc_ptr);
337aadff8e4567e Ashwin Chaugule     2015-10-02  849  
337aadff8e4567e Ashwin Chaugule     2015-10-02  850  out_buf_free:
337aadff8e4567e Ashwin Chaugule     2015-10-02  851  	kfree(output.pointer);
337aadff8e4567e Ashwin Chaugule     2015-10-02  852  	return ret;
337aadff8e4567e Ashwin Chaugule     2015-10-02  853  }
337aadff8e4567e Ashwin Chaugule     2015-10-02  854  EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
337aadff8e4567e Ashwin Chaugule     2015-10-02  855  

:::::: The code at line 835 was first introduced by commit
:::::: 41ea667227bad5c247d76e6605054e96e4d95f51 x86, sched: Calculate frequency invariance for AMD systems

:::::: TO: Nathan Fontenot <nathan.fontenot@amd.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
