Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39D457F6AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiGXTNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGXTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:13:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DF1DFFC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658690000; x=1690226000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/APqt5Mi98G4cmT3Lgm2ScN+tpJjK5pjgrurXgiAjEw=;
  b=fEpqnab6m80pLYnLBEAylRm4Zox5GJSTSw5MVxP5gw3gMSwlbzQkbYob
   eCx4KaoEIfkFrhfTng0f8HhpEjKyvrjn0221HcfwOTwM2OLY6Ml4FxIiv
   p7GjuvWXc+duyqAF0SWbxkE+lIfuGpyy+4AFSTykm6KoTyd3k6skWBWXK
   E0rT8VibwVYqA/me70t7qffiEPqgHlcuy7DPj2mNPo0JqzpVGY6W8Sl4S
   5sqJbPerHDu+Gq5OGhhkxEw4o47okIHtZyIkn/lbGxUsDwyh/+fYCZmdf
   fWIBV5+E14BanlM7UiD2KVBJ/sAPLIb3PmtPAJbwFLGBnFRPdw5VoioYB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288324154"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288324154"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 12:13:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="596469455"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2022 12:13:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFh2T-0004A5-27;
        Sun, 24 Jul 2022 19:13:17 +0000
Date:   Mon, 25 Jul 2022 03:13:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: security/keys/trusted-keys/trusted_tpm2.c:42:9: warning: ISO C90
 forbids mixed declarations and code
Message-ID: <202207250316.ZEbQokZd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220722-162642/Jianglei-Nie/KEYS-trusted-Fix-memory-leak-in-tpm2_key_encode/20220608-211954
head:   7112e578934830db95743922ab0d46d2f4b7dff4
commit: 7112e578934830db95743922ab0d46d2f4b7dff4 KEYS: trusted: Fix memory leak in tpm2_key_encode()
date:   2 days ago
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220725/202207250316.ZEbQokZd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7112e578934830db95743922ab0d46d2f4b7dff4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220722-162642/Jianglei-Nie/KEYS-trusted-Fix-memory-leak-in-tpm2_key_encode/20220608-211954
        git checkout 7112e578934830db95743922ab0d46d2f4b7dff4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash security/keys/trusted-keys/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   security/keys/trusted-keys/trusted_tpm2.c: In function 'tpm2_key_encode':
>> security/keys/trusted-keys/trusted_tpm2.c:42:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      42 |         u8 *work = scratch, *work1;
         |         ^~


vim +42 security/keys/trusted-keys/trusted_tpm2.c

f2219745250f38 James Bottomley 2021-01-27   30  
f2219745250f38 James Bottomley 2021-01-27   31  static int tpm2_key_encode(struct trusted_key_payload *payload,
f2219745250f38 James Bottomley 2021-01-27   32  			   struct trusted_key_options *options,
f2219745250f38 James Bottomley 2021-01-27   33  			   u8 *src, u32 len)
f2219745250f38 James Bottomley 2021-01-27   34  {
7112e578934830 Jianglei Nie    2022-07-22   35  	int ret;
f2219745250f38 James Bottomley 2021-01-27   36  	const int SCRATCH_SIZE = PAGE_SIZE;
7112e578934830 Jianglei Nie    2022-07-22   37  	u8 *scratch;
7112e578934830 Jianglei Nie    2022-07-22   38  
7112e578934830 Jianglei Nie    2022-07-22   39  	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
7112e578934830 Jianglei Nie    2022-07-22   40  	if (!scratch)
7112e578934830 Jianglei Nie    2022-07-22   41  		return -ENOMEM;
f2219745250f38 James Bottomley 2021-01-27  @42  	u8 *work = scratch, *work1;
f2219745250f38 James Bottomley 2021-01-27   43  	u8 *end_work = scratch + SCRATCH_SIZE;
f2219745250f38 James Bottomley 2021-01-27   44  	u8 *priv, *pub;
f2219745250f38 James Bottomley 2021-01-27   45  	u16 priv_len, pub_len;
f2219745250f38 James Bottomley 2021-01-27   46  
f2219745250f38 James Bottomley 2021-01-27   47  	priv_len = get_unaligned_be16(src) + 2;
f2219745250f38 James Bottomley 2021-01-27   48  	priv = src;
f2219745250f38 James Bottomley 2021-01-27   49  
f2219745250f38 James Bottomley 2021-01-27   50  	src += priv_len;
f2219745250f38 James Bottomley 2021-01-27   51  
f2219745250f38 James Bottomley 2021-01-27   52  	pub_len = get_unaligned_be16(src) + 2;
f2219745250f38 James Bottomley 2021-01-27   53  	pub = src;
f2219745250f38 James Bottomley 2021-01-27   54  
f2219745250f38 James Bottomley 2021-01-27   55  	work = asn1_encode_oid(work, end_work, tpm2key_oid,
f2219745250f38 James Bottomley 2021-01-27   56  			       asn1_oid_len(tpm2key_oid));
f2219745250f38 James Bottomley 2021-01-27   57  
f2219745250f38 James Bottomley 2021-01-27   58  	if (options->blobauth_len == 0) {
f2219745250f38 James Bottomley 2021-01-27   59  		unsigned char bool[3], *w = bool;
f2219745250f38 James Bottomley 2021-01-27   60  		/* tag 0 is emptyAuth */
f2219745250f38 James Bottomley 2021-01-27   61  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
7112e578934830 Jianglei Nie    2022-07-22   62  		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
7112e578934830 Jianglei Nie    2022-07-22   63  			ret = PTR_ERR(w);
7112e578934830 Jianglei Nie    2022-07-22   64  			goto err;
7112e578934830 Jianglei Nie    2022-07-22   65  		}
f2219745250f38 James Bottomley 2021-01-27   66  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
f2219745250f38 James Bottomley 2021-01-27   67  	}
f2219745250f38 James Bottomley 2021-01-27   68  
f2219745250f38 James Bottomley 2021-01-27   69  	/*
f2219745250f38 James Bottomley 2021-01-27   70  	 * Assume both octet strings will encode to a 2 byte definite length
f2219745250f38 James Bottomley 2021-01-27   71  	 *
f2219745250f38 James Bottomley 2021-01-27   72  	 * Note: For a well behaved TPM, this warning should never
f2219745250f38 James Bottomley 2021-01-27   73  	 * trigger, so if it does there's something nefarious going on
f2219745250f38 James Bottomley 2021-01-27   74  	 */
f2219745250f38 James Bottomley 2021-01-27   75  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
7112e578934830 Jianglei Nie    2022-07-22   76  		 "BUG: scratch buffer is too small")) {
7112e578934830 Jianglei Nie    2022-07-22   77  		ret = -EINVAL;
7112e578934830 Jianglei Nie    2022-07-22   78  		goto err;
7112e578934830 Jianglei Nie    2022-07-22   79  	}
f2219745250f38 James Bottomley 2021-01-27   80  
f2219745250f38 James Bottomley 2021-01-27   81  	work = asn1_encode_integer(work, end_work, options->keyhandle);
f2219745250f38 James Bottomley 2021-01-27   82  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
f2219745250f38 James Bottomley 2021-01-27   83  	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
f2219745250f38 James Bottomley 2021-01-27   84  
f2219745250f38 James Bottomley 2021-01-27   85  	work1 = payload->blob;
f2219745250f38 James Bottomley 2021-01-27   86  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
f2219745250f38 James Bottomley 2021-01-27   87  				     scratch, work - scratch);
7112e578934830 Jianglei Nie    2022-07-22   88  	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
7112e578934830 Jianglei Nie    2022-07-22   89  		ret = PTR_ERR(work1);
7112e578934830 Jianglei Nie    2022-07-22   90  		goto err;
7112e578934830 Jianglei Nie    2022-07-22   91  	}
f2219745250f38 James Bottomley 2021-01-27   92  
7112e578934830 Jianglei Nie    2022-07-22   93  	kfree(scratch);
f2219745250f38 James Bottomley 2021-01-27   94  	return work1 - payload->blob;
7112e578934830 Jianglei Nie    2022-07-22   95  
7112e578934830 Jianglei Nie    2022-07-22   96  err:
7112e578934830 Jianglei Nie    2022-07-22   97  	kfree(scratch);
7112e578934830 Jianglei Nie    2022-07-22   98  	return ret;
f2219745250f38 James Bottomley 2021-01-27   99  }
f2219745250f38 James Bottomley 2021-01-27  100  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
