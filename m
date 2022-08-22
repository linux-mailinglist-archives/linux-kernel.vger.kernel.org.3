Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1959C264
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiHVPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiHVPKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F13402CE;
        Mon, 22 Aug 2022 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661180887; x=1692716887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AZ3zcJFxLqvw4hD/FAvZLDC1AGZmGOi9qxc+JOuXmN4=;
  b=HgSRTyOy9C2Em8KRmDUMh1r+1UAS5wurIp9AaV2rSH75N1KOLrf90qas
   GN5SBUiJZqi9mDs2xIOyekmeMGXRlwxLZyIX5a4/RhE+/5FHOTsRBhjJ5
   gytp7kascbQonZNyqQmh0hJKs+H2O9/0MGGZx73ODhTfLLyDvYTEWnRhC
   GEWXyNnCow/vFB2Zasovho8dAimdnSvGgMmQztPe4k64p7ZvBFiAKG8Dq
   NJqLdkEzuc7cw9Q6ds5wJzeHPvEgWZoWA6XetG1wl8xY/V2O+L0Ho5i6q
   rMz6F1alzqxaLUABQzjcIjMzJCOBtsnQQV/BafluRVTcFKtqa0ho8VTE5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379727738"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="379727738"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 08:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="712213742"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2022 08:06:48 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ90p-0000Mx-2I;
        Mon, 22 Aug 2022 15:06:47 +0000
Date:   Mon, 22 Aug 2022 23:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org
Subject: [linux-stable-rc:linux-5.18.y 3493/3591] htmldocs:
 Documentation/tty/device_drivers/oxsemi-tornado.rst:41: WARNING: Inline
 interpreted text or phrase reference start-string without end-string.
Message-ID: <202208222259.iWiGmKuH-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
head:   22a992953741ad79c07890d3f4104585e52ef26b
commit: ca2e1cc1f82f619eeb2aa22f06f01097bac355fd [3493/3591] serial: 8250: Add proper clock handling for OxSemi PCIe devices
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=ca2e1cc1f82f619eeb2aa22f06f01097bac355fd
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.18.y
        git checkout ca2e1cc1f82f619eeb2aa22f06f01097bac355fd
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/tty/device_drivers/oxsemi-tornado.rst:41: WARNING: Inline interpreted text or phrase reference start-string without end-string.
>> Documentation/tty/device_drivers/oxsemi-tornado.rst:96: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/tty/device_drivers/oxsemi-tornado.rst: WARNING: document isn't included in any toctree

vim +41 Documentation/tty/device_drivers/oxsemi-tornado.rst

    40	
  > 41	Here are the figures for the standard and some non-standard baud rates
    42	(including those quoted in Oxford Semiconductor documentation), giving
    43	the requested rate (r), the actual rate yielded (a) and its deviation
    44	from the requested rate (d), and the values of the oversampling rate
    45	(tcr), the clock prescaler (cpr) and the divisor (div) produced by the
    46	new `get_divisor' handler:
    47	
    48	r: 15625000, a: 15625000.00, d:  0.0000%, tcr:  4, cpr:  1.000, div:     1
    49	r: 12500000, a: 12500000.00, d:  0.0000%, tcr:  5, cpr:  1.000, div:     1
    50	r: 10416666, a: 10416666.67, d:  0.0000%, tcr:  6, cpr:  1.000, div:     1
    51	r:  8928571, a:  8928571.43, d:  0.0000%, tcr:  7, cpr:  1.000, div:     1
    52	r:  7812500, a:  7812500.00, d:  0.0000%, tcr:  8, cpr:  1.000, div:     1
    53	r:  4000000, a:  4000000.00, d:  0.0000%, tcr:  5, cpr:  3.125, div:     1
    54	r:  3686400, a:  3676470.59, d: -0.2694%, tcr:  8, cpr:  2.125, div:     1
    55	r:  3500000, a:  3496503.50, d: -0.0999%, tcr: 13, cpr:  1.375, div:     1
    56	r:  3000000, a:  2976190.48, d: -0.7937%, tcr: 14, cpr:  1.500, div:     1
    57	r:  2500000, a:  2500000.00, d:  0.0000%, tcr: 10, cpr:  2.500, div:     1
    58	r:  2000000, a:  2000000.00, d:  0.0000%, tcr: 10, cpr:  3.125, div:     1
    59	r:  1843200, a:  1838235.29, d: -0.2694%, tcr: 16, cpr:  2.125, div:     1
    60	r:  1500000, a:  1492537.31, d: -0.4975%, tcr:  5, cpr:  8.375, div:     1
    61	r:  1152000, a:  1152073.73, d:  0.0064%, tcr: 14, cpr:  3.875, div:     1
    62	r:   921600, a:   919117.65, d: -0.2694%, tcr: 16, cpr:  2.125, div:     2
    63	r:   576000, a:   576036.87, d:  0.0064%, tcr: 14, cpr:  3.875, div:     2
    64	r:   460800, a:   460829.49, d:  0.0064%, tcr:  7, cpr:  3.875, div:     5
    65	r:   230400, a:   230414.75, d:  0.0064%, tcr: 14, cpr:  3.875, div:     5
    66	r:   115200, a:   115207.37, d:  0.0064%, tcr: 14, cpr:  1.250, div:    31
    67	r:    57600, a:    57603.69, d:  0.0064%, tcr:  8, cpr:  3.875, div:    35
    68	r:    38400, a:    38402.46, d:  0.0064%, tcr: 14, cpr:  3.875, div:    30
    69	r:    19200, a:    19201.23, d:  0.0064%, tcr:  8, cpr:  3.875, div:   105
    70	r:     9600, a:     9600.06, d:  0.0006%, tcr:  9, cpr:  1.125, div:   643
    71	r:     4800, a:     4799.98, d: -0.0004%, tcr:  7, cpr:  2.875, div:   647
    72	r:     2400, a:     2400.02, d:  0.0008%, tcr:  9, cpr:  2.250, div:  1286
    73	r:     1200, a:     1200.00, d:  0.0000%, tcr: 14, cpr:  2.875, div:  1294
    74	r:      300, a:      300.00, d:  0.0000%, tcr: 11, cpr:  2.625, div:  7215
    75	r:      200, a:      200.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 15625
    76	r:      150, a:      150.00, d:  0.0000%, tcr: 13, cpr:  2.250, div: 14245
    77	r:      134, a:      134.00, d:  0.0000%, tcr: 11, cpr:  2.625, div: 16153
    78	r:      110, a:      110.00, d:  0.0000%, tcr: 12, cpr:  1.000, div: 47348
    79	r:       75, a:       75.00, d:  0.0000%, tcr:  4, cpr:  5.875, div: 35461
    80	r:       50, a:       50.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 62500
    81	r:       25, a:       25.00, d:  0.0000%, tcr: 16, cpr:  2.500, div: 62500
    82	r:        4, a:        4.00, d:  0.0000%, tcr: 16, cpr: 20.000, div: 48828
    83	r:        2, a:        2.00, d:  0.0000%, tcr: 16, cpr: 40.000, div: 48828
    84	r:        1, a:        1.00, d:  0.0000%, tcr: 16, cpr: 63.875, div: 61154
    85	
    86	With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX
    87	limitation imposed by `serial8250_get_baud_rate' standard baud rates
    88	below 300bps become unavailable in the regular way, e.g. the rate of
    89	200bps requires the baud base to be divided by 78125 and that is beyond
    90	the unsigned 16-bit range.  The historic spd_cust feature can still be
    91	used by encoding the values for, the prescaler, the oversampling rate
    92	and the clock divisor (DLM/DLL) as follows to obtain such rates if so
    93	required:
    94	
    95	 31 29 28             20 19   16 15                            0
  > 96	+-----+-----------------+-------+-------------------------------+
    97	|0 0 0|    CPR2:CPR     |  TCR  |            DLM:DLL            |
    98	+-----+-----------------+-------+-------------------------------+
    99	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
