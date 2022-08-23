Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E500359E04E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355775AbiHWLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357549AbiHWLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:31:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E9076479
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661246749; x=1692782749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BLdIdYs4P7OGhFZgYqP5Lg4Lqt4oh/3ZscJpv+NsGFc=;
  b=Pzo/VIGBnrHz+S8Dbwx0e4nrslPg0Q+kJO+C9c23VhCpkA21JST8BoAm
   ikqfODiG2SSvRcilr1zFZRbsr7IHzKFnojyDBeQNUR/2Prmq+8u7CUnt9
   bFYl1y/eVDqWA/15t4zgpvJMiU9hEp0OOwUIkkiR1bS/1u1aS7yMLgndl
   vaw0Hs620zZeqsRxs8v9xWHlNgCPtMXTd8Xl66HgvgApXAXRmkXC0flZO
   0iWrJzuCLLeyQwQKz1Tlil5BKJK1SAMShzQw9VLHU+n53wZyzAaqzJO1L
   rBWjl7qDzrQNiMNgaWmOQvQBQ6iiBcLP5OhXn9HOwqYxC05n119lEa9HW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="274024201"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="274024201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 02:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="560094120"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2022 02:25:46 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQQAL-000059-22;
        Tue, 23 Aug 2022 09:25:45 +0000
Date:   Tue, 23 Aug 2022 17:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 142/314]
 arch/arm64/kvm/../../../virt/kvm/kvm_main.c:4971:1: warning: unused label
 'arch_vm_ioctl'
Message-ID: <202208231700.N4apTibb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: 303b911206dd2a12b1a4fdee94044dc5a6fa36a3 [142/314] KVM: Register/unregister the guest private memory regions
config: arm64-randconfig-r011-20220823 (https://download.01.org/0day-ci/archive/20220823/202208231700.N4apTibb-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project b04d01c009d7f66bcca9138d2ce40999eedf104d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel/tdx/commit/303b911206dd2a12b1a4fdee94044dc5a6fa36a3
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 303b911206dd2a12b1a4fdee94044dc5a6fa36a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/../../../virt/kvm/kvm_main.c:4971:1: warning: unused label 'arch_vm_ioctl' [-Wunused-label]
   arch_vm_ioctl:
   ^~~~~~~~~~~~~~
   1 warning generated.


vim +/arch_vm_ioctl +4971 arch/arm64/kvm/../../../virt/kvm/kvm_main.c

  4747	
  4748	static long kvm_vm_ioctl(struct file *filp,
  4749				   unsigned int ioctl, unsigned long arg)
  4750	{
  4751		struct kvm *kvm = filp->private_data;
  4752		void __user *argp = (void __user *)arg;
  4753		int r;
  4754	
  4755		if (kvm->mm != current->mm || kvm->vm_dead)
  4756			return -EIO;
  4757		switch (ioctl) {
  4758		case KVM_CREATE_VCPU:
  4759			r = kvm_vm_ioctl_create_vcpu(kvm, arg);
  4760			break;
  4761		case KVM_ENABLE_CAP: {
  4762			struct kvm_enable_cap cap;
  4763	
  4764			r = -EFAULT;
  4765			if (copy_from_user(&cap, argp, sizeof(cap)))
  4766				goto out;
  4767			r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
  4768			break;
  4769		}
  4770		case KVM_SET_USER_MEMORY_REGION: {
  4771			struct kvm_user_mem_region mem;
  4772			unsigned long size;
  4773			u32 flags;
  4774	
  4775			kvm_sanity_check_user_mem_region_alias();
  4776	
  4777			memset(&mem, 0, sizeof(mem));
  4778	
  4779			r = -EFAULT;
  4780	
  4781			if (get_user(flags,
  4782				(u32 __user *)(argp + offsetof(typeof(mem), flags))))
  4783				goto out;
  4784	
  4785			if (flags & KVM_MEM_PRIVATE) {
  4786				r = -EINVAL;
  4787				goto out;
  4788			}
  4789	
  4790			size = sizeof(struct kvm_userspace_memory_region);
  4791	
  4792			if (copy_from_user(&mem, argp, size))
  4793				goto out;
  4794	
  4795			r = -EINVAL;
  4796			if ((flags ^ mem.flags) & KVM_MEM_PRIVATE)
  4797				goto out;
  4798	
  4799			r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
  4800			break;
  4801		}
  4802	#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
  4803		case KVM_MEMORY_ENCRYPT_REG_REGION:
  4804		case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
  4805			struct kvm_enc_region region;
  4806	
  4807			if (!kvm_arch_private_mem_supported(kvm))
  4808				goto arch_vm_ioctl;
  4809	
  4810			r = -EFAULT;
  4811			if (copy_from_user(&region, argp, sizeof(region)))
  4812				goto out;
  4813	
  4814			r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
  4815			break;
  4816		}
  4817	#endif
  4818		case KVM_GET_DIRTY_LOG: {
  4819			struct kvm_dirty_log log;
  4820	
  4821			r = -EFAULT;
  4822			if (copy_from_user(&log, argp, sizeof(log)))
  4823				goto out;
  4824			r = kvm_vm_ioctl_get_dirty_log(kvm, &log);
  4825			break;
  4826		}
  4827	#ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
  4828		case KVM_CLEAR_DIRTY_LOG: {
  4829			struct kvm_clear_dirty_log log;
  4830	
  4831			r = -EFAULT;
  4832			if (copy_from_user(&log, argp, sizeof(log)))
  4833				goto out;
  4834			r = kvm_vm_ioctl_clear_dirty_log(kvm, &log);
  4835			break;
  4836		}
  4837	#endif
  4838	#ifdef CONFIG_KVM_MMIO
  4839		case KVM_REGISTER_COALESCED_MMIO: {
  4840			struct kvm_coalesced_mmio_zone zone;
  4841	
  4842			r = -EFAULT;
  4843			if (copy_from_user(&zone, argp, sizeof(zone)))
  4844				goto out;
  4845			r = kvm_vm_ioctl_register_coalesced_mmio(kvm, &zone);
  4846			break;
  4847		}
  4848		case KVM_UNREGISTER_COALESCED_MMIO: {
  4849			struct kvm_coalesced_mmio_zone zone;
  4850	
  4851			r = -EFAULT;
  4852			if (copy_from_user(&zone, argp, sizeof(zone)))
  4853				goto out;
  4854			r = kvm_vm_ioctl_unregister_coalesced_mmio(kvm, &zone);
  4855			break;
  4856		}
  4857	#endif
  4858		case KVM_IRQFD: {
  4859			struct kvm_irqfd data;
  4860	
  4861			r = -EFAULT;
  4862			if (copy_from_user(&data, argp, sizeof(data)))
  4863				goto out;
  4864			r = kvm_irqfd(kvm, &data);
  4865			break;
  4866		}
  4867		case KVM_IOEVENTFD: {
  4868			struct kvm_ioeventfd data;
  4869	
  4870			r = -EFAULT;
  4871			if (copy_from_user(&data, argp, sizeof(data)))
  4872				goto out;
  4873			r = kvm_ioeventfd(kvm, &data);
  4874			break;
  4875		}
  4876	#ifdef CONFIG_HAVE_KVM_MSI
  4877		case KVM_SIGNAL_MSI: {
  4878			struct kvm_msi msi;
  4879	
  4880			r = -EFAULT;
  4881			if (copy_from_user(&msi, argp, sizeof(msi)))
  4882				goto out;
  4883			r = kvm_send_userspace_msi(kvm, &msi);
  4884			break;
  4885		}
  4886	#endif
  4887	#ifdef __KVM_HAVE_IRQ_LINE
  4888		case KVM_IRQ_LINE_STATUS:
  4889		case KVM_IRQ_LINE: {
  4890			struct kvm_irq_level irq_event;
  4891	
  4892			r = -EFAULT;
  4893			if (copy_from_user(&irq_event, argp, sizeof(irq_event)))
  4894				goto out;
  4895	
  4896			r = kvm_vm_ioctl_irq_line(kvm, &irq_event,
  4897						ioctl == KVM_IRQ_LINE_STATUS);
  4898			if (r)
  4899				goto out;
  4900	
  4901			r = -EFAULT;
  4902			if (ioctl == KVM_IRQ_LINE_STATUS) {
  4903				if (copy_to_user(argp, &irq_event, sizeof(irq_event)))
  4904					goto out;
  4905			}
  4906	
  4907			r = 0;
  4908			break;
  4909		}
  4910	#endif
  4911	#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
  4912		case KVM_SET_GSI_ROUTING: {
  4913			struct kvm_irq_routing routing;
  4914			struct kvm_irq_routing __user *urouting;
  4915			struct kvm_irq_routing_entry *entries = NULL;
  4916	
  4917			r = -EFAULT;
  4918			if (copy_from_user(&routing, argp, sizeof(routing)))
  4919				goto out;
  4920			r = -EINVAL;
  4921			if (!kvm_arch_can_set_irq_routing(kvm))
  4922				goto out;
  4923			if (routing.nr > KVM_MAX_IRQ_ROUTES)
  4924				goto out;
  4925			if (routing.flags)
  4926				goto out;
  4927			if (routing.nr) {
  4928				urouting = argp;
  4929				entries = vmemdup_user(urouting->entries,
  4930						       array_size(sizeof(*entries),
  4931								  routing.nr));
  4932				if (IS_ERR(entries)) {
  4933					r = PTR_ERR(entries);
  4934					goto out;
  4935				}
  4936			}
  4937			r = kvm_set_irq_routing(kvm, entries, routing.nr,
  4938						routing.flags);
  4939			kvfree(entries);
  4940			break;
  4941		}
  4942	#endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
  4943		case KVM_CREATE_DEVICE: {
  4944			struct kvm_create_device cd;
  4945	
  4946			r = -EFAULT;
  4947			if (copy_from_user(&cd, argp, sizeof(cd)))
  4948				goto out;
  4949	
  4950			r = kvm_ioctl_create_device(kvm, &cd);
  4951			if (r)
  4952				goto out;
  4953	
  4954			r = -EFAULT;
  4955			if (copy_to_user(argp, &cd, sizeof(cd)))
  4956				goto out;
  4957	
  4958			r = 0;
  4959			break;
  4960		}
  4961		case KVM_CHECK_EXTENSION:
  4962			r = kvm_vm_ioctl_check_extension_generic(kvm, arg);
  4963			break;
  4964		case KVM_RESET_DIRTY_RINGS:
  4965			r = kvm_vm_ioctl_reset_dirty_pages(kvm);
  4966			break;
  4967		case KVM_GET_STATS_FD:
  4968			r = kvm_vm_ioctl_get_stats_fd(kvm);
  4969			break;
  4970		default:
> 4971	arch_vm_ioctl:
  4972			r = kvm_arch_vm_ioctl(filp, ioctl, arg);
  4973		}
  4974	out:
  4975		return r;
  4976	}
  4977	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
