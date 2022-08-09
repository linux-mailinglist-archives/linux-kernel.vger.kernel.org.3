Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2237558D1D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiHIB6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHIB6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:58:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283CA1D0CF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660010301; x=1691546301;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/kgqxvayGmYr7WeQzjjxmxGhkWnKjNCZ9r00wywtC6I=;
  b=mzwkJuqhazQ2FOrechchajscPLSVkK54WV5ZAcDvCluWvd6QOYgbtl+p
   fPMNUfENPYqK0fGcoBZPw/2fVVlUoDHTXHL4PzIRR5I7fBhWpND9RZY5W
   MBVpQ7IR59k5W8y+5xLQNnzwug31W2E6L9VybB3H/Upj3sUEK6fZjbUFW
   coG4GKdMY0bQ+CT02UP47nvvRfX+Xpk4SkgUW3+D7+5Oyhg/Y1R2qjz3j
   SY9ibfiLrQFe+AneBtGXoJBiVmOB6jWW6g8l82xeS1roEiF6XR1jnJkk9
   xyW6F4v+gdStbugMhaNsXfa1w63IipISqnCDxLxZxLqOsNJXMwmH7D4Tr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291519129"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="291519129"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 18:58:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="664225312"
Received: from rongch2-desk.sh.intel.com (HELO localhost) ([10.239.159.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 18:58:18 -0700
Date:   Tue, 9 Aug 2022 09:58:16 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: kismet: WARNING: unmet direct dependencies detected for
 PM_GENERIC_DOMAINS_OF when selected by QCOM_RPMPD
Message-ID: <YvG/OO+Go7YQwsrc@rongch2-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   74cae210a335d159f2eb822e261adee905b6951a
commit: 7d0221fb59125181a31ef3a561306c70fb238bc7 soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF
config: x86_64-kismet-CONFIG_PM_GENERIC_DOMAINS_OF-CONFIG_QCOM_RPMPD-0-0 (https://download.01.org/0day-ci/archive/20220806/202208060923.DrywHbPW-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d0221fb59125181a31ef3a561306c70fb238bc7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7d0221fb59125181a31ef3a561306c70fb238bc7
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_PM_GENERIC_DOMAINS_OF --selectors CONFIG_QCOM_RPMPD -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF when selected by QCOM_RPMPD
   
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
     Depends on [n]: PM [=n]
     Selected by [y]:
     - QCOM_RPMPD [=y] && QCOM_SMD_RPM [=y]
   
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
     Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
     Selected by [y]:
     - QCOM_RPMPD [=y] && QCOM_SMD_RPM [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
