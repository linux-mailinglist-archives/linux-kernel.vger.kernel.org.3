Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733F5A42F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiH2GJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiH2GJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:09:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463943328
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:09:08 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C6AB8481;
        Mon, 29 Aug 2022 08:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661753346;
        bh=65wUzXsVWRtBw2sStVthr/dCJlUlEuqnYzEKpuVAF5M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pdS49U60OI0J1wfXNKFCo1Jnz0yXeKQY3jxs5tT3OyLc32wec4kBOBrhtTzuHqj0P
         PNkrHi0Kuj+TplCtAaVNY+SB0Guhtac8Aj/c3c2aWBwz8sAwDRRSVzfiYA9vp7cwjF
         mD9DuO3No3U+LbuCon93fNxBM7VPBNy/87vE84S4=
Message-ID: <c56f84dc-338d-13f5-bd80-ad4a9b627908@ideasonboard.com>
Date:   Mon, 29 Aug 2022 09:09:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [pinchartl-media:drm/du/next 13/14]
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:6: warning: no previous prototype
 for function 'rcar_mipi_dsi_pclk_enable'
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202208282000.MtTNOyOx-lkp@intel.com>
 <Ywud3DnKFDCyjcBv@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <Ywud3DnKFDCyjcBv@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2022 19:54, Laurent Pinchart wrote:
> Hi Tomi,
> 
> On Sun, Aug 28, 2022 at 08:52:39PM +0800, kernel test robot wrote:
>> tree:   git://linuxtv.org/pinchartl/media.git drm/du/next
>> head:   1a1ef49313becc3127e3bd2b6cdb27e5fc54f761
>> commit: 81c238208c6accde5592851b101986b8b91ec859 [13/14] drm: rcar-du: Fix DSI enable & disable sequence
>> config: riscv-randconfig-c006-20220828 (https://download.01.org/0day-ci/archive/20220828/202208282000.MtTNOyOx-lkp@intel.com/config)
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install riscv cross compiling tool for clang build
>>          # apt-get install binutils-riscv-linux-gnu
>>          git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
>>          git fetch --no-tags pinchartl-media drm/du/next
>>          git checkout 81c238208c6accde5592851b101986b8b91ec859
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/rcar-du/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:6: warning: no previous prototype for function 'rcar_mipi_dsi_pclk_enable' [-Wmissing-prototypes]
>>     void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
>>          ^
>>     drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>     void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
>>     ^
>>     static
>>>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:653:6: warning: no previous prototype for function 'rcar_mipi_dsi_pclk_disable' [-Wmissing-prototypes]
>>     void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
>>          ^
>>     drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:653:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>     void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
>>     ^
>>     static
>>     2 warnings generated.
> 
> I'll squash the following fix in "drm: rcar-du: Fix DSI enable & disable
> sequence":
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> index 90128d5e3d17..a7f2b7f66a17 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> @@ -25,6 +25,7 @@
>   #include <drm/drm_panel.h>
>   #include <drm/drm_probe_helper.h>
> 
> +#include "rcar_mipi_dsi.h"
>   #include "rcar_mipi_dsi_regs.h"
> 
>   struct rcar_mipi_dsi {
> 

Looks good to me.

  Tomi
