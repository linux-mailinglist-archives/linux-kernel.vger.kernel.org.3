Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE62530A78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiEWHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiEWHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:45:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6417065;
        Mon, 23 May 2022 00:45:02 -0700 (PDT)
X-UUID: 04018e99e3d744ec8f540b19ed081c95-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a6f4da93-0487-4c71-9118-8817bfa5d73f,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:a6f4da93-0487-4c71-9118-8817bfa5d73f,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:68f9427a-5ef6-470b-96c9-bdb8ced32786,C
        OID:18f79406f0a9,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 04018e99e3d744ec8f540b19ed081c95-20220523
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1402844007; Mon, 23 May 2022 15:44:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 15:44:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 23 May 2022 15:44:55 +0800
Message-ID: <8362953b3f6e5290cbba3aa06f9bfa2535efadb3.camel@mediatek.com>
Subject: Re: [PATCH v10 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
From:   Axe Yang <axe.yang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Satya Tangirala" <satyat@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Eric Biggers <ebiggers@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lucas Stach <dev@lynxeye.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        <angelogioacchino.delregno@collabora.com>,
        Yue Hu <huyue2@yulong.com>, Kiwoong Kim <kwmad.kim@samsung.com>
Date:   Mon, 23 May 2022 15:44:55 +0800
In-Reply-To: <1652965539.952223.1359564.nullmailer@robh.at.kernel.org>
References: <20220519111323.14586-1-axe.yang@mediatek.com>
         <20220519111323.14586-2-axe.yang@mediatek.com>
         <1652965539.952223.1359564.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 08:05 -0500, Rob Herring wrote:
> On Thu, 19 May 2022 19:13:21 +0800, Axe Yang wrote:
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to
> > host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> > 
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 53
> > ++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/mmc/mtk-
> sd.example.dts:50.36-37 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:364:
> Documentation/devicetree/bindings/mmc/mtk-sd.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1401: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a
> patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

I reproduced the build error, sorry for that.
And it has been fixed in v11. 

Regards,
Axe


