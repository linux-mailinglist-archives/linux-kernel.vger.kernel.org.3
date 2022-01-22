Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80561496CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 15:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiAVOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 09:14:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:27571 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233792AbiAVOOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 09:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642860881; x=1674396881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f0Prtj+CZTne/z/9+yKeVngrXfjH6ffCd25xFCC88jA=;
  b=WYxuYIiUUZaamol8jC46ZTNRINguY2RogmexgPn3esK91p4+uwFKswbo
   xD9AJbT+5YDjDOk4x+yBcKphA8if+7tH6jGCpJROUph9csC5vOoFWo19F
   BhEkujTabLiDjphxUzk0oNuo4evgrWzxjJFr1HyLLW/6GUIgTiPj4edJF
   mXh1NN6WG96n05qgALbaCq3t8v4IMfq2qKD7NXwcr/M+Urx9ieG5UQfqR
   Y8+ugNnU3wH2LGW8PyrtgFTSJRLG9RDgJ80aI9nLXiuj6THzYJq37D5PC
   mGRZbs/PvQU2uqlkUW0UNLQnLfQjedAvk8pC4jU9ZpBaW4j53bZ6+jlKG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244647878"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="244647878"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 06:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="533643069"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2022 06:14:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBHA6-000GTL-Mt; Sat, 22 Jan 2022 14:14:38 +0000
Date:   Sat, 22 Jan 2022 22:14:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander K <ak@tempesta-tech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:topic-rpc-with-tls 9995/9999] net/tls/ttls.c:2148:9: error: too
 few arguments to function 'kernel_fpu_begin'
Message-ID: <202201222234.oGj9OPe6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls
head:   a72d5318846d67a7f3f5f2bcb4c0c09c4f8907d1
commit: 88772cc15e58e3bb69ab319d7fb2ed0cdce5a5a1 [9995/9999] Introduce CONFIG_TLS_SOFTIRQ to perform all TLS routines in softirq (fixes #1446).
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220122/202201222234.oGj9OPe6-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=88772cc15e58e3bb69ab319d7fb2ed0cdce5a5a1
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls
        git checkout 88772cc15e58e3bb69ab319d7fb2ed0cdce5a5a1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/tls/ttls.c:28:
   arch/s390/include/asm/fpu/api.h: In function 'kernel_fpu_begin':
   arch/s390/include/asm/fpu/api.h:97:14: error: invalid use of undefined type 'struct kernel_fpu'
      97 |         state->mask = S390_lowcore.fpu_flags;
         |              ^~
   arch/s390/include/asm/fpu/api.h:98:14: error: implicit declaration of function 'test_cpu_flag' [-Werror=implicit-function-declaration]
      98 |         if (!test_cpu_flag(CIF_FPU))
         |              ^~~~~~~~~~~~~
   arch/s390/include/asm/fpu/api.h:98:28: error: 'CIF_FPU' undeclared (first use in this function)
      98 |         if (!test_cpu_flag(CIF_FPU))
         |                            ^~~~~~~
   arch/s390/include/asm/fpu/api.h:98:28: note: each undeclared identifier is reported only once for each function it appears in
   arch/s390/include/asm/fpu/api.h:101:23: error: invalid use of undefined type 'struct kernel_fpu'
     101 |         else if (state->mask & flags)
         |                       ^~
   arch/s390/include/asm/fpu/api.h: In function 'kernel_fpu_end':
   arch/s390/include/asm/fpu/api.h:109:39: error: invalid use of undefined type 'struct kernel_fpu'
     109 |         S390_lowcore.fpu_flags = state->mask;
         |                                       ^~
   arch/s390/include/asm/fpu/api.h:110:18: error: invalid use of undefined type 'struct kernel_fpu'
     110 |         if (state->mask & flags)
         |                  ^~
   In file included from arch/s390/include/asm/smp.h:13,
                    from include/linux/smp.h:85,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from include/crypto/aead.h:11,
                    from net/tls/ttls.c:29:
   arch/s390/include/asm/processor.h: At top level:
   arch/s390/include/asm/processor.h:58:19: error: static declaration of 'test_cpu_flag' follows non-static declaration
      58 | static inline int test_cpu_flag(int flag)
         |                   ^~~~~~~~~~~~~
   In file included from net/tls/ttls.c:28:
   arch/s390/include/asm/fpu/api.h:98:14: note: previous implicit declaration of 'test_cpu_flag' with type 'int()'
      98 |         if (!test_cpu_flag(CIF_FPU))
         |              ^~~~~~~~~~~~~
   net/tls/ttls.c: In function '__ttls_send_record':
   net/tls/ttls.c:1031:57: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1031 |                 T_DBG("TLS send callback error %d\n", r);
         |                                                         ^
   net/tls/ttls.c: At top level:
   net/tls/ttls.c:1290:1: warning: no previous prototype for 'ttls_handle_alert' [-Wmissing-prototypes]
    1290 | ttls_handle_alert(TlsCtx *tls)
         | ^~~~~~~~~~~~~~~~~
   net/tls/ttls.c: In function 'ttls_parse_certificate':
   net/tls/ttls.c:1582:74: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1582 |                         T_DBG("client cert verification status: %d\n", r);
         |                                                                          ^
   net/tls/ttls.c: In function 'ttls_recv':
>> net/tls/ttls.c:2148:9: error: too few arguments to function 'kernel_fpu_begin'
    2148 |         kernel_fpu_begin();
         |         ^~~~~~~~~~~~~~~~
   In file included from net/tls/ttls.c:28:
   arch/s390/include/asm/fpu/api.h:94:20: note: declared here
      94 | static inline void kernel_fpu_begin(struct kernel_fpu *state, u32 flags)
         |                    ^~~~~~~~~~~~~~~~
>> net/tls/ttls.c:2270:9: error: too few arguments to function 'kernel_fpu_end'
    2270 |         kernel_fpu_end();
         |         ^~~~~~~~~~~~~~
   In file included from net/tls/ttls.c:28:
   arch/s390/include/asm/fpu/api.h:107:20: note: declared here
     107 | static inline void kernel_fpu_end(struct kernel_fpu *state, u32 flags)
         |                    ^~~~~~~~~~~~~~
   net/tls/ttls.c: At top level:
   net/tls/ttls.c:2470:1: warning: no previous prototype for 'ttls_sig_hash_set_has' [-Wmissing-prototypes]
    2470 | ttls_sig_hash_set_has(TlsSigHashSet *set, ttls_pk_type_t sig_alg,
         | ^~~~~~~~~~~~~~~~~~~~~
   net/tls/ttls.c:2484:1: warning: no previous prototype for 'ttls_sig_hash_set_const' [-Wmissing-prototypes]
    2484 | ttls_sig_hash_set_const(TlsSigHashSet *set, ttls_pk_type_t sig_alg,
         | ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1_SSSE3
   Depends on CRYPTO && X86 && 64BIT
   Selected by
   - TLS_HANDSHAKE && NET && TLS && TLS_SOFTIRQ


vim +/kernel_fpu_begin +2148 net/tls/ttls.c

  2111	
  2112	/**
  2113	 * Main TLS receive routine.
  2114	 *
  2115	 * Read a record, only one. A caller will call us again if a following record,
  2116	 * or it's part, is left in @buf.
  2117	 *
  2118	 * Silently ignore non-fatal alert and continue reading until a valid record is
  2119	 * found.
  2120	 *
  2121	 * @buf and @len defines a chunk of ingress network data, probably containing
  2122	 * parts of several TLS messages, e.g. a tail of last message, a short full
  2123	 * message and a begin of a next message.
  2124	 *
  2125	 * @return -EAGAIN if there is no ready data for upper layer (e.g. during
  2126	 * handshake or current record isn't fully read) and T_PASS if a record is ready
  2127	 * for upper layer protocol processing. Other negative values are returned on
  2128	 * errors.
  2129	 * The function adds the number of bytes parsed in @buf to @read.
  2130	 */
  2131	int
  2132	ttls_recv(void *tls_data, unsigned char *buf, size_t len, unsigned int *read)
  2133	{
  2134		int r;
  2135		unsigned int hh_len = 0, parsed = *read;
  2136		TlsCtx *tls = (TlsCtx *)tls_data;
  2137		TlsIOCtx *io = &tls->io_in;
  2138	
  2139		BUG_ON(!tls || !tls->conf);
  2140		T_DBG3("%s: tls=%pK len=%lu read=%u\n", __func__, tls, len, *read);
  2141	
  2142		/*
  2143		 * There are many code executed under the saved FPU context and
  2144		 * probably we won't call SIMD at all. However, in normal case
  2145		 * we do several crypto operations requiring SIMD and we do our
  2146		 * best to minimize the number of FPU context savings and restorings.
  2147		 */
> 2148		kernel_fpu_begin();
  2149	
  2150		if (!(io->st_flags & TTLS_F_ST_HDRIV)) {
  2151			unsigned int delta;
  2152	
  2153			if ((r = ttls_parse_record_hdr(tls, buf, len, read)))
  2154				goto out;
  2155			delta = *read - parsed;
  2156			len -= delta;
  2157			buf += delta;
  2158			parsed = *read;
  2159	
  2160			if (io->msgtype == TTLS_MSG_HANDSHAKE
  2161			    && ttls_hs_checksumable(tls))
  2162			{
  2163				if (likely(delta >= TTLS_HS_HDR_LEN && len > 0)) {
  2164					/*
  2165					 * Compute handshake checksum for the message
  2166					 * body and handshake header in one shot.
  2167					 */
  2168					hh_len = TTLS_HS_HDR_LEN;
  2169				} else {
  2170					ttls_update_checksum(tls, io->hs_hdr,
  2171							     TTLS_HS_HDR_LEN);
  2172				}
  2173			}
  2174		}
  2175		WARN_ON_ONCE(!io->msglen);
  2176	
  2177		/*
  2178		 * Current record is fully read and decrypted if necessary.
  2179		 * Skip alerts and empty records and read a next one.
  2180		 */
  2181		switch (io->msgtype) {
  2182		case TTLS_MSG_ALERT:
  2183			if (unlikely(!ttls_xfrm_ready(tls))) {
  2184				r = ttls_handle_alert(tls);
  2185				goto out;
  2186			}
  2187			break;
  2188	
  2189		case TTLS_MSG_CHANGE_CIPHER_SPEC:
  2190			/* Parsed as part of handshake FSM. */
  2191		case TTLS_MSG_HANDSHAKE:
  2192			if (!len) {
  2193				r = -EAGAIN;
  2194				goto out;
  2195			}
  2196			if (unlikely(tls->state == TTLS_HANDSHAKE_OVER)) {
  2197				T_DBG("refusing renegotiation, sending alert\n");
  2198				ttls_send_alert(tls, TTLS_ALERT_LEVEL_FATAL,
  2199						TTLS_ALERT_MSG_NO_RENEGOTIATION);
  2200				r = TTLS_ERR_UNEXPECTED_MESSAGE;
  2201				goto out;
  2202			}
  2203	
  2204			/*
  2205			 * We add ingress messages to the handshake session checksum
  2206			 * in two different places: here for message chunks and inside
  2207			 * the handshake state machine. @hh_len is used for the
  2208			 * checksumming only. We can not compute checksum for complete
  2209			 * messages here (either before or after the FSM call) because
  2210			 * before Hello message we have no idea which hash algorithm
  2211			 * we should use, but key derieval on KeyExchange phase may
  2212			 * require complete checksum for all the messages including
  2213			 * the KeyExchange one.
  2214			 */
  2215			r = ttls_handshake_step(tls, buf, len, hh_len, read);
  2216	
  2217			/* Cleanup security sensitive temporary data. */
  2218			ttls_mpi_pool_cleanup_ctx(0, true);
  2219	
  2220			if (r == -EAGAIN) {
  2221				/* Add the handshake message chunk to the checksum. */
  2222				BUG_ON(!tls->hs && tls->state != TTLS_HANDSHAKE_OVER);
  2223				if (ttls_hs_checksumable(tls)) {
  2224					size_t n = *read - (int)parsed + hh_len;
  2225					ttls_update_checksum(tls, buf - hh_len, n);
  2226				}
  2227			}
  2228			else if (r) {
  2229				T_DBG("handshake error: %d\n", r);
  2230			}
  2231			goto out;
  2232	
  2233		case TTLS_MSG_APPLICATION_DATA:
  2234			/*
  2235			 * Don't allow application data before secured connection is
  2236			 * established.
  2237			 */
  2238			if (unlikely(tls->state != TTLS_HANDSHAKE_OVER)) {
  2239				T_WARN("TLS context isn't ready after handshake\n");
  2240				r = -EPROTO;
  2241				goto out;
  2242			}
  2243			break;
  2244		}
  2245	
  2246		if (!len) {
  2247			r = -EAGAIN;
  2248			goto out;
  2249		}
  2250	
  2251		/* Encrypted data, crypto context is guaranteed to be ready here. */
  2252		if (io->msglen > io->rlen + len) {
  2253			*read += len;
  2254			io->rlen += len;
  2255			r = -EAGAIN;
  2256			goto out;
  2257		}
  2258		*read += io->msglen - io->rlen;
  2259		if ((r = ttls_decrypt(tls, NULL))) {
  2260			T_DBG("cannot decrypt msg on state %x, ret=%d%s\n",
  2261			      tls->state, r, r == -EBADMSG ? "(bad ciphertext)" : "");
  2262			r = -EPROTO;
  2263			goto out;
  2264		}
  2265	
  2266		if (io->msgtype == TTLS_MSG_ALERT)
  2267			r = ttls_handle_alert(tls);
  2268	
  2269	out:
> 2270		kernel_fpu_end();
  2271	
  2272		return r;
  2273	}
  2274	EXPORT_SYMBOL(ttls_recv);
  2275	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
