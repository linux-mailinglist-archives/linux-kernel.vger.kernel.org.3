Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28A4B4002
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiBNDEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:04:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiBNDEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:04:10 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1920650E02;
        Sun, 13 Feb 2022 19:04:02 -0800 (PST)
X-UUID: c0cc346dcdef40718578236a9f63c992-20220214
X-UUID: c0cc346dcdef40718578236a9f63c992-20220214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1061529773; Mon, 14 Feb 2022 11:04:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Feb 2022 11:03:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 11:03:58 +0800
Message-ID: <ab823da2bff2dddcbf563083c787631c9ef842b7.camel@mediatek.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file
 and binding document
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-gpio@vger.kernel.org>, Sean Wang <sean.wang@kernel.org>,
        <devicetree@vger.kernel.org>
Date:   Mon, 14 Feb 2022 11:03:58 +0800
In-Reply-To: <1644504472.320340.2624780.nullmailer@robh.at.kernel.org>
References: <20220210062122.23974-1-guodong.liu@mediatek.com>
         <20220210062122.23974-2-guodong.liu@mediatek.com>
         <1644504472.320340.2624780.nullmailer@robh.at.kernel.org>
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

-----Original Message-----
From: Rob Herring <robh@kernel.org>
To: Guodong Liu <guodong.liu@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Sean Wang <
sean.wang@mediatek.com>, linux-mediatek@lists.infradead.org, Rob
Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
linux-kernel@vger.kernel.org, 
Project_Global_Chrome_Upstream_Group@mediatek.com, Matthias Brugger <
matthias.bgg@gmail.com>, linux-gpio@vger.kernel.org, Sean Wang <
sean.wang@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8186: add pinctrl
file and binding document
Date: Thu, 10 Feb 2022 08:47:52 -0600

On Thu, 10 Feb 2022 14:21:20 +0800, Guodong Liu wrote:
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8186.yaml      |  313 +++++
>  include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174
> +++++++++++++++++
>  2 files changed, 1487 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-
review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml:
properties:reg-names: {'description': 'Gpio base register names.\n',
'items': [{'const': 'iocfg0'}, {'const': 'iocfg_bm'}, {'const':
'iocfg_bl'}, {'const': 'iocfg_br'}, {'const': 'iocfg_lm'}, {'const':
'iocfg_rb'}, {'const': 'iocfg_tl'}, {'const': 'eint'}], 'maxItems': 8}
should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-
review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml:
ignoring, error in schema: properties: reg-names
Documentation/devicetree/bindings/pinctrl/pinctrl-
mt8186.example.dt.yaml:0:0: /example-0/pinctrl@10005000: failed to
match any schema with compatible: ['mediatek,mt8186-pinctrl']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1590838

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

Hi Rob

Thank you fou your useful information, and we will update it for next
version.

Thanks
Guodong




