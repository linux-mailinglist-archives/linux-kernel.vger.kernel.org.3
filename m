Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27D6537848
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiE3Jdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiE3Jdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:33:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12B703DB;
        Mon, 30 May 2022 02:33:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2E08E1F4239C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653903212;
        bh=lMKzFjgelCV6B+f+Iojh6N9K0j7OtZvxDvvRazCQGi8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e6XuJscA8OJ6A7Fm17Uq+gRoKgI6zyt8LrLBK7yB7ArBvRoXJRT7bFM0eSdRJGzFz
         9MtKae83zjZPsD06ZP6TJXtaz0rZDtz5IsOSHYpnVlu11jQOiO1NXC+MYsAfwLT87k
         xnpRjjICuJAHkns9zk1BegDzpMgZwqO+E2LhrdrtOTsT87WYSjH6VPQAgzSnVVb9ee
         czgPbdHxfFSJxnqoAqkb8wpT+hhVlEUZMIp6dhZlnBuEd6r3+ALjs7+6QCQSygPim9
         CbrEQj/WZr1UnxPYm7O7j4S4vzijkbP0sUarC1XOL3T6VEHE19R+uB0c89IevEZiD2
         RiSMTFTQJSMwg==
Message-ID: <540be3e8-6a97-5e80-3767-892025ded07b@collabora.com>
Date:   Mon, 30 May 2022 11:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/4] regulator: Add driver for MT6332 PMIC regulators
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, lgirdwood@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220523154709.118663-5-angelogioacchino.delregno@collabora.com>
 <202205262341.pY4PkDL7-lkp@intel.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <202205262341.pY4PkDL7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/22 17:12, kernel test robot ha scritto:
> Hi AngeloGioacchino,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on broonie-regulator/for-next]
> [also build test ERROR on v5.18 next-20220526]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/MediaTek-Helio-X10-MT6795-MT6331-6332-Regulators/20220523-235049
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220526/202205262341.pY4PkDL7-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3d546191ad9d7d2ad2c7928204b9de51deafa675)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/062027827142f02db7e65b052d458f424811e30e
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/MediaTek-Helio-X10-MT6795-MT6331-6332-Regulators/20220523-235049
>          git checkout 062027827142f02db7e65b052d458f424811e30e
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/regulator/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/regulator/mt6332-regulator.c:15:10: fatal error: 'linux/mfd/mt6332/registers.h' file not found
>     #include <linux/mfd/mt6332/registers.h>


Note for maintainers: this failure is expected, as this series depends on the
series that introduces the MT6331 and MT6332 MFD device (with its headers, used
by the regulator driver of this series)

https://patchwork.kernel.org/project/linux-mediatek/list/?series=643602



>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1 error generated.
> 
> 
> vim +15 drivers/regulator/mt6332-regulator.c
> 
>       9	
>      10	#include <linux/module.h>
>      11	#include <linux/of.h>
>      12	#include <linux/platform_device.h>
>      13	#include <linux/regmap.h>
>      14	#include <linux/mfd/mt6397/core.h>
>    > 15	#include <linux/mfd/mt6332/registers.h>
>      16	#include <linux/regulator/driver.h>
>      17	#include <linux/regulator/machine.h>
>      18	#include <linux/regulator/mt6332-regulator.h>
>      19	#include <linux/regulator/of_regulator.h>
>      20	
> 
