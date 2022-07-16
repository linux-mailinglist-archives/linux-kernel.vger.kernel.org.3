Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2371857713C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGPTpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGPTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:45:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C11DA69;
        Sat, 16 Jul 2022 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658000735; x=1689536735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZN0hQdqAgRa63AaJQs7N1RWNIWr04yZNa39M13Q1EYk=;
  b=hlVTeqmO6e34+ERzwGPIz6NAFo7ca+WrKySOHmnqX/JlUgmjwwXuTE4S
   gcOGVQHKZklMuBlz4Bws/MpAGYlRSDBTDIekvY57RrzIjXgBGcgZ2rSCB
   JOtShR8yQfzzrOI5x4arBl3Gg507EF/vdMcqbmjwMwds6VWtUmJGc9iYs
   9TAm9TvzMwsuV9ELfy371A60sbg5ptW6c87az4R3fliBGVR4vEGoxUjn/
   hDQtj2r6wfajtsYSxSWmEvDw30JAOP+u7rZAObS9zKvWJ+H3sEnRcpy0/
   6WjmWagbTayghmAJ/nKdllp3GUhQ082CQEDmH0xSgmCJ//RcIy0UYjF7L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="283567185"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="283567185"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 12:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="923882314"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2022 12:45:34 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCnjJ-00023P-Lg;
        Sat, 16 Jul 2022 19:45:33 +0000
Date:   Sun, 17 Jul 2022 03:44:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Kitt <steve@sk2.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 5/5] docs: sysctl/fs: re-order, prettify
Message-ID: <202207170303.ThkAWAGX-lkp@intel.com>
References: <20220712172619.359052-5-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712172619.359052-5-steve@sk2.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Kitt/docs-sysctl-remove-references-to-inode-max/20220713-014344
base:   50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/sysctl/fs.rst:260: WARNING: undefined label: core_pattern (if the link has no caption the label must precede a section header)

vim +260 Documentation/admin-guide/sysctl/fs.rst

   249	
   250	=   ==========  ===============================================================
   251	0   (default)	Traditional behaviour. Any process which has changed
   252			privilege levels or is execute only will not be dumped.
   253	1   (debug)	All processes dump core when possible. The core dump is
   254			owned by the current user and no security is applied. This is
   255			intended for system debugging situations only.
   256			Ptrace is unchecked.
   257			This is insecure as it allows regular users to examine the
   258			memory contents of privileged processes.
   259	2   (suidsafe)	Any binary which normally would not be dumped is dumped
 > 260			anyway, but only if the ``core_pattern`` kernel sysctl (see
   261			:ref:`Documentation/admin-guide/sysctl/kernel.rst <core_pattern>`)
   262			is set to
   263			either a pipe handler or a fully qualified path. (For more
   264			details on this limitation, see CVE-2006-2451.) This mode is
   265			appropriate when administrators are attempting to debug
   266			problems in a normal environment, and either have a core dump
   267			pipe handler that knows to treat privileged core dumps with
   268			care, or specific directory defined for catching core dumps.
   269			If a core dump happens without a pipe handler or fully
   270			qualified path, a message will be emitted to syslog warning
   271			about the lack of a correct setting.
   272	=   ==========  ===============================================================
   273	
   274	
   275	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
