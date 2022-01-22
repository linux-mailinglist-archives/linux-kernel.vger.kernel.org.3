Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AEC496991
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiAVD0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:26:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:27490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbiAVD0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642821977; x=1674357977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iYl05RWrZMzA38CfBGX+HO8IiuDGcGTRWlM/Sy30iqo=;
  b=h7NTBZVtXHEuKfovJXOQ5e2uY3aT53T/Tkb64Rv2JLt7jeCn/YusJCKL
   BrHGV5zu1SjGoA4kN+kXVvRq3DgeyGWhx8Md0I6uXkfo77JO6WvocM2Zc
   9mrqQ5B+FKhdFuI0IfAeTTgMoA4xoeooezyRa9coY4VGJl9QJrRcSZZgO
   c3+7HEwRgsErPLhYb6aSD1djurleLEQEEqMjnpIk35tb9nREDKBUQlrMY
   UMFJEVAaou+2Zc0XyGSZ9q1Q7cklakpz1XQTfFzVbdBTh/r/UOj9IcOQK
   hL2hh31nL6UsDwm9ev2Hpyc3OBCd+nVCX0nA58G2KIoLjWpJVOeKYxtMz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="306503592"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="306503592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 19:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="694845717"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 19:26:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB72c-000Fxy-K6; Sat, 22 Jan 2022 03:26:14 +0000
Date:   Sat, 22 Jan 2022 11:26:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander K <ak@tempesta-tech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:topic-rpc-with-tls 9993/9999] net/tls/crypto.c:252:42: warning:
 suggest braces around empty body in an 'if' statement
Message-ID: <202201221103.a0Ov4OZp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls
head:   a72d5318846d67a7f3f5f2bcb4c0c09c4f8907d1
commit: e0ae63faa3340c31e8457c7a2b9e8210955dd42c [9993/9999] Move headers, required for other modules, to include/net/tls/
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20220122/202201221103.a0Ov4OZp-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=e0ae63faa3340c31e8457c7a2b9e8210955dd42c
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls
        git checkout e0ae63faa3340c31e8457c7a2b9e8210955dd42c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash net/tls/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   net/tls/crypto.c: In function 'ttls_md_starts':
>> net/tls/crypto.c:252:42: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     252 |   T_DBG("cannot start hash ctx, %d\n", r);
         |                                          ^
   net/tls/crypto.c: In function 'ttls_md_update':
   net/tls/crypto.c:266:43: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     266 |   T_DBG("cannot update hash ctx, %d\n", r);
         |                                           ^
   net/tls/crypto.c: In function 'ttls_md_finish':
   net/tls/crypto.c:280:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     280 |   T_DBG("cannot finish hash context, %d\n", r);
         |                                               ^
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
>> net/tls/ec_25519.c:137:1: warning: no previous prototype for 'ecp_mod_p255' [-Wmissing-prototypes]
     137 | ecp_mod_p255(TlsMpi *N)
         | ^~~~~~~~~~~~
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
>> net/tls/ec_p256.c:1412:1: warning: no previous prototype for 'ecp256_gen_keypair' [-Wmissing-prototypes]
    1412 | ecp256_gen_keypair(TlsMpi *d, TlsEcpPoint *Q)
         | ^~~~~~~~~~~~~~~~~~
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   net/tls/mpool.c: In function 'ttls_mpi_pool_free':
>> net/tls/mpool.c:185:29: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     185 |         mp->order, mp->curr);
         |                             ^
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   net/tls/pkparse.c: In function 'pk_parse_key_sec1_der':
>> net/tls/pkparse.c:419:18: warning: variable 'pubkey_done' set but not used [-Wunused-but-set-variable]
     419 |  int r, version, pubkey_done;
         |                  ^~~~~~~~~~~
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
>> net/tls/rsa.c:255:1: warning: no previous prototype for 'ttls_rsa_deduce_primes' [-Wmissing-prototypes]
     255 | ttls_rsa_deduce_primes(TlsMpi const *N, TlsMpi const *E, TlsMpi const *D,
         | ^~~~~~~~~~~~~~~~~~~~~~
>> net/tls/rsa.c:371:1: warning: no previous prototype for 'ttls_rsa_deduce_private_exponent' [-Wmissing-prototypes]
     371 | ttls_rsa_deduce_private_exponent(TlsMpi const *P, TlsMpi const *Q,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/tls/rsa.c:414:1: warning: no previous prototype for 'ttls_rsa_deduce_crt' [-Wmissing-prototypes]
     414 | ttls_rsa_deduce_crt(const TlsMpi *P, const TlsMpi *Q, const TlsMpi *D,
         | ^~~~~~~~~~~~~~~~~~~
>> net/tls/rsa.c:1376:1: warning: no previous prototype for 'ttls_rsa_rsassa_pss_verify' [-Wmissing-prototypes]
    1376 | ttls_rsa_rsassa_pss_verify(TlsRSACtx *ctx, ttls_md_type_t md_alg,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   net/tls/tls_srv.c: In function 'ttls_process_session_ticket':
>> net/tls/tls_srv.c:323:54: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
     323 |    T_DBG("ClientHello: cannot parse ticket, %d\n", r);
         |                                                      ^
   net/tls/tls_srv.c: In function 'ttls_write_certificate_request':
>> net/tls/tls_srv.c:1503:6: warning: variable 'authmode' set but not used [-Wunused-but-set-variable]
    1503 |  int authmode;
         |      ^~~~~~~~
   net/tls/tls_srv.c: In function 'ttls_parse_client_key_exchange':
>> net/tls/tls_srv.c:1786:52: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1786 |   T_DBG("KeyExchange: cannot derive keys, %d\n", r);
         |                                                    ^
   net/tls/tls_srv.c: In function 'ttls_parse_certificate_verify':
   net/tls/tls_srv.c:1880:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1880 |   T_DBG("cannot verify pk, %d\n", r);
         |                                     ^
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   net/tls/tls_ticket.c: In function 'ttls_tickets_init':
>> net/tls/tls_ticket.c:385:1: warning: old-style function definition [-Wold-style-definition]
     385 | ttls_tickets_init()
         | ^~~~~~~~~~~~~~~~~
   net/tls/tls_ticket.c: In function 'ttls_tickets_exit':
   net/tls/tls_ticket.c:406:6: warning: old-style function definition [-Wold-style-definition]
     406 | void ttls_tickets_exit()
         |      ^~~~~~~~~~~~~~~~~
--
   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   net/tls/ttls.c: In function '__ttls_send_record':
>> net/tls/ttls.c:1036:43: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1036 |   T_DBG("TLS send callback error %d\n", r);
         |                                           ^
   net/tls/ttls.c: At top level:
>> net/tls/ttls.c:1295:1: warning: no previous prototype for 'ttls_handle_alert' [-Wmissing-prototypes]
    1295 | ttls_handle_alert(TlsCtx *tls)
         | ^~~~~~~~~~~~~~~~~
   net/tls/ttls.c: In function 'ttls_parse_certificate':
   net/tls/ttls.c:1587:53: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1587 |    T_DBG("client cert verification status: %d\n", r);
         |                                                     ^
   net/tls/ttls.c: At top level:
>> net/tls/ttls.c:2461:1: warning: no previous prototype for 'ttls_sig_hash_set_has' [-Wmissing-prototypes]
    2461 | ttls_sig_hash_set_has(TlsSigHashSet *set, ttls_pk_type_t sig_alg,
         | ^~~~~~~~~~~~~~~~~~~~~
>> net/tls/ttls.c:2475:1: warning: no previous prototype for 'ttls_sig_hash_set_const' [-Wmissing-prototypes]
    2475 | ttls_sig_hash_set_const(TlsSigHashSet *set, ttls_pk_type_t sig_alg,
         | ^~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_CORE
   Depends on HAS_IOMEM
   Selected by
   - MFD_HI6421_SPMI && STAGING && OF && SPMI
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1_SSSE3
   Depends on CRYPTO && X86 && 64BIT
   Selected by
   - TLS_HANDSHAKE && NET && TLS


vim +/if +252 net/tls/crypto.c

a0a99a10f4f0e3 Alexander K 2021-09-27  242  
a0a99a10f4f0e3 Alexander K 2021-09-27  243  int
a0a99a10f4f0e3 Alexander K 2021-09-27  244  ttls_md_starts(TlsMdCtx *ctx)
a0a99a10f4f0e3 Alexander K 2021-09-27  245  {
a0a99a10f4f0e3 Alexander K 2021-09-27  246  	int r;
a0a99a10f4f0e3 Alexander K 2021-09-27  247  
a0a99a10f4f0e3 Alexander K 2021-09-27  248  	BUG_ON(!ctx || !ctx->md_info);
a0a99a10f4f0e3 Alexander K 2021-09-27  249  
a0a99a10f4f0e3 Alexander K 2021-09-27  250  	r = crypto_shash_init(&ctx->md_ctx);
a0a99a10f4f0e3 Alexander K 2021-09-27  251  	if (r)
a0a99a10f4f0e3 Alexander K 2021-09-27 @252  		T_DBG("cannot start hash ctx, %d\n", r);
a0a99a10f4f0e3 Alexander K 2021-09-27  253  
a0a99a10f4f0e3 Alexander K 2021-09-27  254  	return r;
a0a99a10f4f0e3 Alexander K 2021-09-27  255  }
a0a99a10f4f0e3 Alexander K 2021-09-27  256  

:::::: The code at line 252 was first introduced by commit
:::::: a0a99a10f4f0e3e1e35e566687137669da78abcd Port of Tempesta TLS handshakes to the Linux 5.10.68

:::::: TO: Alexander K <ak@tempesta-tech.com>
:::::: CC: Chuck Lever <chuck.lever@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
