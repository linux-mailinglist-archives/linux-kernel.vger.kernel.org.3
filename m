Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF849253B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbiARLwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:52:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60376 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiARLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:51:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2120B612D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566E8C00446;
        Tue, 18 Jan 2022 11:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642506707;
        bh=ruqQ6u6+OHL8NnX5Pv6LIHWbAvMY/0Tismmqvqx2R1E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pSUDCxNTutCw8Cjy/JJ31D0YEBp8+1xGCDC1poKzZnvm6co8FjjO8MGZUHZnh/otg
         vCAa2/DVZ3Wej3RiZcLqqJFkmIPLu3jtIeA7p/3BPhQ1iHaKfLZp4z6BFzfCKJy9/w
         cv1BjjepYBWEmMWQHVNX6/7ZQ1ZfhnbhXAqfPPVRpENm0rfLQtOHHNvi4bcPLsfv9Z
         /FZtmmJf/QbUs1n7Jadv1dTchilhgROZgdF+U0ykcINSgH1Lb6JVnGPPyY/j59Q8PA
         OVLNWYx2joPmo/vcHYcGU1glOBRScyJLP0filqj6ODcCqhKCVCwj+AhP2ZpZDOPIYF
         i5Aa9nQRFXP9w==
Subject: Re: ERROR: modpost: "gpmc_omap_get_nand_ops"
 [drivers/mtd/nand/raw/omap2_nand.ko] undefined!
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202201171805.5HeoR4rS-lkp@intel.com>
 <232ecd71-c4f8-6272-9a1e-91372763c3f5@kernel.org>
 <57ad6f87-2198-92c6-8c26-f5b5a8d8a354@canonical.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <7c523b72-2285-80b9-e0fc-0fbb2aa9d439@kernel.org>
Date:   Tue, 18 Jan 2022 13:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <57ad6f87-2198-92c6-8c26-f5b5a8d8a354@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 17/01/2022 15:08, Krzysztof Kozlowski wrote:
> On 17/01/2022 13:35, Roger Quadros wrote:
>> Hi,
>>
>> On 17/01/2022 12:51, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   0c947b893d69231a9add855939da7c66237ab44f
>>> commit: dbcb124acebd8148e9e858a231f1798956dd3ca6 mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
>>> date:   4 weeks ago
>>> config: arm64-randconfig-r001-20220117 (https://download.01.org/0day-ci/archive/20220117/202201171805.5HeoR4rS-lkp@intel.com/config)
>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # install arm64 cross compiling tool for clang build
>>>         # apt-get install binutils-aarch64-linux-gnu
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dbcb124acebd8148e9e858a231f1798956dd3ca6
>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>         git fetch --no-tags linus master
>>>         git checkout dbcb124acebd8148e9e858a231f1798956dd3ca6
>>>         # save the config file to linux build tree
>>>         mkdir build_dir
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>>>> ERROR: modpost: "gpmc_omap_get_nand_ops" [drivers/mtd/nand/raw/omap2_nand.ko] undefined!
>>
>> The issue is that CONFIG_MEMORY is not set so OMAP_GPMC driver is not built causing the above undefined symbol error.
>>
>>>
>>> Kconfig warnings: (for reference only)
>>>    WARNING: unmet direct dependencies detected for OMAP_GPMC
>>>    Depends on MEMORY && OF_ADDRESS
>>>    Selected by
>>>    - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST && HAS_IOMEM && ARCH_K3
>>>
>>
>> A possible fix would be to select MEMORY along with OMAP_GPMC at the below location
>>
>> config MTD_NAND_OMAP2
>>         tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>         depends on HAS_IOMEM
>> 	select MEMORY
>> ^^
>>         select OMAP_GPMC if ARCH_K3 
>>         help
>>           Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>>           and Keystone platforms.
>>
>>
>> Is this OK?
> 
> Instead rather "select MEMORY if ARCH_K3"?

I think we should drop "if ARCH_K3" for both for simplicity as the driver is using gpmc_omap_get_nand_ops() from that driver.

> 
> However I had impression that selecting a user-visible options is
> discouraged, especially from within the drivers. What I would expect is
> to select it from the machine/architecture code like you did before [1]
> but was rejected by Nishanth.
> 
> https://lore.kernel.org/linux-devicetree/20211217161417.q2qwwlki7oieqzjd@headlock/

OMAP_GPMC option is not user visible. Else I would have just made MTD_NAND_OMAP2 depend on it.

> 
> In such case, your choice (with if ARCH...?) seems sensible.
> MTD_NAND_FSL_IFC already does it.
> 

cheers,
-roger
