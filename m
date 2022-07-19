Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DED8578EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiGSAIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiGSAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:08:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43932BB9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658189291; x=1689725291;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LE2jpBzFPDT5XVM9WKnnmiBu5Si2kmsJhg1zC/jXW50=;
  b=VcpUFHZC5li7NfY9gRwYQtRwW8L7zESwJZhRgjH3mPBF3fZi9ORy2iqB
   Vuc8/7cNi6U326exMiO6qxvtbRTc09gdAgM7i45PirdbPVrqbyNKjo+TS
   8NNOX1hDXBrWTCasfMVETI/HTp3zWxz9eWwBUUAAFuQjYFBHn9JmK8Cn+
   F6VMMbZ2MhmaeWfeuslkn4W4lk+M2w/qTBCK6FsGR5Vj5iCiXAhmj9zX+
   7MfWhwZRdldZx4qlO6dqZsYE++vj4qJ4iGBCkHNgvL8qbs5kZN3N02OBC
   Q2rTFDPis+zcbnpe+aj/+39od7b4vbtkzXmOw4+cnkeZaSubxmDmzzq7y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285104603"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="285104603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="594641354"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2022 17:08:09 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDamW-0004xE-M0;
        Tue, 19 Jul 2022 00:08:08 +0000
Date:   Tue, 19 Jul 2022 08:07:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Coco Li <lixiaoyan@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: toeplitz.c:335:23: warning: excess elements in struct initializer
Message-ID: <202207190811.jZDv1ibc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e19f34c2887a8881084b7bb7480e9544d56b91
commit: 5ebfb4cc3048380b43506ffc71b9cf8b83128989 selftests/net: toeplitz test
date:   12 months ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   toeplitz.c: In function 'create_ring':
   toeplitz.c:334:16: error: variable 'args' has initializer but incomplete type
     334 |         struct fanout_args args = {
         |                ^~~~~~~~~~~
   toeplitz.c:335:18: error: 'struct fanout_args' has no member named 'id'
     335 |                 .id = 1,
         |                  ^~
>> toeplitz.c:335:23: warning: excess elements in struct initializer
     335 |                 .id = 1,
         |                       ^
   toeplitz.c:335:23: note: (near initialization for 'args')
   toeplitz.c:336:18: error: 'struct fanout_args' has no member named 'type_flags'
     336 |                 .type_flags = PACKET_FANOUT_CPU,
         |                  ^~~~~~~~~~
   In file included from toeplitz.c:33:
>> ../../../../usr/include/linux/if_packet.h:63:41: warning: excess elements in struct initializer
      63 | #define PACKET_FANOUT_CPU               2
         |                                         ^
   toeplitz.c:336:31: note: in expansion of macro 'PACKET_FANOUT_CPU'
     336 |                 .type_flags = PACKET_FANOUT_CPU,
         |                               ^~~~~~~~~~~~~~~~~
   ../../../../usr/include/linux/if_packet.h:63:41: note: (near initialization for 'args')
      63 | #define PACKET_FANOUT_CPU               2
         |                                         ^
   toeplitz.c:336:31: note: in expansion of macro 'PACKET_FANOUT_CPU'
     336 |                 .type_flags = PACKET_FANOUT_CPU,
         |                               ^~~~~~~~~~~~~~~~~
   toeplitz.c:337:18: error: 'struct fanout_args' has no member named 'max_num_members'
     337 |                 .max_num_members = RSS_MAX_CPUS
         |                  ^~~~~~~~~~~~~~~
   toeplitz.c:64:22: warning: excess elements in struct initializer
      64 | #define RSS_MAX_CPUS (1 << 16)  /* real constraint is PACKET_FANOUT_MAX */
         |                      ^
   toeplitz.c:337:36: note: in expansion of macro 'RSS_MAX_CPUS'
     337 |                 .max_num_members = RSS_MAX_CPUS
         |                                    ^~~~~~~~~~~~
   toeplitz.c:64:22: note: (near initialization for 'args')
      64 | #define RSS_MAX_CPUS (1 << 16)  /* real constraint is PACKET_FANOUT_MAX */
         |                      ^
   toeplitz.c:337:36: note: in expansion of macro 'RSS_MAX_CPUS'
     337 |                 .max_num_members = RSS_MAX_CPUS
         |                                    ^~~~~~~~~~~~
   toeplitz.c:334:28: error: storage size of 'args' isn't known
     334 |         struct fanout_args args = {
         |                            ^~~~
>> toeplitz.c:334:28: warning: unused variable 'args' [-Wunused-variable]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
