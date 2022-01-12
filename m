Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9019F48BBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344248AbiALAqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:46:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:49289 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343866AbiALAqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641948378; x=1673484378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RZuFfgnNrTLSM579LxhI3jYodEOF6qNjDrhHiRDoTL4=;
  b=NKNuEU45zWqqdR5F+j/XXcinnLmZOqwWJFandASR7Wi/oD4qxe/umSn2
   Y5q6pdMR8JZKIGloWIXCVtWUT9WPkrYrtmApKXgCu6vFjvZp7MdEqCS/j
   B4VQ5+4QHEmYzFwxlE41DcKin8kpGC5N65Bc33/0yPAxKLgoH58+tzjVx
   hdvU9UC/CDymf2QS/TTEWSQ2YztmHAq2OStThODFxO96LrWVEH25ff1HE
   fsVUIiicbPY9UHn0woclbby/eBD4jjb+1vHnzdxM6RfrMl9CNU3bViEzY
   BgTZ4iNR789W+fNQJO39Uqy2lmzhSZpxn9Xdsl6wgRgUkQp8dCXU4FTvr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243585107"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="243585107"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 16:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="691193515"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2022 16:46:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7RmJ-0005NV-Li; Wed, 12 Jan 2022 00:46:15 +0000
Date:   Wed, 12 Jan 2022 08:45:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:tdx/guest-rebased 58/133]
 tools/tdx/attest/tdx-attest-test.c: unistd.h is included more than once.
Message-ID: <202201120805.n3MruXva-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git tdx/guest-rebased
head:   e3995864d37c56f431c93fc3dc454d9c65f5e9ea
commit: 10cf59c2590afd8c342994cd885e4b0c40f1666e [58/133] tools/tdx: Add a sample attestation user app
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> tools/tdx/attest/tdx-attest-test.c: unistd.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
