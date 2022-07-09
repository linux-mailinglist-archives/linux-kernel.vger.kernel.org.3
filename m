Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B835D56C58A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiGIAzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIAzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:55:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D5468DD1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657328117; x=1688864117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u4PMxN43tULEMO2To9nmaVrMhT1dJ7ms1Gb2D990wqM=;
  b=MGYzG0ItsCvNgmose9Ki+pilve8am5Z+YUv47bHL+8Vn2mrjBuTy5bDx
   V3bwi//Q4rKjfz5YNhCzEa2yZd9nzZyi8/T9ZnX4Zv5d+Mg2Lrmc9TfLr
   bgxf+Y9klESu8OApCvVC2orf0ZSq49Cn9ht3REzaUFRcA9tml92EMUNh8
   BFpNMHB0wSrvIt3ps4qr08/WYWOsqEOFibAbmKREfahNIx5/SP7s1vBNk
   Ryyq69SljEpP4CDYOnPLPI03Mzs156d/7GJlFhTBt/BtpNH8Reh9+vKMX
   2DldntNlRJw9rQS1X0KwTmgvq9BE2lUkr+uoaGtf8+UUbqPfCsGHGLptZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348380163"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="348380163"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736515311"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 17:55:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9ykc-000O7S-Ak;
        Sat, 09 Jul 2022 00:55:14 +0000
Date:   Sat, 9 Jul 2022 08:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuan Yao <yuan.yao@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 311/411]
 arch/x86/kvm/x86.c:6733:49: sparse: sparse: incorrect type in initializer
 (different address spaces)
Message-ID: <202207090818.2yZPjqWM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   36253a6ed7e922a2e6888cde465578b98145404e
commit: 1b7cb61ab6bfe6e587f1f1b9ddcc4d6d58106614 [311/411] KVM: Introduce the KVM_MEMORY_ENCRYPT_{READ,WRITE}_MEMORY VM ioctl
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220709/202207090818.2yZPjqWM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/1b7cb61ab6bfe6e587f1f1b9ddcc4d6d58106614
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 1b7cb61ab6bfe6e587f1f1b9ddcc4d6d58106614
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/x86.c:229:47: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c: note: in included file:
   include/linux/kvm_host.h:1925:54: sparse: sparse: array of flexible structures
   arch/x86/kvm/x86.c:255:49: sparse: sparse: array of flexible structures
   include/linux/kvm_host.h:1927:56: sparse: sparse: array of flexible structures
>> arch/x86/kvm/x86.c:6733:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct kvm_rw_memory *rw_user @@     got void [noderef] __user *argp @@
   arch/x86/kvm/x86.c:6733:49: sparse:     expected struct kvm_rw_memory *rw_user
   arch/x86/kvm/x86.c:6733:49: sparse:     got void [noderef] __user *argp
>> arch/x86/kvm/x86.c:6742:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long * @@
   arch/x86/kvm/x86.c:6742:43: sparse:     expected void [noderef] __user *to
   arch/x86/kvm/x86.c:6742:43: sparse:     got unsigned long long *
   arch/x86/kvm/x86.c:6750:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct kvm_rw_memory *rw_user @@     got void [noderef] __user *argp @@
   arch/x86/kvm/x86.c:6750:49: sparse:     expected struct kvm_rw_memory *rw_user
   arch/x86/kvm/x86.c:6750:49: sparse:     got void [noderef] __user *argp
   arch/x86/kvm/x86.c:6759:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long * @@
   arch/x86/kvm/x86.c:6759:43: sparse:     expected void [noderef] __user *to
   arch/x86/kvm/x86.c:6759:43: sparse:     got unsigned long long *
   arch/x86/kvm/x86.c:2911:9: sparse: sparse: context imbalance in '__kvm_start_pvclock_update' - wrong count at exit
   arch/x86/kvm/x86.c:2922:13: sparse: sparse: context imbalance in 'kvm_end_pvclock_update' - unexpected unlock
   arch/x86/kvm/x86.c: note: in included file (through include/linux/notifier.h, arch/x86/include/asm/uprobes.h, include/linux/uprobes.h, ...):
   include/linux/srcu.h:189:9: sparse: sparse: context imbalance in 'vcpu_enter_guest' - unexpected unlock
   include/linux/srcu.h:189:9: sparse: sparse: context imbalance in 'vcpu_run' - unexpected unlock

vim +6733 arch/x86/kvm/x86.c

  6413	
  6414	long kvm_arch_vm_ioctl(struct file *filp,
  6415			       unsigned int ioctl, unsigned long arg)
  6416	{
  6417		struct kvm *kvm = filp->private_data;
  6418		void __user *argp = (void __user *)arg;
  6419		int r = -ENOTTY;
  6420		/*
  6421		 * This union makes it completely explicit to gcc-3.x
  6422		 * that these two variables' stack usage should be
  6423		 * combined, not added together.
  6424		 */
  6425		union {
  6426			struct kvm_pit_state ps;
  6427			struct kvm_pit_state2 ps2;
  6428			struct kvm_pit_config pit_config;
  6429		} u;
  6430	
  6431		switch (ioctl) {
  6432		case KVM_SET_TSS_ADDR:
  6433			r = kvm_vm_ioctl_set_tss_addr(kvm, arg);
  6434			break;
  6435		case KVM_SET_IDENTITY_MAP_ADDR: {
  6436			u64 ident_addr;
  6437	
  6438			mutex_lock(&kvm->lock);
  6439			r = -EINVAL;
  6440			if (kvm->created_vcpus)
  6441				goto set_identity_unlock;
  6442			r = -EFAULT;
  6443			if (copy_from_user(&ident_addr, argp, sizeof(ident_addr)))
  6444				goto set_identity_unlock;
  6445			r = kvm_vm_ioctl_set_identity_map_addr(kvm, ident_addr);
  6446	set_identity_unlock:
  6447			mutex_unlock(&kvm->lock);
  6448			break;
  6449		}
  6450		case KVM_SET_NR_MMU_PAGES:
  6451			r = kvm_vm_ioctl_set_nr_mmu_pages(kvm, arg);
  6452			break;
  6453		case KVM_GET_NR_MMU_PAGES:
  6454			r = kvm_vm_ioctl_get_nr_mmu_pages(kvm);
  6455			break;
  6456		case KVM_CREATE_IRQCHIP: {
  6457			mutex_lock(&kvm->lock);
  6458	
  6459			r = -EEXIST;
  6460			if (irqchip_in_kernel(kvm))
  6461				goto create_irqchip_unlock;
  6462	
  6463			r = -EINVAL;
  6464			if (kvm->created_vcpus)
  6465				goto create_irqchip_unlock;
  6466	
  6467			r = kvm_pic_init(kvm);
  6468			if (r)
  6469				goto create_irqchip_unlock;
  6470	
  6471			r = kvm_ioapic_init(kvm);
  6472			if (r) {
  6473				kvm_pic_destroy(kvm);
  6474				goto create_irqchip_unlock;
  6475			}
  6476	
  6477			r = kvm_setup_default_irq_routing(kvm);
  6478			if (r) {
  6479				kvm_ioapic_destroy(kvm);
  6480				kvm_pic_destroy(kvm);
  6481				goto create_irqchip_unlock;
  6482			}
  6483			/* Write kvm->irq_routing before enabling irqchip_in_kernel. */
  6484			smp_wmb();
  6485			kvm->arch.irqchip_mode = KVM_IRQCHIP_KERNEL;
  6486			kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_ABSENT);
  6487		create_irqchip_unlock:
  6488			mutex_unlock(&kvm->lock);
  6489			break;
  6490		}
  6491		case KVM_CREATE_PIT:
  6492			u.pit_config.flags = KVM_PIT_SPEAKER_DUMMY;
  6493			goto create_pit;
  6494		case KVM_CREATE_PIT2:
  6495			r = -EFAULT;
  6496			if (copy_from_user(&u.pit_config, argp,
  6497					   sizeof(struct kvm_pit_config)))
  6498				goto out;
  6499		create_pit:
  6500			mutex_lock(&kvm->lock);
  6501			r = -EEXIST;
  6502			if (kvm->arch.vpit)
  6503				goto create_pit_unlock;
  6504			r = -ENOMEM;
  6505			kvm->arch.vpit = kvm_create_pit(kvm, u.pit_config.flags);
  6506			if (kvm->arch.vpit)
  6507				r = 0;
  6508		create_pit_unlock:
  6509			mutex_unlock(&kvm->lock);
  6510			break;
  6511		case KVM_GET_IRQCHIP: {
  6512			/* 0: PIC master, 1: PIC slave, 2: IOAPIC */
  6513			struct kvm_irqchip *chip;
  6514	
  6515			chip = memdup_user(argp, sizeof(*chip));
  6516			if (IS_ERR(chip)) {
  6517				r = PTR_ERR(chip);
  6518				goto out;
  6519			}
  6520	
  6521			r = -ENXIO;
  6522			if (!irqchip_kernel(kvm))
  6523				goto get_irqchip_out;
  6524			r = kvm_vm_ioctl_get_irqchip(kvm, chip);
  6525			if (r)
  6526				goto get_irqchip_out;
  6527			r = -EFAULT;
  6528			if (copy_to_user(argp, chip, sizeof(*chip)))
  6529				goto get_irqchip_out;
  6530			r = 0;
  6531		get_irqchip_out:
  6532			kfree(chip);
  6533			break;
  6534		}
  6535		case KVM_SET_IRQCHIP: {
  6536			/* 0: PIC master, 1: PIC slave, 2: IOAPIC */
  6537			struct kvm_irqchip *chip;
  6538	
  6539			chip = memdup_user(argp, sizeof(*chip));
  6540			if (IS_ERR(chip)) {
  6541				r = PTR_ERR(chip);
  6542				goto out;
  6543			}
  6544	
  6545			r = -ENXIO;
  6546			if (!irqchip_kernel(kvm))
  6547				goto set_irqchip_out;
  6548			r = kvm_vm_ioctl_set_irqchip(kvm, chip);
  6549		set_irqchip_out:
  6550			kfree(chip);
  6551			break;
  6552		}
  6553		case KVM_GET_PIT: {
  6554			r = -EFAULT;
  6555			if (copy_from_user(&u.ps, argp, sizeof(struct kvm_pit_state)))
  6556				goto out;
  6557			r = -ENXIO;
  6558			if (!kvm->arch.vpit)
  6559				goto out;
  6560			r = kvm_vm_ioctl_get_pit(kvm, &u.ps);
  6561			if (r)
  6562				goto out;
  6563			r = -EFAULT;
  6564			if (copy_to_user(argp, &u.ps, sizeof(struct kvm_pit_state)))
  6565				goto out;
  6566			r = 0;
  6567			break;
  6568		}
  6569		case KVM_SET_PIT: {
  6570			r = -EFAULT;
  6571			if (copy_from_user(&u.ps, argp, sizeof(u.ps)))
  6572				goto out;
  6573			mutex_lock(&kvm->lock);
  6574			r = -ENXIO;
  6575			if (!kvm->arch.vpit)
  6576				goto set_pit_out;
  6577			r = kvm_vm_ioctl_set_pit(kvm, &u.ps);
  6578	set_pit_out:
  6579			mutex_unlock(&kvm->lock);
  6580			break;
  6581		}
  6582		case KVM_GET_PIT2: {
  6583			r = -ENXIO;
  6584			if (!kvm->arch.vpit)
  6585				goto out;
  6586			r = kvm_vm_ioctl_get_pit2(kvm, &u.ps2);
  6587			if (r)
  6588				goto out;
  6589			r = -EFAULT;
  6590			if (copy_to_user(argp, &u.ps2, sizeof(u.ps2)))
  6591				goto out;
  6592			r = 0;
  6593			break;
  6594		}
  6595		case KVM_SET_PIT2: {
  6596			r = -EFAULT;
  6597			if (copy_from_user(&u.ps2, argp, sizeof(u.ps2)))
  6598				goto out;
  6599			mutex_lock(&kvm->lock);
  6600			r = -ENXIO;
  6601			if (!kvm->arch.vpit)
  6602				goto set_pit2_out;
  6603			r = kvm_vm_ioctl_set_pit2(kvm, &u.ps2);
  6604	set_pit2_out:
  6605			mutex_unlock(&kvm->lock);
  6606			break;
  6607		}
  6608		case KVM_REINJECT_CONTROL: {
  6609			struct kvm_reinject_control control;
  6610			r =  -EFAULT;
  6611			if (copy_from_user(&control, argp, sizeof(control)))
  6612				goto out;
  6613			r = -ENXIO;
  6614			if (!kvm->arch.vpit)
  6615				goto out;
  6616			r = kvm_vm_ioctl_reinject(kvm, &control);
  6617			break;
  6618		}
  6619		case KVM_SET_BOOT_CPU_ID:
  6620			r = 0;
  6621			mutex_lock(&kvm->lock);
  6622			if (kvm->created_vcpus)
  6623				r = -EBUSY;
  6624			else
  6625				kvm->arch.bsp_vcpu_id = arg;
  6626			mutex_unlock(&kvm->lock);
  6627			break;
  6628	#ifdef CONFIG_KVM_XEN
  6629		case KVM_XEN_HVM_CONFIG: {
  6630			struct kvm_xen_hvm_config xhc;
  6631			r = -EFAULT;
  6632			if (copy_from_user(&xhc, argp, sizeof(xhc)))
  6633				goto out;
  6634			r = kvm_xen_hvm_config(kvm, &xhc);
  6635			break;
  6636		}
  6637		case KVM_XEN_HVM_GET_ATTR: {
  6638			struct kvm_xen_hvm_attr xha;
  6639	
  6640			r = -EFAULT;
  6641			if (copy_from_user(&xha, argp, sizeof(xha)))
  6642				goto out;
  6643			r = kvm_xen_hvm_get_attr(kvm, &xha);
  6644			if (!r && copy_to_user(argp, &xha, sizeof(xha)))
  6645				r = -EFAULT;
  6646			break;
  6647		}
  6648		case KVM_XEN_HVM_SET_ATTR: {
  6649			struct kvm_xen_hvm_attr xha;
  6650	
  6651			r = -EFAULT;
  6652			if (copy_from_user(&xha, argp, sizeof(xha)))
  6653				goto out;
  6654			r = kvm_xen_hvm_set_attr(kvm, &xha);
  6655			break;
  6656		}
  6657		case KVM_XEN_HVM_EVTCHN_SEND: {
  6658			struct kvm_irq_routing_xen_evtchn uxe;
  6659	
  6660			r = -EFAULT;
  6661			if (copy_from_user(&uxe, argp, sizeof(uxe)))
  6662				goto out;
  6663			r = kvm_xen_hvm_evtchn_send(kvm, &uxe);
  6664			break;
  6665		}
  6666	#endif
  6667		case KVM_SET_CLOCK:
  6668			r = kvm_vm_ioctl_set_clock(kvm, argp);
  6669			break;
  6670		case KVM_GET_CLOCK:
  6671			r = kvm_vm_ioctl_get_clock(kvm, argp);
  6672			break;
  6673		case KVM_SET_TSC_KHZ: {
  6674			u32 user_tsc_khz;
  6675	
  6676			r = -EINVAL;
  6677			user_tsc_khz = (u32)arg;
  6678	
  6679			if (kvm_caps.has_tsc_control &&
  6680			    user_tsc_khz >= kvm_caps.max_guest_tsc_khz)
  6681				goto out;
  6682	
  6683			if (user_tsc_khz == 0)
  6684				user_tsc_khz = tsc_khz;
  6685	
  6686			WRITE_ONCE(kvm->arch.default_tsc_khz, user_tsc_khz);
  6687			r = 0;
  6688	
  6689			goto out;
  6690		}
  6691		case KVM_GET_TSC_KHZ: {
  6692			r = READ_ONCE(kvm->arch.default_tsc_khz);
  6693			goto out;
  6694		}
  6695		case KVM_MEMORY_ENCRYPT_OP: {
  6696			r = -ENOTTY;
  6697			if (!kvm_x86_ops.mem_enc_ioctl)
  6698				goto out;
  6699	
  6700			r = static_call(kvm_x86_mem_enc_ioctl)(kvm, argp);
  6701			break;
  6702		}
  6703		case KVM_MEMORY_ENCRYPT_REG_REGION: {
  6704			struct kvm_enc_region region;
  6705	
  6706			r = -EFAULT;
  6707			if (copy_from_user(&region, argp, sizeof(region)))
  6708				goto out;
  6709	
  6710			r = -ENOTTY;
  6711			if (!kvm_x86_ops.mem_enc_register_region)
  6712				goto out;
  6713	
  6714			r = static_call(kvm_x86_mem_enc_register_region)(kvm, &region);
  6715			break;
  6716		}
  6717		case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
  6718			struct kvm_enc_region region;
  6719	
  6720			r = -EFAULT;
  6721			if (copy_from_user(&region, argp, sizeof(region)))
  6722				goto out;
  6723	
  6724			r = -ENOTTY;
  6725			if (!kvm_x86_ops.mem_enc_unregister_region)
  6726				goto out;
  6727	
  6728			r = static_call(kvm_x86_mem_enc_unregister_region)(kvm, &region);
  6729			break;
  6730		}
  6731		case KVM_MEMORY_ENCRYPT_READ_MEMORY: {
  6732			struct kvm_rw_memory rw;
> 6733			struct kvm_rw_memory *rw_user = argp;
  6734	
  6735			r = -EFAULT;
  6736			if (copy_from_user(&rw, argp, sizeof(rw)))
  6737				goto out;
  6738	
  6739			r = -ENOTTY;
  6740			if (kvm_x86_ops.mem_enc_read_memory) {
  6741				r = static_call(kvm_x86_mem_enc_read_memory)(kvm, &rw);
> 6742				if (copy_to_user(&rw_user->len, &rw.len,
  6743						 sizeof(rw.len)))
  6744					r = -EFAULT;
  6745			}
  6746			break;
  6747		}
  6748		case KVM_MEMORY_ENCRYPT_WRITE_MEMORY: {
  6749			struct kvm_rw_memory rw;
  6750			struct kvm_rw_memory *rw_user = argp;
  6751	
  6752			r = -EFAULT;
  6753			if (copy_from_user(&rw, argp, sizeof(rw)))
  6754				goto out;
  6755	
  6756			r = -ENOTTY;
  6757			if (kvm_x86_ops.mem_enc_write_memory) {
  6758				r = static_call(kvm_x86_mem_enc_write_memory)(kvm, &rw);
  6759				if (copy_to_user(&rw_user->len, &rw.len,
  6760						 sizeof(rw.len)))
  6761					r = -EFAULT;
  6762			}
  6763			break;
  6764		}
  6765		case KVM_HYPERV_EVENTFD: {
  6766			struct kvm_hyperv_eventfd hvevfd;
  6767	
  6768			r = -EFAULT;
  6769			if (copy_from_user(&hvevfd, argp, sizeof(hvevfd)))
  6770				goto out;
  6771			r = kvm_vm_ioctl_hv_eventfd(kvm, &hvevfd);
  6772			break;
  6773		}
  6774		case KVM_SET_PMU_EVENT_FILTER:
  6775			r = kvm_vm_ioctl_set_pmu_event_filter(kvm, argp);
  6776			break;
  6777		case KVM_X86_SET_MSR_FILTER:
  6778			r = kvm_vm_ioctl_set_msr_filter(kvm, argp);
  6779			break;
  6780		default:
  6781			r = -ENOTTY;
  6782		}
  6783	out:
  6784		return r;
  6785	}
  6786	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
