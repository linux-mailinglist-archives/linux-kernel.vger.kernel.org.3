Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846CF599E85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349758AbiHSPcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349193AbiHSPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:32:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A122101C6D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3435AB827E3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B50C433D6;
        Fri, 19 Aug 2022 15:32:07 +0000 (UTC)
Message-ID: <427a05ef-44c0-0044-6ea4-e110afcb75b2@xs4all.nl>
Date:   Fri, 19 Aug 2022 17:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [hverkuil-media-tree:for-v6.1c 3/3]
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:905:10: warning: cast to
 smaller integer type 'enum mdp_comp_type' from 'const void *'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Moudy Ho <moudy.ho@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>
References: <202208190957.uDT8XE6b-lkp@intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <202208190957.uDT8XE6b-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moudy,

On 19/08/2022 04:05, kernel test robot wrote:
> tree:   git://linuxtv.org/hverkuil/media_tree.git for-v6.1c
> head:   b2273b84e1291c52279edf13b08744833c1faaab
> commit: b2273b84e1291c52279edf13b08744833c1faaab [3/3] media: platform: mtk-mdp3: add MediaTek MDP3 driver
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220819/202208190957.uDT8XE6b-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
>         git fetch --no-tags hverkuil-media-tree for-v6.1c
>         git checkout b2273b84e1291c52279edf13b08744833c1faaab
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/media/platform/mediatek/mdp3/ drivers/vfio/pci/hisilicon/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:905:10: warning: cast to smaller integer type 'enum mdp_comp_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>                    type = (enum mdp_comp_type)of_id->data;
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:964:10: warning: cast to smaller integer type 'enum mdp_comp_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>                    type = (enum mdp_comp_type)of_id->data;
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Can you fix this? I believe you need to do this to fix this:

(enum mdp_comp_type)(uintptr_t)of_id->data

Regards,

	Hans

>    2 warnings generated.
> 
> 
> vim +905 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> 
>    883	
>    884	static int mdp_comp_sub_create(struct mdp_dev *mdp)
>    885	{
>    886		struct device *dev = &mdp->pdev->dev;
>    887		struct device_node *node, *parent;
>    888	
>    889		parent = dev->of_node->parent;
>    890	
>    891		for_each_child_of_node(parent, node) {
>    892			const struct of_device_id *of_id;
>    893			enum mdp_comp_type type;
>    894			int id, alias_id;
>    895			struct mdp_comp *comp;
>    896	
>    897			of_id = of_match_node(mdp_sub_comp_dt_ids, node);
>    898			if (!of_id)
>    899				continue;
>    900			if (!of_device_is_available(node)) {
>    901				dev_dbg(dev, "Skipping disabled sub comp. %pOF\n", node);
>    902				continue;
>    903			}
>    904	
>  > 905			type = (enum mdp_comp_type)of_id->data;
>    906			alias_id = mdp_comp_alias_id[type];
>    907			id = mdp_comp_get_id(type, alias_id);
>    908			if (id < 0) {
>    909				dev_err(dev,
>    910					"Fail to get sub comp. id: type %d alias %d\n",
>    911					type, alias_id);
>    912				return -EINVAL;
>    913			}
>    914			mdp_comp_alias_id[type]++;
>    915	
>    916			comp = mdp_comp_create(mdp, node, id);
>    917			if (IS_ERR(comp))
>    918				return PTR_ERR(comp);
>    919		}
>    920	
>    921		return 0;
>    922	}
>    923	
> 
