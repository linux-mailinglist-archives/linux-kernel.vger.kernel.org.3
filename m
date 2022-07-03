Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA45645CE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGCIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGCIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:31:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D638A2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656837101; x=1688373101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EXOAGAag4EuDsuK3ii+/8wi3GH4aNtp9grYpzrauxNU=;
  b=A8Y89JZEoCglXcMpOjmA0ikdAIBqWNqy4YapoMLXglIPy4ODuCtZ6aoQ
   2ygZglgEnzib6Iy7MExCVwylFD5p0NB5XqA9UHlvI3T576/qPam3ayygR
   51XzbCFEvaXN7t6pLaMahx3j24QEI6nv1hZp3gKKAlD3INSo6nwwrPUAg
   abSaP47VoHoPzHI1tJANL7tNrZvafxi9m92whA5a2aQ2aajX+O8LM/C4J
   WHhB3qAdbEcB7EpeOpgA9AKU32OAiV6Zgr0R5I/hKHRuF4essCbyV+HNM
   2d0Z92UdvA+r7TsWGDCtDLF+Hz/VKRGnKiNfPqqMcaargbkAXtTaoPTQz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="283652896"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="283652896"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 01:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="618893345"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2022 01:31:38 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7v10-000GG7-5P;
        Sun, 03 Jul 2022 08:31:38 +0000
Date:   Sun, 3 Jul 2022 16:31:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Biggers <ebiggers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: crypto/testmgr.c:297:8: warning: Excessive padding in 'struct
 testvec_config' (5 padding bytes, where 1 is optimal). Optimal fields order:
 name, inplace_mode, req_flags, iv_offset, key_offset, finalization_type,
 src_divs, dst_divs, iv_offset_relative_to_a...
Message-ID: <202207031600.5xQNJyk8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69cb6c6556ad89620547318439d6be8bb1629a5a
commit: f17f9e9069f20f4400ae0bb3ee830d34104ff8f7 crypto: testmgr - test in-place en/decryption with two sglists
date:   3 months ago
config: arm-randconfig-c002-20220629 (https://download.01.org/0day-ci/archive/20220703/202207031600.5xQNJyk8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f17f9e9069f20f4400ae0bb3ee830d34104ff8f7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f17f9e9069f20f4400ae0bb3ee830d34104ff8f7
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
           ^      ~~~
   Suppressed 41 warnings (41 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   45 warnings generated.
   drivers/gpu/drm/drm_file.c:587:30: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                           file_priv->event_space += e->event->length;
                                                     ^~~~~~~~
   drivers/gpu/drm/drm_file.c:577:6: note: Assuming 'ret' is 0
           if (ret)
               ^~~
   drivers/gpu/drm/drm_file.c:577:2: note: Taking false branch
           if (ret)
           ^
   drivers/gpu/drm/drm_file.c:580:2: note: Loop condition is true.  Entering loop body
           for (;;) {
           ^
   drivers/gpu/drm/drm_file.c:584:7: note: Assuming the condition is true
                   if (!list_empty(&file_priv->event_list)) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_file.c:584:3: note: Taking true branch
                   if (!list_empty(&file_priv->event_list)) {
                   ^
   drivers/gpu/drm/drm_file.c:592:7: note: 'e' is not equal to NULL
                   if (e == NULL) {
                       ^
   drivers/gpu/drm/drm_file.c:592:3: note: Taking false branch
                   if (e == NULL) {
                   ^
   drivers/gpu/drm/drm_file.c:611:8: note: Assuming the condition is false
                           if (length > count - ret) {
                               ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_file.c:611:4: note: Taking false branch
                           if (length > count - ret) {
                           ^
   drivers/gpu/drm/drm_file.c:622:8: note: Assuming the condition is false
                           if (copy_to_user(buffer + ret, e->event, length)) {
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_file.c:622:4: note: Taking false branch
                           if (copy_to_user(buffer + ret, e->event, length)) {
                           ^
   drivers/gpu/drm/drm_file.c:629:4: note: Memory is released
                           kfree(e);
                           ^~~~~~~~
   drivers/gpu/drm/drm_file.c:580:2: note: Loop condition is true.  Entering loop body
           for (;;) {
           ^
   drivers/gpu/drm/drm_file.c:584:7: note: Assuming the condition is true
                   if (!list_empty(&file_priv->event_list)) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_file.c:584:3: note: Taking true branch
                   if (!list_empty(&file_priv->event_list)) {
                   ^
   drivers/gpu/drm/drm_file.c:587:30: note: Use of memory after it is freed
                           file_priv->event_space += e->event->length;
                                                     ^~~~~~~~
   Suppressed 44 warnings (44 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   45 warnings generated.
   Suppressed 45 warnings (45 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   59 warnings generated.
   Suppressed 59 warnings (59 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   59 warnings generated.
   Suppressed 59 warnings (59 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   64 warnings generated.
   crypto/algboss.c:96:2: warning: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memcpy(param->template, name, len);
           ^~~~~~
   crypto/algboss.c:96:2: note: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11
           memcpy(param->template, name, len);
           ^~~~~~
   crypto/algboss.c:126:3: warning: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
                   memcpy(param->attrs[i].data.name, name, len);
                   ^~~~~~
   crypto/algboss.c:126:3: note: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11
                   memcpy(param->attrs[i].data.name, name, len);
                   ^~~~~~
   crypto/algboss.c:209:2: warning: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memcpy(param->driver, alg->cra_driver_name, sizeof(param->driver));
           ^~~~~~
   crypto/algboss.c:209:2: note: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11
           memcpy(param->driver, alg->cra_driver_name, sizeof(param->driver));
           ^~~~~~
   crypto/algboss.c:210:2: warning: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memcpy(param->alg, alg->cra_name, sizeof(param->alg));
           ^~~~~~
   crypto/algboss.c:210:2: note: Call to function 'memcpy' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memcpy_s' in case of C11
           memcpy(param->alg, alg->cra_name, sizeof(param->alg));
           ^~~~~~
   Suppressed 60 warnings (60 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   78 warnings generated.
   crypto/testmgr.c:207:2: warning: Call to function 'memset' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memset_s' in case of C11 [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
           memset(addr, TESTMGR_POISON_BYTE, len);
           ^~~~~~
   crypto/testmgr.c:207:2: note: Call to function 'memset' is insecure as it does not provide security checks introduced in the C11 standard. Replace with analogous functions that support length arguments or provides boundary checks such as 'memset_s' in case of C11
           memset(addr, TESTMGR_POISON_BYTE, len);
           ^~~~~~
>> crypto/testmgr.c:297:8: warning: Excessive padding in 'struct testvec_config' (5 padding bytes, where 1 is optimal). Optimal fields order: name, inplace_mode, req_flags, iv_offset, key_offset, finalization_type, src_divs, dst_divs, iv_offset_relative_to_alignmask, key_offset_relative_to_alignmask, nosimd, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct testvec_config {
   ~~~~~~~^~~~~~~~~~~~~~~~
   crypto/testmgr.c:297:8: note: Excessive padding in 'struct testvec_config' (5 padding bytes, where 1 is optimal). Optimal fields order: name, inplace_mode, req_flags, iv_offset, key_offset, finalization_type, src_divs, dst_divs, iv_offset_relative_to_alignmask, key_offset_relative_to_alignmask, nosimd, consider reordering the fields or adding explicit padding members
   struct testvec_config {
   ~~~~~~~^~~~~~~~~~~~~~~~
   crypto/testmgr.c:617:25: warning: Access to field 'offset' results in a dereference of an undefined pointer value (loaded from field 'div') [clang-analyzer-core.NullDereference]
                   unsigned int offset = partitions[i].div->offset;
                                         ^
   crypto/testmgr.c:2748:19: note: Assuming 'enc' is 0
           const char *op = enc ? "encryption" : "decryption";
                            ^~~
   crypto/testmgr.c:2748:19: note: '?' condition is false
   crypto/testmgr.c:2753:5: note: Assuming field 'iv_offset_relative_to_alignmask' is false
                    (cfg->iv_offset_relative_to_alignmask ? alignmask : 0);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   crypto/testmgr.c:2753:5: note: '?' condition is false
   crypto/testmgr.c:2758:6: note: Assuming field 'wk' is 0
           if (vec->wk)
               ^~~~~~~
   crypto/testmgr.c:2758:2: note: Taking false branch
           if (vec->wk)
           ^
   crypto/testmgr.c:2763:8: note: 'err' is equal to 0
           err = do_setkey(crypto_skcipher_setkey, tfm, vec->key, vec->klen,
                 ^
   crypto/testmgr.c:846:6: note: expanded from macro 'do_setkey'
           if (err == 0) {                                                 \
               ^~~
   crypto/testmgr.c:2763:8: note: Taking true branch
           err = do_setkey(crypto_skcipher_setkey, tfm, vec->key, vec->klen,
                 ^
   crypto/testmgr.c:846:2: note: expanded from macro 'do_setkey'
           if (err == 0) {                                                 \
           ^
   crypto/testmgr.c:2765:6: note: Assuming 'err' is 0
           if (err) {
               ^~~
   crypto/testmgr.c:2765:2: note: Taking false branch
           if (err) {
           ^
   crypto/testmgr.c:2773:6: note: Assuming field 'setkey_error' is 0
           if (vec->setkey_error) {
               ^~~~~~~~~~~~~~~~~
   crypto/testmgr.c:2773:2: note: Taking false branch
           if (vec->setkey_error) {
           ^
   crypto/testmgr.c:2780:6: note: Assuming 'ivsize' is not equal to 0
           if (ivsize) {
               ^~~~~~
   crypto/testmgr.c:2780:2: note: Taking true branch
           if (ivsize) {
           ^
   crypto/testmgr.c:2781:15: note: Assuming 'ivsize' is <= 32
                   if (WARN_ON(ivsize > MAX_IVLEN))
                               ^
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   crypto/testmgr.c:2781:7: note: Taking false branch
                   if (WARN_ON(ivsize > MAX_IVLEN))
                       ^
   include/asm-generic/bug.h:122:2: note: expanded from macro 'WARN_ON'
           if (unlikely(__ret_warn_on))                                    \
           ^
   crypto/testmgr.c:2781:3: note: Taking false branch
                   if (WARN_ON(ivsize > MAX_IVLEN))
                   ^
   crypto/testmgr.c:2783:7: note: Assuming field 'generates_iv' is true
                   if (vec->generates_iv && !enc)
                       ^~~~~~~~~~~~~~~~~
   crypto/testmgr.c:2783:7: note: Left side of '&&' is true
   crypto/testmgr.c:2783:29: note: 'enc' is 0
                   if (vec->generates_iv && !enc)
                                             ^~~
   crypto/testmgr.c:2783:3: note: Taking true branch
                   if (vec->generates_iv && !enc)
                   ^
   crypto/testmgr.c:2799:19: note: 'enc' is 0
           input.iov_base = enc ? (void *)vec->ptext : (void *)vec->ctext;
                            ^~~
   crypto/testmgr.c:2799:19: note: '?' condition is false
   crypto/testmgr.c:2801:8: note: Calling 'build_cipher_test_sglists'
           err = build_cipher_test_sglists(tsgls, cfg, alignmask,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   crypto/testmgr.c:771:5: note: Assuming field 'inplace_mode' is not equal to OUT_OF_PLACE
                                   cfg->inplace_mode != OUT_OF_PLACE ?
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   crypto/testmgr.c:771:5: note: '?' condition is true
   crypto/testmgr.c:772:6: note: '__UNIQUE_ID___x215' is <= '__UNIQUE_ID___y216'
                                           max(dst_total_len, src_total_len) :
                                           ^
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:38:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:3: note: expanded from macro '__cmp_once'
                   __cmp(unique_x, unique_y, op); })
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +297 crypto/testmgr.c

3f47a03df6e811 Eric Biggers 2019-01-31  274  
3f47a03df6e811 Eric Biggers 2019-01-31  275  /**
3f47a03df6e811 Eric Biggers 2019-01-31  276   * struct testvec_config - configuration for testing a crypto test vector
3f47a03df6e811 Eric Biggers 2019-01-31  277   *
3f47a03df6e811 Eric Biggers 2019-01-31  278   * This struct describes the data layout and other parameters with which each
3f47a03df6e811 Eric Biggers 2019-01-31  279   * crypto test vector can be tested.
3f47a03df6e811 Eric Biggers 2019-01-31  280   *
3f47a03df6e811 Eric Biggers 2019-01-31  281   * @name: name of this config, logged for debugging purposes if a test fails
f17f9e9069f20f Eric Biggers 2022-03-26  282   * @inplace_mode: whether and how to operate on the data in-place, if applicable
3f47a03df6e811 Eric Biggers 2019-01-31  283   * @req_flags: extra request_flags, e.g. CRYPTO_TFM_REQ_MAY_SLEEP
3f47a03df6e811 Eric Biggers 2019-01-31  284   * @src_divs: description of how to arrange the source scatterlist
3f47a03df6e811 Eric Biggers 2019-01-31  285   * @dst_divs: description of how to arrange the dst scatterlist, if applicable
3f47a03df6e811 Eric Biggers 2019-01-31  286   *	      for the algorithm type.  Defaults to @src_divs if unset.
3f47a03df6e811 Eric Biggers 2019-01-31  287   * @iv_offset: misalignment of the IV in the range [0..MAX_ALGAPI_ALIGNMASK+1],
3f47a03df6e811 Eric Biggers 2019-01-31  288   *	       where 0 is aligned to a 2*(MAX_ALGAPI_ALIGNMASK+1) byte boundary
3f47a03df6e811 Eric Biggers 2019-01-31  289   * @iv_offset_relative_to_alignmask: if true, add the algorithm's alignmask to
3f47a03df6e811 Eric Biggers 2019-01-31  290   *				     the @iv_offset
fd8c37c72d60c7 Eric Biggers 2019-12-01  291   * @key_offset: misalignment of the key, where 0 is default alignment
fd8c37c72d60c7 Eric Biggers 2019-12-01  292   * @key_offset_relative_to_alignmask: if true, add the algorithm's alignmask to
fd8c37c72d60c7 Eric Biggers 2019-12-01  293   *				      the @key_offset
3f47a03df6e811 Eric Biggers 2019-01-31  294   * @finalization_type: what finalization function to use for hashes
6570737c7fa047 Eric Biggers 2019-03-12  295   * @nosimd: execute with SIMD disabled?  Requires !CRYPTO_TFM_REQ_MAY_SLEEP.
3f47a03df6e811 Eric Biggers 2019-01-31  296   */
3f47a03df6e811 Eric Biggers 2019-01-31 @297  struct testvec_config {
3f47a03df6e811 Eric Biggers 2019-01-31  298  	const char *name;
f17f9e9069f20f Eric Biggers 2022-03-26  299  	enum inplace_mode inplace_mode;
3f47a03df6e811 Eric Biggers 2019-01-31  300  	u32 req_flags;
3f47a03df6e811 Eric Biggers 2019-01-31  301  	struct test_sg_division src_divs[XBUFSIZE];
3f47a03df6e811 Eric Biggers 2019-01-31  302  	struct test_sg_division dst_divs[XBUFSIZE];
3f47a03df6e811 Eric Biggers 2019-01-31  303  	unsigned int iv_offset;
fd8c37c72d60c7 Eric Biggers 2019-12-01  304  	unsigned int key_offset;
3f47a03df6e811 Eric Biggers 2019-01-31  305  	bool iv_offset_relative_to_alignmask;
fd8c37c72d60c7 Eric Biggers 2019-12-01  306  	bool key_offset_relative_to_alignmask;
3f47a03df6e811 Eric Biggers 2019-01-31  307  	enum finalization_type finalization_type;
6570737c7fa047 Eric Biggers 2019-03-12  308  	bool nosimd;
3f47a03df6e811 Eric Biggers 2019-01-31  309  };
3f47a03df6e811 Eric Biggers 2019-01-31  310  

:::::: The code at line 297 was first introduced by commit
:::::: 3f47a03df6e81174558f4604828851cb600e1db6 crypto: testmgr - add testvec_config struct and helper functions

:::::: TO: Eric Biggers <ebiggers@google.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
