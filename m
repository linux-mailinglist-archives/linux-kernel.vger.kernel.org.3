Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC745A205E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiHZFjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHZFjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:39:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064ACEB37
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:38:58 -0700 (PDT)
X-UUID: de99f75515ae4d33a488e423986c5be0-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cxEgDl4+jLLmXItOb4ZpoNKLX8XnInSqhwiq/zHFf9U=;
        b=rJqhTTcyzFTXdy5oL9LA683w4UluYE0//uU0PLz5aZqU6qhAgkswC6jut9ilTE50jh4Mnql+JApSyt2UZBAtOoAH1YLiJ1MpU5yo0LegVNludEZkz3EefCQkW699WUR46b/tntxPdut/qHTPf+5qHrOPXT1hs05VfNayEdts11I=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:027c1268-b6e0-4c60-814a-03a1e0785a6e,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:49
X-CID-INFO: VERSION:1.1.10,REQID:027c1268-b6e0-4c60-814a-03a1e0785a6e,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:54,FILE:0,BULK:0,RULE:Release_
        HamU,ACTION:release,TS:49
X-CID-META: VersionHash:84eae18,CLOUDID:0a5e2c20-1c20-48a5-82a0-25f9c331906d,C
        OID:58d5f93ec29e,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: de99f75515ae4d33a488e423986c5be0-20220826
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1514045262; Fri, 26 Aug 2022 13:38:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 13:38:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 13:38:50 +0800
Message-ID: <57b31acfc4f5bcff3c73c35bc30805b84af3bfbd.camel@mediatek.com>
Subject: Re: drivers/soc/mediatek/mtk-svs.c:1287:34: warning: unused
 variable 'svs_of_match'
From:   Roger Lu <roger.lu@mediatek.com>
To:     kernel test robot <lkp@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>
Date:   Fri, 26 Aug 2022 13:38:50 +0800
In-Reply-To: <202208210442.ZL8oxHze-lkp@intel.com>
References: <202208210442.ZL8oxHze-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Sorry for late reply. These issues are fixed by below patches. Thanks for the
heads-up.

  drivers/soc/mediatek/mtk-svs.c:1481:12: error: unused function 'svs_suspend'
[-Werror,-Wunused-function]
  static int svs_suspend(struct device *dev)
             ^
  drivers/soc/mediatek/mtk-svs.c:1515:12: error: unused function 'svs_resume' [-
Werror,-Wunused-function]
  static int svs_resume(struct device *dev)

=> fixed by 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220622175649.1856337-1-nathan@kernel.org/

>> drivers/soc/mediatek/mtk-svs.c:1287:34: warning: unused variable
'svs_of_match' [-Wunused-const-variable]
   static const struct of_device_id svs_of_match[] = {

=> fixed by 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220726141653.177948-5-angelogioacchino.delregno@collabora.com/

Sincerely,
Roger Lu.

On Sun, 2022-08-21 at 04:38 +0800, kernel test robot wrote:
> Hi Roger,
> 
> FYI, the error/warning still remains.
> 
> tree:   
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!CTRNKA9wMg0ARbw!0KbjAYXXstyhJQ4NbExdZ1NlNqc0lVccMpejf3AQ2614pGuQkpDXre1pRIYXvgh9$
>   master
> head:   cc1807b9158a909ffe829a5e222be756c57c9a90
> commit: 681a02e9500073cd8b9c25a04f06166254b5a879 soc: mediatek: SVS: introduce
> MTK SVS engine
> date:   9 weeks ago
> config: hexagon-randconfig-r022-20220821 (
> https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20220821/202208210442.ZL8oxHze-lkp@intel.com/config__;!!CTRNKA9wMg0ARbw!0KbjAYXXstyhJQ4NbExdZ1NlNqc0lVccMpejf3AQ2614pGuQkpDXre1pRKmS3VSy$
>  )
> compiler: clang version 16.0.0 (
> https://urldefense.com/v3/__https://github.com/llvm/llvm-project__;!!CTRNKA9wMg0ARbw!0KbjAYXXstyhJQ4NbExdZ1NlNqc0lVccMpejf3AQ2614pGuQkpDXre1pRIUR1DJG$
> $  c9a41fe60ab62f7a40049c100adcc8087a47669b)
> reproduce (this is a W=1 build):
>         wget 
> https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!CTRNKA9wMg0ARbw!0KbjAYXXstyhJQ4NbExdZ1NlNqc0lVccMpejf3AQ2614pGuQkpDXre1pRF4kJosK$
>   -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=681a02e9500073cd8b9c25a04f06166254b5a879__;!!CTRNKA9wMg0ARbw!0KbjAYXXstyhJQ4NbExdZ1NlNqc0lVccMpejf3AQ2614pGuQkpDXre1pRNjbQMgG$
>  
>         git remote add linus 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!CTRNKA9wMg0ARbw!0KbjAYXXstyhJQ4NbExdZ1NlNqc0lVccMpejf3AQ2614pGuQkpDXre1pRIYXvgh9$
>  
>         git fetch --no-tags linus master
>         git checkout 681a02e9500073cd8b9c25a04f06166254b5a879
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1
> O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/mediatek/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/soc/mediatek/mtk-svs.c:853:12: warning: unused function
> 'svs_suspend' [-Wunused-function]
>    static int svs_suspend(struct device *dev)
>               ^
>    drivers/soc/mediatek/mtk-svs.c:880:12: warning: unused function
> 'svs_resume' [-Wunused-function]
>    static int svs_resume(struct device *dev)
>               ^
> > > drivers/soc/mediatek/mtk-svs.c:1287:34: warning: unused variable
> > > 'svs_of_match' [-Wunused-const-variable]
> 
>    static const struct of_device_id svs_of_match[] = {
>                                     ^
>    3 warnings generated.
> 
> 
> vim +/svs_of_match +1287 drivers/soc/mediatek/mtk-svs.c
> 
>   1286	
> > 1287	static const struct of_device_id svs_of_match[] = {
> 
>   1288		{
>   1289			.compatible = "mediatek,mt8183-svs",
>   1290			.data = &svs_mt8183_platform_data,
>   1291		}, {
>   1292			/* Sentinel */
>   1293		},
>   1294	};
>   1295	
> 

