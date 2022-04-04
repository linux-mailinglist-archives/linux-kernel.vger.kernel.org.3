Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1E4F16AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbiDDODG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 10:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376760AbiDDOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:02:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B621AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:00:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbNGD-0002dJ-IU; Mon, 04 Apr 2022 16:00:49 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbNGE-0012SW-7j; Mon, 04 Apr 2022 16:00:48 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbNGC-0009Jb-16; Mon, 04 Apr 2022 16:00:48 +0200
Message-ID: <4a60a46820858adbd9de3b41d37fbc8ddc6c6549.camel@pengutronix.de>
Subject: Re: [pza:reset/next 11/11] drivers/reset/core.c:1114:22: error:
 implicit declaration of function 'acpi_has_method'; did you mean
 'acpi_has_watchdog'?
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     kernel test robot <lkp@intel.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Apr 2022 16:00:47 +0200
In-Reply-To: <202204042122.vBjzQg7a-lkp@intel.com>
References: <202204042122.vBjzQg7a-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2022-04-04 at 21:25 +0800, kernel test robot wrote:
> tree:   https://git.pengutronix.de/git/pza/linux reset/next
> head:   7272ce0fa39b66aa91c934a27e9196082a3ffc40
> commit: 7272ce0fa39b66aa91c934a27e9196082a3ffc40 [11/11] reset: ACPI
> reset support
> config: h8300-randconfig-m031-20220404 (
> https://download.01.org/0day-ci/archive/20220404/202204042122.vBjzQg7a-lkp@intel.com/config
> )
> compiler: h8300-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add pza https://git.pengutronix.de/git/pza/linux
>         git fetch --no-tags pza reset/next
>         git checkout 7272ce0fa39b66aa91c934a27e9196082a3ffc40
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0
> make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/reset/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/reset/core.c: In function '__device_reset':
> > > drivers/reset/core.c:1114:22: error: implicit declaration of
> > > function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-
> > > Werror=implicit-function-declaration]
>     1114 |                 if (!acpi_has_method(handle, "_RST"))
>          |                      ^~~~~~~~~~~~~~~
>          |                      acpi_has_watchdog
>    cc1: some warnings being treated as errors

Apologies, I should have caught this. Unfortunately we are missing
stubs for the ACPI functions. I'll fix it up by wrapping the new code
in #ifdef CONFIG_ACPI.

regards
Philipp
