Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9658E35A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiHIWlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHIWlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:41:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2215C9DF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660084864; x=1691620864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xs0ZXM/9kzTr+uv9yvHdD5QveyR5cc2nhtfCii9MamY=;
  b=QQQl2j2v4VD0iSglaGQcSpCLyVO2nnnauqfnI6pne21AEej5n0MHTn/U
   wztMeTNDE3ntvHkaFt/A4WN/IHPBkUQyt5CG5BDYweQpcp3vvucD/44dE
   46b1D9U2ncZaI/UDg2lKaGjmMVTNg+UYt1WKN/OuHv5hXFmy52tMyhk3m
   UVZK0h3jgS748y53hvoK85u630h2WOtyYtmDIhYq36oqsmlGbJo26eoAT
   KhSb8tkaZo72u4E1nuyTp7YLMv8rCEDPwpkpNt6ww/9V2zAqfh/ClS20l
   l5O+VDwmz7CQ0JdvKTXz6JSGVl07B171Krf9yLZqyR1Axpxze6gfL7IIa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="290951132"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="290951132"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 15:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="932655263"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2022 15:41:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLXuH-000NKZ-2v;
        Tue, 09 Aug 2022 22:41:01 +0000
Date:   Wed, 10 Aug 2022 06:40:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 685/846]
 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4959:1: warning: label
 'arch_vm_ioctl' defined but not used
Message-ID: <202208100656.yYNlLrHS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   6e62680f6e4094d3986229a4145ebd54390dc110
commit: 446bed91935bf1bc401292a921d266416bf97cf9 [685/846] KVM: Register/unregister the guest private memory regions
config: i386-randconfig-a001-20220808 (https://download.01.org/0day-ci/archive/20220810/202208100656.yYNlLrHS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/446bed91935bf1bc401292a921d266416bf97cf9
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 446bed91935bf1bc401292a921d266416bf97cf9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/ virt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kvm/../../../virt/kvm/kvm_main.c: In function 'kvm_vm_ioctl':
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:4959:1: warning: label 'arch_vm_ioctl' defined but not used [-Wunused-label]
    4959 | arch_vm_ioctl:
         | ^~~~~~~~~~~~~


vim +/arch_vm_ioctl +4959 arch/x86/kvm/../../../virt/kvm/kvm_main.c

  4735	
  4736	static long kvm_vm_ioctl(struct file *filp,
  4737				   unsigned int ioctl, unsigned long arg)
  4738	{
  4739		struct kvm *kvm = filp->private_data;
  4740		void __user *argp = (void __user *)arg;
  4741		int r;
  4742	
  4743		if (kvm->mm != current->mm || kvm->vm_dead)
  4744			return -EIO;
  4745		switch (ioctl) {
  4746		case KVM_CREATE_VCPU:
  4747			r = kvm_vm_ioctl_create_vcpu(kvm, arg);
  4748			break;
  4749		case KVM_ENABLE_CAP: {
  4750			struct kvm_enable_cap cap;
  4751	
  4752			r = -EFAULT;
  4753			if (copy_from_user(&cap, argp, sizeof(cap)))
  4754				goto out;
  4755			r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
  4756			break;
  4757		}
  4758		case KVM_SET_USER_MEMORY_REGION: {
  4759			struct kvm_user_mem_region mem;
  4760			unsigned long size;
  4761			u32 flags;
  4762	
  4763			kvm_sanity_check_user_mem_region_alias();
  4764	
  4765			memset(&mem, 0, sizeof(mem));
  4766	
  4767			r = -EFAULT;
  4768	
  4769			if (get_user(flags,
  4770				(u32 __user *)(argp + offsetof(typeof(mem), flags))))
  4771				goto out;
  4772	
  4773			if (flags & KVM_MEM_PRIVATE) {
  4774				r = -EINVAL;
  4775				goto out;
  4776			}
  4777	
  4778			size = sizeof(struct kvm_userspace_memory_region);
  4779	
  4780			if (copy_from_user(&mem, argp, size))
  4781				goto out;
  4782	
  4783			r = -EINVAL;
  4784			if ((flags ^ mem.flags) & KVM_MEM_PRIVATE)
  4785				goto out;
  4786	
  4787			r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
  4788			break;
  4789		}
  4790	#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
  4791		case KVM_MEMORY_ENCRYPT_REG_REGION:
  4792		case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
  4793			struct kvm_enc_region region;
  4794	
  4795			if (!kvm_arch_private_mem_supported(kvm))
  4796				goto arch_vm_ioctl;
  4797	
  4798			r = -EFAULT;
  4799			if (copy_from_user(&region, argp, sizeof(region)))
  4800				goto out;
  4801	
  4802			r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
  4803			break;
  4804		}
  4805	#endif
  4806		case KVM_GET_DIRTY_LOG: {
  4807			struct kvm_dirty_log log;
  4808	
  4809			r = -EFAULT;
  4810			if (copy_from_user(&log, argp, sizeof(log)))
  4811				goto out;
  4812			r = kvm_vm_ioctl_get_dirty_log(kvm, &log);
  4813			break;
  4814		}
  4815	#ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
  4816		case KVM_CLEAR_DIRTY_LOG: {
  4817			struct kvm_clear_dirty_log log;
  4818	
  4819			r = -EFAULT;
  4820			if (copy_from_user(&log, argp, sizeof(log)))
  4821				goto out;
  4822			r = kvm_vm_ioctl_clear_dirty_log(kvm, &log);
  4823			break;
  4824		}
  4825	#endif
  4826	#ifdef CONFIG_KVM_MMIO
  4827		case KVM_REGISTER_COALESCED_MMIO: {
  4828			struct kvm_coalesced_mmio_zone zone;
  4829	
  4830			r = -EFAULT;
  4831			if (copy_from_user(&zone, argp, sizeof(zone)))
  4832				goto out;
  4833			r = kvm_vm_ioctl_register_coalesced_mmio(kvm, &zone);
  4834			break;
  4835		}
  4836		case KVM_UNREGISTER_COALESCED_MMIO: {
  4837			struct kvm_coalesced_mmio_zone zone;
  4838	
  4839			r = -EFAULT;
  4840			if (copy_from_user(&zone, argp, sizeof(zone)))
  4841				goto out;
  4842			r = kvm_vm_ioctl_unregister_coalesced_mmio(kvm, &zone);
  4843			break;
  4844		}
  4845	#endif
  4846		case KVM_IRQFD: {
  4847			struct kvm_irqfd data;
  4848	
  4849			r = -EFAULT;
  4850			if (copy_from_user(&data, argp, sizeof(data)))
  4851				goto out;
  4852			r = kvm_irqfd(kvm, &data);
  4853			break;
  4854		}
  4855		case KVM_IOEVENTFD: {
  4856			struct kvm_ioeventfd data;
  4857	
  4858			r = -EFAULT;
  4859			if (copy_from_user(&data, argp, sizeof(data)))
  4860				goto out;
  4861			r = kvm_ioeventfd(kvm, &data);
  4862			break;
  4863		}
  4864	#ifdef CONFIG_HAVE_KVM_MSI
  4865		case KVM_SIGNAL_MSI: {
  4866			struct kvm_msi msi;
  4867	
  4868			r = -EFAULT;
  4869			if (copy_from_user(&msi, argp, sizeof(msi)))
  4870				goto out;
  4871			r = kvm_send_userspace_msi(kvm, &msi);
  4872			break;
  4873		}
  4874	#endif
  4875	#ifdef __KVM_HAVE_IRQ_LINE
  4876		case KVM_IRQ_LINE_STATUS:
  4877		case KVM_IRQ_LINE: {
  4878			struct kvm_irq_level irq_event;
  4879	
  4880			r = -EFAULT;
  4881			if (copy_from_user(&irq_event, argp, sizeof(irq_event)))
  4882				goto out;
  4883	
  4884			r = kvm_vm_ioctl_irq_line(kvm, &irq_event,
  4885						ioctl == KVM_IRQ_LINE_STATUS);
  4886			if (r)
  4887				goto out;
  4888	
  4889			r = -EFAULT;
  4890			if (ioctl == KVM_IRQ_LINE_STATUS) {
  4891				if (copy_to_user(argp, &irq_event, sizeof(irq_event)))
  4892					goto out;
  4893			}
  4894	
  4895			r = 0;
  4896			break;
  4897		}
  4898	#endif
  4899	#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
  4900		case KVM_SET_GSI_ROUTING: {
  4901			struct kvm_irq_routing routing;
  4902			struct kvm_irq_routing __user *urouting;
  4903			struct kvm_irq_routing_entry *entries = NULL;
  4904	
  4905			r = -EFAULT;
  4906			if (copy_from_user(&routing, argp, sizeof(routing)))
  4907				goto out;
  4908			r = -EINVAL;
  4909			if (!kvm_arch_can_set_irq_routing(kvm))
  4910				goto out;
  4911			if (routing.nr > KVM_MAX_IRQ_ROUTES)
  4912				goto out;
  4913			if (routing.flags)
  4914				goto out;
  4915			if (routing.nr) {
  4916				urouting = argp;
  4917				entries = vmemdup_user(urouting->entries,
  4918						       array_size(sizeof(*entries),
  4919								  routing.nr));
  4920				if (IS_ERR(entries)) {
  4921					r = PTR_ERR(entries);
  4922					goto out;
  4923				}
  4924			}
  4925			r = kvm_set_irq_routing(kvm, entries, routing.nr,
  4926						routing.flags);
  4927			kvfree(entries);
  4928			break;
  4929		}
  4930	#endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
  4931		case KVM_CREATE_DEVICE: {
  4932			struct kvm_create_device cd;
  4933	
  4934			r = -EFAULT;
  4935			if (copy_from_user(&cd, argp, sizeof(cd)))
  4936				goto out;
  4937	
  4938			r = kvm_ioctl_create_device(kvm, &cd);
  4939			if (r)
  4940				goto out;
  4941	
  4942			r = -EFAULT;
  4943			if (copy_to_user(argp, &cd, sizeof(cd)))
  4944				goto out;
  4945	
  4946			r = 0;
  4947			break;
  4948		}
  4949		case KVM_CHECK_EXTENSION:
  4950			r = kvm_vm_ioctl_check_extension_generic(kvm, arg);
  4951			break;
  4952		case KVM_RESET_DIRTY_RINGS:
  4953			r = kvm_vm_ioctl_reset_dirty_pages(kvm);
  4954			break;
  4955		case KVM_GET_STATS_FD:
  4956			r = kvm_vm_ioctl_get_stats_fd(kvm);
  4957			break;
  4958		default:
> 4959	arch_vm_ioctl:
  4960			r = kvm_arch_vm_ioctl(filp, ioctl, arg);
  4961		}
  4962	out:
  4963		return r;
  4964	}
  4965	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
