Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301FB530F03
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiEWM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiEWM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:27:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BABE28732
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653308833; x=1684844833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6CfERtsws+Gj28nSy2CEOaYTZ4KWySHnl7bWXNV4Kic=;
  b=NJAXEwHcGqusu9xjtNoiWA9Pw3hHHfEzHB9iPxqX+aU7THHaxCvD26C4
   nXeTaNCrvrFB7KB2oyGh8vy3bHWYuAuxqqQgrg9DNS/smLrLKz8A1oV6x
   RrDOxmewb9y9EPPON6kiy9W4MrXXtwmbX86V9BOcMlK/fY83OD+4D1gMz
   lCcdil02eiBNfQ2ScmbwzYfL7XnjhZWphgZMJP+18r1p4VDiw2Jh/yYJU
   8B79AYM8CLzCZUXZ8PZ8rytywdSwPKddgC9y46EONbU9g/xOn0M5yX7mv
   GFFhmlRY2/NCfcbAHYPPpTtem9WCCq2HxkqaYdLBUgJmzrp/4yqPYK8Og
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="272020846"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="272020846"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 05:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="608172939"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2022 05:26:57 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nt79E-00018i-QX;
        Mon, 23 May 2022 12:26:56 +0000
Date:   Mon, 23 May 2022 20:26:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 17/17]
 drivers/infiniband/sw/siw/siw_qp_tx.c:538:64: warning: cast to pointer from
 integer of different size
Message-ID: <202205232058.LX5UfEJ1-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   a9b76a04739b5b4dbad86664342c8945e83d8e95
commit: a9b76a04739b5b4dbad86664342c8945e83d8e95 [17/17] RDMA/siw: Pass a pointer to virt_to_page()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220523/202205232058.LX5UfEJ1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=a9b76a04739b5b4dbad86664342c8945e83d8e95
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout a9b76a04739b5b4dbad86664342c8945e83d8e95
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/infiniband/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/page_mm.h:137,
                    from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:256,
                    from include/linux/once.h:6,
                    from include/linux/random.h:9,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
>> drivers/infiniband/sw/siw/siw_qp_tx.c:538:64: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     538 |                                 page_array[seg] = virt_to_page((void *)(va & PAGE_MASK));
         |                                                                ^
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/m68k/include/asm/page_mm.h:124:34: note: in expansion of macro '__pa'
     124 | #define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
         |                                  ^~~~
   arch/m68k/include/asm/page_mm.h:130:21: note: in expansion of macro 'virt_to_pfn'
     130 |         pfn_to_page(virt_to_pfn(addr));                                 \
         |                     ^~~~~~~~~~~
   drivers/infiniband/sw/siw/siw_qp_tx.c:538:51: note: in expansion of macro 'virt_to_page'
     538 |                                 page_array[seg] = virt_to_page((void *)(va & PAGE_MASK));
         |                                                   ^~~~~~~~~~~~


vim +538 drivers/infiniband/sw/siw/siw_qp_tx.c

   426	
   427	/*
   428	 * Write out iov referencing hdr, data and trailer of current FPDU.
   429	 * Update transmit state dependent on write return status
   430	 */
   431	static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
   432	{
   433		struct siw_wqe *wqe = &c_tx->wqe_active;
   434		struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
   435		struct kvec iov[MAX_ARRAY];
   436		struct page *page_array[MAX_ARRAY];
   437		struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
   438	
   439		int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
   440		unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len = 0,
   441			     sge_off = c_tx->sge_off, sge_idx = c_tx->sge_idx,
   442			     pbl_idx = c_tx->pbl_idx;
   443		unsigned long kmap_mask = 0L;
   444	
   445		if (c_tx->state == SIW_SEND_HDR) {
   446			if (c_tx->use_sendpage) {
   447				rv = siw_tx_ctrl(c_tx, s, MSG_DONTWAIT | MSG_MORE);
   448				if (rv)
   449					goto done;
   450	
   451				c_tx->state = SIW_SEND_DATA;
   452			} else {
   453				iov[0].iov_base =
   454					(char *)&c_tx->pkt.ctrl + c_tx->ctrl_sent;
   455				iov[0].iov_len = hdr_len =
   456					c_tx->ctrl_len - c_tx->ctrl_sent;
   457				seg = 1;
   458			}
   459		}
   460	
   461		wqe->processed += data_len;
   462	
   463		while (data_len) { /* walk the list of SGE's */
   464			unsigned int sge_len = min(sge->length - sge_off, data_len);
   465			unsigned int fp_off = (sge->laddr + sge_off) & ~PAGE_MASK;
   466			struct siw_mem *mem;
   467	
   468			if (!(tx_flags(wqe) & SIW_WQE_INLINE)) {
   469				mem = wqe->mem[sge_idx];
   470				is_kva = mem->mem_obj == NULL ? 1 : 0;
   471			} else {
   472				is_kva = 1;
   473			}
   474			if (is_kva && !c_tx->use_sendpage) {
   475				/*
   476				 * tx from kernel virtual address: either inline data
   477				 * or memory region with assigned kernel buffer
   478				 */
   479				iov[seg].iov_base =
   480					(void *)(uintptr_t)(sge->laddr + sge_off);
   481				iov[seg].iov_len = sge_len;
   482	
   483				if (do_crc)
   484					crypto_shash_update(c_tx->mpa_crc_hd,
   485							    iov[seg].iov_base,
   486							    sge_len);
   487				sge_off += sge_len;
   488				data_len -= sge_len;
   489				seg++;
   490				goto sge_done;
   491			}
   492	
   493			while (sge_len) {
   494				size_t plen = min((int)PAGE_SIZE - fp_off, sge_len);
   495				void *kaddr;
   496	
   497				if (!is_kva) {
   498					struct page *p;
   499	
   500					if (mem->is_pbl)
   501						p = siw_get_pblpage(
   502							mem, sge->laddr + sge_off,
   503							&pbl_idx);
   504					else
   505						p = siw_get_upage(mem->umem,
   506								  sge->laddr + sge_off);
   507					if (unlikely(!p)) {
   508						siw_unmap_pages(iov, kmap_mask, seg);
   509						wqe->processed -= c_tx->bytes_unsent;
   510						rv = -EFAULT;
   511						goto done_crc;
   512					}
   513					page_array[seg] = p;
   514	
   515					if (!c_tx->use_sendpage) {
   516						void *kaddr = kmap_local_page(p);
   517	
   518						/* Remember for later kunmap() */
   519						kmap_mask |= BIT(seg);
   520						iov[seg].iov_base = kaddr + fp_off;
   521						iov[seg].iov_len = plen;
   522	
   523						if (do_crc)
   524							crypto_shash_update(
   525								c_tx->mpa_crc_hd,
   526								iov[seg].iov_base,
   527								plen);
   528					} else if (do_crc) {
   529						kaddr = kmap_local_page(p);
   530						crypto_shash_update(c_tx->mpa_crc_hd,
   531								    kaddr + fp_off,
   532								    plen);
   533						kunmap_local(kaddr);
   534					}
   535				} else {
   536					u64 va = sge->laddr + sge_off;
   537	
 > 538					page_array[seg] = virt_to_page((void *)(va & PAGE_MASK));
   539					if (do_crc)
   540						crypto_shash_update(
   541							c_tx->mpa_crc_hd,
   542							(void *)(uintptr_t)va,
   543							plen);
   544				}
   545	
   546				sge_len -= plen;
   547				sge_off += plen;
   548				data_len -= plen;
   549				fp_off = 0;
   550	
   551				if (++seg > (int)MAX_ARRAY) {
   552					siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
   553					siw_unmap_pages(iov, kmap_mask, seg-1);
   554					wqe->processed -= c_tx->bytes_unsent;
   555					rv = -EMSGSIZE;
   556					goto done_crc;
   557				}
   558			}
   559	sge_done:
   560			/* Update SGE variables at end of SGE */
   561			if (sge_off == sge->length &&
   562			    (data_len != 0 || wqe->processed < wqe->bytes)) {
   563				sge_idx++;
   564				sge++;
   565				sge_off = 0;
   566			}
   567		}
   568		/* trailer */
   569		if (likely(c_tx->state != SIW_SEND_TRAILER)) {
   570			iov[seg].iov_base = &c_tx->trailer.pad[4 - c_tx->pad];
   571			iov[seg].iov_len = trl_len = MAX_TRAILER - (4 - c_tx->pad);
   572		} else {
   573			iov[seg].iov_base = &c_tx->trailer.pad[c_tx->ctrl_sent];
   574			iov[seg].iov_len = trl_len = MAX_TRAILER - c_tx->ctrl_sent;
   575		}
   576	
   577		if (c_tx->pad) {
   578			*(u32 *)c_tx->trailer.pad = 0;
   579			if (do_crc)
   580				crypto_shash_update(c_tx->mpa_crc_hd,
   581					(u8 *)&c_tx->trailer.crc - c_tx->pad,
   582					c_tx->pad);
   583		}
   584		if (!c_tx->mpa_crc_hd)
   585			c_tx->trailer.crc = 0;
   586		else if (do_crc)
   587			crypto_shash_final(c_tx->mpa_crc_hd, (u8 *)&c_tx->trailer.crc);
   588	
   589		data_len = c_tx->bytes_unsent;
   590	
   591		if (c_tx->use_sendpage) {
   592			rv = siw_0copy_tx(s, page_array, &wqe->sqe.sge[c_tx->sge_idx],
   593					  c_tx->sge_off, data_len);
   594			if (rv == data_len) {
   595				rv = kernel_sendmsg(s, &msg, &iov[seg], 1, trl_len);
   596				if (rv > 0)
   597					rv += data_len;
   598				else
   599					rv = data_len;
   600			}
   601		} else {
   602			rv = kernel_sendmsg(s, &msg, iov, seg + 1,
   603					    hdr_len + data_len + trl_len);
   604			siw_unmap_pages(iov, kmap_mask, seg);
   605		}
   606		if (rv < (int)hdr_len) {
   607			/* Not even complete hdr pushed or negative rv */
   608			wqe->processed -= data_len;
   609			if (rv >= 0) {
   610				c_tx->ctrl_sent += rv;
   611				rv = -EAGAIN;
   612			}
   613			goto done_crc;
   614		}
   615		rv -= hdr_len;
   616	
   617		if (rv >= (int)data_len) {
   618			/* all user data pushed to TCP or no data to push */
   619			if (data_len > 0 && wqe->processed < wqe->bytes) {
   620				/* Save the current state for next tx */
   621				c_tx->sge_idx = sge_idx;
   622				c_tx->sge_off = sge_off;
   623				c_tx->pbl_idx = pbl_idx;
   624			}
   625			rv -= data_len;
   626	
   627			if (rv == trl_len) /* all pushed */
   628				rv = 0;
   629			else {
   630				c_tx->state = SIW_SEND_TRAILER;
   631				c_tx->ctrl_len = MAX_TRAILER;
   632				c_tx->ctrl_sent = rv + 4 - c_tx->pad;
   633				c_tx->bytes_unsent = 0;
   634				rv = -EAGAIN;
   635			}
   636	
   637		} else if (data_len > 0) {
   638			/* Maybe some user data pushed to TCP */
   639			c_tx->state = SIW_SEND_DATA;
   640			wqe->processed -= data_len - rv;
   641	
   642			if (rv) {
   643				/*
   644				 * Some bytes out. Recompute tx state based
   645				 * on old state and bytes pushed
   646				 */
   647				unsigned int sge_unsent;
   648	
   649				c_tx->bytes_unsent -= rv;
   650				sge = &wqe->sqe.sge[c_tx->sge_idx];
   651				sge_unsent = sge->length - c_tx->sge_off;
   652	
   653				while (sge_unsent <= rv) {
   654					rv -= sge_unsent;
   655					c_tx->sge_idx++;
   656					c_tx->sge_off = 0;
   657					sge++;
   658					sge_unsent = sge->length;
   659				}
   660				c_tx->sge_off += rv;
   661			}
   662			rv = -EAGAIN;
   663		}
   664	done_crc:
   665		c_tx->do_crc = 0;
   666	done:
   667		return rv;
   668	}
   669	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
