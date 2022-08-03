Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C025889DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiHCJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiHCJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA846D8D;
        Wed,  3 Aug 2022 02:50:46 -0700 (PDT)
X-UUID: 8329f5513c2d491db1e3de5bbaaee610-20220803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=a6ri2Ytl22TV/ZfK3yMgIV7P9vbWLL3AJT+Y3T1wV2E=;
        b=A01kveViJzzQaqyKtLiL7sQO9QUjwXIcLN+5vQPspRqJcDQFpe50/svxpKC5HC4z2t+N7yrJXe2WqNog6Yk1gK8KD/G3KHx79PAXDv2np+PITwh0aPt2xi/b+BewW/pxqxRxutOfdRI2EB2sW9GozpQxKuXYgGSafiTx8ZOwess=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:19a684b6-e19e-451d-a1a9-f30c235c28ea,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:b62b1ed1-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 8329f5513c2d491db1e3de5bbaaee610-20220803
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 251189372; Wed, 03 Aug 2022 17:50:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 3 Aug 2022 17:50:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 3 Aug 2022 17:50:40 +0800
Message-ID: <3d97d4c46467909739b8b69662412fe162dbe613.camel@mediatek.com>
Subject: Re: [PATCH v2] pmic: add mt6366 regulator document
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhiyong Tao =?UTF-8?Q?=28=E9=99=B6=E5=BF=97=E5=8B=87=29?= 
        <Zhiyong.Tao@mediatek.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Eddie Huang =?UTF-8?Q?=28=E9=BB=83=E6=99=BA=E5=82=91=29?= 
        <eddie.huang@mediatek.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "fshao@chromium.org" <fshao@chromium.org>
CC:     Sen Chu =?UTF-8?Q?=28=E5=82=A8=E6=A3=AE=29?= 
        <Sen.Chu@mediatek.com>,
        Hui Liu =?UTF-8?Q?=28=E5=88=98=E8=BE=89=29?= 
        <Hui.Liu@mediatek.com>,
        Allen-KH Cheng =?UTF-8?Q?=28=E7=A8=8B=E5=86=A0=E5=8B=B3=29?= 
        <Allen-KH.Cheng@mediatek.com>,
        Hsin-Hsiung Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E9=9B=84=29?= 
        <Hsin-Hsiung.Wang@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin =?UTF-8?Q?=28=E6=9E=97=E6=99=BA=E6=96=8C=29?= 
        <Macpaul.Lin@mediatek.com>,
        Wen Su =?UTF-8?Q?=28=E8=98=87=E5=86=A0=E6=96=87=29?= 
        <Wen.Su@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        zhiyong tao <zhiyong.tao@mediatk.com>
Date:   Wed, 3 Aug 2022 17:50:40 +0800
In-Reply-To: <03a13ed4-e7cd-6f7d-f8f7-9b1e6193e202@linaro.org>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
         <20220728062749.18701-2-zhiyong.tao@mediatek.com>
         <03a13ed4-e7cd-6f7d-f8f7-9b1e6193e202@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-28 at 18:46 +0800, Krzysztof Kozlowski wrote:
> On 28/07/2022 08:27, Zhiyong Tao wrote:
> > From: zhiyong tao <zhiyong.tao@mediatek.com>
> > 
> > Add mt6366 regulator document
> 
> As usual with Mediatek your emails fail to properly pass modern SMTP
> checks and you end up in spam.
> 
> I reported it months ago to folks in Mediatek. No improvements since
> that time.
> 
> I stopped checking my spam folder for Mediatek stuff and all will be
> ignored. I will also stop complaining about it - just ignore
> Mediatek.
> 
> Fix your systems, instead of putting additional effort on community
> and
> on reviewers.
> 

Hello Krzysztof,

I am Rex from MediaTek chrome project team.
We noticed your complain of our upstream mail.

First of all, sorry for the inconvenience.
We really want to fix this SPAM issue.

From our side, we can make sure mails for kernel upstream from MediaTek
is clear and these mails pass the verification of DMARC/DKIM/SPF.
Therefore, to identify the root cause, could you please provide us some
mails that seen as SPAM from MediaTek?
It's more useful if you can use the form of attachment. In that case,
we can analyze whole mails including mail headers.

We really appreciate your big support, and we hope we can fix this
issue to reduce the inconvenience for reviewing series from MediaTek.
If you can spare some time to help us for this, it would very helpful!!

Our IT also adjust the DKIM setting today. If the situation of this
issue it much better, please also let us know.

Many thanks!!

BRs,
Rex
> 
> > 
> > Signed-off-by: zhiyong tao <zhiyong.tao@mediatk.com>
> > ---
> >  .../regulator/mediatek,mt6366-regulator.yaml  | 375
> > ++++++++++++++++++
> >  1 file changed, 375 insertions(+)
> 
> Subject does not match subsystem.
> 
> 
> >  create mode 100755
> > Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > regulator.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > regulator.yaml
> > b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > regulator.yaml
> > new file mode 100755
> > index 000000000000..eb72c64757cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-
> > regulator.yaml
> > @@ -0,0 +1,375 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> >
 https://urldefense.com/v3/__http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml*__;Iw!!CTRNKA9wMg0ARbw!3B-3NHQAsJc6ov022NnUIctYLEyx-BfxG5s85TBBvEfGjc4DdYDIqG_Ka_5D7scVo8CRtzLqokEX_thhM7XK_S90wg$
> > +$schema: 
> >
 https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!3B-3NHQAsJc6ov022NnUIctYLEyx-BfxG5s85TBBvEfGjc4DdYDIqG_Ka_5D7scVo8CRtzLqokEX_thhM7Un6TPZdw$
> > +
> > +title: MT6366 Regulator from MediaTek Integrated
> > +
> > +maintainers:
> > +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> > +
> > +description: |
> > +  List of regulators provided by this controller. It is named
> > +  according to its regulator type, buck_<name> and ldo_<name>.
> > +  MT6366 regulators node should be sub node of the MT6397 MFD
> > node.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6366-regulator
> > +
> > +  regulators:
> > +    type: object
> > +    description: List of regulators and its properties
> > +
> > +    patternProperties:
> > +      "^buck-
> > v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> 
> No need for quotes.
> 
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern:
> > "^v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$"
> 
> Why do you enforce specific regulator-name? Remove.
> 
> > +
> > +      "^ldo-v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern:
> > "^v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$"
> > +
> > +      "^ldo-v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern:
> > "^v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$"
> > +
> > +      "^buck-(vcore)-sshub$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^vcore-sshub$"
> > +
> > +      "^ldo-vcn(28|33)-bt$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^vcn(28|33)-bt$"
> > +
> > +      "^ldo-vcn(33)-wifi$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^vcn33-wifi$"
> > +
> > +      "^ldo-vsram-(others)-sshub$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^vsram-others-sshub$"
> > +
> > +      "^ldo-vsram-(proc11|others|gpu|proc12)$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^vsram-(proc11|others|gpu|proc12)$"
> > +
> > +      "^ldo-v(aud|bif|io|ldo)28$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^v(aud|bif|io|ldo)28$"
> > +
> > +      "^ldo-v(io|aux|rf)18$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^v(io|aux|rf)18$"
> > +
> > +      "^ldo-vsim[2]$":
> > +        type: object
> > +        $ref: "regulator.yaml#"
> > +
> > +        properties:
> > +          regulator-name:
> > +            pattern: "^vsim2$"
> > +
> > +        required:
> > +          - regulator-name
> > +
> > +required:
> > +  - compatible
> > +  - regulators
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pmic {
> > +      compatible = "mediatek,mt6366-regulator";
> > +
> > +      regulators {
> > +        mt6366_vdram1_reg: buck-vdram1 {
> > +            regulator-name = "vdram1";
> 
> Messed up indentation. Use only one, so 4 space for DTS example.
> 
> 
> 
> Best regards,
> Krzysztof

