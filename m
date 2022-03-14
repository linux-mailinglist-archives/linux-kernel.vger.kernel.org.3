Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839384D7F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiCNKNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiCNKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:13:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D43BFB5;
        Mon, 14 Mar 2022 03:12:10 -0700 (PDT)
X-UUID: 34a4a5cbefd240d0a7da37f4ab256220-20220314
X-UUID: 34a4a5cbefd240d0a7da37f4ab256220-20220314
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1468474834; Mon, 14 Mar 2022 18:11:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Mar 2022 18:11:55 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Mar 2022 18:11:55 +0800
Message-ID: <e7e4b31d82fc7a18581dd3daa468297e8b662ea1.camel@mediatek.com>
Subject: Re: [v3 13/19] ASoC: mediatek: mt8186: add platform driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     kernel test robot <lkp@intel.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <angelogioacchino.delregno@collabora.com>
CC:     <kbuild-all@lists.01.org>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <tzungbi@google.com>, <julianbraha@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 14 Mar 2022 18:11:54 +0800
In-Reply-To: <202203140250.ob821GmA-lkp@intel.com>
References: <20220313151023.21229-14-jiaxin.yu@mediatek.com>
         <202203140250.ob821GmA-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-14 at 02:59 +0800, kernel test robot wrote:
> Hi Jiaxin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on broonie-sound/for-next]
> [also build test ERROR on broonie-spi/for-next robh/for-next v5.17-
> rc7 next-20220310]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    
> https://github.com/0day-ci/linux/commits/Jiaxin-Yu/ASoC-mediatek-Add-support-for-MT8186-SoC/20220313-231330
> base:   
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> for-next
> config: m68k-allyesconfig (
> https://download.01.org/0day-ci/archive/20220314/202203140250.ob821GmA-lkp@intel.com/config
> )
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # 
> https://github.com/0day-ci/linux/commit/088850061de683cf1cac329e1187f45fb1d25085
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jiaxin-Yu/ASoC-mediatek-Add-
> support-for-MT8186-SoC/20220313-231330
>         git checkout 088850061de683cf1cac329e1187f45fb1d25085
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0
> make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/device.h:15,
>                     from include/linux/dma-mapping.h:7,
>                     from sound/soc/mediatek/mt8186/mt8186-afe-
> pcm.c:9:
>    sound/soc/mediatek/mt8186/mt8186-afe-pcm.c: In function
> 'mt8186_afe_pcm_dev_probe':
> > > sound/soc/mediatek/mt8186/mt8186-afe-pcm.c:2914:40: error:
> > > 'struct dev_pm_info' has no member named 'runtime_error'
> 
>     2914 |                         ret, dev->power.runtime_error);
>          |                                        ^
>    include/linux/dev_printk.h:110:37: note: in definition of macro
> 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt,
> ##__VA_ARGS__);                       \
>          |                                     ^~~~~~~~~~~
>    sound/soc/mediatek/mt8186/mt8186-afe-pcm.c:2913:17: note: in
> expansion of macro 'dev_err'
>     2913 |                 dev_err(dev, "get_ret:%d, rpm_error:%d\n",
>          |                 ^~~~~~~
>    sound/soc/mediatek/mt8186/mt8186-afe-pcm.c:2948:40: error: 'struct
> dev_pm_info' has no member named 'runtime_error'
>     2948 |                         ret, dev->power.runtime_error);
>          |                                        ^
>    include/linux/dev_printk.h:110:37: note: in definition of macro
> 'dev_printk_index_wrap'
>      110 |                 _p_func(dev, fmt,
> ##__VA_ARGS__);                       \
>          |                                     ^~~~~~~~~~~
>    sound/soc/mediatek/mt8186/mt8186-afe-pcm.c:2947:17: note: in
> expansion of macro 'dev_err'
>     2947 |                 dev_err(dev, "put_ret:%d, rpm_error:%d\n",
>          |                 ^~~~~~~
> 
I'm terrible sorry about this build error. These sections of code need
be wrapped by the CONFIG_PM, or don't use these variables. I will fix
it in the next v4 version.

> 
> vim +2914 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> 
>   2803	
>   2804	static int mt8186_afe_pcm_dev_probe(struct
> platform_device *pdev)
>   2805	{
>   2806		struct mtk_base_afe *afe;
>   2807		struct mt8186_afe_private *afe_priv;
>   2808		struct resource *res;
>   2809		struct reset_control *rstc;
>   2810		struct device *dev = &pdev->dev;
>   2811		int i, ret, irq_id;
>   2812	
>   2813		ret = dma_set_mask_and_coherent(dev,
> DMA_BIT_MASK(34));
>   2814		if (ret)
>   2815			return ret;
>   2816	
>   2817		afe = devm_kzalloc(dev, sizeof(*afe),
> GFP_KERNEL);
>   2818		if (!afe)
>   2819			return -ENOMEM;
>   2820		platform_set_drvdata(pdev, afe);
>   2821	
>   2822		afe->platform_priv = devm_kzalloc(dev,
> sizeof(*afe_priv), GFP_KERNEL);
>   2823		if (!afe->platform_priv)
>   2824			return -ENOMEM;
>   2825	
>   2826		afe_priv = afe->platform_priv;
>   2827		afe->dev = &pdev->dev;
>   2828	
>   2829		res = platform_get_resource(pdev,
> IORESOURCE_MEM, 0);
>   2830		afe->base_addr = devm_ioremap_resource(&pdev-
> >dev, res);
>   2831		if (IS_ERR(afe->base_addr))
>   2832			return PTR_ERR(afe->base_addr);
>   2833	
>   2834		/* init audio related clock */
>   2835		ret = mt8186_init_clock(afe);
>   2836		if (ret) {
>   2837			dev_err(dev, "init clock error, ret
> %d\n", ret);
>   2838			return ret;
>   2839		}
>   2840	
>   2841		/* init memif */
>   2842		afe->memif_32bit_supported = 0;
>   2843		afe->memif_size = MT8186_MEMIF_NUM;
>   2844		afe->memif = devm_kcalloc(dev, afe->memif_size, 
> sizeof(*afe->memif),
>   2845					  GFP_KERNEL);
>   2846	
>   2847		if (!afe->memif)
>   2848			return -ENOMEM;
>   2849	
>   2850		for (i = 0; i < afe->memif_size; i++) {
>   2851			afe->memif[i].data = &memif_data[i];
>   2852			afe->memif[i].irq_usage =
> memif_irq_usage[i];
>   2853			afe->memif[i].const_irq = 1;
>   2854		}
>   2855	
>   2856		mutex_init(&afe->irq_alloc_lock);	/* needed
> when dynamic irq */
>   2857	
>   2858		/* init irq */
>   2859		afe->irqs_size = MT8186_IRQ_NUM;
>   2860		afe->irqs = devm_kcalloc(dev, afe->irqs_size,
> sizeof(*afe->irqs),
>   2861					 GFP_KERNEL);
>   2862	
>   2863		if (!afe->irqs)
>   2864			return -ENOMEM;
>   2865	
>   2866		for (i = 0; i < afe->irqs_size; i++)
>   2867			afe->irqs[i].irq_data = &irq_data[i];
>   2868	
>   2869		/* request irq */
>   2870		irq_id = platform_get_irq(pdev, 0);
>   2871		if (irq_id <= 0)
>   2872			return dev_err_probe(dev, irq_id < 0 ?
> irq_id : -ENXIO,
>   2873					     "no irq found");
>   2874	
>   2875		ret = devm_request_irq(dev, irq_id,
> mt8186_afe_irq_handler,
>   2876				       IRQF_TRIGGER_NONE,
>   2877				       "Afe_ISR_Handle", (void
> *)afe);
>   2878		if (ret)
>   2879			return dev_err_probe(dev, ret, "could
> not request_irq for Afe_ISR_Handle\n");
>   2880	
>   2881		ret = enable_irq_wake(irq_id);
>   2882		if (ret < 0)
>   2883			return dev_err_probe(dev, ret,
> "enable_irq_wake %d\n", irq_id);
>   2884	
>   2885		/* init sub_dais */
>   2886		INIT_LIST_HEAD(&afe->sub_dais);
>   2887	
>   2888		for (i = 0; i < ARRAY_SIZE(dai_register_cbs);
> i++) {
>   2889			ret = dai_register_cbs[i](afe);
>   2890			if (ret)
>   2891				return dev_err_probe(dev, ret,
> "dai register i %d fail\n", i);
>   2892		}
>   2893	
>   2894		/* init dai_driver and component_driver */
>   2895		ret = mtk_afe_combine_sub_dai(afe);
>   2896		if (ret)
>   2897			return dev_err_probe(dev, ret,
> "mtk_afe_combine_sub_dai fail\n");
>   2898	
>   2899		/* reset controller to reset audio regs before
> regmap cache */
>   2900		rstc = devm_reset_control_get_exclusive(dev,
> "audiosys");
>   2901		if (IS_ERR(rstc))
>   2902			return dev_err_probe(dev,
> PTR_ERR(rstc), "could not get audiosys reset\n");
>   2903	
>   2904		ret = reset_control_reset(rstc);
>   2905		if (ret)
>   2906			return dev_err_probe(dev, ret, "failed
> to trigger audio reset\n");
>   2907	
>   2908		/* enable clock for regcache get default value
> from hw */
>   2909		afe_priv->pm_runtime_bypass_reg_ctl = true;
>   2910		pm_runtime_enable(dev);
>   2911		ret = pm_runtime_get_sync(dev);
>   2912		if (ret)
>   2913			dev_err(dev, "get_ret:%d,
> rpm_error:%d\n",
> > 2914				ret, dev->power.runtime_error);
> 
>   2915	
>   2916		afe->regmap = devm_regmap_init_mmio(dev, afe-
> >base_addr,
>   2917						    &mt8186_afe
> _regmap_config);
>   2918		if (IS_ERR(afe->regmap)) {
>   2919			ret = PTR_ERR(afe->regmap);
>   2920			goto err_pm_disable;
>   2921		}
>   2922	
>   2923		/* others */
>   2924		afe->mtk_afe_hardware = &mt8186_afe_hardware;
>   2925		afe->memif_fs = mt8186_memif_fs;
>   2926		afe->irq_fs = mt8186_irq_fs;
>   2927		afe->get_dai_fs = mt8186_get_dai_fs;
>   2928		afe->get_memif_pbuf_size =
> mt8186_get_memif_pbuf_size;
>   2929	
>   2930		afe->runtime_resume =
> mt8186_afe_runtime_resume;
>   2931		afe->runtime_suspend =
> mt8186_afe_runtime_suspend;
>   2932	
>   2933		/* register platform */
>   2934		dev_info(dev, "%s(),
> devm_snd_soc_register_component\n", __func__);
>   2935	
>   2936		ret = devm_snd_soc_register_component(dev,
>   2937						      &mt8186_a
> fe_component,
>   2938						      afe-
> >dai_drivers,
>   2939						      afe-
> >num_dai_drivers);
>   2940		if (ret) {
>   2941			dev_err(dev, "err_dai_component\n");
>   2942			goto err_pm_disable;
>   2943		}
>   2944	
>   2945		ret = pm_runtime_put_sync(dev);
>   2946		if (ret)
>   2947			dev_err(dev, "put_ret:%d,
> rpm_error:%d\n",
>   2948				ret, dev->power.runtime_error);
>   2949		afe_priv->pm_runtime_bypass_reg_ctl = false;
>   2950	
>   2951		regcache_cache_only(afe->regmap, true);
>   2952		regcache_mark_dirty(afe->regmap);
>   2953	
>   2954		return 0;
>   2955	
>   2956	err_pm_disable:
>   2957		pm_runtime_put_sync(dev);
>   2958		pm_runtime_disable(dev);
>   2959	
>   2960		return ret;
>   2961	}
>   2962	
> 
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

