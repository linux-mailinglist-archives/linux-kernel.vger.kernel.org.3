Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224150E5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiDYQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbiDYQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:31:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514A205F0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tA+eK39y5CiTUpYxk2j7KO7uCUuIxmeF7H9cyjhTkcA=; b=Fgo3HIfXCUniND86DHLGwGAHMm
        GOjixI/0BWrd3lHxddAvmNaZTAp24+vq92edqFkNqi60FfqLGEWqn0AtschyjAiMEuyaUOUcxcDAu
        HZG7secfuimD8ybgsMWkA8M7CpgeQ1a0NbcgAGoSg38kbCcICFUnoKGcsYyc/keM++o2Po3M8AxkA
        RVLYzk9nubfYFSjdo5wTaZgbzeqh4NaoejzOxScTZN7bnmPjWvcxJugDuYZzi0+DbCJlaXgS1RVMz
        TbUGmMEqEfzrfWLO60v2fomN/Pg8FLj7Yo/ACcPlsVi1jSdmPv6cuXaR+Fcw5ijkZ5paJ4brLwnWj
        A7sYA4ZA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj1Z0-008Zwp-UO; Mon, 25 Apr 2022 16:27:51 +0000
Message-ID: <f8103fcf-1a16-6247-6ec8-aef8a59d0a48@infradead.org>
Date:   Mon, 25 Apr 2022 09:27:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: isl7998x.c:undefined reference to `v4l2_fwnode_endpoint_parse'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Michael Tretter <m.tretter@pengutronix.de>
References: <202204252008.EH3XUAjp-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202204252008.EH3XUAjp-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/22 05:30, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   af2d861d4cd2a4da5137f795ee3509e6f944a25b
> commit: 51ef2be546e2e480e56fdb59fdeb9a4406e8d52e media: i2c: isl7998x: Add driver for Intersil ISL7998x
> date:   8 weeks ago
> config: riscv-randconfig-r026-20220425 (https://download.01.org/0day-ci/archive/20220425/202204252008.EH3XUAjp-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51ef2be546e2e480e56fdb59fdeb9a4406e8d52e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 51ef2be546e2e480e56fdb59fdeb9a4406e8d52e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    riscv64-linux-ld: drivers/media/i2c/isl7998x.o: in function `.L0 ':
>>> isl7998x.c:(.text+0xa54): undefined reference to `v4l2_fwnode_endpoint_parse'

for isl7998x.c:
https://lore.kernel.org/all/20220330015652.5420-1-rdunlap@infradead.org/

>    riscv64-linux-ld: net/core/sock.o: in function `.L1089':
>    sock.c:(.text+0x5190): undefined reference to `__sk_defer_free_flush'
> 

-- 
~Randy
