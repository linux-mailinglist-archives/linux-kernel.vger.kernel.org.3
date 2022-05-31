Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3D5389E7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiEaCYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiEaCYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:24:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B739344C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653963893; x=1685499893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kSnyw9CgJPyHsIFzt0F4jrpcLwNhXp7QmRJvAg4Hfug=;
  b=aGYKYrGKltGSSor+4V5C4k5RAFiqkCW5M0uzSKHmLR8bYPpiY8EYi8WH
   1Hu9HyYmRyz8lmTN1yRjZdjmLNYDeWhtPtHpP7LvO4YMD1v+TrI7wc40i
   n7ngy6XzB7/Qi2Iziaslk2PsO8+ATEckf8gbjFiUOdjfLAPDpw+fWZp+O
   7SCfEszBt+jSODpqBW0PfAjos+Z9o//+65EUz2zGNHe8i49sh90Ycef9i
   kW4R8nZZBGvDx+tIPHwqtBKbqz56oW3lQziaap5viyEygjUSlBuZENEeO
   od1MEKtWFHnfQeEyCgmNCzZqRMJWiQYKCz1xNoObq3R4iresxwXIatpgw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="361493419"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="361493419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 19:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="562120527"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2022 19:24:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvrYw-0002E0-QM;
        Tue, 31 May 2022 02:24:50 +0000
Date:   Tue, 31 May 2022 10:24:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 19/20]
 drivers/infiniband/sw/siw/siw_qp_tx.c:545:45: error: use of undeclared
 identifier 'unintptr_t'
Message-ID: <202205311028.2XN0vbvg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   eae5a86aafbe4bfbcb5c21b271073b014626a472
commit: d636d650bc9e9d1966fbc3b163c5f97db5ef5dc5 [19/20] RDMA/siw: Pass a pointer to virt_to_page()
config: arm-randconfig-r033-20220530 (https://download.01.org/0day-ci/archive/20220531/202205311028.2XN0vbvg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=d636d650bc9e9d1966fbc3b163c5f97db5ef5dc5
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout d636d650bc9e9d1966fbc3b163c5f97db5ef5dc5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/infiniband/sw/siw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/infiniband/sw/siw/siw_qp_tx.c:545:45: error: use of undeclared identifier 'unintptr_t'
                                   page_array[seg] = virt_to_page((void *)(unintptr_t)(va & PAGE_MASK));
                                                                           ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +/unintptr_t +545 drivers/infiniband/sw/siw/siw_qp_tx.c

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
   538					/*
   539					 * virt_to_page() takes a (void *) pointer, and the va being uint64
   540					 * creates a special problem here needing a double cast to resolve the
   541					 * situation: first to (uintptr_t) to preserve all the 64 bits and from
   542					 * there to a (void *) meaning it will be 64 bits on a 64 bit platform
   543					 * and 32 bits on a 32 bit platform.
   544					 */
 > 545					page_array[seg] = virt_to_page((void *)(unintptr_t)(va & PAGE_MASK));
   546					if (do_crc)
   547						crypto_shash_update(
   548							c_tx->mpa_crc_hd,
   549							(void *)(uintptr_t)va,
   550							plen);
   551				}
   552	
   553				sge_len -= plen;
   554				sge_off += plen;
   555				data_len -= plen;
   556				fp_off = 0;
   557	
   558				if (++seg > (int)MAX_ARRAY) {
   559					siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
   560					siw_unmap_pages(iov, kmap_mask, seg-1);
   561					wqe->processed -= c_tx->bytes_unsent;
   562					rv = -EMSGSIZE;
   563					goto done_crc;
   564				}
   565			}
   566	sge_done:
   567			/* Update SGE variables at end of SGE */
   568			if (sge_off == sge->length &&
   569			    (data_len != 0 || wqe->processed < wqe->bytes)) {
   570				sge_idx++;
   571				sge++;
   572				sge_off = 0;
   573			}
   574		}
   575		/* trailer */
   576		if (likely(c_tx->state != SIW_SEND_TRAILER)) {
   577			iov[seg].iov_base = &c_tx->trailer.pad[4 - c_tx->pad];
   578			iov[seg].iov_len = trl_len = MAX_TRAILER - (4 - c_tx->pad);
   579		} else {
   580			iov[seg].iov_base = &c_tx->trailer.pad[c_tx->ctrl_sent];
   581			iov[seg].iov_len = trl_len = MAX_TRAILER - c_tx->ctrl_sent;
   582		}
   583	
   584		if (c_tx->pad) {
   585			*(u32 *)c_tx->trailer.pad = 0;
   586			if (do_crc)
   587				crypto_shash_update(c_tx->mpa_crc_hd,
   588					(u8 *)&c_tx->trailer.crc - c_tx->pad,
   589					c_tx->pad);
   590		}
   591		if (!c_tx->mpa_crc_hd)
   592			c_tx->trailer.crc = 0;
   593		else if (do_crc)
   594			crypto_shash_final(c_tx->mpa_crc_hd, (u8 *)&c_tx->trailer.crc);
   595	
   596		data_len = c_tx->bytes_unsent;
   597	
   598		if (c_tx->use_sendpage) {
   599			rv = siw_0copy_tx(s, page_array, &wqe->sqe.sge[c_tx->sge_idx],
   600					  c_tx->sge_off, data_len);
   601			if (rv == data_len) {
   602				rv = kernel_sendmsg(s, &msg, &iov[seg], 1, trl_len);
   603				if (rv > 0)
   604					rv += data_len;
   605				else
   606					rv = data_len;
   607			}
   608		} else {
   609			rv = kernel_sendmsg(s, &msg, iov, seg + 1,
   610					    hdr_len + data_len + trl_len);
   611			siw_unmap_pages(iov, kmap_mask, seg);
   612		}
   613		if (rv < (int)hdr_len) {
   614			/* Not even complete hdr pushed or negative rv */
   615			wqe->processed -= data_len;
   616			if (rv >= 0) {
   617				c_tx->ctrl_sent += rv;
   618				rv = -EAGAIN;
   619			}
   620			goto done_crc;
   621		}
   622		rv -= hdr_len;
   623	
   624		if (rv >= (int)data_len) {
   625			/* all user data pushed to TCP or no data to push */
   626			if (data_len > 0 && wqe->processed < wqe->bytes) {
   627				/* Save the current state for next tx */
   628				c_tx->sge_idx = sge_idx;
   629				c_tx->sge_off = sge_off;
   630				c_tx->pbl_idx = pbl_idx;
   631			}
   632			rv -= data_len;
   633	
   634			if (rv == trl_len) /* all pushed */
   635				rv = 0;
   636			else {
   637				c_tx->state = SIW_SEND_TRAILER;
   638				c_tx->ctrl_len = MAX_TRAILER;
   639				c_tx->ctrl_sent = rv + 4 - c_tx->pad;
   640				c_tx->bytes_unsent = 0;
   641				rv = -EAGAIN;
   642			}
   643	
   644		} else if (data_len > 0) {
   645			/* Maybe some user data pushed to TCP */
   646			c_tx->state = SIW_SEND_DATA;
   647			wqe->processed -= data_len - rv;
   648	
   649			if (rv) {
   650				/*
   651				 * Some bytes out. Recompute tx state based
   652				 * on old state and bytes pushed
   653				 */
   654				unsigned int sge_unsent;
   655	
   656				c_tx->bytes_unsent -= rv;
   657				sge = &wqe->sqe.sge[c_tx->sge_idx];
   658				sge_unsent = sge->length - c_tx->sge_off;
   659	
   660				while (sge_unsent <= rv) {
   661					rv -= sge_unsent;
   662					c_tx->sge_idx++;
   663					c_tx->sge_off = 0;
   664					sge++;
   665					sge_unsent = sge->length;
   666				}
   667				c_tx->sge_off += rv;
   668			}
   669			rv = -EAGAIN;
   670		}
   671	done_crc:
   672		c_tx->do_crc = 0;
   673	done:
   674		return rv;
   675	}
   676	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
