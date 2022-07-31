Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1810586022
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 19:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiGaRgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGaRgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:36:14 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBB7BF4E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rb/YjUvomiVZDXYdB7kpegzU1ge+e/pBCgCPDuG9LAE=;
  b=n0utZMEvUtZgGJbYvW4ZVH+lYJ3EOL1MZs5ATHrzMPbdl4YyD/z/wYmQ
   E70cGjc+kqVVYX8W93HK35FOZKgs1xV/cpifvS/e9dgyargGCdLbAhm8c
   HxtDUXwgvSvCg7gDIUbrPIBOVoruW2rOPKRfs9gJPSAWIP7T9Uw81sw37
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,206,1654552800"; 
   d="scan'208";a="20525516"
Received: from ip-153.net-89-2-7.rev.numericable.fr (HELO hadrien) ([89.2.7.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:36:09 +0200
Date:   Sun, 31 Jul 2022 19:36:09 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thermal:thermal/next 28/36] drivers/thermal/thermal_of.c:689:1-23:
 WARNING: Function "for_each_child_of_node" should have of_node_put() before
 goto around lines 692. (fwd)
Message-ID: <alpine.DEB.2.22.394.2207311935070.2877@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't receive a code snippet with this message, but it may be worth
checkin whether there is a missing of_node_put.

julia

---------- Forwarded message ----------
Date: Sun, 31 Jul 2022 10:35:03 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [thermal:thermal/next 28/36] drivers/thermal/thermal_of.c:689:1-23:
    WARNING: Function "for_each_child_of_node" should have of_node_put() before
    goto around lines 692.

CC: kbuild-all@lists.01.org
BCC: lkp@intel.com
CC: linux-kernel@vger.kernel.org
TO: Daniel Lezcano <daniel.lezcano@linexp.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/next
head:   d0c75fa2c17f082b32a5f26ff40bf378b12952de
commit: a3193edcbdf9a8ae73b6e1f2da96e920582c1849 [28/36] thermal/of: Replace device node match with device node search
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
config: nios2-randconfig-c033-20220729 (https://download.01.org/0day-ci/archive/20220731/202207311043.WDsouQI6-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

cocci warnings: (new ones prefixed by >>)
>> drivers/thermal/thermal_of.c:689:1-23: WARNING: Function "for_each_child_of_node" should have of_node_put() before goto around lines 692.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
