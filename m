Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB6F578753
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiGRQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiGRQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:26:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1002A97D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658161565; x=1689697565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3QC6YAMoeXNWQrv+0mBy2+kLe1dZJxM4XIQQ7oCw49c=;
  b=P5C52Y3rszK+MTljG1TEPCgCSm0J+e89kqEA/wu7syFZBYK75QfuotvJ
   VZqZY2QMz6w5bccXIXxoxNAhxVhdRIXFaghXJ3ylk9yrcK3+SgDj752Kr
   A9+fZenNuxyI3d1ANiuoKUxxF57r1dzaDg7U+w1J5LFTG2UZqz2pXdL8I
   MarvphitePLtQZZeyC40TFBmuN9PQCTlkdASIDnVM+Ybm3j0ik4j0sBvT
   WO3tBGg3rmr8xlgaf8odLfroIYkcZffF0cKMHZFBBZcqgR6umzbHIKHdR
   v/T1G+tnMk+y+LJ1YPmwSycEFv9ccezvmISMOONTZlZIIVRBC33un7zO+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287005805"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="287005805"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:25:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="773794174"
Received: from astephax-mobl.amr.corp.intel.com (HELO [10.209.134.250]) ([10.209.134.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:25:37 -0700
Message-ID: <6a06bb5c-c385-a247-1e03-2759dbedbfbb@linux.intel.com>
Date:   Mon, 18 Jul 2022 11:25:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: sof-client-ipc-flood-test.c:undefined reference to
 `sof_client_get_fw_state'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Fred Oh <fred.oh@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <202207170529.CoaJYL8a-lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <202207170529.CoaJYL8a-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/22 16:48, kernel test robot wrote:
> Hi Ranjani,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c5fe7a97f20c7f3070ac870144515c0fabc6b999
> commit: 6e9548cdb30e5d6724236dd7b89a79a270751485 ASoC: SOF: Convert the generic IPC flood test into SOF client
> date:   5 months ago
> config: arm64-buildonly-randconfig-r006-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170529.CoaJYL8a-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e9548cdb30e5d6724236dd7b89a79a270751485
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6e9548cdb30e5d6724236dd7b89a79a270751485
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

I reproduced the problem, it's similar to another randconfig issue
reported by Randy Dunlap. I'll track it here:

https://github.com/thesofproject/linux/issues/3768

> 
> All errors (new ones prefixed by >>):
> 
>    aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>    aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>    aarch64-linux-ld: sound/soc/sof/sof-client-ipc-flood-test.o: in function `sof_ipc_flood_dfs_open':
>>> sof-client-ipc-flood-test.c:(.text+0xfc): undefined reference to `sof_client_get_fw_state'
>    aarch64-linux-ld: sound/soc/sof/sof-client-ipc-flood-test.o: in function `sof_debug_ipc_flood_test':
>>> sof-client-ipc-flood-test.c:(.text+0x254): undefined reference to `sof_client_ipc_tx_message'
>    aarch64-linux-ld: sound/soc/sof/sof-client-ipc-flood-test.o: in function `sof_ipc_flood_probe':
>>> sof-client-ipc-flood-test.c:(.text+0xa54): undefined reference to `sof_client_get_debugfs_root'
> 
