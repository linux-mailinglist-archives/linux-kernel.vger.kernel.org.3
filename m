Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA74B3EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiBNAfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:35:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiBNAfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:35:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FFB51E75
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=oX9SREFtlVDHQnhKalffBeT3HA5HM05B22C1+ce53zM=; b=rg8UpRPk6GH1AZ54OzAOfMzqfU
        Y/1ombvnV0baZfQ/VabZILwVe9XPCfeMOBN8tSxIU4ACliBYVBLika0bcKCceTs0hO4xf7sXBQRjx
        +2poVirVqQ9uClcQIXH4ZlpCD6N/Pf0OnRqJRv0T59IEdgsJId8Ab0XsVNMXr9G4PbHtJSvWYAn9F
        5zKh170EcuWgPvRa/GjuidvA23NH+8rgR1tEehi9f5WgmvNMr6eobtFk7/iIZy/JIreSEiodu46/X
        1I68Sl2G1vaB8bGygT3l6ABWUGq4B5xZDqkN8qxtS4dgpw5hoWeZCPh9eT+ITXIaIhu8XStLRTOsf
        jLgwimgw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJPKP-00COM5-Jm; Mon, 14 Feb 2022 00:34:53 +0000
Message-ID: <b45a15ec-549d-25ba-f818-ed503ba991de@infradead.org>
Date:   Sun, 13 Feb 2022 16:34:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: kernel/module_decompress.c:264:36: error: 'module_kset'
 undeclared; did you mean 'module_use'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <202202140027.K0xZn3T2-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202202140027.K0xZn3T2-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/22 08:57, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> commit: b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7 module: add in-kernel support for decompressing
> date:   5 weeks ago
> config: sparc-randconfig-r005-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140027.K0xZn3T2-lkp@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

FTR/FYI:
# CONFIG_SYSFS is not set

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/module_decompress.c: In function 'module_decompress_sysfs_init':
>>> kernel/module_decompress.c:264:36: error: 'module_kset' undeclared (first use in this function); did you mean 'module_use'?
>      264 |         error = sysfs_create_file(&module_kset->kobj,
>          |                                    ^~~~~~~~~~~
>          |                                    module_use
>    kernel/module_decompress.c:264:36: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +264 kernel/module_decompress.c
> 
>    259	
>    260	static int __init module_decompress_sysfs_init(void)
>    261	{
>    262		int error;
>    263	
>  > 264		error = sysfs_create_file(&module_kset->kobj,
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
~Randy
