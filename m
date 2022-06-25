Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273FD55AA6A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiFYNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiFYNSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:18:48 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9E1D0D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zfMoZm1P48Ok/Dw2HiECELc4ab0O14bkabo5nJoBFjI=;
  b=QRMNwBs21f1UYLGz4+3xhllkZjd38oQZ7CUR2hGJuECSUwQ6+9lHkBy7
   1tkwErgoX3eL0mYGOdQcpCE2cEE8MV7MQVm/tms7p01mGngUaB7j8SiNJ
   LoyGy72jmNd8aopNy6BGw4/UKUHP1NqbscM8Fh+IkTscUZNcLeEtfbGC2
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="42840035"
Received: from 71-219-63-58.chvl.qwest.net (HELO hadrien) ([71.219.63.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 15:18:44 +0200
Date:   Sat, 25 Jun 2022 09:18:41 -0400 (EDT)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     kbuild-all@lists.01.org, Dan Williams <dan.j.williams@intel.com>
cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 37/49] kernel/resource.c:1823:22-23: WARNING this kind
 of initialization is deprecated (fwd)
Message-ID: <alpine.DEB.2.22.394.2206250917320.7300@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See line 1823.

julia

---------- Forwarded message ----------
Date: Thu, 23 Jun 2022 18:17:12 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [cxl:preview 37/49] kernel/resource.c:1823:22-23: WARNING this kind of
    initialization is deprecated

CC: kbuild-all@lists.01.org
BCC: lkp@intel.com
CC: Alison Schofield <alison.schofield@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: Ben Widawsky <ben.widawsky@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: linux-kernel@vger.kernel.org
TO: Dan Williams <dan.j.williams@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: 6f2443c3ffee6675ef14a4b1256400a9c8a652ca [37/49] resource: Introduce alloc_free_mem_region()
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago
config: arm-randconfig-c003-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231855.rDlKL41m-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


cocci warnings: (new ones prefixed by >>)
>> kernel/resource.c:1823:22-23: WARNING this kind of initialization is deprecated

vim +1823 kernel/resource.c

6f2443c3ffee66 Dan Williams 2022-05-20  1820
6f2443c3ffee66 Dan Williams 2022-05-20  1821  static void remove_free_mem_region(void *_res)
6f2443c3ffee66 Dan Williams 2022-05-20  1822  {
6f2443c3ffee66 Dan Williams 2022-05-20 @1823  	struct resource *res = res;
6f2443c3ffee66 Dan Williams 2022-05-20  1824
6f2443c3ffee66 Dan Williams 2022-05-20  1825  	if (res->parent)
6f2443c3ffee66 Dan Williams 2022-05-20  1826  		remove_resource(res);
6f2443c3ffee66 Dan Williams 2022-05-20  1827  	free_resource(res);
6f2443c3ffee66 Dan Williams 2022-05-20  1828  }
6f2443c3ffee66 Dan Williams 2022-05-20  1829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
