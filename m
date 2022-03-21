Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C604E25BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiCUL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiCUL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:56:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1EB78;
        Mon, 21 Mar 2022 04:54:39 -0700 (PDT)
X-UUID: 8fc365ebb8e04c23b6a91a12633afcaf-20220321
X-UUID: 8fc365ebb8e04c23b6a91a12633afcaf-20220321
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 960504842; Mon, 21 Mar 2022 19:54:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 21 Mar 2022 19:54:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 19:54:31 +0800
Message-ID: <b71b2496a19745648d6b1a9788f35b0371b45847.camel@mediatek.com>
Subject: Re: [RESEND v7 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
From:   Axe Yang <axe.yang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tian Tao <tiantao6@hisilicon.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yue Hu <huyue2@yulong.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Eric Biggers" <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mediatek@lists.infradead.org>, Lucas Stach <dev@lynxeye.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Kiwoong Kim" <kwmad.kim@samsung.com>
Date:   Mon, 21 Mar 2022 19:54:31 +0800
In-Reply-To: <1647742413.962309.2990518.nullmailer@robh.at.kernel.org>
References: <20220317101215.24985-1-axe.yang@mediatek.com>
         <20220317101215.24985-2-axe.yang@mediatek.com>
         <1647742413.962309.2990518.nullmailer@robh.at.kernel.org>
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

Hi Rob,

Thanks for your review.

On Sat, 2022-03-19 at 20:13 -0600, Rob Herring wrote:
> On Thu, 17 Mar 2022 18:12:13 +0800, Axe Yang wrote:
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to
> > host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> > 
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 24
> > ++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/mmc/mtk-sd.yaml:
> properties:pinctrl-names: {'description': 'Should at least contain
> default and state_uhs. To support SDIO in-band wakeup, dat1 pin will
> be switched between GPIO mode and SDIO DAT1 mode, state_eint and
> state_dat1 are mandatory in this scenarios.', 'minItems': 2,
> 'maxItems': 4, 'items': [{'const': 'default'}, {'const':
> 'state_uhs'}, {'const': 'state_eint'}, {'const': 'state_dat1'}]}
> should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: ignoring,
> error in schema: properties: pinctrl-names
> Documentation/devicetree/bindings/mmc/mtk-sd.example.dt.yaml:0:0: 
> /example-0/mmc@11230000: failed to match any schema with compatible:
> ['mediatek,mt8173-mmc']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1606491
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


I reproduced the error and already fix it in v8.

Regards,
Axe

