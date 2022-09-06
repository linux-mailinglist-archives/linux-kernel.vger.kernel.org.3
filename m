Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8DC5AF2C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiIFRiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIFRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:37:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500C8A7D7;
        Tue,  6 Sep 2022 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662485618; x=1694021618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s9gZ2XoICzxug5E8CZrxYGQ5div98Sn+DFN1sd0gc/8=;
  b=XrdLy11yHzX/wQB9w1Kzwjsg2dTb7WXtKGIC33FQjqdjk7IbBqcTxOR3
   eKFIN8XWTNGxKRnFhP8N8iBnJrvFtewEJPniNxO24U5WVvUqAxenDya5i
   B3lhk0skVB5YLJ41c8FbAy6vToKZdnbOS9YyDdsa7i9zMtIf9fW7Yp++I
   GmHZi/TXhDno+1aGUUcwVjMV06kv7SK08oMh0eSqXFoHP1hD65KPXFdLl
   gmwJBLjx571v4gL7JqTOciIlTfOTNxn9c+4memnPS+W2vBfY7ccKYjBUg
   AVajUR6bo/AUOQA5uY8qyxPyjv7c7KUawrq8MfsTNmHpsq+cLctRTq3Yj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360606039"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360606039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 10:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="644258976"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2022 10:33:36 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVcS7-0005Ov-1H;
        Tue, 06 Sep 2022 17:33:35 +0000
Date:   Wed, 7 Sep 2022 01:32:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <stfrench@microsoft.com>,
        linux-doc@vger.kernel.org
Subject: [samba-ksmbd:ksmbd-for-next-next 3/3] htmldocs:
 Documentation/filesystems/cifs/ksmbd.rst:123: WARNING: Unexpected
 indentation.
Message-ID: <202209070129.JKu6GWs2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git ksmbd-for-next-next
head:   61f596cda9f2d4d6b068f5226b2e2bc9478fa873
commit: 61f596cda9f2d4d6b068f5226b2e2bc9478fa873 [3/3] ksmbd: update documentation
reproduce:
        git remote add samba-ksmbd git://git.samba.org/ksmbd.git
        git fetch --no-tags samba-ksmbd ksmbd-for-next-next
        git checkout 61f596cda9f2d4d6b068f5226b2e2bc9478fa873
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/cifs/ksmbd.rst:123: WARNING: Unexpected indentation.

vim +123 Documentation/filesystems/cifs/ksmbd.rst

   120	
   121	1. Download ksmbd-tools(https://github.com/cifsd-team/ksmbd-tools/releases) and compile them.
   122	   - Refer README(https://github.com/cifsd-team/ksmbd-tools/blob/master/README.md)
 > 123	     to know how to use ksmbd.<foo> utils
   124	
   125	     $ ./autogen.sh
   126	     $ ./configure --with-rundir=/run
   127	     $ make && sudo make install
   128	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
