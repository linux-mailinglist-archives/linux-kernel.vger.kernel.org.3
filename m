Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50A747B256
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhLTRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:50:12 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38890 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhLTRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:50:09 -0500
Received: by mail-wr1-f45.google.com with SMTP id e5so21664757wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TuTdjr1KdfBk0A9Qw5Xw1Lhq6V3eqRmE0qM4KCLR7YE=;
        b=fAneJTM7FiZ3U0E5GmH0XAI082QLhqIhjWQ+sYZPP2HzBHYj/3n10bOp86awEV9pcD
         LSl0rSpzsRsCvA4hpultShl+GPu5Fn9+wwQKzgZjH8h/R3AjGHeaqWIgBqwT51Zf4bek
         ZaPIMeYkXX+WUcRAKuUT4mDScGm97ymb40QztVrGnEUm/mWEU7e115LBv+mSJW7Xjvp4
         oMjB0dJf5NHMCTCuxsPWfCc7JrkXpYpqrEgHEL1kXX1bMJ5NvlFm+0yeP5d+PUheq6L1
         txQjF94uYG70azIA7+AKWnJ2w/pC5cy/vVv+Qi2+3V3kPyHhhCfTo/kvuJRAmJvNIa/7
         HgaA==
X-Gm-Message-State: AOAM531vkzxyWoapuU4ubvX0GNJ56WWmq47/fD3kcboK9jlD/0b7Y/MA
        GdsLtJrLnOFo0Ylml9UUzZg=
X-Google-Smtp-Source: ABdhPJyIrhW2tjRki+QUqiT7Tj7XbDMo4ItWdbTCzFPi2gl7FBt42LSyx2g3/pLLPnqmKEUX0Rj0kw==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr13577270wrx.426.1640022608045;
        Mon, 20 Dec 2021 09:50:08 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm46156wmq.11.2021.12.20.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:50:07 -0800 (PST)
Date:   Mon, 20 Dec 2021 17:50:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [hyperv:hyperv-next 1/5] kernel/dma/swiotlb.c:176:11: warning:
 format specifies type 'unsigned long long' but the argument has type
 'phys_addr_t' (aka 'unsigned int')
Message-ID: <20211220175006.gfmj3kqmxefuhzbm@liuwe-devbox-debian-v2>
References: <202112202102.zfnhbn2Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112202102.zfnhbn2Q-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 09:10:04PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> head:   63cd06c67a2f46009da6e88ca46f9c7231ab8998
> commit: f16dc95481e2ef2c385008f8b7bd382ea6919ee2 [1/5] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
> config: i386-randconfig-a001-20211219 (https://download.01.org/0day-ci/archive/20211220/202112202102.zfnhbn2Q-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 683cbc12b33e5c8dc8d29bf5ed79fbf45763aadd)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=f16dc95481e2ef2c385008f8b7bd382ea6919ee2
>         git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>         git fetch --no-tags hyperv hyperv-next
>         git checkout f16dc95481e2ef2c385008f8b7bd382ea6919ee2
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/dma/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/dma/swiotlb.c:176:11: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
>                                   paddr, bytes);
>                                   ^~~~~
>    include/linux/printk.h:493:33: note: expanded from macro 'pr_err'
>            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                   ~~~     ^~~~~~~~~~~
>    include/linux/printk.h:450:60: note: expanded from macro 'printk'
>    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>                                                        ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
>                    _p_func(_fmt, ##__VA_ARGS__);                           \
>                            ~~~~    ^~~~~~~~~~~
>    1 warning generated.
> 
> 
> vim +176 kernel/dma/swiotlb.c
> 
>    160	
>    161	/*
>    162	 * Remap swioltb memory in the unencrypted physical address space
>    163	 * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
>    164	 * Isolation VMs).
>    165	 */
>    166	static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>    167	{
>    168		void *vaddr = NULL;
>    169	
>    170		if (swiotlb_unencrypted_base) {
>    171			phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
>    172	
>    173			vaddr = memremap(paddr, bytes, MEMREMAP_WB);
>    174			if (!vaddr)
>    175				pr_err("Failed to map the unencrypted memory %llx size %lx.\n",
>  > 176				       paddr, bytes);

According to printk-format.rst, printing phys_addr_t should use %pa. And
paddr should be passed by reference.

I will fold in the following snippet to the offending patch.

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1b0501fd3e0e..b36c1cdd0c4f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -172,8 +172,8 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)

                vaddr = memremap(paddr, bytes, MEMREMAP_WB);
                if (!vaddr)
-                       pr_err("Failed to map the unencrypted memory %llx size %lx.\n",
-                              paddr, bytes);
+                       pr_err("Failed to map the unencrypted memory %pa size %lx.\n",
+                              &paddr, bytes);
        }

        return vaddr;



>    177		}
>    178	
>    179		return vaddr;
>    180	}
>    181	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
