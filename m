Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2F4908C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiAQMfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiAQMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:35:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6122C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56187B80EFE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B0DC36AE7;
        Mon, 17 Jan 2022 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642422920;
        bh=rid0/aiRZx6t3QXeqWiL2VjrsinUHZKuBq6XLd0Ck5A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uaJtp9LsuREZAqeLpZCNVcnAHek5+pHr1D93EIfP0qwaRRtkNTzkY1DO7Z4orZJ11
         rzGg+tpFbfPjBa2xUBITNnF5G2ChFmc71hUpLOKDkcXA004tEtn0eWDWPyOe7n3cWC
         Y++fREZo3LBJ0B1qUxIPXIheub0p6rtV3Kmz/eza1JJwzcQEmclesjL7dta2BnKfuG
         FN6XUNtesOw48Y3W68M3jY+0U3fNZWPrK9ueh8dPQTPyrPolt8wRhVOdX97b2Xd4ZG
         y7VolqA/J6cmJ3XwOwI5i6qfmQ1ukj570KbTN1sJNKGHpeCtCzWL5jPrwt6F0I/hME
         fUj+k5dP6pqew==
Subject: Re: ERROR: modpost: "gpmc_omap_get_nand_ops"
 [drivers/mtd/nand/raw/omap2_nand.ko] undefined!
To:     kernel test robot <lkp@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <202201171805.5HeoR4rS-lkp@intel.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <232ecd71-c4f8-6272-9a1e-91372763c3f5@kernel.org>
Date:   Mon, 17 Jan 2022 14:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202201171805.5HeoR4rS-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/01/2022 12:51, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0c947b893d69231a9add855939da7c66237ab44f
> commit: dbcb124acebd8148e9e858a231f1798956dd3ca6 mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
> date:   4 weeks ago
> config: arm64-randconfig-r001-20220117 (https://download.01.org/0day-ci/archive/20220117/202201171805.5HeoR4rS-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dbcb124acebd8148e9e858a231f1798956dd3ca6
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout dbcb124acebd8148e9e858a231f1798956dd3ca6
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "gpmc_omap_get_nand_ops" [drivers/mtd/nand/raw/omap2_nand.ko] undefined!

The issue is that CONFIG_MEMORY is not set so OMAP_GPMC driver is not built causing the above undefined symbol error.

> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for OMAP_GPMC
>    Depends on MEMORY && OF_ADDRESS
>    Selected by
>    - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST && HAS_IOMEM && ARCH_K3
> 

A possible fix would be to select MEMORY along with OMAP_GPMC at the below location

config MTD_NAND_OMAP2
        tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
        depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
        depends on HAS_IOMEM
	select MEMORY
^^
        select OMAP_GPMC if ARCH_K3 
        help
          Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
          and Keystone platforms.


Is this OK?

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

cheers,
-roger
