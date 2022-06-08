Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5A5437A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiFHPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiFHPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:40:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E6156798;
        Wed,  8 Jun 2022 08:40:09 -0700 (PDT)
X-UUID: bee3831b47d74af4846d6a5d96237ef8-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:fee6ddc9-049d-48dc-960f-dc46aead21b8,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:affaaa7e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: bee3831b47d74af4846d6a5d96237ef8-20220608
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2023209277; Wed, 08 Jun 2022 23:40:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 23:40:00 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 8 Jun 2022 23:40:00 +0800
Message-ID: <b9f62fe5e39d23d8ce64773814fbb9f5ba1a0a21.camel@mediatek.com>
Subject: Re: [RESEND v5 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>
Date:   Wed, 8 Jun 2022 23:40:00 +0800
In-Reply-To: <1654695907.376302.1272085.nullmailer@robh.at.kernel.org>
References: <20220608043852.4980-1-rex-bc.chen@mediatek.com>
         <20220608043852.4980-4-rex-bc.chen@mediatek.com>
         <1654695907.376302.1272085.nullmailer@robh.at.kernel.org>
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

On Wed, 2022-06-08 at 21:45 +0800, Rob Herring wrote:
> On Wed, 08 Jun 2022 12:38:52 +0800, Bo-Chen Chen wrote:
> > From: "Nancy.Lin" <nancy.lin@mediatek.com>
> > 
> > Add vdosys1 ETHDR definition.
> > 
> > Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Tested-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  .../display/mediatek/mediatek,ethdr.yaml      | 188
> > ++++++++++++++++++
> >  1 file changed, 188 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.y
> > aml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error:
> Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.exa
> mple.dts:71.40-41 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:383:
> Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.exa
> mple.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1404: dt_binding_check] Error 2
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
> 

Hello Rob,

I am not sure why there is this error.
But from my running result: line 71 in mediatek,ethdr.example.dts is
"resets = <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE0_DL_ASYNC>,"

This reset define is in previous patch of this series.
I don't know how to avoid this.

And I also just got this:
./Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.exa
mple.dtb: hdr-engine@1c114000: mediatek,gce-client-reg:0: [4294967295,
7, 16384, 4096, 4294967295, 7, 20480, 4096, 4294967295, 7, 28672, 4096,
4294967295, 7, 36864, 4096, 4294967295, 7, 40960, 4096, 4294967295, 7,
45056, 4096, 4294967295, 7, 49152, 4096] is too long
        From schema:
./Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yam
l
./Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.exa
mple.dtb: hdr-engine@1c114000: mediatek,gce-client-reg: [[4294967295,
7, 16384, 4096, 4294967295, 7,
20480, 4096, 4294967295, 7, 28672, 4096, 4294967295, 7, 36864, 4096,
4294967295, 7, 40960, 4096, 4294967295, 7, 45056, 4096, 4294967295, 7,
49152, 4096]] is too short
        From schema:
./Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yam
l

Is there any suggestion?

BRs,
Bo-Chen

