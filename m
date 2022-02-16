Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA04B8103
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiBPHIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:08:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiBPHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:08:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FB256EC6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:07:42 -0800 (PST)
X-UUID: f7482e9d5ff44fd1acd5f75adc50e8b2-20220216
X-UUID: f7482e9d5ff44fd1acd5f75adc50e8b2-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1743981165; Wed, 16 Feb 2022 14:40:53 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Feb 2022 14:40:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 14:40:52 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 14:40:50 +0800
Message-ID: <553286c9a2fe458f994b334c968eb9899eed892d.camel@mediatek.com>
Subject: Re: [deller-fbdev:for-next 51/51]
 drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:42: error: use of
 undeclared identifier 'component_compare_dev'; did you mean
 'component_master_del'?
From:   Yong Wu <yong.wu@mediatek.com>
To:     Helge Deller <deller@gmx.de>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Date:   Wed, 16 Feb 2022 14:40:49 +0800
In-Reply-To: <202202161324.Jh1OfqAf-lkp@intel.com>
References: <202202161324.Jh1OfqAf-lkp@intel.com>
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

Hi Helge,

Thanks for apply this patch.

Sorry that I didn't Cc you in cover-letter. It depend on [1/23].

To avoid this build fail, Could you help revert this one?

Thanks

On Wed, 2022-02-16 at 13:31 +0800, kernel test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-
> fbdev.git for-next
> head:   61038027aa13351c63b452a0d48c805bab1d2ce9
> commit: 61038027aa13351c63b452a0d48c805bab1d2ce9 [51/51] video:
> fbdev: omapfb: Make use of the helper component_compare_dev
> config: arm-randconfig-c002-20220216 (
> https://download.01.org/0day-ci/archive/20220216/202202161324.Jh1OfqAf-lkp@intel.com/config
> )
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project
> 0e628a783b935c70c80815db6c061ec84f884af5)
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # 
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=61038027aa13351c63b452a0d48c805bab1d2ce9
>         git remote add deller-fbdev
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
>         git fetch --no-tags deller-fbdev for-next
>         git checkout 61038027aa13351c63b452a0d48c805bab1d2ce9
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> drivers/video/fbdev/omap2/omapfb/dss/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> > > drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:42: error: use of
> > > undeclared identifier 'component_compare_dev'; did you mean
> > > 'component_master_del'?
> 
>            component_match_add(dev->parent, match,
> component_compare_dev, dev);
>                                                    ^~~~~~~~~~~~~~~~~~
> ~~~
>                                                    component_master_d
> el
>    include/linux/component.h:85:6: note: 'component_master_del'
> declared here
>    void component_master_del(struct device *,
>         ^
>    1 error generated.
> 
> 
> vim +1209 drivers/video/fbdev/omap2/omapfb/dss/dss.c
> 
>   1195	
>   1196	static int dss_add_child_component(struct device *dev,
> void *data)
>   1197	{
>   1198		struct component_match **match = data;
>   1199	
>   1200		/*
>   1201		 * HACK
>   1202		 * We don't have a working driver for rfbi, so
> skip it here always.
>   1203		 * Otherwise dss will never get probed
> successfully, as it will wait
>   1204		 * for rfbi to get probed.
>   1205		 */
>   1206		if (strstr(dev_name(dev), "rfbi"))
>   1207			return 0;
>   1208	
> > 1209		component_match_add(dev->parent, match,
> > component_compare_dev, dev);
> 
>   1210	
>   1211		return 0;
>   1212	}
>   1213	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

