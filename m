Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5635A55C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiH2Usv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiH2Usr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:48:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CC9C2E7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:48:46 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8CFB26601E7E;
        Mon, 29 Aug 2022 21:48:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661806125;
        bh=ITBsfXO4TLfozLpS9mMyEGgWsWwWiO6v325lcT5dOeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFPKpczLQ6g4Ywmg1CkkRcN8HBV5MMLOzKwgnVMCxupyh6BFAIeEdsgnHqauwvSFM
         bDqy9akL9UPEhi1MaGgch8czsoyqaOE6EbbEvmkqk4EdTBI0fBr0z9YJD0GZsM1vAQ
         VtCg+TaTmvaoxNd7r+fBOW1MIdJ6Tx4cA+VnPXc15rl+oq5atey3Yf+ySjtxnKqL9/
         xF5c3lfXkG3W3uXVjqGw9nCfmE37oThh7sQpooyqOQ+TUBP0vk7PcsY8yzI3YWFA6i
         nRwROXSNp3YOOXmn/JLr9OzGW40YA4QKNW42mn+f1S6vW0KPMNmC0h8tCkuCbyxoUm
         5MDglA52yjDqw==
Date:   Mon, 29 Aug 2022 16:48:40 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     kernel test robot <lkp@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [matthias-bgg:v6.0-next/soc 11/11]
 drivers/soc/mediatek/mtk-svs.c:887:47: error: implicit declaration of
 function 'FIELD_GET'; did you mean 'FOLL_GET'?
Message-ID: <20220829204840.iwhysofe7n4ddnlw@notapiano>
References: <202208270239.HjU7TSCX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202208270239.HjU7TSCX-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 02:51:47AM +0800, kernel test robot wrote:
> Hi AngeloGioacchino,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v6.0-next/soc
> head:   a92438c5a30a27b6791da025306a45478a6ac7a4
> commit: a92438c5a30a27b6791da025306a45478a6ac7a4 [11/11] soc: mediatek: mtk-svs: Use bitfield access macros where possible
> config: arm-buildonly-randconfig-r006-20220823 (https://download.01.org/0day-ci/archive/20220827/202208270239.HjU7TSCX-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?id=a92438c5a30a27b6791da025306a45478a6ac7a4
>         git remote add matthias-bgg https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
>         git fetch --no-tags matthias-bgg v6.0-next/soc
>         git checkout a92438c5a30a27b6791da025306a45478a6ac7a4
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/mediatek/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/soc/mediatek/mtk-svs.c: In function 'svs_get_bank_volts_v3':
> >> drivers/soc/mediatek/mtk-svs.c:887:47: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
>      887 |                         svsb->volt[turn_pt] = FIELD_GET(SVSB_VOPS_FLD_VOP0_4, vop30);
>          |                                               ^~~~~~~~~
>          |                                               FOLL_GET
>    drivers/soc/mediatek/mtk-svs.c: In function 'svs_set_bank_freq_pct_v2':
> >> drivers/soc/mediatek/mtk-svs.c:1073:25: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
>     1073 |         freqpct74_val = FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb->freq_pct[8]) |
>          |                         ^~~~~~~~~~
>    cc1: some warnings being treated as errors

Hi,

thanks for the report. Fix sent [1].

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220829204439.3748648-1-nfraprado@collabora.com
