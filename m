Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61A6568818
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiGFMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiGFMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:13:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306F264F;
        Wed,  6 Jul 2022 05:13:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 074D8660199B;
        Wed,  6 Jul 2022 13:13:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657109627;
        bh=2t6an7ht5+yC7+PkXcKGyRHYvhD0KwqrgG+sCGpknV0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I7+pJxvj8QKrPt8AqHOdoMj/JaWxoFIsBuu34K1/BPeWknPODXtmKVCf0/fFutsn5
         +CND8+23+VmYTE15beI3VZ/Y4GBp2YjFPEdQI32d+2DcGak2oGSr2wI6r3DbHpqjhG
         5Q3budolLZYAIiT663I+VPqnA2vtKSXDNxgqHamjouwLLTyr8Gtfmv592KNWkna+Cj
         giA6RjDeX1YIH2l97eiJrOdnrot+QKDJOFv5AYRLB1odmVkdBC0rAfK2M77QJCo6hf
         h+gscEkJCL6+hXqmC1HXaI+JP0GXkczmF0MGd2HX2MFGLSFqi5gNtOOFs097nBxLzr
         FgNj3gcjln8Mw==
Message-ID: <4e55465d-ccf1-56b0-dfa4-84832edfa937@collabora.com>
Date:   Wed, 6 Jul 2022 14:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 RESEND] Input: mtk-pmic-keys - Add support for MT6331
 PMIC keys
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, dmitry.torokhov@gmail.com
Cc:     kbuild-all@lists.01.org, matthias.bgg@gmail.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220706101122.201007-1-angelogioacchino.delregno@collabora.com>
 <202207061915.tYTQKEhu-lkp@intel.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <202207061915.tYTQKEhu-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/22 13:44, kernel test robot ha scritto:
> Hi AngeloGioacchino,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on dtor-input/next]
> [also build test ERROR on linus/master v5.19-rc5 next-20220705]


This patch compiles fine on next-20220706.


> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/Input-mtk-pmic-keys-Add-support-for-MT6331-PMIC-keys/20220706-181323
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: arc-randconfig-r043-20220703 (https://download.01.org/0day-ci/archive/20220706/202207061915.tYTQKEhu-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/5e286347fa7c13c4674f97ed475e4f42a49ce5b4
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/Input-mtk-pmic-keys-Add-support-for-MT6331-PMIC-keys/20220706-181323
>          git checkout 5e286347fa7c13c4674f97ed475e4f42a49ce5b4
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/input/keyboard/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/input/keyboard/mtk-pmic-keys.c:12:10: fatal error: linux/mfd/mt6331/registers.h: No such file or directory
>        12 | #include <linux/mfd/mt6331/registers.h>
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
> 
> 
> vim +12 drivers/input/keyboard/mtk-pmic-keys.c
> 
>    > 12	#include <linux/mfd/mt6331/registers.h>
>      13	#include <linux/mfd/mt6358/registers.h>
>      14	#include <linux/mfd/mt6397/core.h>
>      15	#include <linux/mfd/mt6397/registers.h>
>      16	#include <linux/module.h>
>      17	#include <linux/of_device.h>
>      18	#include <linux/of.h>
>      19	#include <linux/platform_device.h>
>      20	#include <linux/regmap.h>
>      21	
> 

