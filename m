Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB53E5B225C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiIHPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiIHPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:33:37 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B2120B0;
        Thu,  8 Sep 2022 08:33:32 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0AE112000D;
        Thu,  8 Sep 2022 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662651208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdKcGQxR+2v+D+uRgeMyPmOl42z47nLjBaXhbBwGaX4=;
        b=LSkfEC257xBfJ7nk91EuX3eNbR1eWBKmOhi/2jbiRnJWsWWq0x9DNdejtL8mmjyo/JhfSD
        vIa4Onqili2PeIydC+IpO0plkswuunIq6xH5dfe9yWSD1ov7ivzekxg5jH6l18X1JH2bz1
        IrzgpSAEX+6FxT7Z79Mkq4htLlndiPiL7tSFoWCsXjuNFKEiEh3MOCsmHloxNiXI14/sbM
        woCoE1YHHxtyHDYVn43AEJLV0j0pkupNCzYbIi2eaMiIwEjpfptfCOzEyug57Cpnb3rlQy
        nf/vKZ+Gvg3UZDVIbQmLZTbVIIrrW8Oh7gB9iuWPJOaK5BYtDga0EHgV6G6IuA==
Date:   Thu, 8 Sep 2022 17:33:23 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org, lkp@intel.com,
        kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add RK3308 internal audio codec
 driver
Message-ID: <20220908173323.3981a056@booty>
In-Reply-To: <202209082103.F4ICyyHT-lkp@intel.com>
References: <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
        <202209082103.F4ICyyHT-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Thu, 8 Sep 2022 16:35:19 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hi,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/luca-ceresoli-bootlin-com/Add-support-for-the-internal-RK3308-audio-codec/20220907-222555
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: arc-randconfig-m031-20220908 (https://download.01.org/0day-ci/archive/20220908/202209082103.F4ICyyHT-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> sound/soc/codecs/rk3308_codec.c:748 rk3308_set_dai_fmt() error: uninitialized symbol 'is_master'.
> sound/soc/codecs/rk3308_codec.c:998 rk3308_codec_digital_fadeout() warn: always true condition '(l_dgain >= (0 << 0)) => (0-u32max >= 0)'
> sound/soc/codecs/rk3308_codec.c:998 rk3308_codec_digital_fadeout() warn: always true condition '(l_dgain >= (0 << 0)) => (0-u32max >= 0)'
> 
> vim +/is_master +748 sound/soc/codecs/rk3308_codec.c
> 
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  680  static int rk3308_set_dai_fmt(struct snd_soc_dai *codec_dai,
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  681  			      unsigned int fmt)
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  682  {
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  683  	struct snd_soc_component *component = codec_dai->component;
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  684  	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  685  	const unsigned int inv_bits = fmt & SND_SOC_DAIFMT_INV_MASK;
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  686  	const bool inv_bitclk =
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  687  		(inv_bits & SND_SOC_DAIFMT_IB_IF) ||
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  688  		(inv_bits & SND_SOC_DAIFMT_IB_NF);
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  689  	const bool inv_frmclk =
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  690  		(inv_bits & SND_SOC_DAIFMT_IB_IF) ||
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  691  		(inv_bits & SND_SOC_DAIFMT_NB_IF);
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  692  
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  693  	unsigned int adc_aif1 = 0, adc_aif2 = 0, dac_aif1 = 0, dac_aif2 = 0;
> 786c160ad64ae5 Luca Ceresoli 2022-09-07  694  	int grp, is_master;
> 
> is_master needs to be initialized to false.

Fixed both, and also made is_master a bool for clarity. Changes queued
for v2.

Thank you.
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
